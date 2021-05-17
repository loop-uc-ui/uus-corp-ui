LabelView = {}

function LabelView:new(id)
    local this = {}
    setmetatable(this, self)
    self.__index = self
    this.id = id
    return this
end

function LabelView:setText(text)
    if type(text) == "number" then
        text = StringFormatter.fromTid(text)
    elseif type(text) == "string" then
        text = StringFormatter.toWString(text)
    end
    LabelSetText(self.id, text)
end

function LabelView:setTextColor(r, g, b)
    LabelSetTextColor(self.id, r, g, b)
end