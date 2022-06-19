ContextMenuRootOverlayWindow = {}

ContextMenuRootOverlayWindow.Name = "ContextMenuRootOverlayWindow"

function ContextMenuRootOverlayWindow.onInitialize()
    local x, y = WindowApi.getDimensions(
        WindowApi.getParent(Active.window())
    )
    WindowApi.setDimensions(Active.window(), x, y)
    WindowApi.registerEventHandler(
        ContextMenuRootOverlayWindow.Name,
        Events.onLButtonUp(),
        "ContextMenuRootOverlayWindow.onLButtonUp"
    )
end

function ContextMenuRootOverlayWindow.onShutdown()
    WindowApi.unregisterCoreEventHandler(
        ContextMenuRootOverlayWindow.Name,
        Events.onLButtonUp()
    )
end

function ContextMenuRootOverlayWindow.onLButtonUp()
    local mobile = Active.mobile()

    if mobile == nil or mobile == 0 then
        return
    end

    ContextMenuApi.requestMenu(mobile)

    WindowApi.createFromTemplate(
        ContextMenuWindow.Name .. mobile,
        ContextMenuWindow.Name,
        ContextMenuRootOverlayWindow.Name
    )

    Active.setMobile(nil)
end