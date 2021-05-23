UserContainerSettings = {}

UserContainerSettings.LegacyBackpackStyles = {
    SystemData.Settings.LegacyBackpackStyle.LEGACY_BACKPACK_DEFAULT,
    SystemData.Settings.LegacyBackpackStyle.LEGACY_BACKPACK_SUEDE,
    SystemData.Settings.LegacyBackpackStyle.LEGACY_BACKPACK_POLAR_BEAR,
    SystemData.Settings.LegacyBackpackStyle.LEGACY_BACKPACK_GHOUL_SKIN
}

function UserContainerSettings.alternateGrid(newValue)
    if newValue ~= nil then
        UserInterfaceVariables.SaveBoolean("AlternateGrid", newValue)
    end
    return UserInterfaceVariables.LoadBoolean("AlternateGrid", false)
end

function UserContainerSettings.gridLegacy(newValue)
    if newValue ~= nil then
        UserInterfaceVariables.SaveBoolean("GridLegacy", newValue)
    end
    return UserInterfaceVariables.LoadBoolean("GridLegacy", true)
end

function UserContainerSettings.gridContainer(newValue)
    if newValue ~= nil then
        UserInterfaceVariables.SaveBoolean("EnableContainerGrid", newValue)
    end
    return UserInterfaceVariables.LoadBoolean("EnableContainerGrid", false)
end

function UserContainerSettings.toggleContentsInfo(newValue)
    if newValue ~= nil then
        UserInterfaceVariables.SaveBoolean("ToggleContentsInfo", newValue)
    end
    return UserInterfaceVariables.LoadBoolean("ToggleContentsInfo", false)
end

function UserContainerSettings.corpseView(newValue)
    if newValue ~= nil then
        SystemData.Settings.Interface.defaultCorpseMode = newValue
    end
    return SystemData.Settings.Interface.defaultCorpseMode
end

function UserContainerSettings.containerView(newValue)
    if newValue ~= nil then
        SystemData.Settings.Interface.defaultContainerMode = newValue
    end
    return SystemData.Settings.Interface.defaultContainerMode
end

function UserContainerSettings.brightContainers(newValue)
    if newValue ~= nil then
        UserInterfaceVariables.SaveBoolean("ExtraBrightContainers", newValue)
    end
    return UserInterfaceVariables.LoadBoolean("ExtraBrightContainers", false)
end

function UserContainerSettings.gridColor(newValue)
    if newValue ~= nil then
        UserInterfaceVariables.SaveColor("BaseGridColor", newValue)
    end
    return UserInterfaceVariables.LoadColor("BaseGridColor", {
        r = 255,
        g = 255,
        b = 255
    })
end

function UserContainerSettings.alternateColor(newValue)
    if newValue ~= nil then
        UserInterfaceVariables.SaveColor("AlternateBackpack", newValue)
    end
    return UserInterfaceVariables.LoadColor("AlternateBackpack", {
        r = 80,
        g = 80,
        b = 80
    })
end

function UserContainerSettings.legacyBackPackStyle(newValue)
    if newValue ~= nil then
        SystemData.Settings.GameOptions.myLegacyBackpackType= newValue
    end
    return SystemData.Settings.GameOptions.myLegacyBackpackType
end

function UserContainerSettings.legacyContainers(newValue)
    if newValue ~= nil then
        SystemData.Settings.Interface.LegacyContainers = newValue
    end
    return SystemData.Settings.Interface.LegacyContainers
end