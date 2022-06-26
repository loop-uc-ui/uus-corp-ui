--Container windows are not create explicitly by the UI.
--They are create by client when containers are clicked.
ContainerWindow = {}
ContainerWindow.Template = "ContainerWindow"
ContainerWindow.Name = ContainerWindow.Template .. "_"
ContainerWindow.MaxSlots = 125

ContainerWindow.Views = {
    Grid = "GridView",
    Freeform = "FreeformView"
}

ContainerWindow.Gumps = {
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

function ContainerWindow.Initialize()
    local id = tonumber(string.gsub(Active.window(), ContainerWindow.Name, ""), 10)
    WindowApi.setId(Active.window(), id)
    WindowApi.registerEventHandler(Active.window(), Container.event(), "ContainerWindow.updateContainer")
    WindowApi.registerEventHandler(Active.window(), ObjectInfo.event(), "ContainerWindow.updateObject")
    WindowApi.registerEventHandler(Active.window(), ItemProperties.event(), "ContainerWindow.updateObject")
    WindowDataApi.registerData(Container.type(), id)

    WindowApi.setShowing(
        ContainerWindow.Name .. id .. ContainerWindow.Views.Grid,
        not UserContainerSettings.legacyContainers()
    )

    WindowApi.setShowing(
        ContainerWindow.Name .. id .. ContainerWindow.Views.Freeform,
        UserContainerSettings.legacyContainers()
    )

    WindowApi.setShowing(
        ContainerWindow.Name .. id .. "FreeformBackground",
        UserContainerSettings.legacyContainers()
    )

    ContainerWindow.updateContainer()
end

function ContainerWindow.updateContainer()
    local this = Active.window()
    local id = WindowApi.getId(this)
    local isGrid = not WindowApi.isShowing(this .. ContainerWindow.Views.Freeform)
    local name = StringFormatter.fromWString(Container.name(id))

    if #name > 12 then
        name = string.sub(name, 1, 13) .. "..."
    end

    LabelApi.setText(this .. "Title", name)

    if not isGrid then
        local gump = Container.gumpNum(id)

        local scale = Container.freeFormScale()
        local _, xSize, ySize, _ = RequestGumpArt(gump)

        local textureSize = xSize

        if textureSize < ySize then
            textureSize = ySize
        end

        WindowApi.setDimensions(
            this,
            textureSize,
            textureSize
        )

        DynamicImageApi.setTextureDimensions(
            this .. ContainerWindow.Views.Freeform,
            textureSize,
            textureSize
        )

        WindowApi.setDimensions(
            this .. ContainerWindow.Views.Freeform,
            textureSize,
            textureSize
        )

        DynamicImageApi.setTexture(
            this .. ContainerWindow.Views.Freeform,
            "freeformcontainer_texture" .. id,
            0,
            0
        )

        DynamicImageApi.setTextureScale(
            this .. ContainerWindow.Views.Freeform,
            scale
        )

        if gump == ContainerWindow.Gumps.Backpack then
            WindowApi.clearAnchors(this .. ContainerWindow.Views.Freeform)
            WindowApi.addAnchor(
                this .. ContainerWindow.Views.Freeform,
                "topleft",
                this,
                "topleft",
                -40,
                0
            )
        elseif gump == ContainerWindow.Gumps.Corpse then
            WindowApi.clearAnchors(this .. ContainerWindow.Views.Freeform)
            WindowApi.addAnchor(
                this .. ContainerWindow.Views.Freeform,
                "topleft",
                this,
                "topleft",
                0,
                -40
            )
        end
    else
        local slots = ContainerWindow.MaxSlots
        local window = ContainerWindow.Name .. id .. "GridViewScrollChild"
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
        WindowDataApi.registerData(ItemProperties.type(), object)

        if isGrid then
            local window = ContainerWindow.Name .. id .. "GridViewScrollChild"

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

    ScrollWindowApi.updateScrollRect(this .. ContainerWindow.Views.Grid)
end

function ContainerWindow.updateObject()

end

function ContainerWindow.onRightClick()
    WindowApi.destroyWindow(Active.window())
end

function ContainerWindow.Shutdown()
    ContainerWindow.onSlotMouseOverEnd()

    local window = Active.window()
    local id = WindowApi.getId(window)

    WindowApi.unregisterEventHandler(window, Container.event())
    WindowApi.unregisterEventHandler(window, ObjectInfo.event())
    WindowApi.unregisterEventHandler(window, ItemProperties.event())

    for i = 1, Container.itemCount(id) do
        local item = Container.items(id)[i]
        local object = item.objectId
        WindowDataApi.unregisterData(ObjectInfo.type(), object)
        WindowDataApi.unregisterData(ItemProperties.type(), object)
    end

    WindowDataApi.unregisterData(Container.type(), id)
    GumpApi.onCloseContainer(id)
end

function ContainerWindow.onSlotSingleClick()
    local slot = activeSlot()

    if Cursor.hasTarget() then
        TargetApi.clickTarget(slot.objectId)
    else
        DragApi.setObjectMouseClickData(slot.objectId, Drag.sourceContainer())
        WindowDataApi.unregisterData(ObjectInfo.type(), slot.objectId)
        WindowDataApi.unregisterData(ItemProperties.type(), slot.objectId)
    end
end

function ContainerWindow.onSlotSingleClickUp()
    if Drag.isItem() then
        local slot = activeSlot()
        DragApi.dragObjectToContainer(slot.containerId, 0)
    end
end

function ContainerWindow.onSlotDoubleClick()
    local slot = activeSlot()
    if slot.objectId ~= nil then
        UserAction.useItem(slot.objectId, false)
    end
end

function ContainerWindow.onSlotMouseOver()
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

function ContainerWindow.onSlotMouseOverEnd()
    TooltipWindow.destroy()
end