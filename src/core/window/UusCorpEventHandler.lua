---@class UusCorpEvent
---@field id string|fun():number
---@field callback string
---@field type (fun():number)?

UusCorpEvents = {
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

function UusCorpEventHandler.onInitialize(view)
    view:onInitialize()
end

function UusCorpEventHandler.onShutdown(view)
    view:onShutdown()
end

function UusCorpEventHandler.onUpdate(timePassed, view)
    view:onUpdate(timePassed)
end