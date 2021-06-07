ButtonView = {}

function ButtonView:new(id)
    local this = {}
    setmetatable(this, self)
    self.__index = self
    this.id = id
    return this
end

function ButtonView:setText(text)
    if type(text) == "number" then
        text = StringFormatter.fromTid(text)
    elseif type(text) == "string" then
        text = StringFormatter.toWString(text)
    end
    ButtonSetText(self.id,text)
end

function ButtonView:setDisabledFlag(flag)
    ButtonSetDisabledFlag(self.id, flag)
end