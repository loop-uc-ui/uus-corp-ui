
UusCorpStatusBar = setmetatable({}, { __index = UusCorpViewable})
UusCorpStatusBar.__index = UusCorpStatusBar

function UusCorpStatusBar:setCurrentValue(value)
    StatusBarApi.setCurrentValue(self.name, value or 0)
    return self
end

function UusCorpStatusBar:setMaximumValue(value)
    StatusBarApi.setMaximumValue(self.name, value or 0)
    return self
end

function UusCorpStatusBar:setForegroundTint(color)
    StatusBarApi.setForegroundTint(self.name, color)
    return self
end

function UusCorpStatusBar:setBackgroundTint(color)
    StatusBarApi.setBackgroundTint(self.name, color)
    return self
end

function UusCorpStatusBar:coreEvent(event)
    UusCorpViewable.coreEvent(self, event)
    return self
end

function UusCorpStatusBar:event(event)
    UusCorpViewable.event(self, event)
    return self
end