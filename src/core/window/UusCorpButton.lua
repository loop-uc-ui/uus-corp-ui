---@class UusCorpButton:UusCorpWindow
UusCorpButton = UusCorpWindow:new { name = "UusCorpButton" }

---@param model UusCorpButton
---@return UusCorpButton
function UusCorpButton:new(model)
    return UusCorpWindow.new(self, model) --[[@as UusCorpButton]]
end

function UusCorpButton:setText(text)
    UusCorp.Api.Button.SetText(self.name, text)
end

function UusCorpButton:getText()
    return UusCorp.Api.Button.GetText(self.name)
end