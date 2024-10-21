---@class UusCorpView
---@field name string
---@field template string?
---@field parent string?
---@field id number?
---@field eventHandler string?
---@field onPostInitialize fun(view: UusCorpView, windowData: WindowData?, systemData: SystemData?)?
---@field onUpdate fun(view: UusCorpView, timePassed: number)?
---@field onUpdateMobileStatus fun(view: UusCorpView, data: WindowData.MobileStatus)?
---@field onUpdatePlayerStatus fun(view: UusCorpView, data: WindowData.PlayerStatus, csv: PlayerStat[])?
---@field onUpdateHealthBarColor fun(view: UusCorpView, data: WindowData.HealthBarColor)?
---@field onLButtonUp fun(view: UusCorpView, flags: number, x: number, y: number)?
---@field onLButtonDown fun(view: UusCorpView, flags: number, x: number, y: number)?
---@field onRButtonUp fun(view: UusCorpView, flags: number, x: number, y: number)?
---@field onRButtonDown fun(view: UusCorpView, flags: number, x: number, y: number)?
---@field onLButtonDblClk fun(view: UusCorpView)?
---@field onShown fun(view: UusCorpView, systemData: SystemData)?
---@field onUpdateCurrentTarget fun(view: UusCorpView, data: WindowData.CurrentTarget)?
---@field onUpdateObjectInfo fun(view: UusCorpView, data: WindowData.ObjectInfo?)?
---@field onUpdateContainer fun(view: UusCorpView, data: WindowData.Container)?
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
    object.parent = object.parent or "Root"
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
            if v == UusCorpEvents.PlayerStatus or v == UusCorpEvents.CurrentTarget then
                self:registerData(v.type(), 0)
            else
                self:registerData(v.type(), self:getId())
            end
            self:registerEvent(v.id(), self.eventHandler .. "." .. v.callback)
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
            if v == UusCorpEvents.PlayerStatus or v == UusCorpEvents.CurrentTarget then
                self:unregisterData(v.type(), 0)
            else
                self:unregisterData(v.type(), self:getId())
            end
        end
    end
end

---@param windowData WindowData?
---@param systemData SystemData?
function UusCorpView:onInitialize(windowData, systemData)
    self:registerEvents()
    if self.onPostInitialize ~= nil then
        self:onPostInitialize(windowData, systemData)
    end
    return windowData, systemData
end

function UusCorpView:onShutdown()
    if not self:doesExist() then
        return
    end
    self:unregisterEvents()
 end

function UusCorpView:getPosition()
    return UusCorp.Api.Window.GetPosition(self.name)
end

function UusCorpView:setId(id)
    return UusCorp.Api.Window.SetId(self.name, id or 0)
end

function UusCorpView:getId()
    return UusCorp.Api.Window.GetId(self.name)
end

function UusCorpView:doesExist()
    return UusCorp.Api.Window.DoesExist(self.name)
end

function UusCorpView:isShowing()
    return UusCorp.Api.Window.IsShowing(self.name)
end

function UusCorpView:setShowing(doShow)
    UusCorp.Api.Window.SetShowing(self.name, doShow)
end

function UusCorpView:create(doShow)
    doShow = doShow == nil or doShow
    local created = false

    if self.template ~= nil then
        created = UusCorp.Api.Window.CreateFromTemplate(
            self.name,
            self.template or self.name,
            self.parent or "Root",
            false
        )
    else
        created = UusCorp.Api.Window.Create(self.name, false)
    end

    self:setShowing(doShow)
    return created
end

function UusCorpView:destroy()
    self:onShutdown()
    return UusCorp.Api.Window.Destroy(self.name)
end

function UusCorpView:assignFocus(doFocus)
    UusCorp.Api.Window.AssignFocus(self.name, doFocus)
end

function UusCorpView:addAnchor(anchor)
    UusCorp.Api.Window.AddAnchor(self.name, anchor.anchorPoint, anchor.relativeTo, anchor.relativePoint, anchor.x, anchor.y)
end

function UusCorpView:setUpdateFrequency(frequency)
    UusCorp.Api.Window.SetUpdateFrequency(self.name, frequency)
end

function UusCorpView:getDimensions()
    return UusCorp.Api.Window.GetDimensions(self.name)
end

function UusCorpView:setDimensions(x, y)
    UusCorp.Api.Window.SetDimensions(self.name, x, y)
end

function UusCorpView:forceProcessAnchors()
    UusCorp.Api.Window.ForceProcessAnchors(self.name)
end

function UusCorpView:setOffsetFromParent(x, y)
    return UusCorp.Api.Window.SetOffsetFromParent(self.name, x, y)
end

function UusCorpView:registerEvent(id, callback)
    UusCorp.Api.Window.RegisterEventHandler(self.name, id, callback)
end

function UusCorpView:registerData(type, id)
    UusCorp.Api.Window.RegisterData(type, id)
    return self
end

function UusCorpView:unregisterEvent(id)
    UusCorp.Api.Window.UnregisterEventHandler(self.name, id)
end

function UusCorpView:unregisterData(type, id)
    UusCorp.Api.Window.UnregisterData(type, id)
    return self
end

function UusCorpView:registerCoreEvent(id, callback)
    UusCorp.Api.Window.RegisterCoreEventHandler(self.name, id, callback)
end

function UusCorpView:unregisterCoreEvent(id)
    UusCorp.Api.Window.UnregisterCoreEventHandler(self.name, id)
end

function UusCorpView:setScale(scale)
    UusCorp.Api.Window.SetScale(self.name, scale)
end

function UusCorpView:setColor(color)
    UusCorp.Api.Window.SetColor(self.name, color)
end

function UusCorpView:setAlpha(alpha)
    UusCorp.Api.Window.SetAlpha(self.name, alpha)
end

function UusCorpView:clearAnchors()
    UusCorp.Api.Window.ClearAnchors(self.name)
end

function UusCorpView:getParent()
    local parent = UusCorp.Api.Window.GetParent(self.name)
    if parent == UusCorpRootWindow.name then
        return UusCorpRootWindow
    else
        return UusCorpWindow:new(parent)
    end
end

function UusCorpView:isMoving()
    return UusCorp.Api.Window.IsMoving(self.name)
end

function UusCorpView:setMoving(isMoving)
    UusCorp.Api.Window.SetMoving(self.name, isMoving)
end

function UusCorpView:setParent(parent)
    UusCorp.Api.Window.SetParent(self.name, parent)
end