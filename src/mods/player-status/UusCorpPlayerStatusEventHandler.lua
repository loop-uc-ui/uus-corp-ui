UusCorpPlayerStatusEventHandler = UusCorpEventHandler:new {
    name = "UusCorpPlayerStatusEventHandler",

    onInitialize = function ()
        UusCorpEventHandler.onInitialize(UusCorpPlayerStatusWindow)
    end,

    onShutdown = function ()
        UusCorpEventHandler.onShutdown()
    end
}