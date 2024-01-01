---@class UusCorpStatusBar:UusCorpWindow
UusCorpStatusBar = UusCorpWindow:new("UusCorpStatusBar")
UusCorpStatusBar.__index = UusCorpStatusBar

---@return UusCorpStatusBar
function UusCorpStatusBar:new(name)
    return setmetatable(UusCorpWindow.new(self, name), UusCorpStatusBar) --[[@as UusCorpStatusBar]]
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