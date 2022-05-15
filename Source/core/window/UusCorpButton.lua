UusCorpButton = setmetatable({}, { __index = UusCorpView })
UusCorpButton.__index = UusCorpButton

function UusCorpButton.new(name)
    return setmetatable(
        UusCorpView.new(name),
        UusCorpButton
    )
end

function UusCorpButton:setText(text)
    self.observer.onSetText = function ()
        if text == nil then
            return
        elseif type(text) == "number" then
            text = StringFormatter.fromTid(text)
        elseif type(text) == "string" then
            text = StringFormatter.toWString(text)
        end

        ButtonApi.setText(self.name, text)
    end
    return self
end

function UusCorpButton:setDisabled(isDisabled)
    self.observer.onSetDisabled = function ()
        ButtonApi.setDisabled(self.name, isDisabled ~= nil and isDisabled)
    end
    return self
end