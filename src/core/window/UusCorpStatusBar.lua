---@class UusCorpStatusBar:UusCorpWindow
UusCorpStatusBar = UusCorpWindow:new("UusCorpStatusBar")

---@param name string
---@return UusCorpStatusBar
function UusCorpStatusBar:new(name)
    return UusCorpWindow.new(self, name) --[[@as UusCorpStatusBar]]
end

---@param tint table
function UusCorpStatusBar:setBackgroundTint(tint)
    StatusBarApi.setBackgroundTint(self.name, tint)
end

---@param value number
function UusCorpStatusBar:setCurrentValue(value)
    StatusBarApi.setCurrentValue(self.name, value)
end

---@param value number
function UusCorpStatusBar:setMaxValue(value)
    StatusBarApi.setMaximumValue(self.name, value)
end

---@param tint table
function UusCorpStatusBar:setForegroundTint(tint)
    StatusBarApi.setForegroundTint(self.name, tint)
end