DynamicImageWindow = BaseWindow:new()

function DynamicImageWindow:new(id)
    local this = {}
    this.id = id
    self.__index = self
    return setmetatable(this, self)
end

function DynamicImageWindow:setTexture(texture, xOffset, yOffset)
    DynamicImageApi.setTexture(self.id, texture, xOffset, yOffset)
    return self
end

function DynamicImageWindow:setTextureDimensions(x, y)
    DynamicImageApi.setTextureDimensions(self.id, x, y)
    return self
end

function DynamicImageWindow:setRotation(rotation)
    DynamicImageApi.setRotation(self.id, rotation)
    return self
end