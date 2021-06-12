WindowApi = {}

function WindowApi.destroyWindow(id)
    DestroyWindow(id)
end

function WindowApi.setShowing(id, show)
    WindowSetShowing(id, show)
end

function WindowApi.isShowing(id)
    return WindowGetShowing(id)
end

function WindowApi.clearAnchors(id)
    WindowClearAnchors(id)
end

function WindowApi.addAnchor(
        id,
        anchorPoint,
        relativeTo,
        relativePoint,
        pointX,
        pointY
)
    WindowAddAnchor(id, anchorPoint, relativeTo, relativePoint, pointX, pointY)
end

function WindowApi.setAlpha(id, alpha)
    WindowSetAlpha(id, alpha)
end

function WindowApi.setColor(id, color)
    WindowSetTintColor(id, color.r, color.g, color.b)
end

function WindowApi.doesExist(id)
    return DoesWindowNameExist(id)
end

function WindowApi.createFromTemplate(id, template, parent)
    CreateWindowFromTemplate(id, template, parent)
end

function WindowApi.setId(id, newId)
    WindowSetId(id, newId)
end

function WindowApi.setMoving(id, isMoving)
    WindowSetMoving(id, isMoving)
end

function WindowApi.registerEventHandler(id, event, callback)
    WindowRegisterEventHandler(id, event, callback)
end

function WindowApi.unregisterEventHandler(id, event)
    WindowUnregisterEventHandler(id, event)
end