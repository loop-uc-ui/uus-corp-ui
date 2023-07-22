UusCorpMobileHealthBar = {}
UusCorpMobileHealthBar.Name = "MobileHealthBar"
UusCorpMobileHealthBar.StatusBar = "HealthBar"
UusCorpMobileHealthBar.HealthLabel = "HealthBarPerc"
UusCorpMobileHealthBar.NameLabel = "Name"
UusCorpMobileHealthBar.Arrow = "MobileArrow"
UusCorpMobileHealthBar.ObjectAnchor = "ObjectAnchor"

function UusCorpMobileHealthBar.initialize()
    local dockspots = {
        "YellowDockspot",
        "BlueDockspot",
        "GreyDockspot",
        "RedDockspot",
        "GreenDockspot",
        "OrangeDockspot",
        "PetWindow",
        "MobilesOnScreenWindow"
    }

    for i = 1, #dockspots do
        WindowApi.destroyWindow(dockspots[i])
        SnapUtilsWrapper.removeWindow(dockspots[i])
    end

    UusCorpCore.loadResources(
        "/src/mods/health-bar",
        "UusCorpMobileHealthBar.xml"
    )

    UusCorpCore.overrideFunctions(MobileHealthBar)

    Interface.EnableSnapping = true

    function Interface.MobileArrowManager() end

    MobileHealthBar.CreateHealthBar = function (mobileId)
        local template = UusCorpMobileHealthBar.Name
        local window = template .. mobileId

        if mobileId == PlayerStatus.id() then
            template = UusCorpPlayerStatusWindow.Name
            window = UusCorpPlayerStatusWindow.Name
        end

        WindowApi.createFromTemplate(
            window,
            template,
            "Root"
        )

        local x, y = WindowApi.getDimensions(
            window
        )

        local scale = 1 / InterfaceCore.scale

        WindowApi.setOffsetFromParent(
            window,
            MousePosition.x() * scale - x / 2 * scale,
            MousePosition.y() * scale - y / 2 * scale
        )

        WindowApi.setMoving(window, true)
    end
end

function UusCorpMobileHealthBar.onInitialize()
    local window = Active.window()
    local id = Active.mobile()

    SnapUtilsWrapper.addWindow(window)
    WindowApi.setId(window, id)
    WindowDataApi.registerData(MobileStatus.type(), id)
    WindowDataApi.registerData(HealthBarColorData.type(), id)

    local update = "UusCorpMobileHealthBar.update"
    WindowApi.registerEventHandler(window, MobileStatus.event(), update)
    WindowApi.registerEventHandler(window, Events.enableHealthBar(), update)
    WindowApi.registerEventHandler(window, Events.disableHealthBar(), "UusCorpMobileHealthBar.shutdown")
    WindowApi.registerEventHandler(window, HealthBarColorData.event(), "UusCorpMobileHealthBar.updateHealthBarColor")

    WindowApi.setShowing(window .. UusCorpMobileHealthBar.ObjectAnchor, false)
    UusCorpMobileHealthBar.update()
    UusCorpMobileHealthBar.updateHealthBarColor()
    SnapUtilsWrapper.startSnap(Active.window())
end

function UusCorpMobileHealthBar.shutdown()
    WindowApi.destroyWindow(Active.window())
end

function UusCorpMobileHealthBar.onShutdown()
    local window = Active.window()
    local id = WindowApi.getId(window)

    WindowDataApi.unregisterData(MobileStatus.type(), id)
    WindowDataApi.unregisterData(HealthBarColorData.type(), id)

    WindowApi.unregisterEventHandler(window, MobileStatus.event())
    WindowApi.unregisterEventHandler(window, HealthBarColorData.event())
    WindowApi.unregisterEventHandler(window, Events.disableHealthBar())
    WindowApi.unregisterEventHandler(window, Events.enableHealthBar())
    UusCorpMobileHealthBar.onMouseOverEnd()
    WindowApi.detachWindowFromWorldObject(id, window)
    SnapUtilsWrapper.removeWindow(window)
end

function UusCorpMobileHealthBar.updateHealthBarColor()
    local window = Active.window()
    local id = WindowApi.getId(window)
    StatusBarApi.setForegroundTint(
        window .. UusCorpMobileHealthBar.StatusBar,
        Colors.HealthBar[HealthBarColorData.visualState(id) + 1]
    )
end

function UusCorpMobileHealthBar.update()
    local window = Active.window()
    local id = WindowApi.getId(window)

    local statusBar = window .. UusCorpMobileHealthBar.StatusBar
    StatusBarApi.setCurrentValue(statusBar, MobileStatus.currentHealth(id))
    StatusBarApi.setMaximumValue(statusBar, MobileStatus.maxHealth(id))

    LabelApi.setText(window .. UusCorpMobileHealthBar.NameLabel, MobileStatus.name(id))
    local notoriety = MobileStatus.notoriety(id)
    LabelApi.setTextColor(window .. UusCorpMobileHealthBar.NameLabel, Colors.Notoriety[notoriety])
    LabelApi.setText(window .. UusCorpMobileHealthBar.HealthLabel, tostring(
        math.floor(
            MobileStatus.currentHealth(id) / MobileStatus.maxHealth(id) * 100
        )) .. "%"
    )
end

function UusCorpMobileHealthBar.offset(mobileId)
    WindowApi.setOffsetFromParent(
        UusCorpMobileHealthBar.Name .. mobileId,
        MousePosition.x() - 30,
        MousePosition.y() - 15
    )
end

function UusCorpMobileHealthBar.onRightClick()
    WindowApi.destroyWindow(Active.window())
end

function UusCorpMobileHealthBar.onMouseOver()
    if WindowApi.isShowing(Active.window() .. UusCorpMobileHealthBar.ObjectAnchor) then
        return
    end

    local id = WindowApi.getId(
        Active.window()
    )

    if WindowApi.doesExist(UusCorpMobileHealthBar.Arrow) or not ObjectApi.isValid(id) then
        return
    end

    local notoriety = MobileStatus.notoriety(id)

    WindowApi.createWindow(UusCorpMobileHealthBar.Arrow, false)
    WindowApi.setScale(UusCorpMobileHealthBar.Arrow, 0.33)
    WindowApi.setColor(UusCorpMobileHealthBar.Arrow, Colors.Notoriety[notoriety])
    WindowApi.attachWIndowToWorldObject(WindowApi.getId(Active.window()), UusCorpMobileHealthBar.Arrow)
    WindowApi.setShowing(UusCorpMobileHealthBar.Arrow, true)
    AnimatedImageApi.startAnimation(AnimatedImageApi.Animations.MobileArrow, 1, true, false, 0.0)
end

function UusCorpMobileHealthBar.onMouseOverEnd()
    if Active.window() == Active.mouseOverWindow() then
        WindowApi.destroyWindow(UusCorpMobileHealthBar.Arrow)
    end
end

function UusCorpMobileHealthBar.onDoubleClick()
    UserAction.useItem(
        WindowApi.getId(Active.window()),
        false
    )
end

function UusCorpMobileHealthBar.onLeftClickDown()
    if Cursor.hasTarget() then
        TargetApi.clickTarget(
            WindowApi.getId(
                Active.window()
            )
        )
    else
        SnapUtilsWrapper.startSnap(Active.window())
    end
end
