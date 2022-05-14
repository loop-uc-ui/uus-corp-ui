Interface = {}

function Interface.CreatePlayWindowSet()
    RootWindow:create()

    --Destroy the default Debug Window
    --created by Interface Core
    WindowApi.destroyWindow("DebugWindow")

    MainMenuWindow:create(false)
end


function Interface.onShutdown()
    RootWindow.shutdown()
end