ListWindow = BaseWindow:new()

function ListWindow:new(id, isScrollable)
    local this = {
        id = id,
        adapter = WindowAdapter:new(id),
        eventRegister = WindowEventRegister:new(id),
        isScrollable = isScrollable or false
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

function ListWindow:isLocked()
    local lock = self.adapter.views[self.id.."Lock"]
    return lock ~= nil and lock.isLocked
end

function ListWindow:setLocked(isLocked)
    local lock = self.adapter.views[self.id.."Lock"]
    if lock ~= nil and lock.isLocked ~= isLocked then
        lock:toggleSetting()
        lock:toggleTexture()
    end
end

function ListWindow:onLeftClickDown()
    WindowApi.setShowing("ContextMenu", false)
    if not self:isLocked() then
        SnapUtils.StartWindowSnap(self.id)
        self:setMoving(true)
    else
        self:setMoving(false)
    end
end

function ListWindow:onLeftClickUp()
    self:setMoving(false)
end

function ListWindow:destroy()
    if self == nil or not WindowApi.doesExist(self.id) then
        return
    end

    if self.eventRegister ~= nil then
        self.eventRegister:unregisterAllEvents()
    end
    for i = 1, #self.adapter.views do
        self.adapter.views[i]:destroy()
    end
    WindowUtils.SaveWindowPosition(self.id)
    WindowApi.destroyWindow(self.id)
    self = nil
    return self
end