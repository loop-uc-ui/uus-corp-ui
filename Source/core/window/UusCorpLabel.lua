
UusCorpLabel = setmetatable({}, { __index = UusCorpViewable })
UusCorpLabel.__index = UusCorpLabel

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

function UusCorpLabel:coreEvent(event)
    UusCorpViewable.coreEvent(self, event)
    return self
end

function UusCorpLabel:event(event)
    UusCorpViewable.event(self, event)
    return self
end