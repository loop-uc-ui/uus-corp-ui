---@class UusCorpScrollWindow:UusCorpWindow
UusCorpScrollWindow = UusCorpWindow:new { name = "UusCorpScrollWindow" }

---@param model UusCorpScrollWindow
---@return UusCorpScrollWindow
function UusCorpScrollWindow:new(model)
    local newObject = setmetatable(model or {}, self)
    self.__index = self
    self.scrollChild = newObject:addWindow("ScrollChild")
    return newObject
end

function UusCorpScrollWindow:updateScrollRect()
    ScrollWindowApi.updateScrollRect(self.name)
end

function UusCorpScrollWindow:setOffset(offset)
    ScrollWindowApi.setOffset(self.name, offset)
end