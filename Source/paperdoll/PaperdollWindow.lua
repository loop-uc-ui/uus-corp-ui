PaperdollWindow = {}
PaperdollWindow.Name = "PaperdollWindow"

function PaperdollWindow.onInitialize()
    local pId = Paperdoll.id()
    local window = PaperdollWindow.Name .. pId

    WindowApi.setId(window, pId)
    WindowDataApi.registerData(Paperdoll.type(), pId)
    WindowApi.registerEventHandler(window, Paperdoll.event(), "PaperdollWindow.update")

    for i = 1, Paperdoll.numSlots(pId) do
        local slot = window .. "ItemSlotButton" .. i
        local texture = "Menu_Selection"
        ButtonApi.setTexture(slot, InterfaceCore.ButtonStates.STATE_NORMAL, texture, 50, 25)
        ButtonApi.setTexture(slot, InterfaceCore.ButtonStates.STATE_NORMAL_HIGHLITE, texture, 50, 25)
        ButtonApi.setTexture(slot, InterfaceCore.ButtonStates.STATE_PRESSED, texture, 50, 25)
        ButtonApi.setTexture(slot, InterfaceCore.ButtonStates.STATE_DISABLED, texture, 50, 25)
    end

    PaperdollWindow.update()
end

function PaperdollWindow.update()
    local window = Active.window()
    local id = WindowApi.getId(window)

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