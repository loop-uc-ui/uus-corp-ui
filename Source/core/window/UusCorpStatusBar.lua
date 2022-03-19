UusCorpStatusBar = middleclass.class("UusCorpStatusBar", UusCorpView)

function UusCorpStatusBar:init(name, curVal, maxVal) 
    UusCorpView.init(self, name)
    self.curVal = curVal
    self.maxVal = maxVal
end

function UusCorpStatusBar:create() 
    if self.maxVal then
        self:setMaximumValue(self.maxVal)
    end

    if self.maxVal then
        self:setMaximumValue(self.maxVal)
    end
end

function UusCorpStatusBar:setMaximumValue(value)
    self.maxVal = value
    StatusBarApi.setMaximumValue(self.name, value)
end

function UusCorpStatusBar:setCurrentValue(value)
    self.curVal = value
    StatusBarApi.setCurrentValue(self.name, value)
end