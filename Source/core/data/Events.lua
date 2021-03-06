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

function Events.onLButtonDown()
    return SystemData.Events.L_BUTTON_DOWN_PROCESSED
end

function Events.onEscape()
    return SystemData.Events.ESCAPE_KEY_PROCESSED
end

function Events.onLButtonUp()
    return SystemData.Events.L_BUTTON_UP_PROCESSED
end

function Events.onRButtonDown()
    return SystemData.Events.R_BUTTON_DOWN_PROCESSED
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

function Events.exitGame()
    return SystemData.Events.EXIT_GAME
end

function Events.chatEnterStart()
    return SystemData.Events.CHAT_ENTER_START
end

function Events.textArrived()
    return SystemData.Events.TEXT_ARRIVED
end

function Events.userSettingsUpdated()
    return SystemData.Events.USER_SETTINGS_UPDATED
end

function Events.gChatRosterUpdate()
    return SystemData.Events.GHAT_ROSTER_UPDATE
end

function Events.gumpArrived()
    return SystemData.Events.GG_ARRIVED
end

function Events.gumpClosed()
    return SystemData.Events.GG_CLOSE
end

function Events.gumpReady()
    return SystemData.Events.GG_DATA_READY
end

function Events.showNamesUpdated()
    return SystemData.Events.SHOWNAMES_UPDATED
end

function Events.showNamesFlashTemp()
    return SystemData.Events.SHOWNAMES_FLASH_TEMP
end

function Events.togglePaperdoll()
    return SystemData.Events.TOGGLE_PAPERDOLL_CHARACTER_WINDOW
end

function Events.toggleBackpack()
    return SystemData.Events.TOGGLE_BACKPACK_WINDOW
end

function Events.toggleSkills()
    return SystemData.Events.TOGGLE_SKILLS_WINDOW
end

function Events.createObjectHandles()
    return SystemData.Events.CREATE_OBJECT_HANDLES
end

function Events.destroyObjectHandles()
    return SystemData.Events.DESTROY_OBJECT_HANDLES
end

function Events.contextMenuSelected()
    return SystemData.Events.CONTEXT_MENU_SELECTED
end

function Events.displayActiveAbilities()
    return SystemData.Events.ABILITY_DISPLAY_ACTIVE
end

function Events.resetAbilities()
    return SystemData.Events.ABILITY_RESET
end

function Events.toggleMap()
    return SystemData.Events.TOGGLE_WORLD_MAP_WINDOW
end