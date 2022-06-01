--Container windows are not create explicitly by the UI.
--They are create by client when containers are clicked.
ContainerWindow = {}
ContainerWindow.Name = "ContainerWindow_"
ContainerWindow.MaxSlots = 125

local function activeSlot()
    local slotNum = WindowApi.getId(Active.window())

    local container = tonumber(
        string.gsub(
            WindowApi.getParent(Active.window()),
            ContainerWindow.Name,
            ""
        ):gsub(
            "GridViewScrollChild",
            ""
        ),
        10
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
    local id = Active.dynamicWindowId()
    local window = ContainerWindow.Name .. id
    WindowApi.setId(window, id)
    WindowApi.registerEventHandler(window, Container.event(), "ContainerWindow.updateContainer")
    WindowApi.registerEventHandler(window, ObjectInfo.event(), "ContainerWindow.updateObject")
    WindowDataApi.registerData(Container.type(), id)
end

function ContainerWindow.updateContainer()
    local id = Active.updateId()

    LabelApi.setText(ContainerWindow.Name .. id .. "Title", Container.name(id))

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

        WindowApi.setId(slotName, i)
    end

    for i = 1, Container.itemCount(id) do
        local item = Container.items(id)[i]
        local object = item.objectId
        WindowDataApi.registerData(ObjectInfo.type(), object)

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

    ScrollWindowApi.updateScrollRect(WindowApi.getParent(window))
end

function ContainerWindow.updateObject()

end

function ContainerWindow.onRightClick()
    WindowApi.destroyWindow(Active.window())
end

function ContainerWindow.Shutdown()
    local window = Active.window()
    local id = WindowApi.getId(window)

    WindowApi.unregisterEventHandler(window, Container.event())
    WindowApi.unregisterEventHandler(window, ObjectInfo.event())

    for i = 1, Container.itemCount(id) do
        local item = Container.items(id)[i]
        local object = item.objectId
        WindowDataApi.unregisterData(ObjectInfo.type(), object)
    end

    WindowDataApi.unregisterData(Container.type(), id)
end

function ContainerWindow.onSlotSingleClick()
    local slot = activeSlot()

    if Cursor.hasTarget() then
        TargetApi.clickTarget(slot.objectId)
    else
        DragApi.setObjectMouseClickData(slot.objectId, Drag.sourceContainer())
        WindowDataApi.unregisterData(ObjectInfo.type(), slot.objectId)
        DynamicImageApi.setTexture(Active.window() .. "Icon", "")
    end
end

function ContainerWindow.onSlotSingleClickUp()
    if Drag.isItem() then
        local slot = activeSlot()
        DragApi.dragObjectToContainer(slot.containerId, slot.gridIndex or slot.slotNum)
    end
end