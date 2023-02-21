SkillsWindow = {}
SkillsWindow.Name = "SkillsWindow"
SkillsWindow.List = SkillsWindow.Name .. "List"
SkillsWindow.Icon = "ItemIcon"
SkillsWindow.Lock = "ItemLock"
SkillsWindow.ArrowUp = "ItemArrowUp"
SkillsWindow.ArrowDown = "ItemArrowDown"
SkillsWindow.ListRow = SkillsWindow.List .. "Row"
SkillsWindow.Skills = {}
SkillsWindow.SortOrder = {}
SkillsWindow.Totals = "SkillsWindowTotals"

local toggleState = 2

local function formatValue(skillLevel)
    return StringFormatter.toWString(
        string.format("%2.1f", skillLevel / 10)
    )
end

local function updateTotals()
    local real = 0.0
    local modified = 0.0

    for i = 1, #SkillsWindow.Skills do
        local skill = SkillsWindow.Skills[i]
        real = real + skill.realValue
        modified = modified + skill.tempValue
    end

    LabelApi.setText(
        SkillsWindow.Totals .. "Values",
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
        SkillsWindow.Totals .. "ToggleState",
        text
    )
end

local function updateSkillRow(index)
    local item = SkillsWindow.ListRow .. index

    LabelApi.setText(
        item .. "ItemName",
        SkillsWindow.Skills[index].skillName
    )

    LabelApi.setText(
        item .. "ItemRealValue",
        SkillsWindow.Skills[index].realValue
    )

    LabelApi.setText(
        item .. "ItemTempValue",
        SkillsWindow.Skills[index].tempValue
    )

    LabelApi.setText(
        item .. "ItemCap",
        SkillsWindow.Skills[index].cap
    )

    local state = SkillsWindow.Skills[index].state

    WindowApi.setId(item, SkillsWindow.Skills[index].id)
    WindowApi.setShowing(item .. SkillsWindow.Icon, false)
    WindowApi.setShowing(item .. SkillsWindow.Lock, state == 2)
    WindowApi.setShowing(item .. SkillsWindow.ArrowUp, state == 0)
    WindowApi.setShowing(item .. SkillsWindow.ArrowDown, state == 1)
end

function SkillsWindow.Initialize()
    WindowDataApi.registerData(
        Skills.listDataType()
    )

    for i = 1, #Skills.list() - 1 do
        WindowDataApi.registerData(
            Skills.dynamicDataType(),
            i
        )

        local skill = Skills.list()[i]
        local data = Skills.dynamicData()[i]

        table.insert(
            SkillsWindow.Skills,
            {
                id = i,
                icon = skill.iconId,
                skillName = skill.skillName,
                tempValue = formatValue(data.TempSkillValue),
                state = data.SkillState,
                realValue = formatValue(data.RealSkillValue),
                cap = formatValue(data.SkillCap)
            }
        )
    end

    table.sort(
        SkillsWindow.Skills,
        function (a, b)
            return a.skillName < b.skillName
        end
    )

    WindowApi.registerEventHandler(
        SkillsWindow.Name,
        Skills.event(),
        "SkillsWindow.UpdateSkills"
    )

    WindowApi.createFromTemplate(
        SkillsWindow.Totals,
        SkillsWindow.Totals,
        SkillsWindow.List .. "ScrollChild"
    )

    updateTotals()
    updateStateToggle(toggleState)

    for i = 1, #SkillsWindow.Skills do
        local item = SkillsWindow.ListRow .. i
        WindowApi.createFromTemplate(
            item,
            "SkillsRowTemplate",
            SkillsWindow.List .. "ScrollChild"
        )

        if i > 1 then
            WindowApi.addAnchor(
                item,
                "bottom",
                SkillsWindow.ListRow .. i - 1,
                "top",
                0,
                4
            )
        else
            WindowApi.addAnchor(
                item,
                "bottom",
                SkillsWindow.Totals,
                "top",
                0,
                12
            )
        end

        updateSkillRow(i)
    end
end

function SkillsWindow.UpdateSkills()
    local id = Active.updateId()
    local skill = Skills.list()[id]
    local data = Skills.dynamicData()[id]
    local index = 0

    for k, v in ipairs(SkillsWindow.Skills) do
        if v.id == id then
            index = k
            SkillsWindow.Skills[k] = {
                id = id,
                icon = skill.iconId,
                skillName = skill.skillName,
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

function SkillsWindow.Shutdown()
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
        SkillsWindow.Name,
        Skills.event()
    )

    SkillsWindow.Skills = {}
end

function SkillsWindow.onSkillDoubleClick()
    UserAction.useSkill(
        Skills.serverId(
            Skills.csvId(WindowApi.getId(Active.window()))
        )
    )
end

function SkillsWindow.onSkillDrag()
    --TODO proper drag and release
    local id = WindowApi.getId(Active.window())
    local icon = SkillsWindow.ListRow .. id .. SkillsWindow.Icon

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

function SkillsWindow.onClickArrowUp()
    WindowApi.setShowing(Active.window(), false)
    WindowApi.setShowing(
        WindowApi.getParent(Active.window()) .. SkillsWindow.ArrowDown,
        true
    )
    SkillsWindow.onToggleSkillState(
        WindowApi.getId(
            WindowApi.getParent(
               Active.window()
            )
        ),
        1
    )
end

function SkillsWindow.onClickArrowDown()
    WindowApi.setShowing(Active.window(), false)
    WindowApi.setShowing(
        WindowApi.getParent(Active.window()) .. SkillsWindow.Lock,
        true
    )
    SkillsWindow.onToggleSkillState(
        WindowApi.getId(
            WindowApi.getParent(
               Active.window()
            )
        ),
        2
    )
end

function SkillsWindow.onClickLock()
    WindowApi.setShowing(Active.window(), false)
    WindowApi.setShowing(
        WindowApi.getParent(Active.window()) .. SkillsWindow.ArrowUp,
        true
    )
    SkillsWindow.onToggleSkillState(
        WindowApi.getId(
            WindowApi.getParent(
               Active.window()
            )
        ),
        0
    )
end

function SkillsWindow.onRightClick()
    WindowApi.destroyWindow(SkillsWindow.Name)
end

function SkillsWindow.onToggleSkillState(id, state)
    Skills.state(
        id,
        state
    )

    EventApi.broadcast(
        Events.skillStateChange()
    )
end

function SkillsWindow.onToggleStates()
    if toggleState == 1 then
        updateStateToggle(2)
    elseif toggleState == 2 then
        updateStateToggle(0)
    else
        updateStateToggle(1)
    end

    for i = 1, #SkillsWindow.Skills do
        local skill = SkillsWindow.Skills[i]
        skill.state = toggleState
        SkillsWindow.onToggleSkillState(
            skill.id,
            toggleState
        )
        updateSkillRow(i)
    end
end

function SkillsWindow.onMouseOverStateToggle()
    LabelApi.setTextColor(
        SkillsWindow.Totals .. "ToggleState",
        Colors.OffWhite
    )
end

function SkillsWindow.onMouseOverStateToggleEnd()
    LabelApi.setTextColor(
        SkillsWindow.Totals .. "ToggleState",
        Colors.CoreBlue
    )
end
