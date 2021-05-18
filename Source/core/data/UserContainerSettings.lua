UserContainerSettings = {}

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
    return UserInterfaceVariables.LoadBoolean("GridLegacy", false)
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
    return UserInterfaceVariables.LoadColor("BaseGridColor")
end

function UserContainerSettings.alternateColor(newValue)
    if newValue ~= nil then
        UserInterfaceVariables.SaveColor("AlternateBackpack", newValue)
    end
    return UserInterfaceVariables.LoadColor("AlternateBackpack")
end