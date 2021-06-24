BaseWindow = {}

function BaseWindow:new(id)
    local this = {
        id = id,
        eventRegister = WindowEventRegister:new(id)
    }
    self.__index = self
    return setmetatable(this, self)
end

function BaseWindow:setAlpha(alpha)
    WindowApi.setAlpha(self.id, alpha)
    return self
end

function BaseWindow:addAnchor(
        anchorPoint,
        relativeTo,
        relativePoint,
        pointX,
        pointY
)
    WindowApi.addAnchor(self.id, anchorPoint, relativeTo, relativePoint, pointX, pointY)
    return self
end

function BaseWindow:clearAnchors()
    WindowApi.clearAnchors(self.id)
    return self
end

function BaseWindow:getAnchorCount()
    return WindowApi.getAnchorCount(self.id)
end

function BaseWindow:setOffsetFromParent(x, y)
    WindowApi.setOffsetFromParent(self.id, x, y)
    return self
end

function BaseWindow:isShowing()
    return WindowApi.isShowing(self.id)
end

function BaseWindow:setShowing(doShow)
    WindowApi.setShowing(self.id, doShow)
    return self
end

function BaseWindow:destroy()
    if self.eventRegister ~= nil then
        self.eventRegister:unregisterAllEvents()
    end
    WindowApi.destroyWindow(self.id)
    self = nil
    return self
end

function BaseWindow:setColor(color)
    WindowApi.setColor(self.id, color)
    return self
end

function BaseWindow:registerData(data, id)
    WindowDataApi.registerData(data, id)
    return self
end

function BaseWindow:unregisterData(data, id)
    WindowDataApi.unregisterData(data, id)
    return self
end

function BaseWindow:setId(id)
    WindowApi.setId(self.id, id)
end

function BaseWindow:setMoving(isMoving)
    WindowApi.setMoving(self.id, isMoving)
end

function BaseWindow:registerEventHandler(event, callback)
    if self.eventHandlers == nil then
        self.eventHandlers = {}
    end
    WindowApi.registerEventHandler(self.id, event, callback)
    self.eventHandlers[callback] = event
    return self
end