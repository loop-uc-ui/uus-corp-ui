---@class UusCorpLabel:UusCorpView
UusCorpLabel = UusCorpView:new("UusCorpLabel")

---@param name string
---@return UusCorpLabel
function UusCorpLabel:new(name)
    return UusCorpView.new(self, name) --[[@as UusCorpLabel]]
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