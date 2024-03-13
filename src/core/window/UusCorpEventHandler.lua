---@class UusCorpEvent
---@field id fun():number
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
    }
}

UusCorpCoreEvents = {
    ---@type UusCorpCoreEvent
    OnUpdate = {
        id = "OnUpdate",
        callback = "onUpdate"
    },
    ---@type UusCorpCoreEvent
    OnLButtonUp = {
        id = "OnLButtonUp",
        callback = "onLButtonUp"
    },
    ---@type UusCorpCoreEvent
    OnLButtonDown = {
        id = "OnLButtonDown",
        callback = "onUpdate"
    },
    ---@type UusCorpCoreEvent
    OnRButtonUp = {
        id = "OnRButtonUp",
        callback = "onRButtonUp"
    },
    ---@type UusCorpCoreEvent
    OnRButtonDown = {
        id = "OnRButtonDown",
        callback = "onRButtonDown"
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
---@field getView fun():UusCorpView
---@field coreEvents UusCorpCoreEvent[]?
---@field events UusCorpEvent[]?
---@field data UusCorpData[]?
UusCorpEventHandler = {}

---@param model UusCorpEventHandler
---@return UusCorpEventHandler
function UusCorpEventHandler:new(model)
    ---@class InternalEventHandler:UusCorpEventHandler
    local eventHandler = setmetatable(model or {}, self)

    self.__index = self

    ---@type UusCorpView
    local view

    eventHandler.onInitialize = function ()
        view = model.getView()
        if model.events ~= nil then
            for i = 1, #model.events do
                local event = model.events[i]
                if event == UusCorpEvents.ItemUseRequest then
                    eventHandler[model.events[i].callback] = function ()
                        local request = UusCorpUseRequests()
                        view[model.events[i].callback](view, request.getUseItem(), request.getUseTarget())
                    end
                elseif event == UusCorpEvents.SkillUseRequest then
                    eventHandler[model.events[i].callback] = function ()
                        local request = UusCorpUseRequests()
                        view[model.events[i].callback](view, request.getUseSkill(), request.getUseTarget())
                    end
                elseif event == UusCorpEvents.SpellUseRequest then
                    eventHandler[model.events[i].callback] = function ()
                        local request = UusCorpUseRequests()
                        view[model.events[i].callback](view, request.getUseSpell(), request.getUseTarget())
                    end
                elseif event == UusCorpEvents.VirtueUseRequest then
                    eventHandler[model.events[i].callback] = function ()
                        local request = UusCorpUseRequests()
                        view[model.events[i].callback](view, request.getUseVirtue(), request.getUseTarget())
                    end
                end
            end
        end

        if eventHandler.coreEvents ~= nil then
            for i = 1, #model.coreEvents do
                local event = model.coreEvents[i]
                if event == UusCorpCoreEvents.OnUpdate then
                    eventHandler[event.callback] = function (timePassed)
                        view:onUpdate(timePassed)
                    end
                elseif event == UusCorpCoreEvents.OnShown then
                    eventHandler[event.callback] = function ()
                        view:onShown()
                    end
                end
            end
        end

        view:setId(tonumber(string.match(view.name, "%d+")) or 0)
        eventHandler:register(view)
        view:onInitialize()
    end

    eventHandler.onShutdown = function ()
        eventHandler:unregister(view)
        view:onShutdown()
    end

    return eventHandler
end

---@param view UusCorpView
function UusCorpEventHandler:register(view)
    if self.data ~= nil then
        for i = 1, #self.data do
            local data = self.data[i]
            view:registerData(data.getType(), view:getId())
        end
    end

    if self.coreEvents ~= nil then
        for i = 1, #self.coreEvents do
            local event = self.coreEvents[i]
            view:registerCoreEvent(event.id, self.name .. "." .. event.callback)
        end
    end

    if self.events ~= nil then
        for i = 1, #self.events do
            local event = self.events[i]
            view:registerEvent(event.id(), self.name .. "." .. event.callback)
        end
    end
end

---@param view UusCorpView
function UusCorpEventHandler:unregister(view)
    if self.coreEvents ~= nil then
        for i = 1, #self.coreEvents do
            local event = self.coreEvents[i]
            view:unregisterCoreEvent(event.id)
        end
    end

    if self.events ~= nil then
        for i = 1, #self.events do
            local event = self.events[i]
            view:unregisterEvent(event.id())
        end
    end

    if self.data ~= nil then
        for i = 1, #self.data do
            local data = self.data[i]
            view:unregisterData(data.getType(), view:getId())
        end
    end
end