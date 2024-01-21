UusCorpResizeMod = {}

function UusCorpResizeMod.onInitialize()
    UusCorpCore.loadResources(
        "/src/mods/resize",
        "UusCorpResizeWindow.xml"
    )

    WindowApi.setShowing("ResizeWindowFrame", false)

    WindowApi.createFromTemplate(
        "UusCorpResizeWindowFrame",
        "UusCorpResizeFrame",
        "Root"
    )

    WindowApi.destroyWindow("ResizeWindowResizeButton")

    WindowApi.createFromTemplate(
        "ResizeWindowResizeButton",
        "UusCorpResizeButton",
        "Root"
    )

    WindowApi.setParent("ResizeWindowLock", "Root")
    WindowApi.clearAnchors("ResizeWindowLock")
    WindowApi.setLayer("ResizeWindowLock", Window.Layers.DEFAULT)
    WindowApi.addAnchor("ResizeWindowLock", "left", "ResizeWindowResizeButton", "right", -3, -3)
    WindowApi.unregisterCoreEventHandler("ResizeWindowLock", "OnMouseOver")
end