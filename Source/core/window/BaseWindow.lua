BaseWindow = {}

function BaseWindow:new(id)
    local this = {
        id = id
    }
    self.__index = self
    return setmetatable(this, self)
end

function BaseWindow:setAlpha(alpha)
    WindowSetAlpha(self.id, alpha)
    return self
end

function BaseWindow:addAnchor(
        anchorPoint,
        relativeTo,
        relativePoint,
        pointX,
        pointY
)
    WindowAddAnchor(self.id, anchorPoint, relativeTo, relativePoint, pointX, pointY)
    return self
end

function BaseWindow:clearAnchors()
    WindowClearAnchors(self.id)
    return self
end

function BaseWindow:isShowing()
    return WindowGetShowing(self.id)
end

function BaseWindow:setShowing(doShow)
    WindowSetShowing(self.id, doShow)
    return self
end

function BaseWindow:destroy()
    DestroyWindow(self.id)
    self = nil
end

function BaseWindow:setColor(color)
    WindowSetTintColor(self.id, color.r, color.g, color.b)
    return self
end