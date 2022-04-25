RootEventManager = { name = "RootEventManager", events = {}, data ={}}
RootEventManager.__index = RootEventManager

function RootEventManager:registerEvent(event, callback)
    WindowApi.registerEventHandler(
        RootWindow.NAME,
        event,
        self.name .. "." .. callback
    )
    self.events[event] = callback
end

function RootEventManager:unregisterEvent(event)
    WindowApi.unregisterEventHandler(
        RootWindow.NAME,
        event
    )
    self.events[event] = nil
end

function RootEventManager:registerData(type, id)
    WindowDataApi.registerData(type, id)
    self.data[id] = type
end

function RootEventManager:initialize() end

function RootEventManager:shutdown()
    for k, _ in pairs(self.events) do
        self:unregisterEvent(k)
    end

    for k, v in pairs(self.data) do
        WindowDataApi.unregisterData(v, k)
    end
end