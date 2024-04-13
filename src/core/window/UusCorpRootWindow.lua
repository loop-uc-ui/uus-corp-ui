---@class UusCorpRootWindow:UusCorpWindow
UusCorpRootWindow = UusCorpWindow:new {
    name = "Root",
    eventHandler = "UusCorpRootEventHandler"
}

UusCorpRootEventHandler = UusCorpEventHandler:new {
    name = "UusCorpRootEventHandler",

    onUpdateCurrentTarget = function ()
        UusCorpEventHandler.onUpdateCurrentTarget(UusCorpRootWindow)
    end
}