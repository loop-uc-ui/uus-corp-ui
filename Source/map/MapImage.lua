MapImage = BaseWindow:new()

function MapImage:new(id, isCircular)
    local this = {
        id = id,
        isCircular = isCircular or true,
        texture = "radar_texture",
        centerOnPlayer = true
    }
    if this.isCircular then
        MapSettings.setMode(MapSettings.MODES.RADAR)
    else
        MapSettings.setMode(MapSettings.MODES.ATLAS)
    end
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

end

