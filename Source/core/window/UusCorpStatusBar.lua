
UusCorpStatusBar = setmetatable({}, { __index = UusCorpView})
UusCorpStatusBar.__index = UusCorpStatusBar

function UusCorpStatusBar.new(name)
    return setmetatable(
        UusCorpView.new(name),
        UusCorpStatusBar
    )
end

function UusCorpStatusBar:setCurrentValue(value)
    self.observer.onSetCurrentValue = function ()
        StatusBarApi.setCurrentValue(self.name, value or 0)
    end
    return self
end

function UusCorpStatusBar:setMaximumValue(value)
    self.observer.onSetMaximumValue = function ()
        StatusBarApi.setMaximumValue(self.name, value or 0)
    end
    return self
end

function UusCorpStatusBar:setForegroundTint(color)
    self.observer.onSetForgroundTint = function ()
        StatusBarApi.setForegroundTint(self.name, color)
    end
    return self
end

function UusCorpStatusBar:setBackgroundTint(color)
    self.observer.onSetBackgroundTint = function ()
        StatusBarApi.setBackgroundTint(self.name, color)
    end
    return self
end

function UusCorpStatusBar:coreEvent(event)
    UusCorpView.coreEvent(self, event)
    return self
end

function UusCorpStatusBar:event(event)
    UusCorpView.event(self, event)
    return self
end