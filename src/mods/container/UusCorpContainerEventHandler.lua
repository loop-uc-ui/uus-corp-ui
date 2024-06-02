UusCorpContainerEventHandler = UusCorpEventHandler:new {
    name = "UusCorpContainerEventHandler",

    onInitialize = function ()
        UusCorpEventHandler.onInitialize(UusCorpContainerWindow:new())
    end,

    onUpdateContainer = function ()
        UusCorpEventHandler.onUpdateContainer(UusCorpContainerWindow:new())
    end,

    onShutdown = function ()
        UusCorpEventHandler.onShutdown(UusCorpContainerWindow:new())
    end,

    onRButtonDown = function (flags, x, y)
        UusCorpEventHandler.onRButtonDown(UusCorpContainerWindow:new(), flags, x, y)
    end
}