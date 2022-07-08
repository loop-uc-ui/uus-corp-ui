MobileHealthBar = {}
MobileHealthBar.Name = "MobileHealthBar"
MobileHealthBar.StatusBar = "HealthBar"
MobileHealthBar.HealthLabel = "HealthBarPerc"
MobileHealthBar.NameLabel = "Name"
MobileHealthBar.Arrow = "MobileArrow"

function MobileHealthBar.onInitialize()
    local window = Active.window()
    local id = Active.mobile()

    WindowApi.setId(window, id)
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
    local id = WindowApi.getId(window)

    WindowDataApi.unregisterData(MobileData.nameType(), id)
    WindowDataApi.unregisterData(MobileData.statusType(), id)
    WindowDataApi.unregisterData(MobileData.healthBarColorType(), id)

    WindowApi.unregisterEventHandler(window, MobileData.statusEvent())
    WindowApi.unregisterEventHandler(window, MobileData.nameEvent())
    WindowApi.unregisterEventHandler(window, Events.disableHealthBar())
    WindowApi.unregisterEventHandler(window, Events.enableHealthBar())
    MobileHealthBar.onMouseOverEnd()
end

function MobileHealthBar.update()
    local window = Active.window()
    local id = WindowApi.getId(window)

    local statusBar = window .. MobileHealthBar.StatusBar
    StatusBarApi.setCurrentValue(statusBar, MobileData.currentHealth(id))
    StatusBarApi.setMaximumValue(statusBar, MobileData.maxHealth(id))
    StatusBarApi.setForegroundTint(statusBar, Colors.Red)

    LabelApi.setText(window .. MobileHealthBar.NameLabel, MobileData.name(id))
    local notoriety = MobileData.notoriety(id)
    LabelApi.setTextColor(window .. MobileHealthBar.NameLabel, Colors.Notoriety[notoriety])
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

function MobileHealthBar.onMouseOver()
    local id = WindowApi.getId(
        Active.window()
    )

    if WindowApi.doesExist(MobileHealthBar.Arrow) or not ObjectApi.isValid(id) then
        return
    end

    local notoriety = MobileData.notoriety(id)

    WindowApi.createWindow(MobileHealthBar.Arrow, false)
    WindowApi.setScale(MobileHealthBar.Arrow, 0.33)
    WindowApi.setColor(MobileHealthBar.Arrow, Colors.Notoriety[notoriety])
    WindowApi.attachWIndowToWorldObject(WindowApi.getId(Active.window()), MobileHealthBar.Arrow)
    WindowApi.setShowing(MobileHealthBar.Arrow, true)
    AnimatedImageApi.startAnimation(AnimatedImageApi.Animations.MobileArrow, 1, true, false, 0.0)
end

function MobileHealthBar.onMouseOverEnd()
    WindowApi.destroyWindow(MobileHealthBar.Arrow)
end

function MobileHealthBar.onDoubleClick()
    UserAction.useItem(
        WindowApi.getId(Active.window()),
        false
    )
end
