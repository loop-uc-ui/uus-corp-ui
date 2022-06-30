MapWindow = {}

MapWindow.Name = "MapWindow"

MapWindow.MapImage = MapWindow.Name .. "MapImage"

function MapWindow.onInitialize()
    WindowDataApi.registerData(
        Radar.type(),
        0
    )

    WindowDataApi.registerData(
        WaypointDisplay.type(),
        0
    )

    WindowDataApi.registerData(
        WaypointList.type(),
        0
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

    MapSettings.setMode(MapSettings.MODES.ATLAS)

    DynamicImageApi.setRotation(
        MapWindow.MapImage,
        Radar.textureRotation()
    )

    MapWindow.onUpdateMap()
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
end

function MapWindow.onUpdateWaypoints()

end

function MapWindow.onShutdown()

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

function MapWindow.onLButtonDown()
    --Stubbed, needed for dragging
end