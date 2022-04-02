UusCorpStatusBar = setmetatable({}, {__index = UusCorpView})
UusCorpStatusBar.__index = UusCorpStatusBar

function UusCorpStatusBar:init(name, curVal, maxVal)
    local this = setmetatable(UusCorpView.init(self, name), self)

    this.eventAdapter:onInitialize(function ()
        if curVal then this:setCurrentValue(curVal) end

        if maxVal then this:setMaximumValue(maxVal) end
    end)

    return this
end

function UusCorpStatusBar:setCurrentValue(value)
    StatusBarApi.setCurrentValue(self.name, value)
end

function UusCorpStatusBar:setMaximumValue(value)
    StatusBarApi.setMaximumValue(self.name, value)
end