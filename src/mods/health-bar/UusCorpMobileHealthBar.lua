UusCorpMobileHealthBar = {}
UusCorpMobileHealthBar.Name = "MobileHealthBar"
UusCorpMobileHealthBar.StatusBar = "HealthBar"
UusCorpMobileHealthBar.HealthLabel = "HealthBarPerc"
UusCorpMobileHealthBar.NameLabel = "Name"
UusCorpMobileHealthBar.Arrow = "MobileArrow"
UusCorpMobileHealthBar.ObjectAnchor = "ObjectAnchor"

function UusCorpMobileHealthBar.initialize()
    WindowApi.destroyWindow("YellowDockspot")
    WindowApi.destroyWindow("BlueDockspot")
    WindowApi.destroyWindow("GreyDockspot")
    WindowApi.destroyWindow("RedDockspot")
    WindowApi.destroyWindow("GreenDockspot")
    WindowApi.destroyWindow("OrangeDockspot")
    WindowApi.destroyWindow("PetWindow")
    WindowApi.destroyWindow("MobilesOnScreenWindow")

    UusCorpCore.loadResources(
        "/src/mods/health-bar",
        "UusCorpMobileHealthBar.xml"
    )

    UusCorpCore.overrideFunctions(MobileHealthBar)

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

    WindowApi.setId(window, id)
    WindowDataApi.registerData(MobileData.nameType(), id)
    WindowDataApi.registerData(MobileData.statusType(), id)
    WindowDataApi.registerData(MobileData.healthBarColorType(), id)

    local update = "UusCorpMobileHealthBar.update"
    WindowApi.registerEventHandler(window, MobileData.statusEvent(), update)
    WindowApi.registerEventHandler(window, MobileData.nameEvent(), update)
    WindowApi.registerEventHandler(window, Events.enableHealthBar(), update)
    WindowApi.registerEventHandler(window, Events.disableHealthBar(), "UusCorpMobileHealthBar.onShutdown")

    WindowApi.setShowing(window .. UusCorpMobileHealthBar.ObjectAnchor, false)
    UusCorpMobileHealthBar.update()
end

function UusCorpMobileHealthBar.onShutdown()
    local window = Active.window()
    local id = WindowApi.getId(window)

    WindowDataApi.unregisterData(MobileData.nameType(), id)
    WindowDataApi.unregisterData(MobileData.statusType(), id)
    WindowDataApi.unregisterData(MobileData.healthBarColorType(), id)

    WindowApi.unregisterEventHandler(window, MobileData.statusEvent())
    WindowApi.unregisterEventHandler(window, MobileData.nameEvent())
    WindowApi.unregisterEventHandler(window, Events.disableHealthBar())
    WindowApi.unregisterEventHandler(window, Events.enableHealthBar())
    UusCorpMobileHealthBar.onMouseOverEnd()
    WindowApi.detachWindowFromWorldObject(id, window)
end

function UusCorpMobileHealthBar.update()
    local window = Active.window()
    local id = WindowApi.getId(window)

    local statusBar = window .. UusCorpMobileHealthBar.StatusBar
    StatusBarApi.setCurrentValue(statusBar, MobileData.currentHealth(id))
    StatusBarApi.setMaximumValue(statusBar, MobileData.maxHealth(id))
    StatusBarApi.setForegroundTint(statusBar, Colors.Red)

    LabelApi.setText(window .. UusCorpMobileHealthBar.NameLabel, MobileData.name(id))
    local notoriety = MobileData.notoriety(id)
    LabelApi.setTextColor(window .. UusCorpMobileHealthBar.NameLabel, Colors.Notoriety[notoriety])
    LabelApi.setText(window .. UusCorpMobileHealthBar.HealthLabel, tostring(
        math.floor(
            MobileData.currentHealth(id) / MobileData.maxHealth(id) * 100
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

    local notoriety = MobileData.notoriety(id)

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
    end
end
