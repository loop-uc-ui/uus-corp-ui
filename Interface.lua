Interface = {}

function Interface.CreatePlayWindowSet()
    Paperdoll.useLegacy(false)
    WindowApi.unregisterEventHandler(
        "ResizingWindowFrame",
        Events.onLButtonUp()
    )

    RootWindow:create()

    --Destroy the default Debug Window
    --created by Interface Core
    WindowApi.createWindow(MainMenuWindow.Name, false)
    WindowApi.createWindow("ChatWindow", true)
    WindowApi.setShowing("DebugWindow", true)
end

--Called by client's InterfaceCore script
function Interface.Shutdown()
    RootWindow.shutdown()
end