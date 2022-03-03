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

function ButtonWindow:getText()
    return ButtonApi.getText(self.id)
end

function ButtonWindow:setDisabledFlag(flag)
    ButtonApi.setDisabled(self.id, flag)
end

function ButtonWindow:isDisabled()
    return ButtonApi.isDisabled(self.id)
end

function ButtonWindow:setTexture(state, texture, x, y)
    ButtonApi.setTexture(self.id, state, texture, x, y)
    return self
end

function ButtonWindow:setHighlight(doHighlight)
    ButtonApi.setHighlight(self.id, doHighlight or true)
    return self
end

function ButtonWindow:stayDown(stayDown)
    ButtonApi.setStayDown(self.id, stayDown or true)
    return self
end

function ButtonWindow:isStayDown()
    return ButtonApi.isStayDown(self.id)
end

function ButtonWindow:setChecked(isChecked)
    ButtonApi.setChecked(self.id, isChecked or true)
    return self
end

function ButtonWindow:isChecked()
    return ButtonApi.isChecked(self.id)
end

function ButtonWindow:setTextColor(color)
    ButtonApi.setTextColor(self.id, color.r or 255, color.g or 255, color.b or 255, color.a or 255)
    return self
end