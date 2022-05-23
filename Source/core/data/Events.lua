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

function Events.enableHealthBar()
    return SystemData.Events.ENABLE_HEALTHBAR_WINDOW
end

function Events.disableHealthBar()
    return SystemData.Events.DISABLE_HEALTHBAR_WINDOW
end

function Events.onLButtonUp()
    return SystemData.Events.L_BUTTON_UP_PROCESSED
end

function Events.logOut()
    return SystemData.Events.LOG_OUT
end

function Events.help()
    return SystemData.Events.REQUEST_OPEN_HELP_MENU
end

function Events.store()
    return SystemData.Events.UO_STORE_REQUEST
end