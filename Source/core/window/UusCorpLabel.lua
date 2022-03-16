UusCorpLabel = setmetatable({}, {__index = UusCorpView})
UusCorpLabel.__index = UusCorpLabel

function UusCorpLabel.new(name, text)
    local self = UusCorpView.new(name)
    self.text = text
    return setmetatable(self, UusCorpLabel)
end

function UusCorpLabel:create() 
    if self.text ~= nil then
        self:setText(self.text)
    end
end

function UusCorpLabel:setText(text)
    if type(text) == "number" then
        text = StringFormatter.fromTid(text)
    elseif type(text) == "string" then
        text = StringFormatter.toWString(text)
    end
    LabelApi.setText(self.name, text)
end

function UusCorpLabel:setTextColor(color)
    LabelApi.setTextColor(self.name, color)
end

function UusCorpLabel:setTextAlignment(alignment)
    LabelApi.setTextAlignment(self.name, alignment)
end

function UusCorpLabel:getText()
    return LabelApi.getText(self.name)
end