SkillsWindow = {}
SkillsWindow.Name = "SkillsWindow"
SkillsWindow.List = SkillsWindow.Name .. "List"
SkillsWindow.Icon = "ItemIcon"
SkillsWindow.ListRow = SkillsWindow.List .. "Row"
SkillsWindow.Skills = {}

local function formatValue(skillLevel)
    return StringFormatter.toWString(
        string.format("%2.1f", skillLevel / 10)
    )
end

function SkillsWindow.Initialize()
    WindowDataApi.registerData(
        Skills.listDataType()
    )

    local order = {}

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

    for k, _ in pairs(SkillsWindow.Skills) do
        table.insert(
            order,
            k
        )
    end

    WindowApi.registerEventHandler(
        SkillsWindow.Name,
        Skills.event(),
        "SkillsWindow.UpdateSkills"
    )

    ListBoxApi.setDisplayOrder(SkillsWindow.List, order)
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

function SkillsWindow.Populate(data)
    for k, v in ipairs(data) do
        WindowApi.setId(SkillsWindow.ListRow .. k, SkillsWindow.Skills[v].id)
        WindowApi.setShowing(SkillsWindow.ListRow .. k .. SkillsWindow.Icon, false)
    end
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