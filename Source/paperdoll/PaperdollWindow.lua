PaperdollWindow = {}
PaperdollWindow.Name = "PaperdollWindow"
PaperdollWindow.NumSlots = 19

local function activeSlot()
    local id = WindowApi.getId(Active.window())
    local paperdollId = WindowApi.getId(WindowApi.getParent(Active.window()))
    local object = Paperdoll.slotData(paperdollId, id)
    return {
        objectId = object.slotId,
        paperdollId = paperdollId
    }
end

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

    WindowApi.setShowing(window .. "LegacyTexture", false)
    PaperdollWindow.update()
end

function PaperdollWindow.update()
    local window = Active.window()
    local id = WindowApi.getId(window)

    LabelApi.setText(window .. "Name", Paperdoll.name())

    for i = 1, Paperdoll.numSlots(id) do
        local icon = window .. "ItemSlotButton" .. i .. "Icon"
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

    local texture = Paperdoll.textureData(id)

    --We don't support non-legacy textures.
    --Users on first launch may have non-legacy textures set
    --since it requires a restart to take effect.
    if texture.IsLegacy == 1 then
        WindowApi.setShowing(window .. "ToggleView", true)
        local textureName = "paperdoll_texture" .. id
        local backgroundWindow = window .. "LegacyTexture"
        DynamicImageApi.setTextureDimensions(backgroundWindow, texture.Width, texture.Height)
        DynamicImageApi.setTexture(backgroundWindow, textureName)
        WindowApi.setDimensions(backgroundWindow, texture.Width, texture.Height)
        WindowApi.setScale(backgroundWindow, 1.25)
    else
        WindowApi.setShowing(window .. "ToggleView", false)
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

function PaperdollWindow.ToggleView()
    local paperdoll = string.gsub(Active.window(), "ToggleView", "")
    for i = 1, PaperdollWindow.NumSlots do
        local slot = paperdoll .. "ItemSlotButton" .. tostring(i)
        WindowApi.setShowing(slot, not WindowApi.isShowing(slot))
    end

    local background = paperdoll .. "LegacyTexture"
    WindowApi.setShowing(background, not WindowApi.isShowing(background))
end

function PaperdollWindow.onSlotDoubleClick()
    UserAction.useItem(activeSlot().objectId, false)
end

function PaperdollWindow.onSlotSingleClick()
    local object = activeSlot()

    if Cursor.hasTarget() and object.objectId ~= 0 then
        TargetApi.clickTarget(object.objectId)
    else
        DragApi.setObjectMouseClickData(object.objectId, Drag.sourcePaperdoll())
    end
end

function PaperdollWindow.onSlotSingleClickUp()
    local object = activeSlot()

    if Drag.isItem() and object.objectId ~= 0 then
        DragApi.dropEquipmentOnPaperdoll(object.objectId)
    elseif Drag.isItem() then
        DragApi.dropObjectOnPaperdoll(object.paperdollId)
    end
end