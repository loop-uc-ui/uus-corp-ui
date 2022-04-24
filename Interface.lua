Interface = {}

function Interface.CreatePlayWindowSet()
    --Destroy the default Debug Window
    --created by Interface Core
    DestroyWindow("DebugWindow")

    CreateWindow("ResizeWindow", true)
    MainMenuWindow:create(false)
end
