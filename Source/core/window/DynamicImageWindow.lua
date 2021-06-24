DynamicImageWindow = BaseWindow:new()

function DynamicImageWindow:new(id)
    local this = {
        id = id
    }
    self.__index = self
    return setmetatable(this, self)
end

