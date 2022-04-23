Interface = {}

function Interface.CreatePlayWindowSet()
    CreateWindow("ResizeWindow", true)
    MainMenuWindow:create(true)
    DestroyWindow("DebugWindow")
    UusCorpDebugWindow:create(true)
end

function Interface.debug()
    CreateWindow("DebugWindow", true)
end