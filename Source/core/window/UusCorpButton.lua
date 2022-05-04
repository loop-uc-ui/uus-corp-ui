UusCorpButton = setmetatable({}, { __index = UusCorpViewable })
UusCorpButton.__index = UusCorpButton

function UusCorpButton:setText(text)
    if text == nil then
        return
    elseif type(text) == "number" then
        text = StringFormatter.fromTid(text)
    elseif type(text) == "string" then
        text = StringFormatter.toWString(text)
    end

    ButtonApi.setText(self.name, text)

    return self
end

function UusCorpButton:setDisabled(isDisabled)
    ButtonApi.setDisabled(self.name, isDisabled ~= nil and isDisabled)
    return self
end

function UusCorpButton:coreEvent(event)
    UusCorpViewable.coreEvent(self, event)
    return self
end

function UusCorpButton:event(event)
    UusCorpViewable.event(self, event)
    return self
end