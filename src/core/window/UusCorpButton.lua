---@class UusCorpButton:UusCorpWindow
UusCorpButton = UusCorpWindow:new("UusCorpButton")

---@param name string
---@return UusCorpButton
function UusCorpButton:new(name)
    return UusCorpWindow.new(self, name) --[[@as UusCorpButton]]
end

function UusCorpButton:setText(text)
    ButtonApi.setText(self.name, text)
end

function UusCorpButton:getText()
    return ButtonApi.getText(self.name)
end