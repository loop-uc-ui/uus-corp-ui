HealthBarRootOverlayWindow = {}
HealthBarRootOverlayWindow.Name = "HealthBarRootOverlayWindow"

function HealthBarRootOverlayWindow.onInitialize()
    local x, y = WindowApi.getDimensions(
        WindowApi.getParent(Active.window())
    )
    WindowApi.setDimensions(Active.window(), x, y)
    WindowApi.registerEventHandler(
        HealthBarRootOverlayWindow.Name,
        Events.beginHealthBarDrag(),
        "HealthBarRootOverlayWindow.beginHealthBarDrag"
    )
    WindowApi.registerEventHandler(
        HealthBarRootOverlayWindow.Name,
        Events.endHealthBarDrag(),
        "HealthBarRootOverlayWindow.endHealthBarDrag"
    )
end

function HealthBarRootOverlayWindow.onShutdown()
    WindowApi.unregisterEventHandler(
        HealthBarRootOverlayWindow.Name,
        Events.beginHealthBarDrag()
    )
    WindowApi.unregisterEventHandler(
        HealthBarRootOverlayWindow.Name,
        Events.endHealthBarDrag()
    )
end

function HealthBarRootOverlayWindow.beginHealthBarDrag()
    local mobile = Active.mobile()

    if mobile == nil or mobile == 0 then
        return
    end

    local isPlayer = mobile == PlayerStatus.id()
    local window = MobileHealthBar.Name .. mobile

    if isPlayer then
        window = PlayerHealthBar.Name
    end

    if isPlayer then
        WindowApi.createFromTemplate(
            window,
            PlayerHealthBar.Name,
            HealthBarRootOverlayWindow.Name
        )
    else
        WindowApi.createFromTemplate(
            window,
            MobileHealthBar.Name,
            HealthBarRootOverlayWindow.Name
        )
    end

    local x, y = WindowApi.getDimensions(
        window
    )

    WindowApi.setOffsetFromParent(
        window,
        MousePosition.x() - x / 2,
        MousePosition.y() - y / 2
    )

    WindowApi.setMoving(
        window,
        true
    )
end

function HealthBarRootOverlayWindow.endHealthBarDrag()
    local mobile = Active.mobile()

    if mobile == nil or mobile == 0 then
        return
    end

    local isPlayer = mobile == PlayerStatus.id()
    local window = MobileHealthBar.Name .. mobile

    if isPlayer then
        window = PlayerHealthBar.Name
    end

    local x, y = WindowApi.getDimensions(
        window
    )

    WindowApi.setOffsetFromParent(
        window,
        MousePosition.x() - x / 2,
        MousePosition.y() - y / 2
    )

    WindowApi.setMoving(
        window,
        false
    )

    Active.setMobile(nil)
end