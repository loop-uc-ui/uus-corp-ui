Viewport = {}

function Viewport.create()
    ViewportApi.update(
        ScreenResolution.x(),
        ScreenResolution.y(),
        ScreenResolution.x(),
        ScreenResolution.y()
    )
end