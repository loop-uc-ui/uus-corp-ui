PlayerStatus = {}

function PlayerStatus.id()
    return WindowData.PlayerStatus.PlayerId
end

function PlayerStatus.maxStamina()
    return WindowData.PlayerStatus.MaxStamina
end

function PlayerStatus.maxMana()
    return WindowData.PlayerStatus.MaxMana
end

function PlayerStatus.maxHealth()
    return WindowData.PlayerStatus.MaxHealth
end

function PlayerStatus.currentHealth()
    return WindowData.PlayerStatus.CurrentHealth
end

function PlayerStatus.currentMana()
    return WindowData.PlayerStatus.CurrentMana
end

function PlayerStatus.currentStamina()
    return WindowData.PlayerStatus.CurrentStamina
end

function PlayerStatus.visualState()
    return WindowData.PlayerStatus.VisualStateId
end

function PlayerStatus.isPoisoned()
    return PlayerStatus.visualState() == 1
end

function PlayerStatus.isCursed()
    return PlayerStatus.visualState() == 2
end

function PlayerStatus.event()
    return WindowData.PlayerStatus.Event
end

