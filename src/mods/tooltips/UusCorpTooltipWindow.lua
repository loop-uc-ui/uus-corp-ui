UusCorpTooltipWindow = {}

function UusCorpTooltipWindow.initialize()
    WindowApi.destroyWindow("ItemProperties")
    UusCorpCore.loadResources(
        "/src/mods/tooltips",
        "UusCorpTooltipWindow.xml"
    )
    WindowApi.createWindow("ItemProperties", false)
end

function UusCorpTooltipWindow.onShown()
    WindowApi.registerCoreEventHandler(
        Active.window(),
        "OnUpdate",
        "UusCorpTooltipWindow.onUpdate"
    )
end

function UusCorpTooltipWindow.onHidden()
    WindowApi.unregisterCoreEventHandler(
        Active.window(),
        "OnUpdate"
    )
end

function UusCorpTooltipWindow.onUpdate()
    local scale = 1 / InterfaceCore.scale

    local xPos = scale * MousePosition.x()
    local yPos = scale * (MousePosition.y() - 24)

    WindowApi.clearAnchors(Active.window())

    WindowApi.addAnchor(
        Active.window(),
        "topleft",
        "Root",
        "bottomleft",
        xPos,
        yPos
    )
end