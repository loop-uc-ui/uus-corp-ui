UusCorpPlayerStatusEventHandler = UusCorpEventHandler:new {
    name = "UusCorpPlayerStatusEventHandler",

    onInitialize = function ()
        UusCorpEventHandler.onInitialize(UusCorpPlayerStatusWindow)
        UusCorpPlayerStatusMod.isPlayerStatusOpen = true
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
        UusCorpPlayerStatusMod.isPlayerStatusOpen = false
    end,

    onLButtonDblClk = function ()
        UusCorpEventHandler.onLButtonDblClk(UusCorpPlayerStatusWindow)
    end,

    onLButtonDown = function (flags, x, y)
        UusCorpEventHandler.onLButtonDown(UusCorpPlayerStatusWindow, flags, x, y)
    end,

    onLButtonUp = function (flags, x, y)
        UusCorpEventHandler.onLButtonUp(UusCorpPlayerStatusWindow, flags, x, y)
    end,

    onShown = function ()
        UusCorpEventHandler.onShown(UusCorpPlayerStatusWindow)
    end
}