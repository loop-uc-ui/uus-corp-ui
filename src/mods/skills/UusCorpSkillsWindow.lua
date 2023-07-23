UusCorpSkillsWindow = {}
UusCorpSkillsWindow.Name = "UusCorpSkillsWindow"
UusCorpSkillsWindow.List = UusCorpSkillsWindow.Name .. "List"
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

local function printSkillChangeToChat(oldSkill, newSkill)
    if oldSkill.tempValue == newSkill.tempValue then
        return
    end

    local change = newSkill.tempValue - oldSkill.tempValue
    local qualifier = "increased"

    if change < 0 then
        qualifier = "decreased"
    end

    -- TODO figure out why replace Tokens doesn't work
    ChatApi.print(
        StringFormatter.toWString("Your skill in " .. StringFormatter.fromWString(newSkill.skillName)
            .. " has " .. qualifier .. " by " .. StringFormatter.fromWString(formatValue(math.abs(change) * 10))
            .. ". It is now " .. StringFormatter.fromWString(newSkill.tempValue) .. "."),
        Chat.filtersSystem()
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
        WindowApi.setShowing(
            UusCorpSkillsWindow.Name,
            not WindowApi.isShowing(UusCorpSkillsWindow.Name)
        )
    end

    local window = "SkillsWindow"

    WindowApi.unregisterEventHandler(
        window,
        Events.toggleSkillTracker()
    )

    WindowApi.unregisterEventHandler(
        window,
        Skills.event()
    )

    WindowApi.unregisterCoreEventHandler(
        window,
        "OnUpdate"
    )

    UusCorpCore.overrideFunctions(SkillsWindow)

    -- For compatibility
    function SkillsWindow.FormatSkillValue(skillLevel)
        return formatValue(skillLevel)
    end

    WindowApi.createWindow(UusCorpSkillsWindow.Name, false)
end

function UusCorpSkillsWindow.onInitialize()
    WindowUtilsWrapper.restoreWindowPosition(UusCorpSkillsWindow.Name)

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
                skillName = StringFormatter.fromTid(Skills.csv()[skill.ID].NameTid),
                tempValue = formatValue(data.TempSkillValue),
                state = data.SkillState,
                realValue = formatValue(data.RealSkillValue),
                cap = formatValue(data.SkillCap),
                serverId = skill.ServerId
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

    ScrollWindowApi.updateScrollRect(UusCorpSkillsWindow.List)
end

function UusCorpSkillsWindow.UpdateSkills()
    local id = Active.updateId()
    local data = Skills.dynamicData()[id]
    local oldSkill = nil
    local newSkill = nil
    local index = 0

    for i = 1, #UusCorpSkillsWindow.Skills do
        local skill = UusCorpSkillsWindow.Skills[i]

        if skill.serverId == id then
            oldSkill = {
                id = skill.id,
                icon = skill.icon,
                skillName = skill.skillName,
                tempValue = skill.tempValue,
                state = skill.state,
                realValue = skill.realValue,
                cap = skill.cap,
                serverId = skill.serverId
            }

            index = i
            skill.tempValue = formatValue(data.TempSkillValue)
            skill.state = data.SkillState
            skill.realValue = formatValue(data.RealSkillValue)
            skill.cap = formatValue(data.SkillCap)
            newSkill = skill
            break
        end
    end

    if index ~= 0 then
        updateSkillRow(index)
    end

    if oldSkill ~= nil and newSkill ~= nil then
        printSkillChangeToChat(oldSkill, newSkill)
    end

    updateTotals()
end

function UusCorpSkillsWindow.onShutdown()
    WindowUtilsWrapper.saveWindowPosition(UusCorpSkillsWindow.Name)

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
    for i = 1, #UusCorpSkillsWindow.Skills do
        local skill = UusCorpSkillsWindow.Skills[i]

        if skill.id == WindowApi.getId(Active.window()) then
            UserAction.useSkill(skill.serverId)
            break
        end
    end
end

function UusCorpSkillsWindow.onSkillDrag()
    --TODO proper drag and release
    local id = WindowApi.getId(WindowApi.getParent(Active.window()))

    for i = 1, #UusCorpSkillsWindow.Skills do
        local skill = UusCorpSkillsWindow.Skills[i]

        if skill.id == id then
            DragApi.setActionMouseClickData(
                UserAction.typeSkill(),
                skill.serverId,
                skill.icon
            )
            break
        end
    end
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
    WindowApi.setShowing(UusCorpSkillsWindow.Name, false)
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
