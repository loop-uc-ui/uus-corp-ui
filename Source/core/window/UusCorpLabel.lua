
UusCorpLabel = setmetatable({}, { __index = UusCorpView })
UusCorpLabel.__index = UusCorpLabel

function UusCorpLabel.new(name)
    return setmetatable(
        UusCorpView.new(name),
        UusCorpLabel
    )
end
function UusCorpLabel:setText(text)
    self.observer.onSetText = function()
        local labelText

        if type(text) == "function" then
            labelText = text()
        end

        if labelText == nil then
            return
        elseif type(labelText) == "number" then
            labelText = StringFormatter.fromTid(labelText)
        elseif type(labelText) == "string" then
            labelText = StringFormatter.toWString(labelText)
        end

        LabelApi.setText(self.name, labelText)
    end
    return self
end

function UusCorpLabel:setTextColor(color)
    self.observer.onSetColor = function()
        LabelApi.setTextColor(self.name, color)
    end
    return self
end

function UusCorpLabel:setTextAlignment(alignment)
    self.observer.onSetTextAlignment = function()
        LabelApi.setTextAlignment(self.name, alignment)
    end
    return self
end

function UusCorpLabel:coreEvent(event)
    UusCorpView.coreEvent(self, event)
    return self
end

function UusCorpLabel:event(event)
    UusCorpView.event(self, event)
    return self
end