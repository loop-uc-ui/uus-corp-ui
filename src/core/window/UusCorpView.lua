---@class UusCorpView
---@field name string
---@field template string?
---@field parent string?
---@field id number?
---@field eventHandler string?
UusCorpView = { name = "UusCorpView" }

---@param model string|UusCorpView?
---@return UusCorpView
function UusCorpView:new(model)
    if type(model) == "string" then
        model = { name = model }
    end

    model = model or {}

    if model.name == nil then
        model.name = Active.window()
    end

    local object = setmetatable(model, self)
    self.__index = self
    return object
end

function UusCorpView:registerEvents()
    if self.eventHandler == nil then
        return nil
    end

    for _, v in pairs(UusCorpEvents) do
        if self[v.callback] ~= nil and type(v.id) == "string" then
            self:registerCoreEvent(v.id, self.eventHandler .. "." .. v.callback)
        elseif self[v.callback] ~= nil then
            self:registerData(v.type(), self:getId())
            self:registerEvent(v.id(), self.name .. "." .. v.callback)
        end
    end
end

function UusCorpView:unregisterEvents()
    if self.eventHandler == nil then
        return
    end

    for _, v in pairs(UusCorpEvents) do
        if self[v.callback] ~= nil and type(v.id) == "string" then
            self:unregisterCoreEvent(v.id)
        elseif self[v.callback] ~= nil then
            self:unregisterEvent(v.id())
            self:unregisterData(v.type(), self:getId())
        end
    end
end

---@param data WindowData?
function UusCorpView:onInitialize(data)
    self:registerEvents()
end

function UusCorpView:onShutdown()
    if not self:doesExist() then
        return
    end
    self:unregisterEvents()
 end

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
    self:onShutdown()
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
    Debug.Print(callback)
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
    local parent = WindowApi.getParent(self.name)
    if WindowApi.getParent(self.name) == UusCorpRootWindow.name then
        return UusCorpRootWindow
    else
        return UusCorpWindow:new(parent)
    end
end

-- function UusCorpView:onUpdate(timePassed) return self, timePassed end

-- function UusCorpView:onRButtonUp(flags, x, y) return self, flags, x, y end

-- function UusCorpView:onRButtonDown(flags, x, y) return self, flags, x, y end

-- function UusCorpView:onLButtonUp(flags, x, y) return self, flags, x, y end

-- function UusCorpView:onLButtonDown(flags, x, y) return self, flags, x, y end

-- ---@param data WindowData.PlayerStatus
-- function UusCorpView:onUpdatePlayerStatus(data) return self, data end

-- ---@param data WindowData.MobileStatus
-- function UusCorpView:onMobileStatusUpdate(data) return self, data end

-- function UusCorpView:onHidden() return self end

-- function UusCorpView:onShown() return self end