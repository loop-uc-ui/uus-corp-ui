RootWindow = {}

RootWindow.NAME = "Root"

function RootWindow.initalize()
    ViewportApi.update(
        ScreenResolution.x(),
        ScreenResolution.y(),
        ScreenResolution.x(),
        ScreenResolution.y()
    )

    -- RootHealthBarManager:initialize()
end

function RootWindow.shutdown()
    RootHealthBarManager:shutdown()
end