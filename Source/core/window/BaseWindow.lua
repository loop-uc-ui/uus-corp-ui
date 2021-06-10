BaseWindow = {}

function BaseWindow:new(id)
    local this = {
        id = id
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

function BaseWindow:isShowing()
    return WindowApi.isShowing(self.id)
end

function BaseWindow:setShowing(doShow)
    WindowApi.setShowing(self.id, doShow)
    return self
end

function BaseWindow:destroy()
    WindowApi.destroyWindow(self.id)
    self = nil
end

function BaseWindow:setColor(color)
    WindowApi.setColor(self.id, color)
    return self
end