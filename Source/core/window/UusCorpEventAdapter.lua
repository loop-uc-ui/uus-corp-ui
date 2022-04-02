UusCorpEventAdapter = {}
UusCorpEventAdapter.__index = UusCorpEventAdapter

local function event(name, rootCallback, windowCallback)
    return {
        name = name,
        rootCallback = rootCallback,
        windowCallback = windowCallback
    }
end

function UusCorpEventAdapter:init(name)
    local this = setmetatable({}, self)

    this.name = name

    this.initialize = event("OnInitialize", nil, function () end)

    this.event = event(nil, "UusCorpRoot.onEvent")

    this.coreEvents = {
        onShutdown = event("OnShutdown", "UusCorpRoot.onShutdown"),
        onRButtonUp = event("OnRButtonUp", "UusCorpRoot.onRButtonUp"),
        onRButtonDown = event("OnRButtonDown", "UusCorpRoot.onRBUttonDown"),
        onLButtonUp = event("OnLButtonUp", "UusCorpRoot.onLButtonUp"),
        onShown = event("OnShown", "UusCorpRoot.onShown")
    }

    return this
end

function UusCorpEventAdapter:register()
    for _, value in pairs(self.coreEvents) do
        if value.windowCallback then
            WindowApi.registerCoreEventHandler(
                self.name,
                value.name,
                value.rootCallback
            )
        end
    end

    if self.event.name and self.event.windowCallback then
        WindowApi.registerEventHandler(self.name, self.event.name,
                                       self.event.rootCallback)
        self.event.windowCallback()
    end
end

function UusCorpEventAdapter:unregister()
    for _, value in pairs(self.coreEvents) do
        if value.windowCallback then
            WindowApi.unregisterCoreEventHandler(self.name, value.name)
            value.windowCallback = nil
        end
    end

    if self.event.name then
        WindowApi.unregisterEventHandler(self.name, self.event.name)
    end

    self.event.name = nil
    self.event.windowCallback = nil
    self.initialize.windowCallback = function() end
end

function UusCorpEventAdapter:onInitialize(callback) 
    self.initialize.windowCallback = callback
end

function UusCorpEventAdapter:onEvent(eventName, callback)
    self.event.name = eventName
    self.event.windowCallback = callback
end

function UusCorpEventAdapter:onShutdown(func)
    self.coreEvents.onShutdown.windowCallback = func
end

function UusCorpEventAdapter:onLButtonUp(func)
    self.coreEvents.onLButtonUp.windowCallback = func
end

function UusCorpEventAdapter:onLButtonDown(func)
    self.coreEvents.onLButtonDown.windowCallback = func
end

function UusCorpEventAdapter:onRButtonUp(func)
    self.coreEvents.onRButtonUp.windowCallback = func
end

function UusCorpEventAdapter:onRButtonDown(func)
    self.coreEvents.onRButtonDown.windowCallback = func
end

function UusCorpEventAdapter:onShown(func)
    self.coreEvents.onShown.windowCallback = func
end

