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

    local waypoints = WaypointList.Waypoints.Facet[RadarApi.getFacet()]

    for i = 1, #waypoints do
        WindowApi.createFromTemplate(
            "Waypoint" .. i,
            "WaypointIconTemplate",
            MapWindow.Name .. "Map"
        )
    end
end

function MapWindow.onWaypointInitialize()
    local window = Active.window()
    local waypoint = string.gsub(
        window,
        "Waypoint",
        ""
    )

    waypoint = WaypointList.Waypoints.Facet[RadarApi.getFacet()][tonumber(waypoint)]

    local iconTexture, xIcon, yIcon = IconApi.getIconData(
        tonumber(waypoint.Icon)
    )

    local width, height = IconApi.getTextureSize(
        "icon" .. waypoint.Icon
    )

    DynamicImageApi.setTexture(
        window,
        iconTexture,
        xIcon,
        yIcon
    )

    WindowApi.setScale(
        window,
        0.3
    )

    WindowApi.setDimensions(
        window,
        width,
        height
    )

    WindowApi.clearAnchors(window)

    local xCord, yCord = RadarApi.worldPosToRadar(
        tonumber(waypoint.x),
        tonumber(waypoint.y)
    )

    local centerX, centerY = RadarApi.getCenter()

    centerX, centerY = RadarApi.worldPosToRadar(
        centerX,
        centerY
    )

    WindowApi.addAnchor(
        window,
        "center",
        MapWindow.Name .. "Map",
        "center",
        xCord - centerX,
        yCord - centerY
    )
end

function MapWindow.onUpdateMap()
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

    local xCord, yCord = RadarApi.worldPosToRadar(
        PlayerLocation.xCord(),
        PlayerLocation.yCord()
    )

    WindowApi.addAnchor(
        "WaypointInfoPlayer",
        "topleft",
        MapWindow.Name .. "Map",
        "center",
        xCord / 4,
        yCord / 4
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