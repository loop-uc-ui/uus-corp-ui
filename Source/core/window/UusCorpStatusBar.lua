
UusCorpStatusBar = setmetatable({}, UusCorpActionable)
UusCorpStatusBar.__index = UusCorpStatusBar

function UusCorpStatusBar:setCurrentValue(value)
    StatusBarApi.setCurrentValue(self.name, value or 0)
    return self
end

function UusCorpStatusBar:setMaximumValue(value)
    UusCorpStatusBar.setMaximumValue(self.name, value or 0)
    return self
end

function UusCorpStatusBar:addAction(action)
    UusCorpActionable.addAction(self, action)
    return self
end