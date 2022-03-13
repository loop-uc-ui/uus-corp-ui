UusCorpLabel = setmetatable({}, { __index = UusCorpView })
UusCorpLabel.__index = UusCorpLabel

function UusCorpLabel.new(name)
    return setmetatable(
        UusCorpView.new(name),
        UusCorpLabel
    )
end

function UusCorpLabel:setText(text)
    if type(text) == "number" then
        text = StringFormatter.fromTid(text)
    elseif type(text) == "string" then
        text = StringFormatter.toWString(text)
    end
    LabelApi.setText(self.name, text)
    return self
end

function UusCorpLabel:setTextColor(color)
    LabelApi.setTextColor(self.name, color)
    return self
end

function UusCorpLabel:setTextAlignment(alignment)
    LabelApi.setTextAlignment(self.name, alignment)
    return self
end

function UusCorpLabel:getText()
    return LabelApi.getText(self.name)
end