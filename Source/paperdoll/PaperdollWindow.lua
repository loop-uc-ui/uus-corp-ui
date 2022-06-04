--Paperdolls are not created explicitly by the UI.
--They are created by the client whenever a mobile is double clicked.
PaperdollWindow = {}
PaperdollWindow.Name = "PaperdollWindow"

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
    WindowDataApi.registerData(MobileData.nameType(), pId)
    WindowApi.registerEventHandler(window, MobileData.nameEvent(), "PaperdollWindow.updateName")
    WindowApi.registerEventHandler(window, Paperdoll.event(), "PaperdollWindow.update")

    WindowApi.setOffsetFromParent(
        window,
        MousePosition.x() - 50,
        MousePosition.y() - 100
    )

    WindowApi.setShowing(window .. "LegacyTexture", false)
    PaperdollWindow.update()
end

function PaperdollWindow.updateName()
    local id = WindowApi.getId(Active.window())
    LabelApi.setText(Active.window() .. "Name", MobileData.name(id))
    local notoriety = MobileData.notoriety(id)
    LabelApi.setTextColor(Active.window() .. "Name", Colors.Notoriety[notoriety])
end

function PaperdollWindow.update()
    local window = Active.window()
    local id = WindowApi.getId(window)

    PaperdollWindow.updateName()

    for i = 1, Paperdoll.numSlots(id) do
        local icon = window .. "ItemSlotButton" .. i .. "Icon"
        local data = Paperdoll.slotData(id, i)

        if data ~= nil and data.newWidth ~= nil and data.newHeight ~= nil and data.iconName ~= nil then
            WindowApi.setDimensions(icon, data.newWidth, data.newHeight)
            DynamicImageApi.setTextureDimensions(icon, data.newWidth, data.newHeight)
            DynamicImageApi.setTexture(icon, data.iconName, 0, 0)
            DynamicImageApi.setCustomShader(icon, DynamicImageApi.Shaders.Sprite, {
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
    WindowDataApi.unregisterData(MobileData.nameType(), WindowApi.getId(Active.window()))
    WindowApi.unregisterEventHandler(Active.window(), Paperdoll.event())
    WindowApi.unregisterEventHandler(Active.window(), MobileData.nameEvent())
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
    local paperdoll = WindowApi.getParent(Active.window())
    local paperdollId = WindowApi.getId(paperdoll)

    for i = 1, Paperdoll.numSlots(paperdollId) do
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