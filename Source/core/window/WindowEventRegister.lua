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
    table.insert(self.eventHandlers, {
        id = self.id,
        event = event,
        callback = callback
    })
    return self
end

function WindowEventRegister:unregisterEventHandler(event)
    WindowApi.unregisterEventHandler(self.id, event)
    for i = 1, #self.eventHandlers do
        if event == self.eventHandlers[i].event then
            table.remove(self.eventHandlers, i)
            return
        end
    end
end

function WindowEventRegister:unregisterAllEvents()
    for i = 1, #self.eventHandlers do
        WindowApi.unregisterEventHandler(self.id, self.eventHandlers[i].event)
    end
end