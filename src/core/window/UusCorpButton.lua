---@class UusCorpButton:UusCorpWindow
UusCorpButton = UusCorpWindow:new { name = "UusCorpButton" }

---@param model UusCorpButton
---@return UusCorpButton
function UusCorpButton:new(model)
    local newObject = setmetatable(model or {}, self)
    self.__index = self
    return newObject
end

function UusCorpButton:setText(text)
    ButtonApi.setText(self.name, text)
end

function UusCorpButton:getText()
    return ButtonApi.getText(self.name)
end