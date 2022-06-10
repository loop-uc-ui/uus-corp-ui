SkillsWindow = {}
SkillsWindow.Name = "SkillsWindow"
SkillsWindow.Skills = {}
SkillsWindow.NumSkills = 57
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
                tempValue = data.TempSkillValue,
                state = data.SkillState,
                realValue = tostring(data.RealSkillValue),
                cap = data.SkillCap,
            }
        )

        table.insert(order, i)
    end

    WindowApi.registerEventHandler(
        SkillsWindow.Name,
        Skills.event(),
        "SkillsWindow.UpdateSkills"
    )

    ListBoxSetDisplayOrder("SkillsWindowList", order)
end

function SkillsWindow.Shutdown()
    WindowDataApi.unregisterData(
        Skills.listDataType()
    )

    for i = 1, SkillsWindow.NumSkills - 1 do
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
        LabelApi.setText("SkillsWindowListRow" .. k .. "ItemName", SkillsWindow.Skills[v].skillName)
        LabelApi.setText("SkillsWindowListRow" .. k .. "ItemRealValue", SkillsWindow.Skills[v].realValue)
    end
end