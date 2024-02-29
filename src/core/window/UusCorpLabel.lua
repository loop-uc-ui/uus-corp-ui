---@class UusCorpLabelModel:UusCorpViewModel
local UusCorpLabelModel = {
    name = "",
    data = {},
    events = {}
}

---@class UusCorpLabel:UusCorpView
UusCorpLabel = UusCorpView:new(UusCorpLabelModel)

---@param model UusCorpLabelModel
---@return UusCorpLabel
function UusCorpLabel:new(model)
    return UusCorpView.new(self, model) --[[@as UusCorpLabel]]
end

function UusCorpLabel:setText(text)
    LabelApi.setText(self:getName(), text)
end

function UusCorpLabel:getText()
    return LabelApi.getText(self:getName())
end

function UusCorpLabel:setTextColor(color)
    LabelApi.setTextColor(self:getName(), color)
end