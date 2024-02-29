---@class UusCorpStatusBarModel:UusCorpViewModel
local UusCorpStatusBarModel = {
    name = "",
    data = {},
    events = {}
}

---@class UusCorpStatusBar:UusCorpView
UusCorpStatusBar = UusCorpView:new(UusCorpStatusBarModel)

---@param model UusCorpStatusBarModel
---@return UusCorpStatusBar
function UusCorpStatusBar:new(model)
    return UusCorpView.new(self, model) --[[@as UusCorpStatusBar]]
end

---@param tint table
function UusCorpStatusBar:setBackgroundTint(tint)
    StatusBarApi.setBackgroundTint(self:getName(), tint)
end

---@param value number
function UusCorpStatusBar:setCurrentValue(value)
    StatusBarApi.setCurrentValue(self:getName(), value)
end

---@param value number
function UusCorpStatusBar:setMaxValue(value)
    StatusBarApi.setMaximumValue(self:getName(), value)
end

---@param tint table
function UusCorpStatusBar:setForegroundTint(tint)
    StatusBarApi.setForegroundTint(self:getName(), tint)
end