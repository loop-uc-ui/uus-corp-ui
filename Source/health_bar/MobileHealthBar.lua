MobileHealthBar = {}
MobileHealthBar.Name = "MobileHealthBar"
MobileHealthBar.StatusBar = "HealthBar"
MobileHealthBar.HealthLabel = "HealthBarPerc"
MobileHealthBar.NameLabel = "Name"

local function mobile(window)
    return tonumber(string.gsub(window, MobileHealthBar.Name, ""), 10)
end

function MobileHealthBar.onInitialize()
    local window = Active.window()
    local id = mobile(window)

    WindowDataApi.registerData(MobileData.nameType(), id)
    WindowDataApi.registerData(MobileData.statusType(), id)
    WindowDataApi.registerData(MobileData.healthBarColorType(), id)

    local update = "MobileHealthBar.update"
    WindowApi.registerEventHandler(window, MobileData.statusEvent(), update)
    WindowApi.registerEventHandler(window, MobileData.nameEvent(), update)
    WindowApi.registerEventHandler(window, Events.enableHealthBar(), update)
    WindowApi.registerEventHandler(window, Events.disableHealthBar(), "MobileHealthBar.onShutdown")

    MobileHealthBar.update()
end

function MobileHealthBar.onShutdown()
    local window = Active.window()
    local id = mobile(window)

    WindowDataApi.unregisterData(MobileData.nameType(), id)
    WindowDataApi.unregisterData(MobileData.statusType, id)
    WindowDataApi.unregisterData(MobileData.healthBarColorType(), id)

    WindowApi.unregisterEventHandler(window, MobileData.statusEvent())
    WindowApi.unregisterEventHandler(window, MobileData.nameEvent())
    WindowApi.unregisterEventHandler(window, Events.disableHealthBar())
    WindowApi.unregisterEventHandler(window, Events.enableHealthBar())
end

function MobileHealthBar.update()
    local window = Active.window()
    local id = mobile(window)

    local statusBar = window .. MobileHealthBar.StatusBar
    StatusBarApi.setCurrentValue(statusBar, MobileData.currentHealth(id))
    StatusBarApi.setMaximumValue(statusBar, MobileData.maxHealth(id))
    StatusBarApi.setForegroundTint(statusBar, Colors.Red)

    LabelApi.setText(window .. MobileHealthBar.NameLabel, MobileData.name(id))
    LabelApi.setText(window .. MobileHealthBar.HealthLabel, tostring(
        math.floor(
            MobileData.currentHealth(id) / MobileData.maxHealth(id) * 100
        )) .. "%"
    )
end

function MobileHealthBar.offset(mobileId)
    WindowApi.setOffsetFromParent(
        MobileHealthBar.Name .. mobileId,
        MousePosition.x() - 30,
        MousePosition.y() - 15
    )
end

function MobileHealthBar.onRightClick()
    WindowApi.destroyWindow(Active.window())
end