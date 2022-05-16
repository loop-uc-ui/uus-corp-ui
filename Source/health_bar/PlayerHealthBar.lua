PlayerHealthBar = {}
PlayerHealthBar.name = "PlayerHealthBar"

function PlayerHealthBar.new()
    return UusCorpWindow.new(
        PlayerHealthBar.name
    ):child(
        UusCorpLabel.new(PlayerHealthBar.name .. "HealthBarPerc"):setText(
            function ()
                return PlayerStatus.currentHealth() .. " / " .. PlayerStatus.maxHealth()
            end
        )
    ):child(
        UusCorpLabel.new(PlayerHealthBar.name .. "ManaBarPerc"):setText(
            function ()
                return PlayerStatus.currentMana() .. " / " .. PlayerStatus.maxMana()
            end
        )
    ):child(
        UusCorpLabel.new(PlayerHealthBar.name .. "StaminaBarPerc"):setText(
            function ()
                return PlayerStatus.currentStamina() .. " / " .. PlayerStatus.maxStamina()
            end
        )
    ):child(
        UusCorpStatusBar.new(PlayerHealthBar.name .. "HealthBar"):setCurrentValue(
            function ()
                return PlayerStatus.currentHealth()
            end
        ):setMaximumValue(
            function ()
                return PlayerStatus.maxHealth()
            end
        ):setForegroundTint(
            function ()
                return Colors.Red
            end
        )
    ):child(
        UusCorpStatusBar.new(PlayerHealthBar.name .. "ManaBar"):setCurrentValue(
            function ()
                return PlayerStatus.currentMana()
            end
        ):setMaximumValue(
            function ()
                return PlayerStatus.maxMana()
            end
        ):setForegroundTint(
            function ()
                return Colors.Blue
            end
        )
    ):child(
        UusCorpStatusBar.new(PlayerHealthBar.name .. "StaminaBar"):setCurrentValue(
            function ()
                return PlayerStatus.currentStamina()
            end
        ):setMaximumValue(
            function ()
                return PlayerStatus.maxStamina()
            end
        ):setForegroundTint(
            function ()
                return Colors.YellowDark
            end
        )
    ):event(
        UusCorpViewEvent.new(
            PlayerStatus.event()
        )
    )
end

function PlayerHealthBar.offset()
    WindowApi.setOffsetFromParent(
        PlayerHealthBar.name,
        MousePosition.x() - 30,
        MousePosition.y() - 15
    )
end