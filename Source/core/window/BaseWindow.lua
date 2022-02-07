BaseWindow = {}

function BaseWindow:new(id)
    local this = {
        id = id,
        time = TimeApi.getCurrentTime(),
        eventRegister = WindowEventRegister:new(id)
    }
    self.__index = self
    return setmetatable(this, self)
end

function BaseWindow:exists()
    return WindowApi.doesExist(self.id)
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

function BaseWindow:setDimensions(x, y)
    WindowApi.setDimensions(self.id, x, y)
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
    return self ~= nil and WindowApi.doesExist(self.id) and WindowApi.isShowing(self.id)
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
    return self
end

function BaseWindow:setMoving(isMoving)
    WindowApi.setMoving(self.id, isMoving)
    return self
end

function BaseWindow:registerEventHandler(event, callback)
    if self.eventHandlers == nil then
        self.eventHandlers = {}
    end
    WindowApi.registerEventHandler(self.id, event, callback)
    self.eventHandlers[callback] = event
    return self
end

function BaseWindow:startAlphaAnimation(
        animType,
        startAlpha,
        endAlpha,
        duration,
        setStartBeforeDelay,
        delay,
        numLoop
)
    if not self.isAnimating then
        self.isAnimating = true
        WindowApi.startAlphaAnimation(self.id, animType, startAlpha, endAlpha, duration, setStartBeforeDelay, delay, numLoop)
    end
    return self
end

function BaseWindow:stopAlphaAnimation()
    if self.isAnimating then
        self.isAnimating = false
        WindowApi.stopAlphaAnimation(self.id)
    end
    return self
end

function BaseWindow:setScale(scale)
    WindowApi.setScale(self.id, scale)
    return self
end

function BaseWindow:getScale()
    return WindowApi.getScale(self.id)
end

function BaseWindow:setUpdateFrequency(frequency)
    WindowApi.setUpdateFrequency(self.id, frequency)
    return self
end

function BaseWindow:startAlphaAnimationWindowApi(
        animType,
        startAlpha,
        endAlpha,
        duration,
        setStartBeforeDelay,
        delay,
        numLoop
)
    WindowApi.startAlphaAnimation(
            self.id,
            animType,
            startAlpha,
            endAlpha,
            duration,
            setStartBeforeDelay,
            delay,
            numLoop
    )
    return self
end

function BaseWindow:stopAlphaAnimation()
    WindowApi.stopAlphaAnimation(self.id)
    return self
end