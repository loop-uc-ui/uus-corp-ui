--Paperdolls are not created explicitly by the UI.
--They are created by the client whenever a mobile is double clicked.
PaperdollWindow = {}
PaperdollWindow.Name = "PaperdollWindow"
PaperdollWindow.NameLabel = "Name"
PaperdollWindow.SlotButton = "ItemSlotButton"
PaperdollWindow.WarButton = "WarButton"
PaperdollWindow.CharacterAbilities = "ToggleCharacterAbilities"
PaperdollWindow.Model = "ModelTexture"
PaperdollWindow.CharacterSheet = "ToggleCharacterSheet"
PaperdollWindow.ModelOffset = 1.75

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
        WindowApi.getScale(Active.window()) / PaperdollWindow.ModelOffset
    )

    return paperdollId, slotId
end

function PaperdollWindow.onInitialize()
    local pId = Paperdoll.id()
    local window = PaperdollWindow.Name .. pId

    WindowApi.setId(window, pId)
    WindowDataApi.registerData(Paperdoll.type(), pId)
    WindowDataApi.registerData(MobileData.nameType(), pId)
    WindowApi.registerEventHandler(window, MobileData.nameEvent(), "PaperdollWindow.updateName")
    WindowApi.registerEventHandler(window, Paperdoll.event(), "PaperdollWindow.update")
    WindowApi.registerEventHandler(window, ItemProperties.event(), "PaperdollWindow.update")

    WindowApi.setOffsetFromParent(
        window,
        MousePosition.x() - 50,
        MousePosition.y() - 100
    )

    local isPlayer = pId == PlayerStatus.id()

    if isPlayer then
        WindowDataApi.registerData(PlayerStatus.type(), 0)
        WindowApi.registerEventHandler(window, PlayerStatus.event(), "PaperdollWindow.onUpdateWarMode")
    end

    WindowApi.setShowing(window .. PaperdollWindow.Model, false)
    WindowApi.setShowing(window .. PaperdollWindow.WarButton, isPlayer)
    WindowApi.setShowing(window .. PaperdollWindow.CharacterSheet, isPlayer)
    WindowApi.setShowing(window .. PaperdollWindow.CharacterAbilities, isPlayer)
    ButtonApi.setChecked(
        window .. PaperdollWindow.WarButton,
        isPlayer and PlayerStatus.inWarMode()
    )
    PaperdollWindow.update()
end

function PaperdollWindow.onUpdateWarMode()
    ButtonApi.setChecked(
        Active.window() .. PaperdollWindow.WarButton, PlayerStatus.inWarMode()
    )
end

function PaperdollWindow.updateName()
    local id = WindowApi.getId(Active.window())
    local label = Active.window() .. PaperdollWindow.NameLabel
    LabelApi.setText(label, MobileData.name(id))
    local notoriety = MobileData.notoriety(id)
    LabelApi.setTextColor(label, Colors.Notoriety[notoriety])
    WindowApi.forceProcessAnchors(label)
end

function PaperdollWindow.update()
    local window = Active.window()
    local id = WindowApi.getId(window)

    PaperdollWindow.updateName()

    for i = 1, Paperdoll.numSlots(id) do
        local slot = window .. PaperdollWindow.SlotButton .. i
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
                WindowDataApi.registerData(ItemProperties.type(), data.slotId)

                local properties = ItemProperties.propertiesList(data.slotId)

                local color = {
                    r = 255,
                    g = 255,
                    b = 255
                }

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
        local backgroundWindow = window .. PaperdollWindow.Model
        DynamicImageApi.setTextureDimensions(backgroundWindow, texture.Width, texture.Height)
        DynamicImageApi.setTexture(backgroundWindow, textureName)
        WindowApi.setDimensions(
            backgroundWindow, texture.Width / PaperdollWindow.ModelOffset,
            texture.Height / PaperdollWindow.ModelOffset
        )
    else
        WindowApi.setShowing(window .. "ToggleView", false)
    end
end

function PaperdollWindow.ItemMouseOver()
end

function PaperdollWindow.onShutdown()
    TooltipWindow.destroy()

    local id = WindowApi.getId(Active.window())

    for i = 1, Paperdoll.numSlots(id) do
        local data = Paperdoll.slotData(id, i)
        if data ~= nil and data.slotId ~= nil then
            WindowDataApi.unregisterData(ItemProperties.type(), data.slotId)
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

function PaperdollWindow.onRightClick()
    WindowApi.destroyWindow(Active.window())
end

function PaperdollWindow.ToggleInventoryWindow()
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

function PaperdollWindow.ToggleView()
    local paperdoll = WindowApi.getParent(Active.window())
    local paperdollId = WindowApi.getId(paperdoll)

    for i = 1, Paperdoll.numSlots(paperdollId) do
        local slot = paperdoll .. "ItemSlotButton" .. tostring(i)
        WindowApi.setShowing(slot, not WindowApi.isShowing(slot))
    end

    local background = paperdoll .. PaperdollWindow.Model
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
        WindowDataApi.unregisterData(ItemProperties.type(), object.objectId)
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

function PaperdollWindow.onSlotMouseOver()
    local slot = activeSlot()

    if slot.objectId == nil then
        return
    end

    if ItemProperties.properties(slot.objectId) == nil then
        return
    end

    local data = {}
    local properties = ItemProperties.propertiesList(slot.objectId)

    if properties ~= nil then
        for i = 1, #properties do
            local text = tostring(properties[i])
            table.insert(data, text)
        end
        TooltipWindow.create(data)
    end
end

function PaperdollWindow.onSlotMouseOverEnd()
    TooltipWindow.destroy()
end

function PaperdollWindow.toggleWarMode()
    UserActionApi.toggleWarMode()
    ButtonApi.setChecked(Active.window(), not PlayerStatus.inWarMode())
end

function PaperdollWindow.ToggleCharacterAbilities()
    WindowApi.toggleWindow(CharacterAbilitiesWindow.Name)
end

function PaperdollWindow.onModelLeftClickDown()
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

function PaperdollWindow.onModelLeftClickUp()
    local paperdollId, slotId = activeModelTexture()

    if Drag.isItem() and slotId ~= 0 then
        DragApi.dropEquipmentOnPaperdoll(slotId)
    elseif Drag.isItem() then
        DragApi.dropObjectOnPaperdoll(paperdollId)
    end
end

function PaperdollWindow.onModelMouseOverEnd()
    WindowApi.unregisterCoreEventHandler(
        Active.window(),
        "OnUpdate"
    )
end

function PaperdollWindow.onModelMouseOver()
    WindowApi.registerCoreEventHandler(
        Active.window(),
        "OnUpdate",
        "PaperdollWindow.onModelUpdate"
    )
end

function PaperdollWindow.onModelUpdate()
    local _, slotId = activeModelTexture()

    if slotId == 0 or ItemProperties.properties(slotId) == nil then
        TooltipWindow.destroy()
        return
    end

    if WindowApi.doesExist(TooltipWindow.Name) and
        slotId == WindowApi.getId(TooltipWindow.Name) then
        return
    end

    TooltipWindow.destroy()

    local data = {}
    local properties = ItemProperties.propertiesList(slotId)

    if properties ~= nil then
        for i = 1, #properties do
            local text = tostring(properties[i])
            table.insert(data, text)
        end
        TooltipWindow.create(data)
        WindowApi.setId(TooltipWindow.Name, slotId)
    end
end

function PaperdollWindow.ToggleCharacterSheet()
    WindowApi.toggleWindow(CharacterSheetWindow.Name)
end