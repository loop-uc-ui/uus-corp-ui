UusCorpStatusBar = setmetatable({}, { __index = UusCorpView })
UusCorpStatusBar.__index = UusCorpStatusBar

function UusCorpStatusBar.new(name)
    return setmetatable(
        UusCorpView.new(name),
        UusCorpStatusBar
    )
end

function UusCorpStatusBar:setMaximumValue(value)
    StatusBarApi.setMaximumValue(self.name, value)
    return self
end

function UusCorpStatusBar:setCurrentValue(value)
    StatusBarApi.setCurrentValue(self.name, value)
    return self
end