Skills = {}

function Skills.dynamicDataType()
    return WindowData.SkillDynamicData.Type
end

function Skills.listDataType()
    return WindowData.SkillList.Type
end

function Skills.list()
    return WindowData.SkillList
end

function Skills.dynamicData()
    return WindowData.SkillDynamicData
end

function Skills.csvId(index)
    return Skills.list()[index].CSVId
end

function Skills.iconId(index)
    return Skills.list()[index].iconId
end

function Skills.hasEntitlement(index)
    return Skills.list()[index].hasEntitlement
end

function Skills.name(index)
    return Skills.list()[index].skillName
end

function Skills.description(index)
    return Skills.list()[index].skillDescription
end

function Skills.tempValue(index)
    return Skills.dynamicData()[index].TempSkillValue
end

function Skills.state(index, newState)
    if newState ~= nil then
        Skills.dynamicData()[index].SkillState = newState
    end
    return Skills.dynamicData()[index].SkillState
end

function Skills.realValue(index)
    return Skills.dynamicData()[index].RealSkillValue
end

function Skills.cap(index)
    return Skills.dynamicData()[index].SkillCap
end

function Skills.icon(index)
    return WindowData.SkillsCSV[index].IconId
end

function Skills.serverId(index)
    return WindowData.SkillsCSV[index].ServerId
end

function Skills.dragIcon(index)
    return WindowData.SkillsCSV[index].DragIcon
end

function Skills.setId(id)
    ReturnWindowData.SkillSystem.SkillId = id
end

function Skills.setState(id, state)
    WindowData.SkillDynamicData[id].SkillState = state
    ReturnWindowData.SkillSystem.SkillButtonState = state
end

function Skills.event()
    return Skills.dynamicData().Event
end

function Skills.csv()
    return WindowData.SkillsCSV
end