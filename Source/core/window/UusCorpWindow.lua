UusCorpWindow = {
    ChildAdapter =  {
        init = function()
            local self = {}
            local children = {}

            self.getChildren = function() return children end

            self.addChild = function(view)
                table.insert(children, view)
            end

            self.register = function()
                for _, value in pairs(children) do value.getLifeCycle().onInitialize() end
            end

            self.unregister = function()
                for _, value in pairs(children) do value.destroy() end
                children = {}
            end

            self.getChild = function(name)
                for _, value in pairs(children) do
                    if string.find(name, value.getName()) then
                        return value
                    end
                end
            end

            return self
        end
    },

    EventAdapter = {
        init = function(name)
            local self = {}
            local events = {}

            self.getEvents = function() return events end

            self.addEvent = function(event, callback)
                table.insert(events, {
                    event = event,
                    callback = callback
                })
            end

            self.register = function()
                for _, value in pairs(events) do
                    WindowApi.registerEventHandler(name, value.event, "UusCorpRoot.onEvent")
                    value.callback()
                end
            end

            self.unregister = function()
                for _, value in pairs(events) do
                    WindowApi.unregisterEventHandler(name, value.event)
                end
                events = {}
            end

            return self
        end
    },

    DataAdapter = {
        init = function()
            local self = {}
            local data = {}

            self.getData = function() return data end

            self.addData = function(type, id) 
                table.insert(data, {
                    type = type,
                    id = id
                })
            end

            self.unregister = function()
                for _, value in pairs(data) do
                    WindowDataApi.unregisterData(value.type, value.id)
                end
                data = {}
            end

            self.register = function()
                for _, value in pairs(data) do
                    WindowDataApi.registerData(value.type, value.id)
                end
            end

            return self
        end
    },

    onInitialize = function(window)
        if window.getName() == ActiveWindow.name() then
            WindowUtils.RestoreWindowPosition(window.getName(), true)
        end
        window.getDataAdapter().register()
        window.getChildAdapter().register()
        window.getEventAdapter().register()
    end,

    init = function(name, template, parent)
        local self = UusCorpView.init(name)

        local childAdapter = UusCorpWindow.ChildAdapter.init()
        local dataAdapter = UusCorpWindow.DataAdapter.init()
        local eventAdapter = UusCorpWindow.EventAdapter.init(name)

        local doDestroy = true
        local _template = template or name
        local _parent = parent or UusCorpRoot.Name

        self.getChildAdapter = function() return childAdapter end

        self.getDataAdapter = function() return dataAdapter end

        self.getEventAdapter = function() return eventAdapter end

        self.create = function(doShow)
            if self.doesExist() then return end

            doDestroy = doShow == nil or doShow

            UusCorpRoot.Windows[self.getName()] = self

            WindowApi.createFromTemplate(name, _template, _parent)
            self.setShowing(doShow == nil or doShow)
        end

        self.getLifeCycle().onInitialize = function()
            UusCorpWindow.onInitialize(self)
        end

        self.getLifeCycle().onShutdown =
            function(activeWindow)
                if name == activeWindow then
                    WindowUtils.SaveWindowPosition(name)
                end
                dataAdapter.unregister()
                eventAdapter.unregister()
                childAdapter.unregister()
                self = nil
            end

        self.getLifeCycle().onLButtonUp =
            function(flag, x, y, activeWindow)
                if name ~= activeWindow then
                    childAdapter.getChild(activeWindow).getLifeCycle()
                        .onLButtonUp(flag, x, y)
                end
            end

        self.getLifeCycle().onLButtonDown =
            function(flag, x, y, activeWindow)
                if name ~= activeWindow then
                    childAdapter.getChild(activeWindow).getLifeCycle()
                        .onLButtonDown(flag, x, y)
                end
            end

        self.getLifeCycle().onRButtonUp =
            function(flag, x, y, activeWindow)
                if name == activeWindow and doDestroy then
                    self.destroy()
                elseif name == activeWindow then
                    self.setShowing(false)
                else
                    childAdapter.getChild(activeWindow).getLifeCycle()
                        .onRButtonUp(flag, x, y)
                end
            end

        self.getLifeCycle().onRButtonDown =
            function(flag, x, y, activeWindow)
                if name ~= activeWindow then
                    childAdapter.getChild(activeWindow).getLifeCycle()
                        .onLButtonDown(flag, x, y)
                end
            end

        self.getLifeCycle().onEvent = function(activeWindow)
            if name == activeWindow then
                for _, value in pairs(eventAdapter.getEvents()) do
                    value.callback()
                end
            else
                childAdapter.getChild(activeWindow).getLifeCycle()
                    .onEvent()
            end
        end

        return self
    end
}
