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
    ButtonSetText(self.id,text)
end

function ButtonWindow:setDisabledFlag(flag)
    ButtonSetDisabledFlag(self.id, flag)
end