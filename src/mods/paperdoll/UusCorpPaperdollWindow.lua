--Paperdolls are not created explicitly by the UI.
--They are created by the client whenever a mobile is double clicked.
UusCorpPaperdollWindow = {}
UusCorpPaperdollWindow.Name = "PaperdollWindow"
UusCorpPaperdollWindow.NameLabel = "Name"
UusCorpPaperdollWindow.SlotButton = "ItemSlotButton"
UusCorpPaperdollWindow.WarButton = "WarButton"
UusCorpPaperdollWindow.CharacterAbilities = "ToggleCharacterAbilities"
UusCorpPaperdollWindow.Model = "ModelTexture"
UusCorpPaperdollWindow.CharacterSheet = "ToggleCharacterSheet"
UusCorpPaperdollWindow.ModelOffset = 1.75

local function activeSlot()
    local id = WindowApi.getId(Active.window())
    local paperdollId = WindowApi.getId(WindowApi.getParent(Active.window()))
    local object = Paperdoll.slotData(paperdollId, id)

    local slotId

    if object ~= nil then
        slotId = object.slotId
    end

    return {
        objectId = slotId,
        paperdollId = paperdollId
    }
end

local function activeModelTexture()
    local paperdollId = WindowApi.getId(
        WindowApi.getParent(
            Active.window()
        )
    )

    local scale = WindowApi.getScale(Active.window())

    if not Paperdoll.isLegacyEnabled() then
        scale = scale / UusCorpPaperdollWindow.ModelOffset
    else
        scale = scale / 2
    end

    local slotId = ObjectApi.fromPaperdoll(
        paperdollId,
        scale
    )

    return paperdollId, slotId
end

function UusCorpPaperdollWindow.initialize()
    UusCorpCore.loadResources(
        "/src/mods/paperdoll",
        "UusCorpPaperdollWindow.xml"
    )

    local itemMouseOver = PaperdollWindow.ItemMouseOver

    UusCorpPaperdollWindow.onSlotMouseOver = function ()
        itemMouseOver()
    end

    UusCorpCore.overrideFunctions(PaperdollWindow)
    WindowApi.destroyWindow("PropertiesInfoWindow")
    WindowApi.setShowing("WarShield", false)
end

function UusCorpPaperdollWindow.onInitialize()
    local pId = Paperdoll.id()
    local window = UusCorpPaperdollWindow.Name .. pId

    WindowApi.setId(window, pId)
    WindowDataApi.registerData(Paperdoll.type(), pId)
    WindowDataApi.registerData(MobileStatus.type(), pId)
    WindowApi.registerEventHandler(window, MobileStatus.event(), "UusCorpPaperdollWindow.updateName")
    WindowApi.registerEventHandler(window, Paperdoll.event(), "UusCorpPaperdollWindow.update")
    WindowApi.registerEventHandler(window, ItemPropertiesData.event(), "UusCorpPaperdollWindow.update")

    WindowApi.setOffsetFromParent(
        window,
        MousePosition.x() - 50,
        MousePosition.y() - 100
    )

    local isPlayer = pId == PlayerStatus.id()

    if isPlayer then
        WindowDataApi.registerData(PlayerStatus.type(), 0)
        WindowApi.registerEventHandler(window, PlayerStatus.event(), "UusCorpPaperdollWindow.onUpdateWarMode")
    end

    WindowApi.setShowing(window .. UusCorpPaperdollWindow.Model, false)
    WindowApi.setShowing(window .. UusCorpPaperdollWindow.WarButton, isPlayer)
    WindowApi.setShowing(window .. UusCorpPaperdollWindow.CharacterSheet, isPlayer)
    WindowApi.setShowing(window .. UusCorpPaperdollWindow.CharacterAbilities, isPlayer)
    ButtonApi.setChecked(
        window .. UusCorpPaperdollWindow.WarButton,
        isPlayer and PlayerStatus.inWarMode()
    )
    UusCorpPaperdollWindow.update()
end

function UusCorpPaperdollWindow.onUpdateWarMode()
    ButtonApi.setChecked(
        Active.window() .. UusCorpPaperdollWindow.WarButton, PlayerStatus.inWarMode()
    )
end

function UusCorpPaperdollWindow.updateName()
    local id = WindowApi.getId(Active.window())
    local label = Active.window() .. UusCorpPaperdollWindow.NameLabel
    LabelApi.setText(label, MobileStatus.name(id))
    local notoriety = MobileStatus.notoriety(id)
    LabelApi.setTextColor(label, Colors.Notoriety[notoriety])
    WindowApi.forceProcessAnchors(label)
end

function UusCorpPaperdollWindow.update()
    local window = Active.window()
    local id = WindowApi.getId(window)

    UusCorpPaperdollWindow.updateName()

    for i = 1, Paperdoll.numSlots(id) do
        local slot = window .. UusCorpPaperdollWindow.SlotButton .. i
        local icon = slot .. "Icon"
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
            if data.slotId ~= nil and data.slotId ~= 0 then
                WindowDataApi.registerData(ItemPropertiesData.type(), data.slotId)

                local properties = ItemPropertiesData.propertiesList(data.slotId)

                local color = {
                    r = 255,
                    g = 255,
                    b = 255
                }

                if properties ~= nil then
                    for p = 1, #properties do
                        local property = StringFormatter.fromWString(properties[p])

                        if string.match(property, "Durability") then
                            local numbers = {}
                            for n in property:gmatch("%d+") do
                                table.insert(numbers, n)
                            end

                            if #numbers == 2 then
                                local percentage = numbers[1] / numbers[2]

                                if percentage <= 0.25 then
                                    color = Colors.Red
                                end
                            end
                        end
                    end
                end

                WindowApi.setColor(slot, color)
            end
        end
    end

    local texture = Paperdoll.textureData(id)

    local textureName = "paperdoll_texture" .. id
    local backgroundWindow = window .. UusCorpPaperdollWindow.Model

    DynamicImageApi.setTextureDimensions(backgroundWindow, texture.Width, texture.Height)
    DynamicImageApi.setTexture(backgroundWindow, textureName)

    local width = texture.Width
    local height = texture.Height

    if texture.IsLegacy == 0 then
        width = width / UusCorpPaperdollWindow.ModelOffset
        height = height / UusCorpPaperdollWindow.ModelOffset
    else
        WindowApi.setScale(backgroundWindow, InterfaceCore.scale * 1.35)
        WindowApi.clearAnchors(backgroundWindow)
    end

    WindowApi.setDimensions(
        backgroundWindow,
        width,
        height
    )
end

function UusCorpPaperdollWindow.onShutdown()
    UusCorpPaperdollWindow.onSlotMouseOverEnd()
    UusCorpPaperdollWindow.onModelMouseOverEnd()

    local id = WindowApi.getId(Active.window())

    if id == PlayerStatus.id() then
        WindowDataApi.unregisterData(PlayerStatus.type())
        WindowApi.unregisterEventHandler(Active.window(), PlayerStatus.event())
    end

    WindowDataApi.unregisterData(MobileStatus.type(), id)
    WindowDataApi.unregisterData(Paperdoll.type(), id)
    WindowApi.unregisterEventHandler(Active.window(), Paperdoll.event())
    WindowApi.unregisterEventHandler(Active.window(), MobileStatus.event())
    WindowApi.unregisterEventHandler(Active.window(), ItemPropertiesData.event())
end

function UusCorpPaperdollWindow.onRightClick()
    if WindowApi.getId(Active.window()) == PlayerStatus.id() then
        Interface.PaperdollOpen = false
        UserInterfaceVariables.SaveBoolean(
            "PaperdollOpen",
            Interface.PaperdollOpen
        )
    end
    if (id == WindowData.PlayerStatus.PlayerId) then
		Interface.PaperdollOpen = false
		Interface.SaveBoolean( "PaperdollOpen",Interface.PaperdollOpen )
	end
    WindowApi.destroyWindow(Active.window())
end

function UusCorpPaperdollWindow.ToggleInventoryWindow()
    local id = WindowApi.getId(WindowApi.getParent(Active.window()))
    if Drag.isItem() and id == PlayerStatus.id() then
        DragApi.dragToObject(PlayerStatus.id())
    else
        Actions.ToggleInventoryWindow()
    end
end

function UusCorpPaperdollWindow.ToggleView()
    local paperdoll = WindowApi.getParent(Active.window())
    local paperdollId = WindowApi.getId(paperdoll)

    for i = 1, Paperdoll.numSlots(paperdollId) do
        local slot = paperdoll .. "ItemSlotButton" .. tostring(i)
        WindowApi.setShowing(slot, not WindowApi.isShowing(slot))
    end

    local background = paperdoll .. UusCorpPaperdollWindow.Model
    WindowApi.setShowing(background, not WindowApi.isShowing(background))
end

function UusCorpPaperdollWindow.onSlotDoubleClick()
    UserAction.useItem(activeSlot().objectId, false)
end

function UusCorpPaperdollWindow.onSlotSingleClick()
    local object = activeSlot()

    if Cursor.hasTarget() and object.objectId ~= 0 then
        TargetApi.clickTarget(object.objectId)
    else
        WindowDataApi.unregisterData(ItemPropertiesData.type(), object.objectId)
        DragApi.setObjectMouseClickData(object.objectId, Drag.sourcePaperdoll())
    end
end

function UusCorpPaperdollWindow.onSlotSingleClickUp()
    local object = activeSlot()

    if Drag.isItem() and object.objectId ~= 0 then
        DragApi.dropEquipmentOnPaperdoll(object.objectId)
    elseif Drag.isItem() then
        DragApi.dropObjectOnPaperdoll(object.paperdollId)
    end
end

function UusCorpPaperdollWindow.onSlotMouseOverEnd()
    ItemPropertiesData.clearActiveItem()
end

function UusCorpPaperdollWindow.toggleWarMode()
    UserActionApi.toggleWarMode()
    ButtonApi.setChecked(Active.window(), not PlayerStatus.inWarMode())
end

function UusCorpPaperdollWindow.onSlotShutdown()
    WindowDataApi.unregisterData(ItemPropertiesData.type(), WindowApi.getId(Active.window()))
end

function UusCorpPaperdollWindow.ToggleCharacterAbilities()
    WindowApi.setShowing("CharacterAbilities", true)
end

function UusCorpPaperdollWindow.onModelLeftClickDown()
    local _, slotId = activeModelTexture()

    if Cursor ~= nil and Cursor.hasTarget() and slotId ~= 0 then
        WindowDataApi.registerData(
            ObjectInfo.type(),
            slotId
        )
        TargetApi.clickTarget(slotId)
        WindowDataApi.unregisterData(
            ObjectInfo.type(),
            slotId
        )
    elseif slotId ~= 0 then
        DragApi.setObjectMouseClickData(
            slotId,
            Drag.sourcePaperdoll()
        )
    end
end

function UusCorpPaperdollWindow.onModelLeftClickUp()
    local paperdollId, slotId = activeModelTexture()

    if Drag.isItem() and slotId ~= 0 then
        DragApi.dropEquipmentOnPaperdoll(slotId)
    elseif Drag.isItem() then
        DragApi.dropObjectOnPaperdoll(paperdollId)
    end
end

function UusCorpPaperdollWindow.onModelMouseOverEnd()
    WindowApi.unregisterCoreEventHandler(
        Active.window(),
        "OnUpdate"
    )
end

function UusCorpPaperdollWindow.onModelMouseOver()
    WindowApi.registerCoreEventHandler(
        Active.window(),
        "OnUpdate",
        "UusCorpPaperdollWindow.onModelUpdate"
    )
end

function UusCorpPaperdollWindow.onModelUpdate()
    local window = WindowApi.getParent(Active.window())
    local _, slotId = activeModelTexture()

    local itemData = {
        windowName = window,
        itemId = slotId,
        itemType = ItemPropertiesData.tyepItem(),
        detail = ItemPropertiesData.detailLong()
    }

    ItemPropertiesData.setActiveItem(itemData)
end

function UusCorpPaperdollWindow.ToggleCharacterSheet()
    WindowApi.toggleWindow("CharacterSheetWindow")
end

function UusCorpPaperdollWindow.onModelDoubleClick()
    local _, slotId = activeModelTexture()
    UserActionApi.useItem(slotId, false)
end