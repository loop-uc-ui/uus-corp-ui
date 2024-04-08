UusCorpDistanceCounterEventHandler = UusCorpEventHandler:new {
    name = "UusCorpDistanceCounterEventHandler",

    mod = function ()
        UusCorpCore.loadResources(
            "/src/mods/distance-counter",
            "UusCorpDistanceCounterWindow.xml"
        )

        UusCorpDistanceCounterWindow:create()
    end,

    onInitialize = function ()
        UusCorpEventHandler.onInitialize(UusCorpDistanceCounterWindow)
    end,

    onShutdown = function ()
        UusCorpEventHandler.onShutdown(UusCorpDistanceCounterWindow)
    end,

    onUpdate = function ()
        UusCorpEventHandler.onUpdate(0, UusCorpDistanceCounterWindow)
    end
}