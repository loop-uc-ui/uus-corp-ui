---@class UusCorpStatusBar:UusCorpView
UusCorpStatusBar = UusCorpView:new { name = "UusCorpStatusBar" }

---@param model UusCorpStatusBar
---@return UusCorpStatusBar
function UusCorpStatusBar:new(model)
    return UusCorpView.new(self, model) --[[@as UusCorpStatusBar]]
end

---@param tint table
function UusCorpStatusBar:setBackgroundTint(tint)
    UusCorp.Api.StatusBar.SetBackgroundTint(self.name, tint)
end

---@param value number
function UusCorpStatusBar:setCurrentValue(value)
    UusCorp.Api.StatusBar.SetCurrentValue(self.name, value)
end

---@param value number
function UusCorpStatusBar:setMaxValue(value)
    UusCorp.Api.StatusBar.SetMaxValue(self.name, value)
end

---@param tint table
function UusCorpStatusBar:setForegroundTint(tint)
    UusCorp.Api.StatusBar.SetForegroundTint(self.name, tint)
end