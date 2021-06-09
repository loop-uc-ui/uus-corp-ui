SliderWindow = BaseWindow:new()

function SliderWindow:new(id)
    local this = {
        id = id
    }
    self.__index = self
    return setmetatable(this, self)
end

function SliderWindow:setPosition(position)
    SliderBarSetCurrentPosition(self.id, position)
end

function SliderWindow:getPosition()
    return SliderBarGetCurrentPosition(self.id)
end