LabelWindow = BaseWindow:new()

function LabelWindow:new(id)
    local this = {
        id = id
    }
    self.__index = self
    return setmetatable(this, self)
end

function LabelWindow:setText(text)
    if type(text) == "number" then
        text = StringFormatter.fromTid(text)
    elseif type(text) == "string" then
        text = StringFormatter.toWString(text)
    end
    LabelApi.setText(self.id, text)
end

function LabelWindow:setTextColor(color)
    LabelApi.setTextColor(self.id, color)
end