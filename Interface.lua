Interface = {}

function Interface.CreatePlayWindowSet()
    CreateWindow("ResizeWindow", true)
    MainMenuWindow:create(true)
    DestroyWindow("DebugWindow")
    CreateWindow("DebugWindow", true)
end

function Interface.debug()
    CreateWindow("DebugWindow", true)
end