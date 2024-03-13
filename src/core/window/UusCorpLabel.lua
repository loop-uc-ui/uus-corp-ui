---@class UusCorpLabel:UusCorpView
UusCorpLabel = UusCorpView:new { name = "UusCorpLabel" }

---@param model UusCorpLabel
---@return UusCorpLabel
function UusCorpLabel:new(model)
    local newObject = setmetatable(model or {}, self)
    self.__index = self
    return newObject
end

function UusCorpLabel:setText(text)
    LabelApi.setText(self.name, text)
end

function UusCorpLabel:getText()
    return LabelApi.getText(self.name)
end

function UusCorpLabel:setTextColor(color)
    LabelApi.setTextColor(self.name, color)
end