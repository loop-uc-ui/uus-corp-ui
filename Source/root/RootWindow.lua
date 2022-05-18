RootWindow = {}
RootWindow.Name = "Root"

local mousePosX, mousePosY

function RootWindow.create()
    ViewportApi.update(
        ScreenResolution.x(),
        ScreenResolution.y(),
        ScreenResolution.x(),
        ScreenResolution.y()
    )

    WindowApi.registerEventHandler(RootWindow.Name, Events.beginHealthBarDrag(), "RootWindow.onHealthBarDrag")
    WindowApi.registerEventHandler(RootWindow.Name, Events.endHealthBarDrag(), "RootWindow.onEndHealthBarDrag")
end

function RootWindow.onHealthBarDrag()
    local mobile = Active.mobile()

    if not mobile then
        return
    end

    local isPlayer = mobile == PlayerStatus.id()
    local window

    if mobile == PlayerStatus.id() then
        window = PlayerHealthBar.Name
    else
        window = MobileHealthBar.Name .. mobile
    end

    mousePosX = MousePosition.x()
    mousePosY = MousePosition.y()

    if WindowApi.doesExist(window) then
        if isPlayer then
            PlayerHealthBar.offset()
        else
            MobileHealthBar.offset(mobile)
        end
        WindowApi.setMoving(window, true)
    elseif isPlayer then
        WindowApi.createWindow(PlayerHealthBar.Name, false)
    else
        WindowApi.createFromTemplate(window, MobileHealthBar.Name, RootWindow.Name)
        WindowApi.setShowing(window, false)
    end
end

function RootWindow.onEndHealthBarDrag()
    local mobile = Active.mobile()
    local isPlayer = mobile == PlayerStatus.id()
    local window

    if isPlayer then
        window = PlayerHealthBar.Name
    else
        window = MobileHealthBar.Name .. mobile
    end

    local isDragged = mousePosX ~= MousePosition.x() and mousePosY ~= MousePosition.y()

    if WindowApi.doesExist(window) and not WindowApi.isShowing(window) and isDragged then
        WindowApi.setShowing(window, true)

        if isPlayer then
            PlayerHealthBar.offset()
        else
            MobileHealthBar.offset(mobile)
        end
    end
end

function RootWindow.shutdown()
    WindowApi.unregisterEventHandler(RootWindow.Name, Events.beginHealthBarDrag())
    WindowApi.unregisterEventHandler(RootWindow.Name, Events.endHealthBarDrag())
end