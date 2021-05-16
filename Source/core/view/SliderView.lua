SliderView = {}
SliderView.__index = SliderView

function SliderView:new(id)
    local this = {
        id = id
    }
    setmetatable(this, self)
    return this
end

function SliderView:setPosition(position)
    SliderBarSetCurrentPosition(self.id, position)
end

function SliderView:getPosition()
    return SliderBarGetCurrentPosition(self.id)
end