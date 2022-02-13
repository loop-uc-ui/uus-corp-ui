WaypointDisplay = {}


function WaypointDisplay.currentDisplayMode()
    return WindowData.WaypointDisplay.currentDisplayMode
end

function WaypointDisplay.type()
    return WindowData.WaypointDisplay.Type
end

function WaypointDisplay.typeNames()
    return WindowData.WaypointDisplay.typeNames
end

function WaypointDisplay.displayTypes()
    return WindowData.WaypointDisplay.displayTypes
end

function WaypointDisplay.isTypeDisplayed(mode, index)
    return WindowData.WaypointDisplay.displayTypes[mode][index].isDisplayed
end

function WaypointDisplay.getTypeIndex(mode, index)
    return WindowData.WaypointDisplay.displayTypes[mode][index].displayIndex
end

function WaypointDisplay.getIconId(mode, index)
    Debug.Print(mode)
    Debug.Print(WindowData.WaypointDisplay.displayTypes[mode])
    return WindowData.WaypointDisplay.displayTypes[mode][index].iconId
end

function WaypointDisplay.iconNames()
    return WindowData.WaypointDisplay.iconNames
end

function WaypointDisplay.iconIds()
    return WindowData.WaypointDisplay.iconIds
end

function WaypointDisplay.effectNames()
    return WindowData.WaypointDisplay.effectNames
end