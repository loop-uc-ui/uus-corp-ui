ListWindow = BaseWindow:new()

function ListWindow:new(id, isScrollable)
    local this = {
        id = id,
        adapter = WindowAdapter:new(id),
        isScrollable = isScrollable == nil or isScrollable
    }
    self.__index = self
    return setmetatable(this, self)
end

function ListWindow:setOffset(offset)
    if self.isScrollable then
        ScrollWindowApi.setOffset(self.id, offset)
    end
    return self
end

function ListWindow:updateScrollRect()
    if self.isScrollable then
        ScrollWindowApi.updateScrollRect(self.id)
    end
    return self
end