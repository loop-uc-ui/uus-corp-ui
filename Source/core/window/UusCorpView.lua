
UusCorpView = {
    name = nil,
    coreEvents = {},
    events = {},
    observer = {}
}

UusCorpView.__index = UusCorpView

UusCorpGlobalEvents = {}
UusCorpGlobalCoreEvents = {}

function UusCorpView.new(name)
    return setmetatable({
        name = name,
        coreEvents = {},
        events = {},
        observer = {}
    }, UusCorpView)
end

function UusCorpView:coreEvent(event)
    self.coreEvents[event.name] = event.func
    UusCorpGlobalCoreEvents[self.name .. event.name] = event.func
    return self
end

function UusCorpView:registerCoreEvents()
    for k, _ in pairs(self.coreEvents) do
        WindowApi.registerCoreEventHandler(
            self.name,
            k,
            "UusCorpGlobalCoreEvents" .. "." .. self.name .. k
        )
    end
end

function UusCorpView:unregisterCoreEvents()
    for k, _ in pairs(self.coreEvents) do
        WindowApi.unregisterCoreEventHandler(
            self.name,
            k
        )
        self.coreEvents[k] = nil
        UusCorpGlobalCoreEvents[self.name .. k] = nil
    end
end

function UusCorpView:event(event)
    self.events[event.name] = event
    UusCorpGlobalEvents[self.name .. event.name] = event.func or function ()
        self:update()
    end
    return self
end

function UusCorpView:registerEvents()
    for k, _ in pairs(self.events) do
        WindowApi.registerEventHandler(
            self.name,
            k,
            "UusCorpGlobalEvents" .. "." .. self.name .. k
        )
    end
end

function UusCorpView:unregisterEvents()
    for k, _ in pairs(self.events) do
        WindowApi.unregisterEventHandler(
            self.name,
            k
        )
        self.events[k] = nil
        UusCorpGlobalEvents[self.name .. k] = nil
    end
end

function UusCorpView:update(...)
    for _, v in pairs(self.observer) do
        if type(v) == "function" then
            v(...)
        end
    end
end