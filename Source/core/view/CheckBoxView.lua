CheckBoxView = {}
CheckBoxView.__index = CheckBoxView

function CheckBoxView:new(id)
    local this = {
        id = id
    }
    setmetatable(this, self)
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
