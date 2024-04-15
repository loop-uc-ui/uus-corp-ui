---@class UusCorpEditTextBox:UusCorpView
UusCorpEditTextBox = UusCorpView:new { name = "UusCorpEditTextBox" }

---@param model UusCorpEditTextBox
---@return UusCorpEditTextBox
function UusCorpEditTextBox:new(model)
    return UusCorpView.new(self, model) --[[@as UusCorpEditTextBox]]
end

function UusCorpEditTextBox:getText()
    return UusCorp.Api.EditTextBox.GetText(self.name)
end

function UusCorpEditTextBox:setText(text)
    UusCorp.Api.EditTextBox.SetText(self.name, text)
end