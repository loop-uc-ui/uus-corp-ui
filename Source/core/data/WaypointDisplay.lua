WaypointDisplay = {}

function WaypointDisplay.currentDisplayMode()
    return WindowData.WaypointDisplay.currentDisplayMode
end

function WaypointDisplay.typeNames()
    return WindowData.WaypointDisplay.typeNames
end

function WaypointDisplay.displayTypes()
    return WindowData.WaypointDisplay.displayTypes
end

function WaypointDisplay.isTypeDisplayed(type)
    return WaypointDisplay.displayTypes()[type].isDisplayed
end

function WaypointDisplay.getTypeIndex(type)
    return WaypointDisplay.displayTypes()[type].displayIndex
end

function WaypointDisplay.getIconId(type)
    return WaypointDisplay.displayTypes()[type].iconId
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