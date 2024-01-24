---@class UusCorpScrollWindow:UusCorpWindow
---@field scrollChild UusCorpWindow
UusCorpScrollWindow = UusCorpWindow:new("UusCorpScrollWindow")

---@param name string
---@return UusCorpScrollWindow
function UusCorpScrollWindow:new(name)
    local window = UusCorpWindow.new(self, name) --[[@as UusCorpScrollWindow]]
    window.scrollChild = window:addWindow("ScrollChild")
    return window
end

function UusCorpScrollWindow:updateScrollRect()
    ScrollWindowApi.updateScrollRect(self.name)
end

function UusCorpScrollWindow:setOffset(offset)
    ScrollWindowApi.setOffset(self.name, offset)
end