UusCorpResizeMod = UusCorp.Mod {
    Name = "UusCorpResize",

    Path = "/src/mods/resize",

    Files = {
        "UusCorpResizeWindow.xml"
    },

    OnInitialize = function (context)
        context.Api.Window.SetShowing("ResizeWindowFrame", false)
        context.Api.Window.CreateFromTemplate(
            "UusCorpResizeWindowFrame",
            "UusCorpResizeFrame",
            "Root",
            true
        )
        context.Api.Window.Destroy("ResizeWindowResizeButton")
        context.Api.Window.CreateFromTemplate(
            "ResizeWindowResizeButton",
            "UusCorpResizeButton",
            "Root",
            true
        )

        local lock = "ResizeWindowLock"
        context.Api.Window.SetParent(lock, "Root")
        context.Api.Window.ClearAnchors(lock)
        context.Api.Window.SetLayer(lock, context.Constants.WindowLayers.Default)
        context.Api.Window.AddAnchor(
            lock,
            "left",
            "ResizeWindowResizeButton",
            "right",
            -3,
            -3
        )
        context.Api.Window.UnregisterCoreEventHandler(lock, context.Constants.CoreEvents.OnMouseOver)
    end
}