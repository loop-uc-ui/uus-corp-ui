Interface = {}

function Interface.CreatePlayWindowSet()
    Paperdoll.useLegacy(true)
    RootWindow:create()

    --Destroy the default Debug Window
    --created by Interface Core
    WindowApi.destroyWindow("DebugWindow")
    WindowApi.createWindow(MainMenuWindow.Name, false)
    WindowApi.createWindow("ChatWindow", true)
    WindowApi.createWindow("UusCorpDebugWindow", true)
end

--Called by client's InterfaceCore script
function Interface.Shutdown()
    RootWindow.shutdown()
end