UusCorpLabel = setmetatable({}, {__index = UusCorpView})
UusCorpLabel.__index = UusCorpLabel

function UusCorpLabel:init(name, textValue,  textColor, textAlignment)
    local this = setmetatable(UusCorpView.init(self, name), self)

    this.eventAdapter:onInitialize(function ()
        if textValue then this:setText(textValue) end

        if textColor then this:setTextColor(textColor) end

        if textAlignment then this:setTextAlignment(textAlignment) end
    end)

    return this
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