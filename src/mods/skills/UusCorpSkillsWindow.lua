UusCorpSkillsWindow = {}
UusCorpSkillsWindow.Name = "UusCorpSkillsWindow"
UusCorpSkillsWindow.List = UusCorpSkillsWindow.Name .. "List"
UusCorpSkillsWindow.Icon = "ItemIcon"
UusCorpSkillsWindow.Lock = "ItemLock"
UusCorpSkillsWindow.ArrowUp = "ItemArrowUp"
UusCorpSkillsWindow.ArrowDown = "ItemArrowDown"
UusCorpSkillsWindow.ListRow = UusCorpSkillsWindow.List .. "Row"
UusCorpSkillsWindow.Skills = {}
UusCorpSkillsWindow.SortOrder = {}
UusCorpSkillsWindow.Totals = "SkillsWindowTotals"

local toggleState = 2

local function formatValue(skillLevel)
    return StringFormatter.toWString(
        string.format("%2.1f", skillLevel / 10)
    )
end

local function updateTotals()
    local real = 0.0
    local modified = 0.0

    for i = 1, #UusCorpSkillsWindow.Skills do
        local skill = UusCorpSkillsWindow.Skills[i]
        real = real + skill.realValue
        modified = modified + skill.tempValue
    end

    LabelApi.setText(
        UusCorpSkillsWindow.Totals .. "Values",
        "Total: " .. string.format("%2.1f", real) .. " (" .. string.format("%2.1f", modified) .. ")"
    )
end

local function updateStateToggle(state)
    toggleState = state

    local text = "Raise All"

    if state == 0 then
        text = "Lower All"
    elseif state == 1 then
        text = "Lock All"
    end

    LabelApi.setText(
        UusCorpSkillsWindow.Totals .. "ToggleState",
        text
    )
end

local function updateSkillRow(index)
    local item = UusCorpSkillsWindow.ListRow .. index

    LabelApi.setText(
        item .. "ItemName",
        UusCorpSkillsWindow.Skills[index].skillName
    )

    LabelApi.setText(
        item .. "ItemRealValue",
        UusCorpSkillsWindow.Skills[index].realValue
    )

    LabelApi.setText(
        item .. "ItemTempValue",
        UusCorpSkillsWindow.Skills[index].tempValue
    )

    LabelApi.setText(
        item .. "ItemCap",
        UusCorpSkillsWindow.Skills[index].cap
    )

    local state = UusCorpSkillsWindow.Skills[index].state

    WindowApi.setId(item, UusCorpSkillsWindow.Skills[index].id)
    WindowApi.setShowing(item .. UusCorpSkillsWindow.Icon, false)
    WindowApi.setShowing(item .. UusCorpSkillsWindow.Lock, state == 2)
    WindowApi.setShowing(item .. UusCorpSkillsWindow.ArrowUp, state == 0)
    WindowApi.setShowing(item .. UusCorpSkillsWindow.ArrowDown, state == 1)
end

function UusCorpSkillsWindow.initialize()
    UusCorpCore.loadResources(
        "/src/mods/skills",
        "UusCorpSkillsWindow.xml"
    )

    Interface.SkillLocker = function ()
    end

    Actions.ToggleSkillsWindow = function ()
        WindowApi.toggleWindow(UusCorpSkillsWindow.Name)
    end
end

function UusCorpSkillsWindow.onInitialize()
    WindowDataApi.registerData(
        Skills.listDataType()
    )

    for i = 1, #Skills.csv() do
        WindowDataApi.registerData(
            Skills.dynamicDataType(),
            i
        )

        local skill = Skills.csv()[i]
        local data = Skills.dynamicData()[skill.ServerId]

        table.insert(
            UusCorpSkillsWindow.Skills,
            {
                id = skill.ID,
                icon = skill.IconId,
                skillName = skill.SkillName,
                tempValue = formatValue(data.TempSkillValue),
                state = data.SkillState,
                realValue = formatValue(data.RealSkillValue),
                cap = formatValue(data.SkillCap)
            }
        )
    end

    table.sort(
        UusCorpSkillsWindow.Skills,
        function (a, b)
            return a.skillName < b.skillName
        end
    )

    WindowApi.registerEventHandler(
        UusCorpSkillsWindow.Name,
        Skills.event(),
        "UusCorpSkillsWindow.UpdateSkills"
    )

    WindowApi.createFromTemplate(
        UusCorpSkillsWindow.Totals,
        UusCorpSkillsWindow.Totals,
        UusCorpSkillsWindow.List .. "ScrollChild"
    )

    updateTotals()
    updateStateToggle(toggleState)

    for i = 1, #UusCorpSkillsWindow.Skills do
        local item = UusCorpSkillsWindow.ListRow .. i
        WindowApi.createFromTemplate(
            item,
            "SkillsRowTemplate",
            UusCorpSkillsWindow.List .. "ScrollChild"
        )

        if i > 1 then
            WindowApi.addAnchor(
                item,
                "bottom",
                UusCorpSkillsWindow.ListRow .. i - 1,
                "top",
                0,
                4
            )
        else
            WindowApi.addAnchor(
                item,
                "bottom",
                UusCorpSkillsWindow.Totals,
                "top",
                0,
                12
            )
        end

        updateSkillRow(i)
    end
end

function UusCorpSkillsWindow.UpdateSkills()
    local id = Active.updateId()
    local skill = Skills.csv()[id]
    local data = Skills.dynamicData()[skill.ServerId]
    local index = 0

    for k, v in ipairs(UusCorpSkillsWindow.Skills) do
        if v.id == id then
            index = k
            UusCorpSkillsWindow.Skills[k] = {
                id = skill.ID,
                icon = skill.IconId,
                skillName = skill.SkillName,
                tempValue = formatValue(data.TempSkillValue),
                state = data.SkillState,
                realValue = formatValue(data.RealSkillValue),
                cap = formatValue(data.SkillCap)
            }
            break
        end
    end

    updateSkillRow(index)
    updateTotals()
end

function UusCorpSkillsWindow.Shutdown()
    WindowDataApi.unregisterData(
        Skills.listDataType()
    )

    for i = 1, #Skills.list()- 1 do
        WindowDataApi.unregisterData(
            Skills.dynamicDataType(),
            i
        )
    end

    WindowApi.unregisterEventHandler(
        UusCorpSkillsWindow.Name,
        Skills.event()
    )

    UusCorpSkillsWindow.Skills = {}
end

function UusCorpSkillsWindow.onSkillDoubleClick()
    UserAction.useSkill(
        Skills.serverId(
            Skills.csvId(WindowApi.getId(Active.window()))
        )
    )
end

function UusCorpSkillsWindow.onSkillDrag()
    --TODO proper drag and release
    local id = WindowApi.getId(Active.window())
    local icon = UusCorpSkillsWindow.ListRow .. id .. UusCorpSkillsWindow.Icon

    WindowApi.clearAnchors(icon)
    WindowApi.setShowing(
        icon,
        true
    )

    WindowApi.setMoving(
        icon,
        true
    )

    DragApi.setActionMouseClickData(
        UserAction.typeSkill(),
        Skills.serverId(
            Skills.csvId(id)
        ),
        Skills.iconId(
            id
        )
    )
end

function UusCorpSkillsWindow.onClickArrowUp()
    WindowApi.setShowing(Active.window(), false)
    WindowApi.setShowing(
        WindowApi.getParent(Active.window()) .. UusCorpSkillsWindow.ArrowDown,
        true
    )
    UusCorpSkillsWindow.onToggleSkillState(
        WindowApi.getId(
            WindowApi.getParent(
               Active.window()
            )
        ),
        1
    )
end

function UusCorpSkillsWindow.onClickArrowDown()
    WindowApi.setShowing(Active.window(), false)
    WindowApi.setShowing(
        WindowApi.getParent(Active.window()) .. UusCorpSkillsWindow.Lock,
        true
    )
    UusCorpSkillsWindow.onToggleSkillState(
        WindowApi.getId(
            WindowApi.getParent(
               Active.window()
            )
        ),
        2
    )
end

function UusCorpSkillsWindow.onClickLock()
    WindowApi.setShowing(Active.window(), false)
    WindowApi.setShowing(
        WindowApi.getParent(Active.window()) .. UusCorpSkillsWindow.ArrowUp,
        true
    )
    UusCorpSkillsWindow.onToggleSkillState(
        WindowApi.getId(
            WindowApi.getParent(
               Active.window()
            )
        ),
        0
    )
end

function UusCorpSkillsWindow.onRightClick()
    WindowApi.destroyWindow(UusCorpSkillsWindow.Name)
end

function UusCorpSkillsWindow.onToggleSkillState(id, state)
    Skills.state(
        id,
        state
    )

    EventApi.broadcast(
        Events.skillStateChange()
    )
end

function UusCorpSkillsWindow.onToggleStates()
    if toggleState == 1 then
        updateStateToggle(2)
    elseif toggleState == 2 then
        updateStateToggle(0)
    else
        updateStateToggle(1)
    end

    for i = 1, #UusCorpSkillsWindow.Skills do
        local skill = UusCorpSkillsWindow.Skills[i]
        skill.state = toggleState
        UusCorpSkillsWindow.onToggleSkillState(
            skill.id,
            toggleState
        )
        updateSkillRow(i)
    end
end

function UusCorpSkillsWindow.onMouseOverStateToggle()
    LabelApi.setTextColor(
        UusCorpSkillsWindow.Totals .. "ToggleState",
        Colors.OffWhite
    )
end

function UusCorpSkillsWindow.onMouseOverStateToggleEnd()
    LabelApi.setTextColor(
        UusCorpSkillsWindow.Totals .. "ToggleState",
        Colors.CoreBlue
    )
end
