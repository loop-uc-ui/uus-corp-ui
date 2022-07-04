MapWindow = {}

MapWindow.Name = "MapWindow"

MapWindow.MapImage = MapWindow.Name .. "MapImage"

function MapWindow.onInitialize()
    WindowDataApi.registerData(
        PlayerLocation.type()
    )

    WindowDataApi.registerData(
        Radar.type()
    )

    WindowDataApi.registerData(
        WaypointDisplay.type()
    )

    WindowDataApi.registerData(
        WaypointList.type()
    )

    WindowApi.registerEventHandler(
        MapWindow.Name,
        Radar.event(),
        "MapWindow.onUpdateMap"
    )

    WindowApi.registerEventHandler(
        MapWindow.Name,
        WaypointList.event(),
        "MapWindow.onUpdateWaypoints"
    )

    local x, y = WindowApi.getDimensions(
        MapWindow.MapImage
    )

    RadarApi.setWindowSize(
        x,
        y,
        true,
        true
    )

    RadarApi.setOffset(0, 0)

    RadarApi.setCenterOnPlayer(true)

    MapSettings.setMode(MapSettings.MODES.ATLAS)

    DynamicImageApi.setRotation(
        MapWindow.MapImage,
        Radar.textureRotation()
    )
end

function MapWindow.onUpdateMap()
    DynamicImageApi.setTextureScale(
        MapWindow.MapImage,
        Radar.textureScale()
    )

    DynamicImageApi.setTexture(
        MapWindow.MapImage,
        "radar_texture",
        Radar.textureXCord(),
        Radar.textureYCord()
    )

    MapWindow.onUpdateWaypoints()
end

function MapWindow.onUpdateWaypoints()
    WindowApi.createFromTemplate(
        "WaypointInfoPlayer",
        "WaypointIconTemplate",
        MapWindow.Name .. "Map"
    )

    local iconTexture, x, y = IconApi.getIconData(
        WaypointDisplay.getTypeIconId(
            MapSettings.MODES.ATLAS,
            WaypointDisplay.TYPE_PLAYER
        )
    )

    local width, height = IconApi.getTextureSize(
        "icon" .. WaypointDisplay.getTypeIconId(
            MapSettings.MODES.ATLAS,
            WaypointDisplay.TYPE_PLAYER
        )
    )

    DynamicImageApi.setTexture(
        "WaypointInfoPlayer",
        iconTexture,
        x,
        y
    )

    WindowApi.setScale(
        "WaypointInfoPlayer",
        0.5
    )

    WindowApi.setDimensions(
        "WaypointInfoPlayer",
        width,
        height
    )

    WindowApi.clearAnchors("WaypointInfoPlayer")

    WindowApi.addAnchor(
        "WaypointInfoPlayer",
        "center",
        MapWindow.Name .. "Map",
        "center",
        0,
        0
    )
end

function MapWindow.onShutdown()
    WindowDataApi.unregisterData(
        PlayerLocation.type()
    )

    WindowDataApi.unregisterData(
        Radar.type()
    )

    WindowDataApi.unregisterData(
        WaypointDisplay.type()
    )

    WindowDataApi.registerData(
        WaypointList.type()
    )

    WindowApi.unregisterEventHandler(
        MapWindow.Name,
        Radar.event()
    )

    WindowApi.unregisterEventHandler(
        MapWindow.Name,
        WaypointList.event()
    )
end

function MapWindow.onRightClick()
    WindowApi.destroyWindow(MapWindow.Name)
end

function MapWindow.onMouseWheel(_, _, delta)
    local zoom = MapSettings.getZoom() - (delta * 0.2)
    local maxZoom = RadarApi.getMaxZoom(
        RadarApi.getFacet(),
        RadarApi.getArea()
    )

    if zoom < -2 then
        zoom = -2
    elseif zoom > maxZoom then
        zoom = maxZoom
    end

    RadarApi.setZoom(zoom)
    MapSettings.setZoom(zoom)
end

function MapWindow.onMapMouseDrag(_, deltaX, deltaY)
    if deltaX == 0 or deltaY == 0 then
        return
    end

    RadarApi.setCenterOnPlayer(false)

    local area = RadarApi.getArea()
    local facet = RadarApi.getFacet()
    local centerX, centerY = RadarApi.getCenter()
    local worldPosX, worldPosY = RadarApi.worldPosToRadar(centerX, centerY)

    centerX, centerY = RadarApi.radarPosToWorld(
        worldPosX - deltaX,
        worldPosY - deltaY,
        false
    )

    RadarApi.centerOnLocation(
        centerX,
        centerY,
        facet,
        area,
        false
    )
end

function MapWindow.onMapLButtonDown()
    --Stubbed, needed for dragging
end

function MapWindow.onMapDoubleClick()
    RadarApi.setCenterOnPlayer(true)
end