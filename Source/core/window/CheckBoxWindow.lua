CheckBoxWindow = BaseWindow:new()

function CheckBoxWindow:new(id)
    local this = {
        id = id
    }
    self.__index = self
    return setmetatable(this, self)
end

function CheckBoxWindow:setEnabled(isEnabled)
    ButtonSetCheckButtonFlag(self.id, isEnabled)
end

function CheckBoxWindow:setChecked(isChecked)
    ButtonSetPressedFlag(self.id, isChecked)
end

function CheckBoxWindow:isChecked()
    return ButtonGetPressedFlag(self.id)
end
