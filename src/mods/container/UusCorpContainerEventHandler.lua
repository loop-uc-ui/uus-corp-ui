UusCorpContainerEventHandler = UusCorpEventHandler:new {
    name = "UusCorpContainerEventHandler",

    onInitialize = function ()
        UusCorpEventHandler.onInitialize(UusCorpContainerWindow:new())
    end,

    onUpdateContainer = function ()
        UusCorpEventHandler.onUpdateContainer(UusCorpContainerWindow:new())
    end
}