---@class UusCorpWindow
---@field name string
UusCorpWindow = { name = "UusCorpWindow" }
UusCorpWindow.__index = UusCorpWindow

---@return UusCorpWindow
function UusCorpWindow:new(name)
    return setmetatable({ name = name }, UusCorpWindow)
end

function UusCorpWindow:setId(id)
    return WindowApi.setId(self.name, id)
end

function UusCorpWindow:getId()
    return WindowApi.getId(self.name)
end

function UusCorpWindow:doesExist()
    return WindowApi.doesExist(self.name)
end

function UusCorpWindow:isShowing()
    return WindowApi.isShowing(self.name)
end

function UusCorpWindow:setShowing(doShow)
    WindowApi.setShowing(self.name, doShow)
end

function UusCorpWindow:createFromTemplate(template, parent)
    return WindowApi.createFromTemplate(self.name, template or name, parent or "Root")
end

function UusCorpWindow:create(doShow)
    return WindowApi.createWindow(self.name, doShow == nil or doShow)
end

function UusCorpWindow:destroy()
    return WindowApi.destroyWindow(self.name)
end

function UusCorpWindow:addAnchor(anchor)
    WindowApi.addAnchor(self.name, anchor.anchorPoint, anchor.relativeTo, anchor.relativePoint, anchor.x, anchor.y)
end

function UusCorpWindow:setUpdateFrequency(frequency)
    WindowApi.setUpdateFrequency(self.name, frequency)
end

function UusCorpWindow:getDimensions()
    return WindowApi.getDimensions(self.name)
end

function UusCorpWindow:setOffsetFromParent(x, y)
    return WindowApi.setOffsetFromParent(self.name, x, y)
end

function UusCorpWindow:registerEvent(id, callback)
    WindowApi.registerEventHandler(self.name, id, self.name .. "." .. callback)
end

function UusCorpWindow:registerData(type, id)
    WindowDataApi.registerData(type, id)
end

function UusCorpWindow:unregisterEvent(id)
    WindowApi.unregisterEventHandler(self.name, id)
end

function UusCorpWindow:unregisterData(type, id)
    WindowDataApi.unregisterData(type, id)
end

function UusCorpWindow:registerCoreEvent(id, callback)
    WindowApi.registerCoreEventHandler(self.name, id, callback)
end

function UusCorpWindow:unregisterCoreEvent(id)
    WindowApi.unregisterCoreEventHandler(self.name, id)
end

function UusCorpWindow:attachToWorldObject(id)
    WindowApi.attachWindowToWorldObject(id, self.name)
end

function UusCorpWindow:detatchFromWorlObject(id)
    WindowApi.detachWindowFromWorldObject(id, self.name)
end

function UusCorpWindow:setScale(scale)
    WindowApi.setScale(self.name, scale)
end

function UusCorpWindow:setColor(color)
    WindowApi.setColor(self.name, color)
end

function UusCorpWindow:savePosition()
    WindowUtilsWrapper.saveWindowPosition(self.name)
end

function UusCorpWindow:restorePosition()
    WindowUtilsWrapper.restoreWindowPosition(self.name)
end

---@return UusCorpLabel
function UusCorpWindow:addLabel(label)
    return UusCorpLabel.new(self --[[@as UusCorpLabel]], self.name .. label)
end

---@return UusCorpStatusBar
function UusCorpWindow:addStatusBar(statusBar)
    return UusCorpStatusBar.new(self --[[@as UusCorpStatusBar]], self.name .. statusBar)
end