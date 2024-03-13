---@class UusCorpStatusBar:UusCorpView
UusCorpStatusBar = UusCorpView:new { name = "UusCorpStatusBar" }

---@param model UusCorpStatusBar
---@return UusCorpStatusBar
function UusCorpStatusBar:new(model)
    local newObject = setmetatable(model or {}, self)
    self.__index = self
    return newObject
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