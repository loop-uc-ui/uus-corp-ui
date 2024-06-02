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
        local target = UusCorpWindowData().CurrentTarget
        if target.isObject() or target.isCorpse() then
            UusCorpEventHandler.onUpdateObjectInfo(UusCorpTargetWindow)
        end
    end,

    onRButtonDown = function (flags, x, y)
        UusCorpEventHandler.onRButtonDown(UusCorpTargetWindow, flags, x, y)
    end,

    onLButtonUp = function (flags, x, y)
        UusCorpEventHandler.onLButtonUp(UusCorpTargetWindow, flags, x, y)
    end,

    onUpdate = function ()
        if not UusCorpWindowData().CurrentTarget.HasTarget then
            UusCorpTargetWindow:destroy()
        else
            UusCorpEventHandler.onUpdate(0, UusCorpTargetWindow)
        end
    end,

    onLButtonDblClk = function ()
        UusCorpEventHandler.onLButtonDblClk(UusCorpTargetWindow)
    end
}