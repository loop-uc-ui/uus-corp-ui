---@class UusCorpGenericWindow:UusCorpScrollWindow
UusCorpGenericWindow = UusCorpWindow:new {
    name = "UusCorpGenericWindow",
    template = "UusCorpGenericWindow",
    eventHandler = "UusCorpWindowLifeCycle"
}

---@param model UusCorpGenericWindow?
---@return UusCorpGenericWindow
function UusCorpGenericWindow:new(model)
    model = model or {}
    model.eventHandler = model.eventHandler
    model.template = model.template
    model.name = model.name or StringFormatter.randomString()
    return UusCorpWindow.new(self, model) --[[@as UusCorpGenericWindow]]
end

function UusCorpGenericWindow:create(doShow)
    UusCorpWindowLifeCycle.Windows[self.name] = self
    return UusCorpWindow.create(self, doShow)
end

function UusCorpGenericWindow:onShutdown()
    UusCorpWindow.onShutdown(self)
    UusCorpWindowLifeCycle.Windows[self.name] = nil
end