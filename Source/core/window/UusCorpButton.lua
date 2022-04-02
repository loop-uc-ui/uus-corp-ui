UusCorpButton = UusCorpView:init()

function UusCorpButton:init(name, text)
    setmetatable(UusCorpView.init(name), self)

    self.__index = self

    self.eventAdapter:onInitialize(function ()
        if text then
            self:setText(text)
        end
    end)

    return self
end

function UusCorpButton:setText(text)
    if type(text) == "number" then
        text = StringFormatter.fromTid(text)
    elseif type(text) == "string" then
        text = StringFormatter.toWString(text)
    end
    ButtonApi.setText(self.namename, text)
end

function UusCorpButton:setDisabled(isDisabled)
    ButtonApi.setDisabled(self.name, isDisabled)
end
