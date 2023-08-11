UusCorpMobileHealthBar = {}
UusCorpMobileHealthBar.Name = "MobileHealthBar"
UusCorpMobileHealthBar.StatusBar = "HealthBar"
UusCorpMobileHealthBar.HealthLabel = "HealthBarPerc"
UusCorpMobileHealthBar.NameLabel = "Name"
UusCorpMobileHealthBar.Arrow = "MobileArrow"
UusCorpMobileHealthBar.ObjectAnchor = "ObjectAnchor"

local previousTarget = nil

local function overrideCoreInterface()
    Interface.EnableSnapping = true
    function Interface.MobileArrowManager() end
end

local function overrideTargeting()
    local targetWindow = "TargetWindow"

    local events = {
        CurrentTarget.event(),
        MobileStatus.event(),
        MobileData.nameEvent(),
        ObjectInfo.event(),
        HealthBarColorData.event()
    }

    for i = 1, #events do
        WindowApi.unregisterEventHandler(targetWindow, events[i])
    end

    WindowApi.unregisterCoreEventHandler(targetWindow, "OnUpdate")
    WindowApi.setShowing(targetWindow, false)
    UusCorpCore.overrideFunctions(TargetWindow)
    WindowApi.registerEventHandler("Root", CurrentTarget.event(), "UusCorpMobileHealthBar.onTarget")
end

local function overrideDockspots()
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
end

local function overrideHealthBars()
    UusCorpCore.overrideFunctions(MobileHealthBar)

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

        if mobileId ~= PlayerStatus.id() then
            WindowApi.setShowing(
                window .. UusCorpMobileHealthBar.ObjectAnchor,
                false
            )
            SnapUtilsWrapper.startSnap(window)
        end
    end
end

local function isAttached()
    return WindowApi.isShowing(Active.window() .. UusCorpMobileHealthBar.ObjectAnchor)
end

local function destroyPrevious()
    if previousTarget == nil then
        return
    end

    local window = UusCorpMobileHealthBar.Name .. previousTarget

    if WindowApi.doesExist(window) and WindowApi.isShowing(window .. UusCorpMobileHealthBar.ObjectAnchor) then
        WindowApi.destroyWindow(window)
    end
end

function UusCorpMobileHealthBar.initialize()
    overrideDockspots()

    UusCorpCore.loadResources(
        "/src/mods/health-bar",
        "UusCorpMobileHealthBar.xml"
    )

    overrideCoreInterface()
    overrideTargeting()
    overrideHealthBars()
end

function UusCorpMobileHealthBar.onInitialize()
    local window = Active.window()
    local id = tonumber(
        string.gsub(
            window,
            UusCorpMobileHealthBar.Name,
            ""
        ),
        10
    )

    SnapUtilsWrapper.addWindow(window)
    WindowApi.setId(window, id)
    WindowDataApi.registerData(MobileStatus.type(), id)
    WindowDataApi.registerData(HealthBarColorData.type(), id)

    local update = "UusCorpMobileHealthBar.update"
    WindowApi.registerEventHandler(window, MobileStatus.event(), update)
    WindowApi.registerEventHandler(window, HealthBarColorData.event(), "UusCorpMobileHealthBar.updateHealthBarColor")
    WindowApi.setUpdateFrequency(window, 0.10)
    UusCorpMobileHealthBar.update()
    UusCorpMobileHealthBar.updateHealthBarColor()
    SnapUtilsWrapper.startSnap(Active.window())
end

function UusCorpMobileHealthBar.onUpdate()
    local window = Active.window()
    local id = WindowApi.getId(window)
    WindowApi.setShowing(window .. "CurrentTargetFrame", id == CurrentTarget.id())
    WindowApi.setShowing(window .. "Frame", id ~= CurrentTarget.id())
end

function UusCorpMobileHealthBar.onTarget()
    if CurrentTarget.id() == 0 then
        WindowApi.setShowing("ContextMenu", false)
        destroyPrevious()
        previousTarget = nil
        return
    end

    local window = UusCorpMobileHealthBar.Name .. CurrentTarget.id()
    local isPlayer = CurrentTarget.id() == PlayerStatus.id()

    if not isPlayer and CurrentTarget.isMobile() and ObjectApi.isValid(CurrentTarget.id())
        and not WindowApi.doesExist(window) then

        if not string.match(Active.mouseOverWindow(), UusCorpMobileHealthBar.Name) then
            WindowApi.destroyWindow(UusCorpMobileHealthBar.Arrow)
        end

        MobileHealthBar.CreateHealthBar(CurrentTarget.id())

        WindowApi.attachWIndowToWorldObject(
            CurrentTarget.id(),
            window
        )

        SnapUtilsWrapper.removeWindow(window)
        WindowApi.setShowing(window .. UusCorpMobileHealthBar.ObjectAnchor, true)
        destroyPrevious()

        previousTarget = CurrentTarget.id()
    end
end

function UusCorpMobileHealthBar.shutdown()
    WindowApi.destroyWindow(Active.window())
end

function UusCorpMobileHealthBar.onShutdown()
    local window = Active.window()
    local id = WindowApi.getId(window)

    UusCorpMobileHealthBar.onMouseOverEnd()
    WindowDataApi.unregisterData(MobileStatus.type(), id)
    WindowDataApi.unregisterData(HealthBarColorData.type(), id)

    WindowApi.unregisterEventHandler(window, MobileStatus.event())
    WindowApi.unregisterEventHandler(window, HealthBarColorData.event())
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
    local healthLabel = window .. UusCorpMobileHealthBar.HealthLabel
    local maxHealth = MobileStatus.maxHealth(id)

    StatusBarApi.setCurrentValue(statusBar, MobileStatus.currentHealth(id))
    StatusBarApi.setMaximumValue(statusBar, maxHealth)

    LabelApi.setText(healthLabel, tostring(
        math.floor(
            MobileStatus.currentHealth(id) / maxHealth * 100
        )) .. "%"
    )

    -- There's a delay in updating the mobile's status where
    -- values are initialy 0'd out
    WindowApi.setShowing(statusBar, maxHealth ~= 0)
    WindowApi.setShowing(healthLabel, maxHealth ~= 0)

    LabelApi.setText(window .. UusCorpMobileHealthBar.NameLabel, MobileStatus.name(id))
    local notoriety = MobileStatus.notoriety(id)
    LabelApi.setTextColor(window .. UusCorpMobileHealthBar.NameLabel, Colors.Notoriety[notoriety])
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
    if isAttached() then
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

function UusCorpMobileHealthBar.onLeftClickDown(flags)
    local id = WindowApi.getId(Active.window())

    if Cursor.hasTarget() then
        TargetApi.clickTarget(id)
        return
    elseif ButtonFlags.isShift(flags) and isAttached() then
        WindowApi.detachWindowFromWorldObject(
            id,
            Active.window()
        )

        WindowApi.setShowing(
            Active.window() .. UusCorpMobileHealthBar.ObjectAnchor,
            false
        )

        SnapUtilsWrapper.addWindow(Active.window())
        UusCorpMobileHealthBar.onMouseOver()
    else
        TargetApi.clickTarget(id)
    end

    SnapUtilsWrapper.startSnap(Active.window())
end
