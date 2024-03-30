---@class UusCorpScrollWindow:UusCorpWindow
---@field scrollChild UusCorpWindow?
UusCorpScrollWindow = UusCorpWindow:new { name = "UusCorpScrollWindow" }

---@param model UusCorpScrollWindow
---@return UusCorpScrollWindow
function UusCorpScrollWindow:new(model)
    local this = UusCorpWindow.new(self, model) --[[@as UusCorpScrollWindow]]
    this.scrollChild = this:addWindow("ScrollChild")
    return this
end

function UusCorpScrollWindow:updateScrollRect()
    ScrollWindowApi.updateScrollRect(self.name)
end

function UusCorpScrollWindow:setOffset(offset)
    ScrollWindowApi.setOffset(self.name, offset)
end