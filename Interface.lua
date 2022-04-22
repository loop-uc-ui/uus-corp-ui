Interface = {}

function Interface.CreatePlayWindowSet()
    CreateWindow("ResizeWindow", true)
    MainMenuWindow:create(true)
    WindowSetShowing("DebugWindow", true)
end

function Interface.debug()
    CreateWindow("DebugWindow", true)
end