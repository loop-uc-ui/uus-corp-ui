ListWindow = BaseWindow:new()

function ListWindow:new(id, isScrollable)
    local this = {
        id = id,
        adapter = WindowAdapter:new(id),
        eventRegister = WindowEventRegister:new(id),
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

function ListWindow:addLock(onLock, onUnlock)
    local lock = LockWindow:new(self.id, onLock, onUnlock)
    self.adapter.views[lock.id] = lock
    return self
end

function ListWindow:isLocked()
    local lock = self.adapter.views[self.id.."Lock"]
    return lock ~= nil and lock.isLocked
end