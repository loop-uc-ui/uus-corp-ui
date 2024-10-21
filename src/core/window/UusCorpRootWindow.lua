---@class UusCorpRootWindow:UusCorpWindow
UusCorpRootWindow = UusCorpView:new {
    name = "Root",
    eventHandler = "UusCorpRootEventHandler"
}

UusCorpRootEventHandler = UusCorpEventHandler:new {
    name = "UusCorpRootEventHandler",

    onUpdateCurrentTarget = function ()
        UusCorpEventHandler.onUpdateCurrentTarget(UusCorpRootWindow)
    end
}