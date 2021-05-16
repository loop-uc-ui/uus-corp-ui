ButtonView = {}
ButtonView.__index = ButtonView

function ButtonView:new(id)
    local this = {
        id = id
    }
    setmetatable(this, self)
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