MapImage = BaseWindow:new()

function MapImage:new(id, isCircular, facet, area)
    local this = {
        id = id,
        isCircular = isCircular or true,
        texture = "radar_texture",
        centerOnPlayer = true,
        facet = facet or RadarApi.getFacet(),
        area = area or RadarApi.getArea(),
        zoom = MapSettings.getZoom()
    }
    if this.isCircular then
        MapSettings.setMode(MapSettings.MODES.RADAR)
    else
        MapSettings.setMode(MapSettings.MODES.ATLAS)
    end
    this.mazZoom = RadarApi.getMaxZoom(this.facet, this.area)
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
    return self
end

function MapImage:activate()
    local width, height = self:getDimensions()
    RadarApi.setWindowSize(width, height, true, self.centerOnPlayer)
    RadarApi.setOffset(0, 0)
    self:setTexture(Radar.textureXCord(), Radar.textureYCord())
end

