SliderView = {}

function SliderView:new(id)
    local this = {}
    setmetatable(this, self)
    self.__index = self
    this.id = id
    return this
end

function SliderView:setPosition(position)
    SliderBarSetCurrentPosition(self.id, position)
end

function SliderView:getPosition()
    return SliderBarGetCurrentPosition(self.id)
end