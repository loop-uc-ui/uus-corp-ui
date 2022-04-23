WindowApi = {}

function WindowApi.destroyWindow(windowName)
    DestroyWindow(windowName)
end

function WindowApi.setShowing(windowName, show)
    WindowSetShowing(windowName, show)
end

function WindowApi.isShowing(windowName)
    return WindowGetShowing(windowName)
end

function WindowApi.setLayer(windowName, layer)
    WindowSetLayer(windowName, layer)
end

function WindowApi.getLayer(windowName)
    return WindowGetLayer(windowName)
end

function WindowApi.setHandleInput(windowName, handleInput)
    WindowHandleInput(windowName, handleInput)
end

function WindowApi.getHandleInput(windowName)
    return WindowGetHandleInput(windowName)
end

function WindowApi.setPopable(windowName, popable)
    WindowSetPopable(windowName, popable)
end

function WindowApi.isPopable(windowName)
    return windowGetPopable(windowName)
end

function WindowApi.setMovable(windowName, movable)
    WindowSetMovable(windowName, movable)
end

function WindowApi.isMovable(windowName)
    return WindowGetMovable(windowName)
end

function WindowApi.setOffsetFromParent(windowName, xOffset, yOffset)
    WindowSetOffsetFromParent(windowName, xOffset, yOffset)
end

function WindowApi.setDimensions(windowName, xOffset, yOffset)
    WindowSetDimensions(windowName, xOffset, yOffset)
end

function WindowApi.getDimensions(windowName)
    return WindowGetDimensions(windowName)
end

function WindowApi.isSticky(windowName)
    return WindowIsSticky(windowName)
end

function WindowApi.clearAnchors(windowName)
    WindowClearAnchors(windowName)
end

function WindowApi.addAnchor(
        windowName,
        anchorPoint,
        relativeTo,
        relativePoint,
        pointX,
        pointY
)
    WindowAddAnchor(windowName, anchorPoint, relativeTo, relativePoint, pointX, pointY)
end

function WindowApi.getAnchor(windowName, anchorId)
    return WindowGetAnchor(windowName, anchorId)
end

function WindowApi.getAnchorCount(windowName)
    return WindowGetAnchorCount(windowName)
end

function WindowApi.forceProcessAnchors(windowName)
    WindowForceProcessAnchors(windowName)
end

function WindowApi.assignFocus(windowName, doFocus)
    return WindowAssignFocus(windowName, doFocus)
end

function WindowApi.hasFocus(windowName)
    return WindowHasFocus(windowName)
end

function WindowApi.setResizing(windowName, isResizing)
    WindowSetResizing(windowName, isResizing)
end

function WindowApi.isResizing(windowName)
    return WindowGetResizing(windowName)
end

function WindowApi.startAlphaAnimation(
        windowName,
        animType,
        startAlpha,
        endAlpha,
        duration,
        setStartBeforeDelay,
        delay,
        numLoop
)
    WindowStartAlphaAnimation(windowName, animType, startAlpha, endAlpha, duration, setStartBeforeDelay, delay, numLoop)
end

function WindowApi.stopAlphaAnimation(windowName)
    WindowStopAlphaAnimation(windowName)
end

function WindowApi.startScaleAnimation(
        windowName,
        animType,
        startScale,
        endScale,
        duration,
        setStartBeforeDelay,
        delay,
        numLoop
)
    WindowStartScaleAnimation(windowName, animType, startScale, endScale, duration, setStartBeforeDelay, delay, numLoop)
end

function WindowApi.stopScaleAnimation(windowName)
    WindowStopScaleAnimation(windowName)
end

function WindowApi.startScaleAnimation(
        windowName,
        animType,
        startX,
        startY,
        endX,
        endY,
        duration,
        setStartBeforeDelay,
        delay,
        numLoop
)
    WindowStartScaleAnimation(
        windowName,
        animType,
        startX,
        startY,
        endX,
        endY,
        duration,
        setStartBeforeDelay,
        delay,
        numLoop
    )
end

function WindowApi.stopPositionAnimation(windowName)
    WindowStopPositionAnimation(windowName)
end

function WindowApi.setAlpha(windowName, alpha)
    WindowSetAlpha(windowName, alpha)
end

function WindowApi.getAlpha(windowName)
    return WindowGetAlpha(windowName)
end

function WindowApi.setColor(windowName, color)
    WindowSetTintColor(windowName, color.r, color.g, color.b)
end

function WindowApi.doesExist(windowName)
    return DoesWindowNameExist(windowName)
end

function WindowApi.createFromTemplate(windowName, template, parent)
    CreateWindowFromTemplate(windowName, template, parent)
end

function WindowApi.createWindow(windowName, doShow)
    CreateWindow(windowName, doShow)
end

function WindowApi.setId(windowName, newId)
    WindowSetId(windowName, newId)
end

function WindowApi.getId(windowName)
    return WindowGetId(windowName)
end

function WindowApi.setTabOrder(windowName, tabOrder)
    WindowSetTabOrder(windowName, tabOrder)
end

function WindowApi.getTabOrder(windowName)
    return WindowGetTabOrder(windowName)
end

function WindowApi.setMoving(windowName, isMoving)
    WindowSetMoving(windowName, isMoving)
end

function WindowApi.isMoving(windowName)
    return WindowGetMoving(windowName)
end

function WindowApi.registerEventHandler(windowName, event, callback)
    WindowRegisterEventHandler(windowName, event, callback)
end

function WindowApi.unregisterEventHandler(windowName, event)
    WindowUnregisterEventHandler(windowName, event)
end

function WindowApi.registerCoreEventHandler(windowName, event, callback)
    WindowRegisterCoreEventHandler(windowName, event, callback)
end

function WindowApi.unregisterCoreEventHandler(windowName, event)
    WindowUnregisterCoreEventHandler(windowName, event)
end

function WindowApi.setParent(windowName, parentId)
    WindowSetParent(windowName, parentId)
end

function WindowApi.getParent(windowName)
    return WindowGetParent(windowName)
end

function WindowApi.setScale(windowName, scale)
    WindowSetScale(windowName, scale)
end

function WindowApi.getScale(windowName)
    return WindowGetScale(windowName)
end

function WindowApi.setRelativeScale(windowName, scale)
    WindowSetRelativeScale(windowName, scale)
end

function WindowApi.resizeOnChildren(windowName, isRecursive, borderSpacing)
    WindowResizeOnChildren(windowName, isRecursive, borderSpacing)
end

function WindowApi.setGameActionTrigger(windowName, action)
    WindowSetGameActionTrigger(windowName, action)
end

function WindowApi.setGameActionData(windowName, actionType, actionId, actionText)
    WindowSetGameActionData(windowName, actionType, actionId, actionText)
end

function WindowApi.setGameActionButton(windowName, button)
    WindowSetGameActionButton(windowName, button)
end

function WindowApi.getGameActionButton(windowName)
    return WindowGetGameActionButton(windowName)
end

function WindowApi.isGameActionLocked(windowName)
    return WindowIsGameActionLocked(windowName)
end

function WindowApi.setDrawWhenInterfaceHidden(windowName, doDraw)
    WindowSetDrawWhenInterfaceHidden(windowName, doDraw)
end

function WindowApi.restoreDefaultSettings(windowName)
    WindowRestoreDefaultSettings(windowName)
end

function WindowApi.setUpdateFrequency(windowName, frequency)
    WindowSetUpdateFrequency(windowName, frequency)
end

function WindowApi.getPosition(id)
    return WindowGetScreenPosition(id)
end
