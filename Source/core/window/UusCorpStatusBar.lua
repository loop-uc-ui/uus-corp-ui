
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
        local _value

        if type(value) == "function" then
            _value = value()
        else
            _value = value
        end

        StatusBarApi.setCurrentValue(self.name, _value or 0)
    end
    return self
end

function UusCorpStatusBar:setMaximumValue(value)
    self.observer.onSetMaximumValue = function ()
        local _value

        if type(value) == "function" then
            _value = value()
        else
            _value = value
        end

        StatusBarApi.setMaximumValue(self.name, _value or 0)
    end
    return self
end

function UusCorpStatusBar:setForegroundTint(color)
    self.observer.onSetForgroundTint = function ()
        local _color

        if type(color) == "function" then
            _color = color()
        else
            _color = color
        end

        StatusBarApi.setForegroundTint(self.name, _color)
    end
    return self
end

function UusCorpStatusBar:setBackgroundTint(color)
    self.observer.onSetBackgroundTint = function ()
        local _color

        if type(color) == "function" then
            _color = color()
        else
            _color = color
        end

        StatusBarApi.setBackgroundTint(self.name, _color)
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