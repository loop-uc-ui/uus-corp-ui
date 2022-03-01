MapImage = ListWindow:new()

function MapImage:new(id, mode, facet, area)
    local this = {
        id = id,
        texture = "radar_texture",
        centerOnPlayer = true,
        facet = facet,
        area = area,
        isInitialized = false,
        forceUpdate = false
    }
    MapSettings.setMode(mode)
    self.__index = self
    return setmetatable(this, self)
end

function MapImage:setTexture(xCord, yCord)
    if MapSettings.isRadar() then
        CircleImageApi.setTexture(
                self.id,
                self.texture,
                xCord,
                yCord
        )
    else
        DynamicImageApi.setTexture(
                self.id,
                self.texture,
                xCord,
                yCord
        )
    end
end

function MapImage:setTextureScale(scale)
    if MapSettings.isRadar() then
        CircleImageApi.setTextureScale(
                self.id,
                scale
        )
    else
        DynamicImageApi.setTextureScale(
                self.id,
                scale
        )
    end
end

function MapImage:setRotation(rotation)
    if MapSettings.isRadar() then
        CircleImageApi.setRotation(
                self.id,
                rotation
        )
    else
        DynamicImageApi.setRotation(
                self.id,
                rotation
        )
    end
    RadarApi.setRotation(rotation)
end

function MapImage:addWaypoint(id, name, iconId, x, y)
    local waypoint = WaypointWindow:new(
            id,
            name,
            iconId,
            self.id,
            x,
            y
    )
    self.adapter.views[waypoint.id] = waypoint
    return waypoint
end

function MapImage:update(facet, area)
    if facet == nil or area == nil then
        return
    end

    self:setRotation(45)
    self:setTextureScale(Radar.textureScale())

    local width, height = WindowApi.getDimensions(self.id)

    if MapSettings.isRadar() then
        width = width / 2
        height = height / 2
    else
        width = 0
        height = 0
    end

    local forceUpdate = self.forceUpdate or not self.isInitialized

    self.area = area
    self.facet = facet

    if forceUpdate then
        self:clearWaypoints()
    end

    self:setTexture(Radar.textureXCord() + width, Radar.textureYCord() + height)

    if not WindowApi.doesExist("WaypointIconPlayer") and area == RadarApi.getArea() and facet == RadarApi.getFacet() then
        self:addWaypoint(
                "WaypointIconPlayer",
                nil,
                WaypointDisplay.getTypeIconId(MapSettings.getMapMode(), WaypointDisplay.TYPE_PLAYER),
                PlayerLocation.xCord(),
                PlayerLocation.yCord()
        )
    end

    if forceUpdate and MapSettings.isAtlas() then
        for _, value in pairs(Waypoints.Facet[facet]) do
            local id = "Waypoint"..value.Name.."_"..RadarApi.getFacetLabel(facet).."_"..RadarApi.getAreaLabel(facet, area).."_"..value.Icon
            if not WindowApi.doesExist(id) then
                self:addWaypoint(
                        id,
                        value.Name,
                        tonumber(value.Icon),
                        tonumber(value.x),
                        tonumber(value.y)
                )
            end
        end
    end

    for key, value in pairs(self.adapter.views) do
        if key == "WaypointIconPlayer" then
            value:update(
                    PlayerLocation.xCord(),
                    PlayerLocation.yCord()
            )
        elseif WindowApi.doesExist(key) then
            value:update()
        end
    end

    self.forceUpdate = false
    self.isInitialized = true
end

function MapImage:clearWaypoints()
    for key, value in pairs(self.adapter.views) do
        if string.find(key, "Waypoint") and WindowApi.doesExist(key) then
            value:destroy()
            self.adapter.views[key] = nil
        end
    end
end

function MapImage:onMouseWheel(delta, facet, area)
    local zoom = MapSettings.getZoom() - (delta * 0.2)
    local maxZoom = RadarApi.getMaxZoom(facet or self.facet, area or self.area)

    if zoom < -2 then
        zoom = -2
    elseif zoom > maxZoom then
        zoom = maxZoom
    end

    RadarApi.setZoom(zoom)
    MapSettings.setZoom(zoom)
end

function MapImage:setCenterOnPlayer(isCenter)
    self.centerOnPlayer = isCenter
    RadarApi.setCenterOnPlayer(isCenter)
end
