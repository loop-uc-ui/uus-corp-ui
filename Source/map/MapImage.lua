MapImage = BaseWindow:new()

function MapImage:new(id, isCircular)
    local this = {
        id = id,
        isCircular = isCircular,
        texture = "radar_texture"
    }
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

