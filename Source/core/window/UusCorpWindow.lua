UusCorpWindow = setmetatable({}, {__index = UusCorpView})
UusCorpWindow.__index = UusCorpWindow

function UusCorpWindow:init(name, template, parent)
    local this = setmetatable(UusCorpView.init(self, name), self)

    this.childAdapter = UusCorpChildAdapter:init()
    this.dataAdapter = UusCorpWindowDataAdapter:init()
    this.doDestroy = true
    this.parent = parent or UusCorpRoot.Name
    this.template = template or name

    this.eventAdapter:onShutdown(function ()
        if this.parent == UusCorpRoot.Name then
            WindowUtils.SaveWindowPosition(this.name, true)
        end
        this.childAdapter:unregister()
        this.dataAdapter:unregister()
        this.eventAdapter:unregister()
    end)

    this.eventAdapter:onRButtonUp(function ()
        if this.parent == UusCorpRoot.Name and this.doDestroy then
            this:destroy()
        elseif this.parent == UusCorpRoot.Name then
            this:setShowing(false)
        end
    end)

    this.eventAdapter:onInitialize(function ()
        if this.parent == UusCorpRoot.Name then
            WindowUtils.RestoreWindowPosition(this.name, true)
        end
        this.dataAdapter:register()
        this.eventAdapter:register()
        this.childAdapter:register()
    end)

    return this
end

function UusCorpWindow:create(doShow)
    if self:doesExist() then return end

    self.doDestroy = doShow == nil or doShow

    UusCorpRoot.Windows[self.name] = self
    WindowApi.createFromTemplate(self.name, self.template, self.parent)

    self:setShowing(doShow == nil or doShow)
    self.eventAdapter.initialize.windowCallback()
end 

function UusCorpWindow:destroy()
    if not self:doesExist() then
        return
    end

    WindowApi.destroyWindow(self.name)
end