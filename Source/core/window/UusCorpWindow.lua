UusCorpWindow = setmetatable({}, { __index = UusCorpActionable})
UusCorpWindow.__index = UusCorpWindow

function UusCorpWindow:doesExist()
    return WindowApi.doesExist(self.name)
end

function UusCorpWindow:create(doShow)
    if self:doesExist() then
        return
    end

    UusCorpViewActionManager.Views[self.name] = self

    for key, value in pairs(self.data) do
        WindowDataApi.registerData(key, value)
    end

    self:registerData()
    WindowApi.createFromTemplate(self.name, self.template or self.name, self.parent)

    self:onInitialize()
    self:show(doShow == nil or doShow)
end

function UusCorpWindow:onInitialize()
    if self.parent == "Root" then
        WindowUtils.RestoreWindowPosition(self.name, true)
    end

    for _, value in pairs(self.actions) do
        WindowApi.registerCoreEventHandler(self.name, value.name, value.callback)
    end

    for i = 1, #self.children do
        local child = self.children[i]

        if child.create then
            child:create()
        elseif child.actions then
            for _, value in pairs(child.actions) do
                WindowApi.registerCoreEventHandler(
                    child.name,
                    value.name,
                    value.callback
                )
            end
        end
    end
end

function UusCorpWindow:onShutdown()
    if self.parent == "Root" then
        WindowUtils.SaveWindowPosition(self.name, true)
    end

    for key, value in pairs(self.data) do
        WindowDataApi.unregisterData(key, value)
    end

    for _, value in pairs(self.actions) do
        WindowApi.unregisterCoreEventHandler(self.name, value.name)
    end

    for i = 1, #self.children do
        local child = self.children[i]

        if child.destroy then
            child:destroy()
        elseif child.actions then
            for _, value in pairs(child.actions) do
                WindowApi.unregisterCoreEventHandler(
                    child.name,
                    value.name
                )
            end
            UusCorpViewActionManager.Views[child.name] = nil
        end
    end
end

function UusCorpWindow:onShown()
    return self
end

function UusCorpWindow:onHidden()
    return self
end

function UusCorpWindow:destroy()
    if not self:doesExist() then
        return
    end

    self:onShutdown()
    WindowApi.destroyWindow(self.name)
    UusCorpViewActionManager.Views[self.name] = nil
    self = nil
    return self
end

function UusCorpWindow:show(doShow)
    doShow = doShow == nil or doShow

    if doShow == WindowApi.isShowing(self.name) then
        return
    end

    WindowApi.setShowing(self.name, doShow == nil or doShow)

    if doShow then
        self:onShown()
    else
        self:onHidden()
    end

    return self
end

function UusCorpWindow:addChild(view)
    table.insert(self.children, view)
    UusCorpViewActionManager.Views[view.name] = view
    return self
end

function UusCorpWindow:addAction(action)
    UusCorpActionable.addAction(self, action)
    return self
end

function UusCorpWindow:registerData()
    return self
end

function UusCorpWindow:unregisterData()
    return self
end

function UusCorpWindow:addData(type, id)
    if not self.data then
        self.data = {}
    end

    self.data[type] = id
    return self
end