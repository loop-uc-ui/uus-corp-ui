MapSettings = {}

local MAP_MODE_HIDDEN = "hidden"
local MAP_MODE_RADAR = "radar"
local MAP_MODE_ATLAS = "atlas"
local MAP_SETTING_ZOOM = "MapZoom"

function MapSettings.getMapMode()
    return SystemData.Settings.Interface.mapMode
end

function MapSettings.isAtlas()
    return MapSettings.getMapMode() == MAP_MODE_ATLAS
end

function MapSettings.isRadar()
    return MapSettings.getMapMode() == MAP_MODE_RADAR
end

function MapSettings.isHidden()
    return MapSettings.getMapMode() == MAP_MODE_HIDDEN
end

function MapSettings.setZoom(zoom)
    UserInterfaceVariables.SaveNumber(MAP_SETTING_ZOOM, zoom)
end

function MapSettings.getZoom()
    return UserInterfaceVariables.LoadNumber(MAP_SETTING_ZOOM, -100)
end

