UusCorpResizeMod = UusCorp.Mod {
    Name = "UusCorpResize",

    Path = "/src/mods/resize",

    OnInitialize = function (self)
        self.LoadResource("UusCorpResizeWindow.xml")
        UusCorp.Api.Window.SetShowing("ResizeWindowFrame", false)
        UusCorp.Api.Window.CreateFromTemplate(
            "UusCorpResizeWindowFrame",
            "UusCorpResizeFrame",
            "Root",
            true
        )
        UusCorp.Api.Window.Destroy("ResizeWindowResizeButton")
        UusCorp.Api.Window.CreateFromTemplate(
            "ResizeWindowResizeButton",
            "UusCorpResizeButton",
            "Root",
            true
        )

        local lock = "ResizeWindowLock"
        UusCorp.Api.Window.SetParent(lock, "Root")
        UusCorp.Api.Window.ClearAnchors(lock)
        UusCorp.Api.Window.SetLayer(lock, UusCorp.Constants.WindowLayers.Default)
        UusCorp.Api.Window.AddAnchor(
            lock,
            "left",
            "ResizeWindowResizeButton",
            "right",
            -3,
            -3
        )
        UusCorp.Api.Window.UnregisterCoreEventHandler(lock, UusCorp.Constants.CoreEvents.OnMouseOver)
    end
}