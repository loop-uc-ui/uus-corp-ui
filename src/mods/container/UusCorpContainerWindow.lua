--Container windows are not create explicitly by the UI.
--They are create by client when containers are clicked.
UusCorpContainerWindow = {}
UusCorpContainerWindow.Template = "ContainerWindow"
UusCorpContainerWindow.Name = UusCorpContainerWindow.Template .. "_"
UusCorpContainerWindow.MaxSlots = 125

UusCorpContainerWindow.Views = {
    Grid = "GridView",
    Freeform = "FreeformView"
}

UusCorpContainerWindow.Gumps = {
    Backpack = 60,
    Corpse = 9
}

local function activeSlot()
    local slotNum = WindowApi.getId(Active.window())

    local container = WindowApi.getId(
        WindowApi.getParent(
            WindowApi.getParent(
                WindowApi.getParent(
                    Active.window()
                )
            )
        )
    )

    local item = nil

    for i = 1, Container.itemCount(container) do
        local thisItem = Container.items(container)[i]
        if thisItem.gridIndex == slotNum then
            item = thisItem
            break
        end
    end

    local objectId = nil

    if item ~= nil then
        objectId = item.objectId
    end

    local gridIndex = nil

    if item ~= nil then
        gridIndex = item.gridIndex
    end

    return {
        containerId = container,
        objectId = objectId,
        gridIndex = gridIndex,
        slotNum = slotNum
    }
end

local function toggleLegacy(id, isLegacy)
    local window = UusCorpContainerWindow.Name .. id

    WindowApi.setShowing(
        window .. UusCorpContainerWindow.Views.Grid,
        not isLegacy
    )

    WindowApi.setShowing(
        window .. UusCorpContainerWindow.Views.Freeform,
        isLegacy
    )

    WindowApi.setShowing(
        window .. "FreeformBackground",
        isLegacy
    )

    WindowApi.setShowing(
        window .. "Title",
        not isLegacy
    )

    WindowApi.setShowing(
        window .. "Background",
        not isLegacy
    )

    WindowApi.setShowing(
        window .. "Frame",
        not isLegacy
    )

    WindowApi.setShowing(
        window .. "ResizeButton",
        not isLegacy
    )

    WindowApi.setShowing(
        window .. "LootAll",
        id ~= Paperdoll.backpack(PlayerStatus.id()) and not isLegacy
    )
end

function UusCorpContainerWindow.Initialize()
    local id = tonumber(string.gsub(Active.window(), UusCorpContainerWindow.Name, ""), 10)
    WindowApi.setId(Active.window(), id)
    WindowApi.registerEventHandler(Active.window(), Container.event(), "UusCorpContainerWindow.updateContainer")
    WindowApi.registerEventHandler(Active.window(), Events.userSettingsUpdated(), "UusCorpContainerWindow.reopenContainer")
    WindowApi.registerEventHandler(Active.window(), ObjectInfo.event(), "UusCorpContainerWindow.updateObject")
    WindowApi.registerEventHandler(Active.window(), ItemPropertiesData.event(), "UusCorpContainerWindow.updateObject")

    WindowDataApi.registerData(Container.type(), id)

    WindowApi.setUpdateFrequency(Active.window(), 1)

    toggleLegacy(id, UserContainerSettings.legacyContainers())

    -- There appears to be a bug with empty containers
    -- where updateContainer is not fired automatically
    if Container.itemCount(id) <= 0 then
        UusCorpContainerWindow.updateContainer()
    end
end

function UusCorpContainerWindow.onUpdate()
    local id = WindowApi.getId(Active.window())
    if Container.itemCount(id) > 0 then
        DragApi.autoPickUpObject(Container.items(id)[1].objectId)
    else
        WindowApi.unregisterCoreEventHandler(Active.window(), "OnUpdate")
    end
end

function UusCorpContainerWindow.updateContainer()
    local this = Active.window()
    local id = WindowApi.getId(this)
    local isGrid = not WindowApi.isShowing(this .. UusCorpContainerWindow.Views.Freeform)
    local name = StringFormatter.fromWString(Container.name(id))

    if #name > 12 then
        name = string.sub(name, 1, 13) .. "..."
    end

    LabelApi.setText(this .. "Title", name)

    if not isGrid then
        local gump = Container.gumpNum(id)

        local scale = Container.freeFormScale()
        local texture, xSize, ySize, _ = RequestGumpArt(gump)
        local tScale = 1.5

        DynamicImageApi.setTextureDimensions(
            this .. UusCorpContainerWindow.Views.Freeform,
            xSize * scale,
            ySize * scale
        )

        WindowApi.setDimensions(
            this .. UusCorpContainerWindow.Views.Freeform,
            xSize * scale,
            ySize * scale
        )

        DynamicImageApi.setTexture(
            this .. UusCorpContainerWindow.Views.Freeform,
            "freeformcontainer_texture" .. id,
            0,
            0
        )

        DynamicImageApi.setTextureScale(
            this .. UusCorpContainerWindow.Views.Freeform,
            InterfaceCore.scale * scale
        )

        DynamicImageApi.setTextureDimensions(
            this .. "FreeformBackground",
            xSize * tScale,
            ySize * tScale
        )

        WindowApi.setDimensions(
            this .. "FreeformBackground",
            xSize * tScale,
            ySize * tScale
        )

        DynamicImageApi.setTexture(
            this .. "FreeformBackground",
            texture,
            0,
            0
        )

        DynamicImageApi.setTextureScale(
            this .. "FreeformBackground",
            tScale
        )

        WindowApi.setDimensions(
            this,
            xSize * scale,
            ySize * scale
        )
    else
        local slots = UusCorpContainerWindow.MaxSlots
        local window = UusCorpContainerWindow.Name .. id .. "GridViewScrollChild"
        local x, _ = WindowApi.getDimensions(window)

        --Public corpses may have more than the max count
        if Container.itemCount(id) > slots then
            slots = Container.itemCount(id)
        end

        local sizeMultiplier = 1

        for i = 1, slots do
            local slotName = window .. "Slot" .. tostring(i)
            WindowApi.createFromTemplate(
                slotName,
                "ContainerSlotTemplate",
                window
            )

            local slotX, _ =  WindowApi.getDimensions(slotName)
            local rowSize = sizeMultiplier * slotX

            if i ~= 1 then
                WindowApi.clearAnchors(slotName)
                if rowSize < x then
                    WindowApi.addAnchor(
                        slotName,
                        "right",
                        window .. "Slot" .. tostring(i - 1),
                        "left"
                    )
                    sizeMultiplier = sizeMultiplier + 1
                else
                    WindowApi.addAnchor(
                        slotName,
                        "bottomleft",
                        window .. "Slot" .. tostring(i - sizeMultiplier),
                        "topleft"
                    )
                    sizeMultiplier = 1
                end
            end

            DynamicImageApi.setTexture(slotName .. "Icon", "")
            WindowApi.setId(slotName, i)
        end
    end

    for i = 1, Container.itemCount(id) do
        local item = Container.items(id)[i]
        local object = item.objectId
        WindowDataApi.registerData(ObjectInfo.type(), object)
        WindowDataApi.registerData(ItemPropertiesData.type(), object)

        if isGrid then
            local window = UusCorpContainerWindow.Name .. id .. "GridViewScrollChild"

            local image = window .. "Slot" .. tostring(item.gridIndex) .. "Icon"

            DynamicImageApi.setTexture(
                image,
                ObjectInfo.iconName(object)
            )
            DynamicImageApi.setTextureScale(
                image,
                ObjectInfo.iconScale(object)
            )
            DynamicImageApi.setCustomShader(image, DynamicImageApi.Shaders.Sprite, {
                ObjectInfo.hueId(object),
                ObjectInfo.objectType(object)
            })
            DynamicImageApi.setTextureDimensions(
                image,
                ObjectInfo.newWidth(object),
                ObjectInfo.newHeight(object)
            )

            WindowApi.setDimensions(
                image,
                ObjectInfo.newWidth(object),
                ObjectInfo.newHeight(object)
            )
            WindowApi.setColor(
                image,
                ObjectInfo.hue(object)
            )
            WindowApi.setAlpha(
                image,
                ObjectInfo.hue(object).a / 255
            )
        end
    end

    ScrollWindowApi.updateScrollRect(this .. UusCorpContainerWindow.Views.Grid)
end

function UusCorpContainerWindow.updateObject()

end

function UusCorpContainerWindow.onRightClick()
    WindowApi.destroyWindow(Active.window())
end

function UusCorpContainerWindow.onShutdown()
    UusCorpContainerWindow.onSlotMouseOverEnd()

    local window = Active.window()
    local id = WindowApi.getId(window)

    WindowApi.unregisterEventHandler(window, Container.event())
    WindowApi.unregisterEventHandler(window, ObjectInfo.event())
    WindowApi.unregisterEventHandler(window, ItemPropertiesData.event())

    for i = 1, Container.itemCount(id) do
        local item = Container.items(id)[i]
        local object = item.objectId
        WindowDataApi.unregisterData(ObjectInfo.type(), object)
        WindowDataApi.unregisterData(ItemPropertiesData.type(), object)
    end

    WindowDataApi.unregisterData(Container.type(), id)
    GumpApi.onCloseContainer(id)
end

function UusCorpContainerWindow.onLootAll()
    WindowApi.registerCoreEventHandler(
        WindowApi.getParent(Active.window()),
        "OnUpdate",
        "UusCorpContainerWindow.onUpdate"
    )
end

function UusCorpContainerWindow.onSlotSingleClick()
    local slot = activeSlot()

    if Cursor.hasTarget() then
        TargetApi.clickTarget(slot.objectId)
    else
        DragApi.setObjectMouseClickData(slot.objectId, Drag.sourceContainer())
        WindowDataApi.unregisterData(ObjectInfo.type(), slot.objectId)
        WindowDataApi.unregisterData(ItemPropertiesData.type(), slot.objectId)
    end
end

function UusCorpContainerWindow.onSlotSingleClickUp()
    if Drag.isItem() then
        local slot = activeSlot()
        DragApi.dragObjectToContainer(slot.containerId, 0)
    end
end

function UusCorpContainerWindow.onSlotDoubleClick()
    local slot = activeSlot()
    if slot.objectId ~= nil then
        UserAction.useItem(slot.objectId, false)
    end
end

function UusCorpContainerWindow.onSlotRightClick()
    local slot = activeSlot()

    if slot.containerId ~= PlayerEquipment.slotId(PlayerEquipment.Slots.Backpack) then
        DragApi.autoPickUpObject(
            slot.objectId
        )
    end
end

function UusCorpContainerWindow.onSlotMouseOver()
    -- local slot = activeSlot()

    -- if slot.objectId == nil then
    --     return
    -- end

    -- if ItemPropertiesData.properties(slot.objectId) == nil then
    --     return
    -- end

    -- local data = {}
    -- local properties = ItemPropertiesData.propertiesList(slot.objectId)

    -- if properties ~= nil then
    --     for i = 1, #properties do
    --         local text = tostring(properties[i])
    --         table.insert(data, text)
    --     end
    --     UusCorpTooltipWindow.create(data)
    -- end
end

function UusCorpContainerWindow.onSlotMouseOverEnd()
end

function UusCorpContainerWindow.onToggleView()
    UserContainerSettings.legacyContainers(
        not UserContainerSettings.legacyContainers()
    )
    SettingsApi.settingsChanged()
    UusCorpContainerWindow.reopenContainer(WindowApi.getParent(Active.window()))
end

function UusCorpContainerWindow.reopenContainer(container)
    container = container or Active.window()
    WindowApi.destroyWindow(container)
    UserAction.useItem(
        WindowApi.getId(container),
        false
    )
end