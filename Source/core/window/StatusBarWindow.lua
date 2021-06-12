StatusBarWindow = BaseWindow:new()

function StatusBarWindow:new(id)
    local this = {}
    this.id = id
    self.__index = self
    return setmetatable(this, self)
end

function StatusBarWindow:setMaximumValue(value)
    StatusBarApi.setMaximumValue(self.id, value)
end

function StatusBarWindow:setCurrentValue(value)
    StatusBarApi.setCurrentValue(self.id, value)
end