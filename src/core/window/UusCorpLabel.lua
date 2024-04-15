---@class UusCorpLabel:UusCorpView
UusCorpLabel = UusCorpView:new { name = "UusCorpLabel" }

---@param model UusCorpLabel?
---@return UusCorpLabel
function UusCorpLabel:new(model)
    return UusCorpView.new(self, model) --[[@as UusCorpLabel]]
end

function UusCorpLabel:setText(text)
    UusCorp.Api.Label.SetText(self.name, text)
end

function UusCorpLabel:getText()
    return UusCorp.Api.Label.GetText(self.name)
end

function UusCorpLabel:setTextColor(color)
    UusCorp.Api.Label.SetTextColor(self.name, color)
end