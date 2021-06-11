ButtonWindow = BaseWindow:new()

function ButtonWindow:new(id)
    local this = {
        id = id
    }
    self.__index = self
    return setmetatable(this, self)
end

function ButtonWindow:setText(text)
    if type(text) == "number" then
        text = StringFormatter.fromTid(text)
    elseif type(text) == "string" then
        text = StringFormatter.toWString(text)
    end
    ButtonApi.setText(self.id, text)
end

function ButtonWindow:setDisabledFlag(flag)
    ButtonApi.setDisabled(self.id, flag)
end

function ButtonWindow:setTexture(state, texture, x, y)
    ButtonApi.setTexture(self.id, state, texture, x, y)
end