---@class UusCorpEditTextBoxModel:UusCorpViewModel
local UusCorpEditTextBoxModel = {
    name = "",
    data = {},
    events = {}
}

---@class UusCorpEditTextBox:UusCorpView
UusCorpEditTextBox = UusCorpView:new(UusCorpEditTextBoxModel)

---@param model UusCorpEditTextBoxModel
---@return UusCorpEditTextBox
function UusCorpEditTextBox:new(model)
    return UusCorpView.new(self, model) --[[@as UusCorpEditTextBox]]
end

function UusCorpEditTextBox:getText()
    return EditTextBoxApi.getText(self:getName())
end

function UusCorpEditTextBox:setText(text)
    EditTextBoxApi.setText(self:getName(), text)
end