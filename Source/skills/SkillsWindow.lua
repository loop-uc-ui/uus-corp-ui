SkillsWindow = {}
SkillsWindow.Name = "SkillsWindow"
SkillsWindow.ItemName = "ItemName"
SkillsWindow.ItemRealValue = "ItemRealValue"
SkillsWindow.ItemTempValue = "ItemTempValue"
SkillsWindow.ItemCap = "ItemCap"
SkillsWindow.List = SkillsWindow.Name .. "List"
SkillsWindow.ListRow = SkillsWindow.List .. "Row"
SkillsWindow.Skills = {}

local function formatValue(skillLevel)
    return string.format("%2.1f", skillLevel / 10)
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
                skillName = skill.skillName,
                tempValue = formatValue(data.TempSkillValue),
                state = data.SkillState,
                realValue = formatValue(data.RealSkillValue),
                cap = formatValue(data.SkillCap),
            }
        )

        table.insert(order, i)
    end

    WindowApi.registerEventHandler(
        SkillsWindow.Name,
        Skills.event(),
        "SkillsWindow.UpdateSkills"
    )

    ListBoxSetDisplayOrder(SkillsWindow.List, order)
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
        LabelApi.setText(SkillsWindow.ListRow .. k .. SkillsWindow.ItemName, SkillsWindow.Skills[v].skillName)
        LabelApi.setText(SkillsWindow.ListRow .. k .. SkillsWindow.ItemRealValue, SkillsWindow.Skills[v].realValue)
        LabelApi.setText(SkillsWindow.ListRow .. k .. SkillsWindow.ItemTempValue, SkillsWindow.Skills[v].tempValue)
        LabelApi.setText(SkillsWindow.ListRow .. k .. SkillsWindow.ItemCap, SkillsWindow.Skills[v].cap)
    end
end