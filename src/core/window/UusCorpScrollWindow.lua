---@class UusCorpScrollWindow:UusCorpWindow
---@field scrollChild UusCorpWindow?
UusCorpScrollWindow = UusCorpWindow:new {
    name = "UusCorpScrollWindow"
}

---@param model UusCorpScrollWindow
---@return UusCorpScrollWindow
function UusCorpScrollWindow:new(model)
    local this = UusCorpWindow.new(self, model) --[[@as UusCorpScrollWindow]]
    this.scrollChild = model.scrollChild or UusCorpWindow:new { name = self.name .. "ScrollChild" }
    return this
end

function UusCorpScrollWindow:updateScrollRect()
    UusCorp.Api.ScrollWindow.UpdateScrollRect(self.name)
end

function UusCorpScrollWindow:setOffset(offset)
    UusCorp.Api.ScrollWindow.SetOffset(self.name, offset)
end

function UusCorpScrollWindow:addChild(child)
    return UusCorpWindow.addChild(self.scrollChild, child)
end