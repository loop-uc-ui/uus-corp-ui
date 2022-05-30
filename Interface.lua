Interface = {}

function Interface.CreatePlayWindowSet()
    Paperdoll.useLegacy(true)
    RootWindow:create()

    --Destroy the default Debug Window
    --created by Interface Core
    WindowApi.destroyWindow("DebugWindow")
    WindowApi.createWindow(MainMenuWindow.Name, false)
end

function Interface.OnShutdown()
    RootWindow.shutdown()
end