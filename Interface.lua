Interface = {}

function Interface.CreatePlayWindowSet()
    Viewport.create()

    --Destroy the default Debug Window
    --created by Interface Core
    WindowApi.destroyWindow("DebugWindow")

    MainMenuWindow:create(false)
end
