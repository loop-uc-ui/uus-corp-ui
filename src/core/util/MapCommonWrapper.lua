MapCommonWrapper = {}

MapCommonWrapper.Modes = {
    Radar = MapCommon.RADAR_MODE_NAME,
    Hidden = MapCommon.HIDDEN,
    Atlas = MapCommon.MAP_MODE_NAME
}

function MapCommonWrapper.setMode(mode)
    MapCommon.ActiveView = mode
end

function MapCommonWrapper.adjustZoom(zoom)
    MapCommon.AdjustZoom(zoom)
end