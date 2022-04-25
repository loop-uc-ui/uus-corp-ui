UusCorpButton = setmetatable({}, { __index = UusCorpActionable })
UusCorpButton.__index = UusCorpButton

function UusCorpButton:addAction(action)
    UusCorpActionable.addAction(self, action)
    return self
end

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