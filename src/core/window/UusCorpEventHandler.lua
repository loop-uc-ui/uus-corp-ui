---@class UusCorpEvent
---@field id string|fun():number
---@field callback string

---@class UusCorpCoreEvent
---@field id string
---@field callback string

UusCorpEvents = {
    ---@type UusCorpEvent
    Container = {
        id = function ()
            return Container.event()
        end,
        callback = "onUpdateContainer"
    },
    ---@type UusCorpEvent
    ObjectInfo = {
        id = function ()
            return ObjectInfo.event()
        end,
        callback = "onUpdateObjectInfo"
    },
    ---@type UusCorpEvent
    PlayerStatus = {
        id = function ()
            return PlayerStatus.event()
        end,
        callback = "onUpdatePlayerStatus"
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
        callback = "onUpdate"
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
        callback = "OnMouseOverEnd"
    }
}

---@class UusCorpData
---@field getType fun(): number

UusCorpData = {
    ---@type UusCorpData
    Container = {
        getType = function ()
            return Container.type()
        end
    },
    ---@type UusCorpData
    ObjectInfo = {
        getType = function ()
            return ObjectInfo.type()
        end
    },
    ---@type UusCorpData
    PlayerStatus = {
        getType = function ()
            return PlayerStatus.type()
        end
    }
}

---@class UusCorpEventHandler
---@field name string
---@field getView fun(...):UusCorpView
---@field events UusCorpEvent[]?
---@field data UusCorpData[]?
UusCorpEventHandler = {}

---@param model UusCorpEventHandler
---@return InternalEventHandler
function UusCorpEventHandler:new(model)
    ---@class InternalEventHandler:UusCorpEventHandler
    local eventHandler = setmetatable(model or {}, self)

    self.__index = self

    ---@type UusCorpView
    local view

    local data = {}

    eventHandler.onInitialize = function (...)
        view = model.getView(...)
        view:create()
        if model.events ~= nil then
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
                    table.insert(data, UusCorpData.Container)
                    eventHandler[callback] = function ()
                        view[callback](view, UusCorpContainer(view:getId()))
                    end
                elseif event == UusCorpEvents.ObjectInfo then
                    table.insert(data, UusCorpData.ObjectInfo)
                    eventHandler[callback] = function ()
                        view[callback](view, UusCorpObjectInfo(view:getId()), UusCorpContainer(view:getId()))
                    end
                elseif event == UusCorpEvents.PlayerStatus then
                    table.insert(data, UusCorpData.PlayerStatus)
                    eventHandler[callback] = function ()
                        view[callback](view)
                    end
                end
            end
        end

        if view.id ~= nil then
            view:setId(view.id)
        elseif view:getId() == nil or view:getId() == 0 then
            view:setId(tonumber(view.name:match("%d+")) or 0)
        end
        eventHandler:register(view, data)
        view:onInitialize(UusCorpGameObject:new(view:getId()))
        return view
    end

    eventHandler.onShutdown = function ()
        eventHandler:unregister(view, data)
        view:onShutdown()
    end

    return eventHandler
end

---@param view UusCorpView
---@param data UusCorpData[]
function UusCorpEventHandler:register(view, data)
    if data ~= nil then
        for i = 1, #data do
            local item = data[i]
            view:registerData(item.getType(), view:getId())
        end
    end

    if self.events ~= nil then
        for i = 1, #self.events do
            local event = self.events[i]
            if type(event.id) == "string" then
                view:registerCoreEvent(event.id, self.name .. "." .. event.callback)
            else
                view:registerEvent(event.id(), self.name .. "." .. event.callback)
            end
        end
    end
end

---@param view UusCorpView
function UusCorpEventHandler:unregister(view, data)
    if self.events ~= nil then
        for i = 1, #self.events do
            local event = self.events[i]
            if type(event.id) == "string" then
                view:unregisterCoreEvent(event.id)
            else
                view:unregisterEvent(event.id())
            end
        end
    end

    if data ~= nil then
        for i = 1, #data do
            local item = data[i]
            view:unregisterData(item.getType(), view:getId())
        end
    end
end