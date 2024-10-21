---@class UusCorpGenericButton:UusCorpGenericWindow
---@field _button UusCorpButton?
UusCorpGenericButton = UusCorpGenericWindow:new {
    name = "UusCorpGenericButton",
    template = "UusCorpGenericButton",
    eventHandler = "UusCorpWindowLifeCycle"
}

---@param model UusCorpGenericButton?
---@return UusCorpGenericButton
function UusCorpGenericButton:new(model)
    model = model or {}
    model.name = model.name or StringFormatter.randomString()
    local window = UusCorpGenericWindow.new(self, model) --[[@as UusCorpGenericButton]]
    window._button = window:addButton("View")
    window.onRButtonDown = model.onRButtonDown or nil
    return window
end

function UusCorpGenericButton:setText(text)
    self._button:setText(text)
end