---@class UusCorpView
---@field name string
UusCorpView = { name = "UusCorpView" }

---@param name string
---@return UusCorpView
function UusCorpView:new(name)
    local object = setmetatable({ name = name }, self)
    self.__index = self
    return object
end

function UusCorpView:setId(id)
    return WindowApi.setId(self.name, id)
end

function UusCorpView:getId()
    return WindowApi.getId(self.name)
end

function UusCorpView:doesExist()
    return WindowApi.doesExist(self.name)
end

function UusCorpView:isShowing()
    return WindowApi.isShowing(self.name)
end

function UusCorpView:setShowing(doShow)
    WindowApi.setShowing(self.name, doShow)
end

function UusCorpView:createFromTemplate(template, parent)
    return WindowApi.createFromTemplate(self.name, template or self.name, parent or "Root")
end

function UusCorpView:create(doShow)
    return WindowApi.createWindow(self.name, doShow == nil or doShow)
end

function UusCorpView:destroy()
    return WindowApi.destroyWindow(self.name)
end

function UusCorpView:assignFocus(doFocus)
    WindowApi.assignFocus(self.name, doFocus)
end

function UusCorpView:addAnchor(anchor)
    WindowApi.addAnchor(self.name, anchor.anchorPoint, anchor.relativeTo, anchor.relativePoint, anchor.x, anchor.y)
end

function UusCorpView:setUpdateFrequency(frequency)
    WindowApi.setUpdateFrequency(self.name, frequency)
end

function UusCorpView:getDimensions()
    return WindowApi.getDimensions(self.name)
end

function UusCorpView:setDimensions(x, y)
    WindowApi.setDimensions(self.name, x, y)
end

function UusCorpView:setOffsetFromParent(x, y)
    return WindowApi.setOffsetFromParent(self.name, x, y)
end

function UusCorpView:registerEvent(id, callback)
    WindowApi.registerEventHandler(self.name, id, callback)
end

function UusCorpView:registerData(type, id)
    WindowDataApi.registerData(type, id)
    return self
end

function UusCorpView:unregisterEvent(id)
    WindowApi.unregisterEventHandler(self.name, id)
end

function UusCorpView:unregisterData(type, id)
    WindowDataApi.unregisterData(type, id)
    return self
end

function UusCorpView:registerCoreEvent(id, callback)
    WindowApi.registerCoreEventHandler(self.name, id, callback)
end

function UusCorpView:unregisterCoreEvent(id)
    WindowApi.unregisterCoreEventHandler(self.name, id)
end

function UusCorpView:setScale(scale)
    WindowApi.setScale(self.name, scale)
end

function UusCorpView:setColor(color)
    WindowApi.setColor(self.name, color)
end

function UusCorpView:setAlpha(alpha)
    WindowApi.setAlpha(self.name, alpha)
end

function UusCorpView:clearAnchors()
    WindowApi.clearAnchors(self.name)
end