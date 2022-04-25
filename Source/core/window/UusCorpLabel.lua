
UusCorpLabel = setmetatable({}, { __index = UusCorpActionable })
UusCorpLabel.__index = UusCorpLabel

function UusCorpLabel:addAction(action)
    UusCorpActionable.addAction(self, action)
    return self
end

function UusCorpLabel:setText(labelText)
    if labelText == nil then
        return
    elseif type(labelText) == "number" then
        labelText = StringFormatter.fromTid(labelText)
    elseif type(labelText) == "string" then
        labelText = StringFormatter.toWString(labelText)
    end

    LabelApi.setText(self.name, labelText)

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