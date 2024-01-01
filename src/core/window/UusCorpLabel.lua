---@class UusCorpLabel:UusCorpWindow
UusCorpLabel = UusCorpWindow:new()
UusCorpLabel.__index = UusCorpLabel

---@return UusCorpLabel
function UusCorpLabel:new(name)
    return setmetatable(UusCorpWindow.new(self, name), UusCorpLabel) --[[@as UusCorpLabel]]
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