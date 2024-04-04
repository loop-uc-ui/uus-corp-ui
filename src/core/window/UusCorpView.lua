---@class UusCorpView
---@field name string
---@field template string?
---@field parent string?
---@field id number?
---@field eventHandler UusCorpEventHandler?
UusCorpView = { name = "UusCorpView" }

---@param model UusCorpView?
---@return UusCorpView
function UusCorpView:new(model)
    if type(model) == "string" then
        model = { name = Active.window()}
    end

    model = model or {}

    if model.name == nil then
        model.name = Active.window()
    end

    local object = setmetatable(model, self)
    self.__index = self
    return object
end

---@param view UusCorpView
---@param eventHandler UusCorpEventHandler
local function mapEvents(view, eventHandler)
    for i = 1, #eventHandler.events do
        local event = eventHandler.events[i]
        local callback = event.callback
        if event == UusCorpEvents.OnUpdate then
            eventHandler[event.callback] = function (timePassed)
                view:onUpdate(timePassed)
            end
        elseif event == UusCorpEvents.OnShown then
            eventHandler[event.callback] = function ()
                view:onShown()
            end
        elseif event == UusCorpEvents.ItemUseRequest then
            eventHandler[callback] = function ()
                local request = UusCorpUseRequests()
                view[callback](view, request.getUseItem(), request.getUseTarget())
            end
        elseif event == UusCorpEvents.SkillUseRequest then
            eventHandler[callback] = function ()
                local request = UusCorpUseRequests()
                view[callback](view, request.getUseSkill(), request.getUseTarget())
            end
        elseif event == UusCorpEvents.SpellUseRequest then
            eventHandler[callback] = function ()
                local request = UusCorpUseRequests()
                view[callback](view, request.getUseSpell(), request.getUseTarget())
            end
        elseif event == UusCorpEvents.VirtueUseRequest then
            eventHandler[callback] = function ()
                local request = UusCorpUseRequests()
                view[callback](view, request.getUseVirtue(), request.getUseTarget())
            end
        elseif event == UusCorpEvents.Container then
            eventHandler[callback] = function ()
                view[callback](view, UusCorpContainer(view:getId()))
            end
        elseif event == UusCorpEvents.ObjectInfo then
            eventHandler[callback] = function ()
                view[callback](view, UusCorpObjectInfo(view:getId()), UusCorpContainer(view:getId()))
            end
        elseif event == UusCorpEvents.PlayerStatus then
            eventHandler[callback] = function ()
                view[callback](view)
            end
        end
    end
end

function UusCorpView:onInitialize()
    self:setId(tonumber(self.name:match("%d+")) or 0)
    if self.eventHandler ~= nil then
        mapEvents(self, self.eventHandler)
        for i = 1, #self.eventHandler.events do
            local event = self.eventHandler.events[i]
            if type(event.id) == "string" then
                self:registerCoreEvent(event.id, self.eventHandler.name .. "." .. event.callback)
            else
                self:registerData(event.type(), self:getId())
                self:registerEvent(event.id(), self.eventHandler.name .. "." .. event.callback)
            end
        end
    end

    return self, object
end

function UusCorpView:onShown() end

function UusCorpView:onHidden() end

function UusCorpView:onUpdatePlayerStatus() end

function UusCorpView:onShutdown()
    if self ~= nil and self.eventHandler ~= nil then
        for i = 1, #self.eventHandler.events do
            local event = self.eventHandler.events[i]
            if type(event.id) == "string" then
                self:unregisterCoreEvent(event.id)
            else
                self:unregisterEvent(event.id())
                self:unregisterData(event.type(), self:getId())
            end
        end
    end
    self = nil
 end

function UusCorpView:onUpdate(timePassed) return self, timePassed end

function UusCorpView:onLButtonUp(flags, x, y) return self, flags, x, y end

function UusCorpView:onRButtonUp(flags, x, y) return self, flags, x, y end

function UusCorpView:onLButtonDown(flags, x, y) return self, flags, x, y end

function UusCorpView:onRButtonDown(flags, x, y) return self, flags, x, y end

---@param data UusCorpContainer
function UusCorpView:onUpdateContainer(data) return self, data end

function UusCorpView:onUpdateObjectInfo(object) return self, object end

function UusCorpView:getPosition()
    return WindowApi.getPosition(self.name)
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

function UusCorpView:create(doShow)
    doShow = doShow == nil or doShow
    local created = false

    if self.template ~= nil and self.parent ~= nil then
        created = WindowApi.createFromTemplate(self.name, self.template or self.name, self.parent or "Root")
    else
        created = WindowApi.createWindow(self.name, false)
    end

    self:setShowing(doShow)
    return created
end

function UusCorpView:destroy()
    local name = self.name
    self:onShutdown()
    return WindowApi.destroyWindow(name)
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

function UusCorpView:forceProcessAnchors()
    WindowApi.forceProcessAnchors(self.name)
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

function UusCorpView:getParent()
    return WindowApi.getParent(self.name)
end