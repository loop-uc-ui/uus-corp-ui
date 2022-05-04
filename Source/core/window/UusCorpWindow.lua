UusCorpWindow = UusCorpViewable.new("")
UusCorpWindow.__index = UusCorpWindow

function UusCorpWindow:doesExist()
    return WindowApi.doesExist(self.name)
end

function UusCorpWindow:create(doShow)
    if self:doesExist() then
        return
    end

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

    self:registerCoreEvents()
    self:registerEvents()

    for i = 1, #self.children do
        local child = self.children[i]

        if child.create then
            child:create()
        else
            child:registerCoreEvents()
            child:registerEvents()
        end
    end
end

function UusCorpWindow:onShutdown()
    if self.parent == "Root" then
        WindowUtils.SaveWindowPosition(self.name, true)
    end

    self:unregisterData()
    self:unregisterCoreEvents()
    self:unregisterEvents()

    for i = 1, #self.children do
        local child = self.children[i]

        if child.destroy then
            child:destroy()
        else
            child:unregisterCoreEvents()
            child:unregisterEvents()
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

function UusCorpWindow:datum(datum)
    self.data[datum.type] = datum.id
    return self
end

function UusCorpWindow:registerData()
    for k, v in pairs(self.data) do
        WindowDataApi.registerData(k, v)
    end
end

function UusCorpWindow:unregisterData()
    for k, v in pairs(self.data) do
        WindowDataApi.unregisterData(k, v)
        self.data[k] = nil
    end
end

function UusCorpWindow:child(child)
    table.insert(self.children, child)
    return self
end

function UusCorpWindow:coreEvent(event)
    UusCorpViewable.coreEvent(self, event)
    return self
end

function UusCorpWindow:event(event)
    UusCorpViewable.event(self, event)
    return self
end