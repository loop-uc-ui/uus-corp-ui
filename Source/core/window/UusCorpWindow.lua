UusCorpWindow = middleclass.class("UusCorpWindow", UusCorpView)

local ROOT_WINDOW = "Root"

function UusCorpWindow:init(name)
    UusCorpView.init(self, name)
    self.children = {}
    self.registeredData = {}
    self.root = ROOT_WINDOW
end

function UusCorpWindow:create(doShow)
    if self:doesExist() then
        return
    end

    UusCorpViewLifeCycle.Windows[self.name] = self
    
    WindowApi.createWindow(
        self.name,
        doShow == nil or doShow
    )
end

function UusCorpWindow:addChild(window)
    self.children[window.name] = window
end

function UusCorpWindow:registerData(type, id)
    WindowDataApi.registerData(type, id)
    self.registeredData[type] = id
end

function UusCorpWindow:unregisterData(type, id)
    self.registeredData[type] = nil
    WindowDataApi.unregisterData(type, id)
end

function UusCorpWindow:registerEventHandler(event, callback)
    WindowApi.registerEventHandler(self.name, event, callback or "UusCorpViewLifeCycle.onEvent")
end

function UusCorpWindow:onInitialize(activeWindow)
    if not self.children[activeWindow] then
        WindowUtils.RestoreWindowPosition(self.name, true)
    end

    for _, value in pairs(self.children) do
        value:create()
    end
end

function UusCorpWindow:onShutdown(activeWindow)
    if not self.children[activeWindow] then
        WindowUtils.SaveWindowPosition(self.id)
    end

    for key, value in pairs(self.registeredData) do
        self:unregisterData(key, value)
    end
end

function UusCorpWindow:onLButtonUp(flags, x, y, activeWindow)
    if self.children[activeWindow] then
        self.children[activeWindow]:onLButtonUp(flags, x, y)
    end
end

function UusCorpWindow:onRButtonUp(flags, x, y, activeWindow)
    if self.children[activeWindow] then
        self.children[activeWindow]:onRButtonUp(flags, x, y)
    end
end

function UusCorpWindow:onRButtonDown(flags, x, y, activeWindow)
    if self.children[activeWindow] then
        self.children[activeWindow]:onRButtonDown(flags, x, y)
    end
end

function UusCorpWindow:onEvent(activeWindow)
    if self.children[activeWindow] then
        self.children[activeWindow]:onEvent()
    end
end