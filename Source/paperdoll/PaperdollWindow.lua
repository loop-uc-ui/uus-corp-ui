PaperdollWindow = {}
PaperdollWindow.Name = "PaperdollWindow"

function PaperdollWindow.onInitialize()
    local pId = Paperdoll.id()
    local window = PaperdollWindow.Name .. pId

    WindowApi.setId(window, pId)
    WindowDataApi.registerData(Paperdoll.type(), pId)
    WindowApi.registerEventHandler(window, Paperdoll.event(), "PaperdollWindow.update")

    WindowApi.setOffsetFromParent(
        window,
        MousePosition.x() - 50,
        MousePosition.y() - 100
    )
    PaperdollWindow.update()
end

function PaperdollWindow.update()
    local window = Active.window()
    local id = WindowApi.getId(window)

    LabelApi.setText(window .. "Name", Paperdoll.name())

    for i = 1, Paperdoll.numSlots(id) do
        local icon = window .. "ItemSlotButton" .. i .. "SquareIcon"
        local data = Paperdoll.slotData(id, i)

        if data ~= nil and data.newWidth ~= nil and data.newHeight ~= nil and data.iconName ~= nil then
            WindowApi.setDimensions(icon, data.newWidth, data.newHeight)
            DynamicImageApi.setTextureDimensions(icon, data.newWidth, data.newHeight)
            DynamicImageApi.setTexture(icon, data.iconName, 0, 0)
            DynamicImageApi.setCustomShader(icon, "UOSpriteUIShader", {
                data.hueId,
                data.objectType
            })
            DynamicImageApi.setTextureScale(icon, data.iconScale)
        end
    end
end

function PaperdollWindow.ItemMouseOver()
end

function PaperdollWindow.onShutdown()
    WindowDataApi.unregisterData(Paperdoll.type(), WindowApi.getId(Active.window()))
    WindowApi.unregisterEventHandler(Active.window(), Paperdoll.event())
end

function PaperdollWindow.onRightClick()
    WindowApi.destroyWindow(Active.window())
end

function PaperdollWindow.ToggleInventoryWindow()
    local id = WindowApi.getId(WindowApi.getParent(Active.window()))
    local backpack = Paperdoll.backpack(id)
    UserAction.useItem(backpack, false)
end