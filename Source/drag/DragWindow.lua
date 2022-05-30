DragWindow = {}
DragWindow.Name = "DragWindow"

function DragWindow.Initialize()
    if Drag.isItem() then
        WindowApi.setDimensions(DragWindow.Name, Drag.itemWidth(), Drag.itemHeight())
    end
    DragWindow.Update()
end

function DragWindow.Shutdown()
end

function DragWindow.Update()
    local posX = MousePosition.x() / InterfaceCore.scale
    local posY = MousePosition.y() /InterfaceCore.scale

    WindowApi.clearAnchors(DragWindow.Name)

    if Drag.isItem() then
        WindowApi.addAnchor(DragWindow.Name, "topleft", RootWindow.Name, "center", posX, posY)
    end
end
