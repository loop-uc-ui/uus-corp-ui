---@class UusCorpEditTextBox:UusCorpView
UusCorpEditTextBox = UusCorpView:new { name = "UusCorpEditTextBox" }

---@param model UusCorpEditTextBox
---@return UusCorpEditTextBox
function UusCorpEditTextBox:new(model)
    return UusCorpView.new(self, model) --[[@as UusCorpEditTextBox]]
end

function UusCorpEditTextBox:getText()
    return EditTextBoxApi.getText(self.name)
end

function UusCorpEditTextBox:setText(text)
    EditTextBoxApi.setText(self.name, text)
end