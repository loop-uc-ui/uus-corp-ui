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

    WindowDataApi.registerData(PlayerStatus.type())
    WindowApi.registerEventHandler(RootWindow.Name, Events.beginHealthBarDrag(), "RootWindow.onHealthBarDrag")
    WindowApi.registerEventHandler(RootWindow.Name, Events.endHealthBarDrag(), "RootWindow.onEndHealthBarDrag")
    WindowApi.registerEventHandler(RootWindow.Name, Events.showNamesUpdated(), "RootWindow.onShowNamesUpdated")
    WindowApi.registerEventHandler(RootWindow.Name, Events.showNamesFlashTemp(), "RootWindow.onShowNamesFlashTemp")
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

    if WindowApi.doesExist(window) then
        return
    elseif isPlayer then
        WindowApi.createWindow(PlayerHealthBar.Name, false)
    else
        WindowApi.createFromTemplate(window, MobileHealthBar.Name, RootWindow.Name)
        WindowApi.setShowing(window, false)
    end

    mousePosX = MousePosition.x()
    mousePosY = MousePosition.y()
end

function RootWindow.onEndHealthBarDrag()
    if mousePosX == MousePosition.x() and mousePosY == MousePosition.y() then
        return
    end

    local mobile = Active.mobile()
    local isPlayer = mobile == PlayerStatus.id()
    local window

    if isPlayer then
        window = PlayerHealthBar.Name
    else
        window = MobileHealthBar.Name .. mobile
    end

    if WindowApi.doesExist(window) and not WindowApi.isShowing(window) then
        WindowApi.setShowing(window, true)

        if isPlayer then
            PlayerHealthBar.offset()
        else
            MobileHealthBar.offset(mobile)
        end
    end
end

function RootWindow.shutdown()
    WindowDataApi.unregisterData(PlayerStatus.type())
    WindowApi.unregisterEventHandler(RootWindow.Name, Events.beginHealthBarDrag())
    WindowApi.unregisterEventHandler(RootWindow.Name, Events.endHealthBarDrag())
    WindowApi.unregisterEventHandler(RootWindow.Name, Events.showNamesUpdated())
    WindowApi.unregisterEventHandler(RootWindow.Name, Events.showNamesFlashTemp())
end

function RootWindow.onShowNamesUpdated()

end

function RootWindow.onShowNamesFlashTemp()

end