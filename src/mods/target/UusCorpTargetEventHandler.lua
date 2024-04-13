UusCorpTargetEventHandler = UusCorpEventHandler:new {
    name = "UusCorpTargetEventHandler",

    onInitialize = function ()
        UusCorpEventHandler.onInitialize(UusCorpTargetWindow)
    end,

    onShutdown = function ()
        UusCorpEventHandler.onShutdown(UusCorpTargetWindow)
    end,

    onUpdateMobileStatus = function ()
        if UusCorpWindowData().CurrentTarget.isMobile() then
            UusCorpEventHandler.onUpdateMobileStatus(UusCorpTargetWindow)
        end
    end,

    onUpdateHealthBarColor = function ()
        UusCorpEventHandler.onUpdateHealthBarColor(UusCorpTargetWindow)
    end,

    onUpdateObjectInfo = function ()
        if UusCorpWindowData().CurrentTarget.isObject() then
            UusCorpEventHandler.onUpdateObjectInfo(UusCorpTargetWindow)
        end
    end,

    onRButtonDown = function (flags, x, y)
        UusCorpEventHandler.onRButtonDown(UusCorpTargetWindow, flags, x, y)
    end,

    onLButtonUp = function (flags, x, y)
        UusCorpEventHandler.onLButtonUp(UusCorpTargetWindow, flags, x, y)
    end
}