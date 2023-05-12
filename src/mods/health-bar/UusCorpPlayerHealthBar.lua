UusCorpPlayerHealthBar = {}
UusCorpPlayerHealthBar.Name = "PlayerHealthBar"

function UusCorpPlayerHealthBar.initialize()
    UusCorpCore.loadResources(
        "/src/mods/health-bar",
        "UusCorpPlayerHealthBar.xml"
    )

    WindowApi.setShowing("StatusWindow", false)

    WindowApi.unregisterEventHandler(
        "StatusWindow",
        PlayerStatus.event()
    )

    UusCorpCore.overrideFunctions(StatusWindow)
end

function UusCorpPlayerHealthBar.onInitialize()
    WindowDataApi.registerData(MobileData.nameType(), PlayerStatus.id())
    WindowDataApi.registerData(MobileData.healthBarColorType(), PlayerStatus.id())
    WindowApi.registerEventHandler(UusCorpPlayerHealthBar.Name, PlayerStatus.event(), "UusCorpPlayerHealthBar.update")
    WindowApi.setShowing(UusCorpBuffsWindow.Name, true)
    WindowApi.setColor(Active.window() .. "FrameWar", Colors.NotoMurderer)
    UusCorpPlayerHealthBar.update()
end

function UusCorpPlayerHealthBar.onShutdown()
    WindowApi.setShowing(UusCorpBuffsWindow.Name, false)
    WindowDataApi.unregisterData(MobileData.nameType(), PlayerStatus.id())
    WindowDataApi.unregisterData(MobileData.healthBarColorType(), PlayerStatus.id())
    WindowApi.unregisterEventHandler(UusCorpPlayerHealthBar.Name, PlayerStatus.event())
end

function UusCorpPlayerHealthBar.update()
    WindowApi.setShowing(Active.window() .. "Frame", not PlayerStatus.inWarMode())
    WindowApi.setShowing(Active.window() .. "FrameWar", PlayerStatus.inWarMode())

    LabelApi.setText(
        UusCorpPlayerHealthBar.Name .. "Name",
        MobileData.name(PlayerStatus.id())
    )
    LabelApi.setText(
        UusCorpPlayerHealthBar.Name .. "HealthBarPerc",
        PlayerStatus.currentHealth() .. " / " .. PlayerStatus.maxHealth()
    )
    LabelApi.setText(
        UusCorpPlayerHealthBar.Name .. "ManaBarPerc",
        PlayerStatus.currentMana() .. " / " .. PlayerStatus.maxMana()
    )
    LabelApi.setText(
        UusCorpPlayerHealthBar.Name .. "StaminaBarPerc",
        PlayerStatus.currentStamina() .. " / " .. PlayerStatus.maxStamina()
    )

    local bar = UusCorpPlayerHealthBar.Name .. "HealthBar"
    StatusBarApi.setCurrentValue(bar, PlayerStatus.currentHealth())
    StatusBarApi.setMaximumValue(bar, PlayerStatus.maxHealth())
    StatusBarApi.setForegroundTint(bar, Colors.Red)

    bar = UusCorpPlayerHealthBar.Name .. "ManaBar"
    StatusBarApi.setCurrentValue(bar, PlayerStatus.currentMana())
    StatusBarApi.setMaximumValue(bar, PlayerStatus.maxMana())
    StatusBarApi.setForegroundTint(bar, Colors.Blue)

    bar = UusCorpPlayerHealthBar.Name .. "StaminaBar"
    StatusBarApi.setCurrentValue(bar, PlayerStatus.currentStamina())
    StatusBarApi.setMaximumValue(bar, PlayerStatus.maxStamina())
    StatusBarApi.setForegroundTint(bar, Colors.YellowDark)
end

function UusCorpPlayerHealthBar.offset()
    WindowApi.setOffsetFromParent(
        UusCorpPlayerHealthBar.Name,
        MousePosition.x() - 30,
        MousePosition.y() - 15
    )
end

function UusCorpPlayerHealthBar.onRightClick()
    WindowApi.destroyWindow(UusCorpPlayerHealthBar.Name)
end

function UusCorpPlayerHealthBar.onDoubleClick()
    UserAction.useItem(PlayerStatus.id(), false)
end

function UusCorpPlayerHealthBar.onLeftClickDown()
    if Cursor.hasTarget() then
        TargetApi.clickTarget(
            PlayerStatus.id()
        )
    end
end