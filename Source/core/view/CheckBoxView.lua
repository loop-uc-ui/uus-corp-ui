CheckBoxView = {}

function CheckBoxView:new(id)
    local this = {}
    setmetatable(this, self)
    self.__index = self
    this.id = id
    return this
end

function CheckBoxView:setEnabled(isEnabled)
    ButtonSetCheckButtonFlag(self.id, isEnabled)
end

function CheckBoxView:setChecked(isChecked)
    ButtonSetPressedFlag(self.id, isChecked)
end

function CheckBoxView:isChecked()
    return ButtonGetPressedFlag(self.id)
end
