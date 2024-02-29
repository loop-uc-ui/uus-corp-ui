---@class UusCorpViewModel
---@field name string
---@field data UusCorpViewData[]
---@field events UusCorpEvent[]
local UusCorpViewModel = {
    name = "",
    data = {},
    events = {}
}

---@class UusCorpView
---@field model UusCorpViewModel
UusCorpView = { model = UusCorpViewModel }

---@param model UusCorpViewModel
---@return UusCorpView
function UusCorpView:new(model)
    local object = setmetatable({ model = model  }, self)
    self.__index = self
    return object
end

function UusCorpView:getName()
    return self.model.name
end

function UusCorpView:setId(id)
    return WindowApi.setId(self:getName(), id)
end

function UusCorpView:getId()
    return WindowApi.getId(self:getName())
end

function UusCorpView:doesExist()
    return WindowApi.doesExist(self:getName())
end

function UusCorpView:isShowing()
    return WindowApi.isShowing(self:getName())
end

function UusCorpView:setShowing(doShow)
    WindowApi.setShowing(self:getName(), doShow)
end

function UusCorpView:createFromTemplate(template, parent)
    return WindowApi.createFromTemplate(self:getName(), template or self:getName(), parent or "Root")
end

function UusCorpView:create(doShow)
    return WindowApi.createWindow(self:getName(), doShow == nil or doShow)
end

function UusCorpView:destroy()
    return WindowApi.destroyWindow(self:getName())
end

function UusCorpView:assignFocus(doFocus)
    WindowApi.assignFocus(self:getName(), doFocus)
end

function UusCorpView:addAnchor(anchor)
    WindowApi.addAnchor(self:getName(), anchor.anchorPoint, anchor.relativeTo, anchor.relativePoint, anchor.x, anchor.y)
end

function UusCorpView:setUpdateFrequency(frequency)
    WindowApi.setUpdateFrequency(self:getName(), frequency)
end

function UusCorpView:getDimensions()
    return WindowApi.getDimensions(self:getName())
end

function UusCorpView:setDimensions(x, y)
    WindowApi.setDimensions(self:getName(), x, y)
end

function UusCorpView:forceProcessAnchors()
    WindowApi.forceProcessAnchors(self:getName())
end

function UusCorpView:setOffsetFromParent(x, y)
    return WindowApi.setOffsetFromParent(self:getName(), x, y)
end

function UusCorpView:registerEvent(id, callback)
    WindowApi.registerEventHandler(self:getName(), id, callback)
end

function UusCorpView:registerData(type, id)
    WindowDataApi.registerData(type, id)
    return self
end

function UusCorpView:unregisterEvent(id)
    WindowApi.unregisterEventHandler(self:getName(), id)
end

function UusCorpView:unregisterData(type, id)
    WindowDataApi.unregisterData(type, id)
    return self
end

function UusCorpView:registerCoreEvent(id, callback)
    WindowApi.registerCoreEventHandler(self:getName(), id, callback)
end

function UusCorpView:unregisterCoreEvent(id)
    WindowApi.unregisterCoreEventHandler(self:getName(), id)
end

function UusCorpView:setScale(scale)
    WindowApi.setScale(self:getName(), scale)
end

function UusCorpView:setColor(color)
    WindowApi.setColor(self:getName(), color)
end

function UusCorpView:setAlpha(alpha)
    WindowApi.setAlpha(self:getName(), alpha)
end

function UusCorpView:clearAnchors()
    WindowApi.clearAnchors(self:getName())
end

function UusCorpView:onInitialize()
    if self.model.data ~= nil then
        for i = 1, #self.model.data do
            local data = self.model.data[i]
            self:registerData(data.type, data.id)
        end
    end

    if self.model.events ~= nil then
        for i = 1, #self.model.events do
            local event = self.model.events[i]
            self:registerEvent(event.event, event.callback)
        end
    end
end

function UusCorpView:onLButtonUp(flags, x, y) return flags, x, y end

function UusCorpView:onLButtonDown(flags, x, y) return flags, x, y end

function UusCorpView:onRButtonUp(flags, x, y) return flags, x, y end

function UusCorpView:onRButtonDown(flags, x, y) return flags, x, y end

function UusCorpView:onMouseOver() end

function UusCorpView:onMouseOverEnd() end

function UusCorpView:onLButtonDblClk() end

function UusCorpView:onUpdatePlayerStatus(data) return data end

function UusCorpView:onUpdateContainer(data) return data end

function UusCorpView:onUpdateObjectInfo(data) return data end

function UusCorpView:onUpdate(timePassed) return timePassed end

function UusCorpView:onShutdown()
    if self.model.events ~= nil then
        for i = 1, #self.model.events do
            local event = self.model.events[i]
            self:unregisterEvent(event.event)
        end
    end

    if self.model.data ~= nil then
        for i = 1, #self.model.data do
            local data = self.model.data[i]
            self:unregisterData(data.type, data.id)
        end
    end
end