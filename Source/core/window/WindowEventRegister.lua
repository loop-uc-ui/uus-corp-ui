WindowEventRegister = {}

function WindowEventRegister:new(id)
    local this = {}
    this.id = id
    this.eventHandlers = {}
    self.__index = self
    return setmetatable(this, self)
end

function WindowEventRegister:registerEventHandler(event, callback)
    WindowApi.registerEventHandler(self.id, event, callback)
    self.eventHandlers[event] = callback
    return self
end

function WindowEventRegister:unregisterEventHandler(event)
    WindowApi.unregisterEventHandler(self.id, event)
    for key, _ in pairs(self.eventHandlers) do
        if event == key then
            table.remove(self.eventHandlers, key)
            break
        end
    end
end

function WindowEventRegister:unregisterAllEvents()
    for key, _ in pairs(self.eventHandlers) do
        WindowApi.unregisterEventHandler(self.id, key)
    end
end