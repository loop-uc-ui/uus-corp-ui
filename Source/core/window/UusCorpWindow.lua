UusCorpWindow = function(name)
    local self = UusCorpView(name)
    local children = {}
    local data = {}
    local events = {}

    self.doDestroy = true

    self.addChild = function(child) children[child.getName()] = child end

    self.addData = function(type, id) data[type] = id end

    self.addEvent = function(event, callback) events[event] = callback end

    self.create = function(doShow)
        if self.doesExist() then return end

        UusCorpRoot.Windows[self.getName()] = self

        WindowApi.createWindow(name, doShow == nil or doShow)
    end

    self.getLifeCycle().onInitialize = function(activeWindow)
        if name == activeWindow then
            WindowUtils.RestoreWindowPosition(name, true)
        end

        for key, value in pairs(data) do
            WindowDataApi.registerData(key, value)
        end

        for key, _ in pairs(events) do
            WindowApi.registerEventHandler(name, key, "UusCorpRoot.onEvent")
        end

        for _, value in pairs(children) do value.create() end
    end

    self.getLifeCycle().onShutdown = function(activeWindow)
        if name == activeWindow then WindowUtils.SaveWindowPosition(name) end

        for key, value in pairs(data) do
            WindowDataApi.unregisterData(key, value)
        end

        self = nil
    end

    self.getLifeCycle().onLButtonUp = function(flag, x, y, activeWindow)
        if children[activeWindow] then
            children[activeWindow].getLifeCycle().onLButtonUp(flag, x, y)
        end
    end

    self.getLifeCycle().onLButtonDown = function(flag, x, y, activeWindow)
        if children[activeWindow] then
            children[activeWindow].getLifeCycle().onLButtonDown(flag, x, y)
        end
    end

    self.getLifeCycle().onRButtonUp = function(flag, x, y, activeWindow)
        if name == activeWindow and self.doDestroy then
            self.destroy()
        elseif name == activeWindow then
            self.setShowing(false)
        elseif children[activeWindow] then
            children[activeWindow].getLifeCycle().onRButtonUp(flag, x, y)
        end
    end

    self.getLifeCycle().onRButtonDown = function(flag, x, y, activeWindow)
        if children[activeWindow] then
            children[activeWindow].getLifeCycle().onLButtonDown(flag, x, y)
        end
    end

    self.getLifeCycle().onEvent = function(activeWindow)
        if name == activeWindow then
            for _, value in pairs(events) do value() end
        elseif children[activeWindow] then
            children[activeWindow].getLifeCycle().onEvent()
        end
    end

    return self
end