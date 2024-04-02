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
    }
}

---@class UusCorpEventHandler
---@field name string
---@field getView fun(...):UusCorpView
---@field events UusCorpEvent[]?
UusCorpEventHandler = {}

---@param model UusCorpEventHandler
---@return UusCorpEventHandler
function UusCorpEventHandler:new(model)
    model.events = model.events or {}
    local eventHandler = setmetatable(model, self)
    self.__index = self

    ---@type UusCorpView
    local view

    eventHandler.onInitialize = function (...)
        view = model.getView(...)
        view:create()
        for i = 1, #model.events do
            local event = model.events[i]
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
        view.eventHandler = eventHandler
        view:onInitialize()
        return view
    end

    eventHandler.onShutdown = function ()
        view:onShutdown()
    end

    return eventHandler
end

function UusCorpEventHandler.onInitialize(...) return ... end

function UusCorpEventHandler.onShutdown() end