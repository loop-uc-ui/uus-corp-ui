--[[
    Interfaces with the Root Window to provide update callbacks
    to the Object Handles as the player moves. The overlay is added
    to the Root window and retains the same dimensions. The overlay
    allows us to avoid registering complicated chains of events
    to the singular Root window by serving as the parent for all
    Object Handles.
]]--
ObjectHandleRootOverlayWindow = {}

ObjectHandleRootOverlayWindow.Name = "ObjectHandleRootOverlayWindow"

function ObjectHandleRootOverlayWindow.onInitialize()
    local x, y = WindowApi.getDimensions(
        WindowApi.getParent(Active.window())
    )
    WindowApi.setDimensions(Active.window(), x, y)
    WindowApi.registerEventHandler(
        ObjectHandleRootOverlayWindow.Name,
        Events.createObjectHandles(),
        "ObjectHandleRootOverlayWindow.createObjectHandles"
    )
    WindowApi.registerEventHandler(
        ObjectHandleRootOverlayWindow.Name,
        Events.destroyObjectHandles(),
        "ObjectHandleRootOverlayWindow.destroyObjectHandles"
    )
end

function ObjectHandleRootOverlayWindow.createObjectHandles()
    WindowApi.registerCoreEventHandler(
        ObjectHandleRootOverlayWindow.Name,
        "OnUpdate",
        "ObjectHandleRootOverlayWindow.onUpdate"
    )

    for i = 1, #ObjectHandles.objectId() do
        local id = ObjectHandles.objectId()[i]

        if ObjectApi.isValid(id) then
            WindowApi.createFromTemplate(
                ObjectHandleWindow.Name .. id,
                ObjectHandleWindow.Name,
                ObjectHandleRootOverlayWindow.Name
            )
        end
    end
end

function ObjectHandleRootOverlayWindow.destroyObjectHandles()
    WindowApi.unregisterCoreEventHandler(
        ObjectHandleRootOverlayWindow.Name,
        "OnUpdate"
    )

    for i = 1, #ObjectHandles.objectId() do
        WindowApi.destroyWindow(
            ObjectHandleWindow.Name .. ObjectHandles.objectId()[i]
        )
    end
end

function ObjectHandleRootOverlayWindow.onShutdown()
    ObjectHandleRootOverlayWindow.destroyObjectHandles()
    WindowApi.unregisterEventHandler(
        ObjectHandleRootOverlayWindow.Name,
        Events.createObjectHandles()
    )
    WindowApi.unregisterEventHandler(
        ObjectHandleRootOverlayWindow.Name,
        Events.destroyObjectHandles()
    )
end

function ObjectHandleRootOverlayWindow.onUpdate()
    for i = 1, #ObjectHandles.objectId() do
        local id = ObjectHandles.objectId()[i]

        if not ObjectApi.isValid(id) then
            WindowApi.destroyWindow(
                ObjectHandleWindow.Name .. id
            )
        end
    end
end