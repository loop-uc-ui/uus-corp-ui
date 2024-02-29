---@class UusCorpButtonModel:UusCorpWindowModel
local UusCorpButtonModel = {
    name = "",
    data = {},
    events = {}
}

---@class UusCorpButton:UusCorpWindow
UusCorpButton = UusCorpWindow:new(UusCorpButtonModel)

---@param model UusCorpButtonModel
---@return UusCorpButton
function UusCorpButton:new(model)
    return UusCorpWindow.new(self, model) --[[@as UusCorpButton]]
end

function UusCorpButton:setText(text)
    ButtonApi.setText(self:getName(), text)
end

function UusCorpButton:getText()
    return ButtonApi.getText(self:getName())
end