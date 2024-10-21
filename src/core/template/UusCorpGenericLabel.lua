---@class UusCorpGenericLabel:UusCorpGenericWindow
---@field _label UusCorpLabel?
UusCorpGenericLabel = UusCorpGenericWindow:new {
    name = "UusCorpGenericLabel",
    template = "UusCorpGenericLabel",
    eventHandler = "UusCorpWindowLifeCycle"
}

---@param model UusCorpGenericLabel?
---@return UusCorpGenericLabel
function UusCorpGenericLabel:new(model)
    model = model or {}
    model.name = model.name or StringFormatter.randomString()
    local window = UusCorpGenericWindow.new(self, model) --[[@as UusCorpGenericLabel]]
    window._label = UusCorpLabel:new { name = window.name .. "View" }
    window.onRButtonDown = model.onRButtonDown or nil
    return window
end

function UusCorpGenericLabel:setText(text)
    self._label:setText(text)
end

function UusCorpGenericLabel:seTexttColor(color)
    self._label:setTextColor(color)
end