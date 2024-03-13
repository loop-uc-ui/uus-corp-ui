---@class UusCorpEditTextBox:UusCorpView
UusCorpEditTextBox = UusCorpView:new { name = "UusCorpEditTextBox" }

---@param model UusCorpEditTextBox
---@return UusCorpEditTextBox
function UusCorpEditTextBox:new(model)
    local newObject = setmetatable(model or {}, self)
    self.__index = self
    return newObject
end

function UusCorpEditTextBox:getText()
    return EditTextBoxApi.getText(self.name)
end

function UusCorpEditTextBox:setText(text)
    EditTextBoxApi.setText(self.name, text)
end