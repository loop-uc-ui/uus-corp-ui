UusCorpLabel = middleclass.class("UusCorpLabel", UusCorpView)

function UusCorpLabel:init(name, text)
    UusCorpLabel.super.init(self, name)
    self.text = text
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