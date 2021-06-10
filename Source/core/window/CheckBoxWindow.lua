CheckBoxWindow = BaseWindow:new()

function CheckBoxWindow:new(id)
    local this = {
        id = id
    }
    self.__index = self
    return setmetatable(this, self)
end

function CheckBoxWindow:setEnabled(isEnabled)
    ButtonApi.setEnabled(self.id, isEnabled)
end

function CheckBoxWindow:setChecked(isChecked)
    ButtonApi.setChecked(self.id, isChecked)
end

function CheckBoxWindow:isChecked()
    return ButtonApi.isChecked(self.id)
end
