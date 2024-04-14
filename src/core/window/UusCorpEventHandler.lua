---@class UusCorpEvent
---@field id string|fun():number
---@field callback string
---@field type (fun():number)?

UusCorpEvents = {
    ---@type UusCorpEvent
    CurrentTarget = {
        id = function ()
            return CurrentTarget.event()
        end,
        callback = "onUpdateCurrentTarget",
        type = function ()
            return CurrentTarget.dataType()
        end
    },
    ---@type UusCorpEvent
    Container = {
        id = function ()
            return Container.event()
        end,
        callback = "onUpdateContainer",
        type = function ()
            return Container.type()
        end
    },
    ---@type UusCorpEvent
    ObjectInfo = {
        id = function ()
            return ObjectInfo.event()
        end,
        callback = "onUpdateObjectInfo",
        type = function ()
            return ObjectInfo.type()
        end
    },
    ---@type UusCorpEvent
    PlayerStatus = {
        id = function ()
            return PlayerStatus.event()
        end,
        callback = "onUpdatePlayerStatus",
        type = function ()
            return PlayerStatus.type()
        end
    },
    HealthBarColor = {
        id = function ()
            return HealthBarColorData.event()
        end,
        callback = "onUpdateHealthBarColor",
        type = function ()
            return HealthBarColorData.type()
        end
    },
    MobileStatus = {
        id = function ()
            return MobileStatus.event()
        end,
        callback = "onUpdateMobileStatus",
        type = function ()
            return MobileStatus.type()
        end
    },
    ---@type UusCorpEvent
    OnUpdate = {
        id = "OnUpdate",
        callback = "onUpdate"
    },
    ---@type UusCorpEvent
    OnLButtonUp = {
        id = "OnLButtonUp",
        callback = "onLButtonUp"
    },
    ---@type UusCorpEvent
    OnLButtonDown = {
        id = "OnLButtonDown",
        callback = "onLButtonDown"
    },
    ---@type UusCorpEvent
    OnRButtonUp = {
        id = "OnRButtonUp",
        callback = "onRButtonUp"
    },
    ---@type UusCorpEvent
    OnRButtonDown = {
        id = "OnRButtonDown",
        callback = "onRButtonDown"
    },
    ---@type UusCorpEvent
    OnMouseOver = {
        id = "OnMouseOver",
        callback = "onMouseOver"
    },
    ---@type UusCorpEvent
    OnMouseOverEnd = {
        id = "OnMouseOverEnd",
        callback = "onMouseOverEnd"
    },
    ---@type UusCorpEvent
    OnShutdown = {
        id = "OnShutdown",
        callback = "onShutdown"
    },
    ---@type UusCorpEvent
    OnLButtonDblClk = {
        id = "OnLButtonDblClk",
        callback = "onLButtonDblClk"
    },
    ---@type UusCorpEvent
    OnShown = {
        id = "OnShown",
        callback = "onShown"
    }
}

---@class UusCorpEventHandler
---@field name string
UusCorpEventHandler = { name = "UusCorpEventHandler" }

---@param model UusCorpEventHandler
function UusCorpEventHandler:new(model)
    local this = setmetatable(model, self)
    self.__index = self
    return this
end

---@param view UusCorpView
function UusCorpEventHandler.onInitialize(view)
    view:onInitialize(UusCorpWindowData(), UusCorpSystemData())

    --- Call events immediately to mitigate delay
    if view.onUpdatePlayerStatus ~= nil then
        _G[view.eventHandler].onUpdatePlayerStatus(view)
    end

    if view.onUpdateMobileStatus ~= nil then
        _G[view.eventHandler].onUpdateMobileStatus(view)
    end

    if view.onUpdateHealthBarColor ~= nil then
        _G[view.eventHandler].onUpdateHealthBarColor(view)
    end

    if view.onUpdateCurrentTarget ~= nil then
        _G[view.eventHandler].onUpdateCurrentTarget(view)
    end

    if view.onUpdateObjectInfo ~= nil then
        _G[view.eventHandler].onUpdateObjectInfo(view)
    end

    if view.onUpdateCurrentTarget ~= nil then
        _G[view.eventHandler].onUpdateCurrentTarget(view)
    end
end

function UusCorpEventHandler.onShutdown(view)
    view:onShutdown()
end

function UusCorpEventHandler.onUpdate(timePassed, view)
    view:onUpdate(timePassed)
end

function UusCorpEventHandler.onUpdatePlayerStatus(view)
    local data = UusCorpWindowData()
    view:onUpdatePlayerStatus(data.PlayerStatus, data.PlayerStatsDataCSV)
end

function UusCorpEventHandler.onUpdateMobileStatus(view)
    view:onUpdateMobileStatus(UusCorpWindowData().MobileStatus[view:getId()])
end

function UusCorpEventHandler.onUpdateHealthBarColor(view)
    view:onUpdateHealthBarColor(UusCorpWindowData().HealthBarColor[view:getId()])
end

function UusCorpEventHandler.onUpdateCurrentTarget(view)
    local data = UusCorpWindowData().CurrentTarget
    view:onUpdateCurrentTarget(data)
end

function UusCorpEventHandler.onUpdateObjectInfo(view)
    view:onUpdateObjectInfo(UusCorpWindowData().ObjectInfo[view:getId()])
end

function UusCorpEventHandler.onRButtonDown(view, flags, x, y)
    view:onRButtonDown(flags, x, y)
end

function UusCorpEventHandler.onLButtonDown(view, flags, x, y)
    view:onLButtonDown(flags, x, y)
end

function UusCorpEventHandler.onLButtonUp(view, flags, x, y)
    view:onLButtonUp(flags, x, y)
end

function UusCorpEventHandler.onLButtonDblClk(view)
    view:onLButtonDblClk()
end

function UusCorpEventHandler.onShown(view)
    view:onShown(UusCorpSystemData())
end