Events = {}

function Events.SkillStateChange()
    return SystemData.Events.SKILLS_ACTION_SKILL_STATE_CHANGE
end

function Events.beginHealthBarDrag()
    return SystemData.Events.BEGIN_DRAG_HEALTHBAR_WINDOW
end

function Events.endHealthBarDrag()
    return SystemData.Events.END_DRAG_HEALTHBAR_WINDOW
end