MapSettings = {}

MapSettings.MODES = {
    HIDDEN = "HIDDEN",
    RADAR = "RADAR",
    ATLAS = "ATLAS"
}

local MAP_SETTING_ZOOM = "MapZoom"

function MapSettings.getMapMode()
    return SystemData.Settings.Interface.mapMode
end

function MapSettings.isAtlas()
    return MapSettings.getMapMode() == MapSettings.MODES.ATLAS
end

function MapSettings.isRadar()
    return MapSettings.getMapMode() == MapSettings.MODES.RADAR
end

function MapSettings.isHidden()
    return MapSettings.getMapMode() == MapSettings.MODES.HIDDEN
end

function MapSettings.setMode(mode)
    SystemData.Settings.Interface.mapMode = mode
end

function MapSettings.setZoom(zoom)
    UserInterfaceVariables.SaveNumber(MAP_SETTING_ZOOM, zoom)
end

function MapSettings.getZoom()
    return UserInterfaceVariables.LoadNumber(MAP_SETTING_ZOOM, 0)
end

