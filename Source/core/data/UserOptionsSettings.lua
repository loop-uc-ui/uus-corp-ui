UserOptionsSettings = {}

UserOptionsSettings.Languages = {
    SystemData.Settings.Language.LANGUAGE_ENU,
    SystemData.Settings.Language.LANGUAGE_JPN,
    SystemData.Settings.Language.LANGUAGE_CHINESE_TRADITIONAL,
    SystemData.Settings.Language.LANGUAGE_KOR
}

function UserOptionsSettings.useEnglishNames(newValue)
    if newValue ~= nil then
        SystemData.Settings.Language.englishNames = newValue
    end
    return SystemData.Settings.Language.englishNames
end

function UserOptionsSettings.cacheSize(newValue)
    if newValue ~= nil then
        SystemData.Settings.Optimization.cacheSize = newValue
    end
    return SystemData.Settings.Optimization.cacheSize
end

function UserOptionsSettings.uiScale(newValue)
    if newValue ~= nil then
        SystemData.Settings.Interface.customUiScale = newValue
    end
    return SystemData.Settings.Interface.customUiScale
end

function UserOptionsSettings.genericGumpScale(newValue)
    if newValue ~= nil then
        SystemData.Settings.Interface.customGenericGumpScale = newValue
    end
    return SystemData.Settings.Interface.customGenericGumpScale
end

function UserOptionsSettings.alwaysRun(newValue)
    if newValue ~= nil then
        SystemData.Settings.GameOptions.alwaysRun = newValue
    end
    return SystemData.Settings.GameOptions.alwaysRun
end

function UserOptionsSettings.autoRun(newValue)
    if newValue ~= nil then
        SystemData.Settings.GameOptions.enableAutorun = newValue
    end
    return SystemData.Settings.GameOptions.enableAutorun
end

function UserOptionsSettings.pathfinding(newValue)
    if newValue ~= nil then
        SystemData.Settings.GameOptions.enablePathfinding = newValue
    end
    return SystemData.Settings.GameOptions.enablePathfinding
end

function UserOptionsSettings.queryBeforeCriminalAction(newValue)
    if newValue ~= nil then
        SystemData.Settings.GameOptions.queryBeforeCriminalAction = newValue
    end
    return SystemData.Settings.GameOptions.queryBeforeCriminalAction
end

function UserOptionsSettings.ignoreMouseActionsOnSelf(newValue)
    if newValue ~= nil then
        SystemData.Settings.GameOptions.ignoreMouseActionsOnSelf = newValue
    end
    return SystemData.Settings.GameOptions.ignoreMouseActionsOnSelf
end

function UserOptionsSettings.shiftRightClickContextMenus(newValue)
    if newValue ~= nil then
        SystemData.Settings.GameOptions.shiftRightClickContextMenus = newValue
    end
    return SystemData.Settings.GameOptions.shiftRightClickContextMenus
end

function UserOptionsSettings.holdShiftToUnstack(newValue)
    if newValue ~= nil then
        SystemData.Settings.GameOptions.holdShiftToUnstack = newValue
    end
    return SystemData.Settings.GameOptions.holdShiftToUnstack
end

function UserOptionsSettings.targetQueueing(newValue)
    if newValue ~= nil then
        SystemData.Settings.GameOptions.targetQueueing = newValue
    end
    return SystemData.Settings.GameOptions.targetQueueing
end

function UserOptionsSettings.alwaysAttack(newValue)
    if newValue ~= nil then
        SystemData.Settings.GameOptions.alwaysAttack = newValue
    end
    return SystemData.Settings.GameOptions.alwaysAttack
end

function UserOptionsSettings.showTooltips(newValue)
    if newValue ~= nil then
        SystemData.Settings.Interface.showTooltips = newValue
    end
    return SystemData.Settings.Interface.showTooltips
end

function UserOptionsSettings.partyInvitePopUp(newValue)
    if newValue ~= nil then
        SystemData.Settings.Interface.partyInvitePopUp = newValue
    end
    return SystemData.Settings.Interface.partyInvitePopUp
end

function UserOptionsSettings.enableChatLog(newValue)
    if newValue ~= nil then
        SystemData.Settings.GameOptions.enableChatLog = newValue
    end
    return SystemData.Settings.GameOptions.enableChatLog
end

function UserOptionsSettings.blockWarOnPets(newValue)
    if newValue ~= nil then
        SystemData.Settings.GameOptions.noWarOnPets = newValue
    end
    return SystemData.Settings.GameOptions.noWarOnPets
end

function UserOptionsSettings.blockWarOnParty(newValue)
    if newValue ~= nil then
        SystemData.Settings.GameOptions.noWarOnParty = newValue
    end
    return SystemData.Settings.GameOptions.noWarOnParty
end

function UserOptionsSettings.blockWarOnFriendly(newValue)
    if newValue ~= nil then
        SystemData.Settings.GameOptions.noWarOnFriendly = newValue
    end
    return SystemData.Settings.GameOptions.noWarOnFriendly
end

function UserOptionsSettings.showWarShield(newValue)
    if  newValue ~= nil then
        UserInterfaceVariables.SaveBoolean("WarShield", newValue)
        return newValue
    else
        return UserInterfaceVariables.LoadBoolean("WarShield", true)
    end
end

function UserOptionsSettings.autoIgnoreCorpses(newValue)
    if  newValue ~= nil then
        UserInterfaceVariables.SaveBoolean("AutoIgnoreCorpses", newValue)
        return newValue
    else
        return UserInterfaceVariables.LoadBoolean("AutoIgnoreCorpses", true)
    end
end

function UserOptionsSettings.enableSnapping(newValue)
    if  newValue ~= nil then
        UserInterfaceVariables.SaveBoolean("EnableSnapping", newValue)
        return newValue
    else
        return UserInterfaceVariables.LoadBoolean("EnableSnapping", true)
    end
end

function UserOptionsSettings.language(newValue)
    if newValue ~= nil then
        SystemData.Settings.Language.type = newValue
    end
    return SystemData.Settings.Language.type
end

function UserOptionsSettings.objectHandleFilter(newValue)
    if newValue ~= nil then
        SystemData.Settings.GameOptions.objectHandleFilter = newValue
    end
    return SystemData.Settings.GameOptions.objectHandleFilter
end

function UserOptionsSettings.customUI(newValue)
    if newValue ~= nil then
        SystemData.Settings.Interface.customUiName = newValue
    end
    return SystemData.Settings.Interface.customUiName
end

function UserOptionsSettings.legacyChat(newValue)
    if newValue ~= nil then
        SystemData.Settings.Interface.LegacyChat = newValue
    end
    return SystemData.Settings.Interface.LegacyChat
end

function UserOptionsSettings.legacyTarget(newValue)
    if newValue ~= nil then
        SystemData.Settings.GameOptions.legacyTargeting = newValue
    end
    return SystemData.Settings.GameOptions.legacyTargeting
end

function UserOptionsSettings.customUiList()
    return SystemData.CustomUIList
end

