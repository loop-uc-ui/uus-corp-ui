DynamicImageWindow = BaseWindow:new()

function DynamicImageWindow:new(id)
    local this = {}
    this.id = id
    self.__index = self
    return setmetatable(this, self)
end

function DynamicImageWindow:setTexture(texture, xOffset, yOffset)
    DynamicImageApi.setTexture(self.id, texture, xOffset, yOffset)
end