
UusCorpViewable = {}
UusCorpViewable.__index = UusCorpViewable

function UusCorpViewable.new(name)
    return setmetatable({
        name = name,
        coreEvents = {},
        events = {}
    }, UusCorpViewable)
end

function UusCorpViewable:coreEvent(event)
    self.coreEvents[event.name] = event.func
    UusCorpViewActionManager[self.name .. event.name] = event.func
    return self
end

function UusCorpViewable:registerCoreEvents()
    for k, _ in pairs(self.coreEvents) do
        WindowApi.registerCoreEventHandler(
            self.name,
            k,
            "UusCorpViewActionManager" .. "." .. self.name .. k
        )
    end
end

function UusCorpViewable:unregisterCoreEvents()
    for k, _ in pairs(self.coreEvents) do
        WindowApi.unregisterCoreEventHandler(
            self.name,
            k
        )
        self.coreEvents[k] = nil
        UusCorpViewActionManager[self.name .. k] = nil
    end
end

function UusCorpViewable:event(event)
    self.events[event.name] = event
    self[event.name] = event.func
    return self
end

function UusCorpViewable:registerEvents()
    for k, _ in pairs(self.events) do
        WindowApi.registerEventHandler(
            self.name,
            k,
            "UusCorpViewActionManager" .. "." .. self.name .. k
        )
    end
end

function UusCorpViewable:unregisterEvents()
    for k, _ in pairs(self.events) do
        WindowApi.unregisterEventHandler(
            self.name,
            k
        )
        self.events[k] = nil
        UusCorpViewActionManager[self.name .. k] = nil
    end
end