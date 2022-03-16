UusCorpWindow = setmetatable({}, {__index = UusCorpView})
UusCorpWindow.__index = UusCorpWindow

local ROOT_WINDOW = "Root"

function UusCorpWindow.new(name)
    local self = UusCorpView.new(name)
    self.children = {}
    self.registeredData = {}
    self.root = ROOT_WINDOW
    return setmetatable(self, UusCorpWindow)
end

function UusCorpWindow:create(doShow)
    if self:doesExist() then
        return
    end

    UusCorpView.create(self, doShow)
    
    WindowApi.createWindow(
        self.name,
        doShow == nil or doShow
    )

    for _, value in pairs(self.children) do
        if value.template == nil then
            value:create()
        end
    end
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

function UusCorpWindow:registerEventHanlder(event, callback)
    WindowApi.registerEventHandler(self.name, event, callback)
end

function UusCorpWindow:onInitialize()
    if self.root == ROOT_WINDOW then
        WindowUtils.RestoreWindowPosition(self.name, true)
    end
end

function UusCorpWindow:onShutdown()
    if self.root == ROOT_WINDOW then
        WindowUtils.SaveWindowPosition(self.id)
    end

    for key, value in pairs(self.registeredData) do
        self:unregisterData(key, value)
    end

    for key, _ in pairs(UusCorpViewLifeCycle.Views) do
        if string.find(key, self.name) then
            UusCorpViewLifeCycle.Views[key] = nil
        end
    end
end