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

    local slotId = ObjectApi.fromPaperdoll(
        paperdollId,
        WindowApi.getScale(Active.window()) / UusCorpPaperdollWindow.ModelOffset
    )

    return paperdollId, slotId
end

function UusCorpPaperdollWindow.initialize()
    UusCorpCore.loadResources(
        "/mods/paperdoll",
        "UusCorpPaperdollWindow.xml"
    )

    UusCorpCore.overrideFunctions(PaperdollWindow)

    WindowApi.setShowing("WarShield", false)
end

function UusCorpPaperdollWindow.onInitialize()
    local pId = Paperdoll.id()
    local window = UusCorpPaperdollWindow.Name .. pId

    WindowApi.setId(window, pId)
    WindowDataApi.registerData(Paperdoll.type(), pId)
    WindowDataApi.registerData(MobileData.nameType(), pId)
    WindowApi.registerEventHandler(window, MobileData.nameEvent(), "UusCorpPaperdollWindow.updateName")
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
    LabelApi.setText(label, MobileData.name(id))
    local notoriety = MobileData.notoriety(id)
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

    --Unfortunately, we can't support legacy textures
    --because they're horrendously buggy. We ONLY support
    --enhanced textures. If the user had legacy textures enabled
    --in the default UI, they will be required to restart.
    if texture.IsLegacy == 0 then
        WindowApi.setShowing(window .. "ToggleView", true) --TODO disable and add a tooltip
        local textureName = "paperdoll_texture" .. id
        local backgroundWindow = window .. UusCorpPaperdollWindow.Model
        DynamicImageApi.setTextureDimensions(backgroundWindow, texture.Width, texture.Height)
        DynamicImageApi.setTexture(backgroundWindow, textureName)
        WindowApi.setDimensions(
            backgroundWindow, texture.Width / UusCorpPaperdollWindow.ModelOffset,
            texture.Height / UusCorpPaperdollWindow.ModelOffset
        )
    else
        WindowApi.setShowing(window .. "ToggleView", false)
    end
end

function UusCorpPaperdollWindow.ItemMouseOver()
end

function UusCorpPaperdollWindow.onShutdown()
   -- TooltipWindow.destroy()

    local id = WindowApi.getId(Active.window())

    for i = 1, Paperdoll.numSlots(id) do
        local data = Paperdoll.slotData(id, i)
        if data ~= nil and data.slotId ~= nil then
            WindowDataApi.unregisterData(ItemPropertiesData.type(), data.slotId)
        end
    end

    if id == PlayerStatus.id() then
        WindowDataApi.unregisterData(PlayerStatus.type())
        WindowApi.unregisterEventHandler(Active.window(), PlayerStatus.event())
    end

    WindowDataApi.unregisterData(MobileData.nameType(), id)
    WindowDataApi.unregisterData(Paperdoll.type(), id)
    WindowApi.unregisterEventHandler(Active.window(), Paperdoll.event())
    WindowApi.unregisterEventHandler(Active.window(), MobileData.nameEvent())
    WindowApi.unregisterCoreEventHandler(
        Active.window(),
        "OnUpdate"
    )
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
    local backpack = Paperdoll.backpack(id)

    if Drag.isNone() and not WindowApi.doesExist(ContainerWindow.Name .. backpack) then
        UserAction.useItem(backpack, false)
    elseif Drag.isNone() then
        WindowApi.destroyWindow(ContainerWindow.Name .. backpack)
    elseif Drag.isItem() and id == PlayerStatus.id() then
        DragApi.dragObjectToContainer(backpack, 0)
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

function UusCorpPaperdollWindow.onSlotMouseOver()
    local slot = activeSlot()

    if slot.objectId == nil or slot.objectId == 0 then
        return
    end

    if ItemPropertiesData.properties(slot.objectId) == nil then
        return
    end

    local data = {}
    local properties = ItemPropertiesData.propertiesList(slot.objectId)

    if properties ~= nil then
        for i = 1, #properties do
            local text = tostring(properties[i])
            table.insert(data, text)
        end
        TooltipWindow.create(data)
    end
end

function UusCorpPaperdollWindow.onSlotMouseOverEnd()
    TooltipWindow.destroy()
end

function UusCorpPaperdollWindow.toggleWarMode()
    UserActionApi.toggleWarMode()
    ButtonApi.setChecked(Active.window(), not PlayerStatus.inWarMode())
end

function UusCorpPaperdollWindow.ToggleCharacterAbilities()
    WindowApi.toggleWindow(UusCorpCharacterAbilitiesWindow.Name)
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
    local _, slotId = activeModelTexture()

    if slotId == nil or slotId == 0 or ItemPropertiesData.properties(slotId) == nil then
        TooltipWindow.destroy()
        return
    end

    if WindowApi.doesExist(TooltipWindow.Name) and
        slotId == WindowApi.getId(TooltipWindow.Name) then
        return
    end

    TooltipWindow.destroy()

    local data = {}
    local properties = ItemPropertiesData.propertiesList(slotId)

    if properties ~= nil then
        for i = 1, #properties do
            local text = tostring(properties[i])
            table.insert(data, text)
        end
        TooltipWindow.create(data)
        WindowApi.setId(TooltipWindow.Name, slotId)
    end
end

function UusCorpPaperdollWindow.ToggleCharacterSheet()
    WindowApi.toggleWindow("CharacterSheetWindow")
end