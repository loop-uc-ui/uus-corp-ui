ContainerWindow = {}
ContainerWindow.Name = "ContainerWindow_"
ContainerWindow.MaxSlots = 125

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
    local slots = ContainerWindow.MaxSlots
    local window = ContainerWindow.Name .. id
    local x, y = WindowApi.getDimensions(window)

    --Public corpses may have more than the max count
    if Container.itemCount(id) > slots then
        slots = Container.itemCount(id)
    end

    local sizeMultiplier = 1

    for i = 1, slots do
        local slotName = window .. "Slot" .. tostring(i)
        WindowApi.createFromTemplate(
            slotName,
            "GridViewSocketTemplate",
            window
        )

        local slotX, slotY =  WindowApi.getDimensions(slotName)
        local rowSize = sizeMultiplier * slotX

        if i ~= 1 then
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
    end
end

function ContainerWindow.updateObject()

end

function ContainerWindow.onRightClick()
    WindowApi.destroyWindow(Active.window())
end