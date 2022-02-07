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

function Skills:csvId(index)
    return self:list()[index].CSVId
end

function Skills:iconId(index)
    return self:list()[index].iconId
end

function Skills:hasEntitlement(index)
    return self:list()[index].hasEntitlement
end

function Skills:name(index)
    return self:list()[index].skillName
end

function Skills:description(index)
    return self:list()[index].skillDescription
end

function Skills:tempValue(index)
    return self:dynamicData()[index].TempSkillValue
end

function Skills:state(index)
    return self:dynamicData()[index].SkillState
end

function Skills:realValue(index)
    return self:dynamicData()[index].RealSkillValue
end

function Skills:cap(index)
    return self:dynamicData()[index].SkillCap
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