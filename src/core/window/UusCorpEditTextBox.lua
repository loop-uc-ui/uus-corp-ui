---@class UusCorpEditTextBox:UusCorpView
UusCorpEditTextBox = UusCorpView:new("UusCorpEditTextBox")

---@param name string
---@return UusCorpEditTextBox
function UusCorpEditTextBox:new(name)
    return UusCorpView.new(self, name) --[[@as UusCorpEditTextBox]]
end

function UusCorpEditTextBox:getText()
    return EditTextBoxApi.getText(self.name)
end

function UusCorpEditTextBox:setText(text)
    EditTextBoxApi.setText(self.name, text)
end