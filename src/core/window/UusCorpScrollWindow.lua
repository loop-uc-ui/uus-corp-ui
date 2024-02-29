---@class UusCorpScrollWindowModel:UusCorpWindowModel
local UusCorpScrollWindowModel = {
    name = "",
    data = {},
    events = {}
}

---@class UusCorpScrollWindow:UusCorpWindow
---@field scrollChild UusCorpWindow
UusCorpScrollWindow = UusCorpWindow:new(UusCorpScrollWindowModel)

---@param model UusCorpScrollWindowModel
---@return UusCorpScrollWindow
function UusCorpScrollWindow:new(model)
    local window = UusCorpWindow.new(self, model) --[[@as UusCorpScrollWindow]]
    window.scrollChild = window:addWindow("ScrollChild")
    return window
end

function UusCorpScrollWindow:updateScrollRect()
    ScrollWindowApi.updateScrollRect(self:getName())
end

function UusCorpScrollWindow:setOffset(offset)
    ScrollWindowApi.setOffset(self:getName(), offset)
end