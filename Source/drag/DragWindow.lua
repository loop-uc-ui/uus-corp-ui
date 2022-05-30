--Drag windows are not created explicitly by the UI.
--They are created by the client whenever a drag function is invoked.
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

    local window = DragWindow.Name .. "Item"
    WindowApi.setDimensions(window, Drag.itemWidth(), Drag.itemHeight())
    DynamicImageApi.setTextureDimensions(window, Drag.itemWidth(), Drag.itemHeight())
    DynamicImageApi.setTexture(window, Drag.itemName())
    DynamicImageApi.setCustomShader(window, DynamicImageApi.Shaders.Sprite, {
        Drag.itemHue(),
        Drag.itemType()
    })
    DynamicImageApi.setTextureScale(window, Drag.itemScale())
    WindowApi.setColor(window, Drag.itemHue())
    WindowApi.setAlpha(window, Drag.itemHue().a / 255)
end
