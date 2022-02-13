MapImage = BaseWindow:new()

function MapImage:new(id, isCircular, facet, area, rotation)
    local this = {
        id = id,
        isCircular = isCircular or true,
        texture = "radar_texture",
        centerOnPlayer = true,
        facet = facet or RadarApi.getFacet(),
        area = area or RadarApi.getArea(),
        zoom = MapSettings.getZoom(),
        rotation = rotation or 45
    }

    if this.isCircular then
        MapSettings.setMode(MapSettings.MODES.RADAR)
    else
        MapSettings.setMode(MapSettings.MODES.ATLAS)
    end

    this.maxZoom = RadarApi.getMaxZoom(this.facet, this.area)

    self.__index = self
    return setmetatable(this, self)
end

function MapImage:setTexture(xCord, yCord)
    if self.isCircular then
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
    if self.isCircular then
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
    if self.isCircular then
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

function MapImage:update()
    self:setRotation(self.rotation)
    self:setTextureScale(Radar.textureScale())
    local width, height = WindowApi.getDimensions(self.id)
    self:setTexture(Radar.textureXCord() + width / 2, Radar.textureYCord() + height / 2)

    local area = RadarApi.getArea()
    self.area = area
    local facet = RadarApi.getFacet()
    self.facet = facet
    self.zoom = MapSettings.getZoom()
    self.maxZoom = RadarApi.getMaxZoom(facet, area)
end

function MapImage:onMouseWheel(x, y, delta)
    local zoom = self.zoom - (delta * 0.2)

    if zoom < -2 then
        zoom = -2
    elseif zoom > self.maxZoom then
        zoom = self.maxZoom
    end

    RadarApi.setZoom(zoom)
    MapSettings.setZoom(zoom)
    self.zoom = zoom
end

