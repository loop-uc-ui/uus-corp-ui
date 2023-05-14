UusCorpPlayerStatusWindow = {}
UusCorpPlayerStatusWindow.Name = "PlayerHealthBar"

function UusCorpPlayerStatusWindow.initialize()
    UusCorpCore.loadResources(
        "/src/mods/player-status",
        "UusCorpPlayerStatusWindow.xml"
    )

    WindowApi.setShowing("StatusWindow", false)

    WindowApi.unregisterEventHandler(
        "StatusWindow",
        PlayerStatus.event()
    )

    UusCorpCore.overrideFunctions(StatusWindow)
end

function UusCorpPlayerStatusWindow.onInitialize()
    WindowDataApi.registerData(MobileData.nameType(), PlayerStatus.id())
    WindowDataApi.registerData(MobileData.healthBarColorType(), PlayerStatus.id())
    WindowApi.registerEventHandler(UusCorpPlayerStatusWindow.Name, PlayerStatus.event(), "UusCorpPlayerStatusWindow.update")
    if UusCorpCore.isBuffsModEnabled then
        WindowApi.setShowing(UusCorpBuffsWindow.Name, true)
    end
    WindowApi.setColor(Active.window() .. "FrameWar", Colors.NotoMurderer)
    UusCorpPlayerStatusWindow.update()
end

function UusCorpPlayerStatusWindow.onShutdown()
    if UusCorpCore.isBuffsModEnabled then
        WindowApi.setShowing(UusCorpBuffsWindow.Name, false)
    end
    WindowDataApi.unregisterData(MobileData.nameType(), PlayerStatus.id())
    WindowDataApi.unregisterData(MobileData.healthBarColorType(), PlayerStatus.id())
    WindowApi.unregisterEventHandler(UusCorpPlayerStatusWindow.Name, PlayerStatus.event())
end

function UusCorpPlayerStatusWindow.update()
    WindowApi.setShowing(Active.window() .. "Frame", not PlayerStatus.inWarMode())
    WindowApi.setShowing(Active.window() .. "FrameWar", PlayerStatus.inWarMode())

    LabelApi.setText(
        UusCorpPlayerStatusWindow.Name .. "Name",
        MobileData.name(PlayerStatus.id())
    )
    LabelApi.setText(
        UusCorpPlayerStatusWindow.Name .. "HealthBarPerc",
        PlayerStatus.currentHealth() .. " / " .. PlayerStatus.maxHealth()
    )
    LabelApi.setText(
        UusCorpPlayerStatusWindow.Name .. "ManaBarPerc",
        PlayerStatus.currentMana() .. " / " .. PlayerStatus.maxMana()
    )
    LabelApi.setText(
        UusCorpPlayerStatusWindow.Name .. "StaminaBarPerc",
        PlayerStatus.currentStamina() .. " / " .. PlayerStatus.maxStamina()
    )

    local bar = UusCorpPlayerStatusWindow.Name .. "HealthBar"
    StatusBarApi.setCurrentValue(bar, PlayerStatus.currentHealth())
    StatusBarApi.setMaximumValue(bar, PlayerStatus.maxHealth())
    StatusBarApi.setForegroundTint(bar, Colors.Red)

    bar = UusCorpPlayerStatusWindow.Name .. "ManaBar"
    StatusBarApi.setCurrentValue(bar, PlayerStatus.currentMana())
    StatusBarApi.setMaximumValue(bar, PlayerStatus.maxMana())
    StatusBarApi.setForegroundTint(bar, Colors.Blue)

    bar = UusCorpPlayerStatusWindow.Name .. "StaminaBar"
    StatusBarApi.setCurrentValue(bar, PlayerStatus.currentStamina())
    StatusBarApi.setMaximumValue(bar, PlayerStatus.maxStamina())
    StatusBarApi.setForegroundTint(bar, Colors.YellowDark)
end

function UusCorpPlayerStatusWindow.offset()
    WindowApi.setOffsetFromParent(
        UusCorpPlayerStatusWindow.Name,
        MousePosition.x() - 30,
        MousePosition.y() - 15
    )
end

function UusCorpPlayerStatusWindow.onRightClick()
    WindowApi.destroyWindow(UusCorpPlayerStatusWindow.Name)
end

function UusCorpPlayerStatusWindow.onDoubleClick()
    UserAction.useItem(PlayerStatus.id(), false)
end

function UusCorpPlayerStatusWindow.onLeftClickDown()
    if Cursor.hasTarget() then
        TargetApi.clickTarget(
            PlayerStatus.id()
        )
    end
end