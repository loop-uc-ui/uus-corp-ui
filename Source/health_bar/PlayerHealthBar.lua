PlayerHealthBar = {}
PlayerHealthBar.Name = "PlayerHealthBar"

function PlayerHealthBar.onInitialize()
    WindowDataApi.registerData(MobileData.nameType(), PlayerStatus.id())
    WindowDataApi.registerData(MobileData.healthBarColorType(), PlayerStatus.id())
    WindowApi.registerEventHandler(PlayerHealthBar.Name, PlayerStatus.event(), "PlayerHealthBar.update")
    PlayerHealthBar.update()
end

function PlayerHealthBar.onShutdown()
    WindowDataApi.unregisterData(MobileData.nameType(), PlayerStatus.id())
    WindowDataApi.unregisterData(MobileData.healthBarColorType(), PlayerStatus.id())
    WindowApi.unregisterEventHandler(PlayerHealthBar.Name, PlayerStatus.event())
end

function PlayerHealthBar.update()
    LabelApi.setText(PlayerHealthBar.Name .. "Name", MobileData.name(PlayerStatus.id()))
    LabelApi.setText(PlayerHealthBar.Name .. "HealthBarPerc", PlayerStatus.currentHealth() .. " / " .. PlayerStatus.maxHealth())
    LabelApi.setText(PlayerHealthBar.Name .. "ManaBarPerc", PlayerStatus.currentMana() .. " / " .. PlayerStatus.maxMana())
    LabelApi.setText(PlayerHealthBar.Name .. "StaminaBarPerc", PlayerStatus.currentStamina() .. " / " .. PlayerStatus.maxStamina())

    local bar = PlayerHealthBar.Name .. "HealthBar"
    StatusBarApi.setCurrentValue(bar, PlayerStatus.currentHealth())
    StatusBarApi.setMaximumValue(bar, PlayerStatus.maxHealth())
    StatusBarApi.setForegroundTint(bar, Colors.Red)

    bar = PlayerHealthBar.Name .. "ManaBar"
    StatusBarApi.setCurrentValue(bar, PlayerStatus.currentMana())
    StatusBarApi.setMaximumValue(bar, PlayerStatus.maxMana())
    StatusBarApi.setForegroundTint(bar, Colors.Blue)

    bar = PlayerHealthBar.Name .. "StaminaBar"
    StatusBarApi.setCurrentValue(bar, PlayerStatus.currentStamina())
    StatusBarApi.setMaximumValue(bar, PlayerStatus.maxStamina())
    StatusBarApi.setForegroundTint(bar, Colors.YellowDark)
end

function PlayerHealthBar.offset()
    WindowApi.setOffsetFromParent(
        PlayerHealthBar.Name,
        MousePosition.x() - 30,
        MousePosition.y() - 15
    )
end

function PlayerHealthBar.onRightClick()
    WindowApi.destroyWindow(PlayerHealthBar.Name)
end