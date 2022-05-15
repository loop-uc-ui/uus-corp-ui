UusCorpWindow = setmetatable({}, {__index = UusCorpView})

UusCorpWindow.__index = UusCorpWindow

function UusCorpWindow.new(name, parent, template)
    local this = setmetatable(
        UusCorpView.new(name),
        UusCorpWindow
    )

    this._data = {}
    this._children = {}
    this.parent = parent or "Root"
    this.template = template

    this:coreEvent(
        UusCorpViewEvent.onRButtonUp(
            function ()
                this:destroy()
            end
        )
    )

    return this
end

function UusCorpWindow:doesExist()
    return WindowApi.doesExist(self.name)
end

function UusCorpWindow:create(doShow)
    if self:doesExist() then
        return
    end

    self:registerData()

    WindowApi.createFromTemplate(self.name, self.template or self.name, self.parent)

    self:onInitialize()
    self:show(doShow == nil or doShow)
    WindowApi.clearAnchors(self.name)
    return self
end

function UusCorpWindow:loadPosition()
    if self.parent == "Root" then
        WindowUtils.RestoreWindowPosition(self.name, true)
    end
end

function UusCorpWindow:onInitialize()
    self:loadPosition()
    self:registerCoreEvents()
    self:registerEvents()

    for i = 1, #self._children do
        local child = self._children[i]

        if child.create then
            child:create()
        else
            child:registerCoreEvents()
            child:registerEvents()
        end
        child:update()
    end
end

function UusCorpWindow:onShutdown()
    if self.parent == "Root" then
        WindowUtils.SaveWindowPosition(self.name, true)
    end

    self:unregisterData()
    self:unregisterCoreEvents()
    self:unregisterEvents()

    for i = 1, #self._children do
        local child = self._children[i]

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

function UusCorpWindow:data(type, id)
    self._data[type] = id or 0
    return self
end

function UusCorpWindow:child(child)
    table.insert(self._children, child)
    return self
end

function UusCorpWindow:coreEvent(event)
    UusCorpView.coreEvent(self, event)
    return self
end

function UusCorpWindow:event(event)
    UusCorpView.event(self, event)
    return self
end

function UusCorpWindow:registerData()
    for k, v in pairs(self._data) do
        WindowDataApi.registerData(k, v)
    end
end

function UusCorpWindow:unregisterData()
    for k, v in pairs(self._data) do
        WindowDataApi.unregisterData(k, v)
        self._data[k] = nil
    end
end

function UusCorpWindow:update()
    UusCorpView.update(self)
    for i = 1, #self._children do
        self._children[i]:update()
    end
end

function UusCorpWindow:setOffsetFromParent(x, y)
    WindowApi.setOffsetFromParent(self.name, x, y)
    return self
end

function UusCorpWindow:setMoving(isMoving)
    WindowApi.setMoving(self.name, isMoving == nil or isMoving)
end