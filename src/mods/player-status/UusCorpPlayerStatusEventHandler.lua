UusCorpPlayerStatusEventHandler = UusCorpEventHandler:new {
    name = "UusCorpPlayerStatusEventHandler",

    onInitialize = function ()
        UusCorpEventHandler.onInitialize(UusCorpPlayerStatusWindow)
    end,

    onShutdown = function ()
        UusCorpEventHandler.onShutdown(UusCorpPlayerStatusWindow)
    end,

    onUpdatePlayerStatus = function ()
        UusCorpEventHandler.onUpdatePlayerStatus(UusCorpPlayerStatusWindow)
    end,

    onUpdateMobileStatus = function ()
        UusCorpEventHandler.onUpdateMobileStatus(UusCorpPlayerStatusWindow)
    end,

    onUpdateHealthBarColor = function ()
        UusCorpEventHandler.onUpdateHealthBarColor(UusCorpPlayerStatusWindow)
    end,

    onRButtonDown = function (flags, x, y)
        UusCorpEventHandler.onRButtonDown(UusCorpPlayerStatusWindow, flags, x, y)
    end,

    onLButtonDblClk = function ()
        UusCorpEventHandler.onLButtonDblClk(UusCorpPlayerStatusWindow)
    end
}