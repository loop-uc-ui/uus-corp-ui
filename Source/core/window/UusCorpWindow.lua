UusCorpWindow = setmetatable({}, UusCorpActionable)
UusCorpWindow.__index = UusCorpWindow

function UusCorpWindow:doesExist()
    return WindowApi.doesExist(self.name)
end

function UusCorpWindow:create(doShow)
    if self:doesExist() then
        return
    end

    self.doDestroy = doShow
    UusCorpViewActionManager.Views[self.name] = self
    WindowApi.createFromTemplate(self.name, self.template, self.parent)
    self:onInitialize()
    self:show(self.doDestroy)
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
            child = nil
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

function UusCorpWindow:onRButtonUp(flag, x, y)
    if self.doDestroy then
        self:destroy()
    else
        self:show(false)
    end
    return self, flag, x, y
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