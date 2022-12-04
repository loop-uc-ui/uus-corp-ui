PlayerStatus = {}

function PlayerStatus.id()
    return WindowData.PlayerStatus.PlayerId
end

function PlayerStatus.type()
    return WindowData.PlayerStatus.Type
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

function PlayerStatus.inWarMode()
    return WindowData.PlayerStatus.InWarMode
end

function PlayerStatus.stats()
    return WindowData.PlayerStatsDataCSV
end

function PlayerStatus.data()
    return WindowData.PlayerStatus
end

function PlayerStatus.increaseMaxHitPoints()
    return PlayerStatus.data()["IncreaseHitPointsMax"]
end

function PlayerStatus.increaseMaxMana()
    return PlayerStatus.data()["IncreaseManaMax"]
end

function PlayerStatus.increaseMaxStamina()
    return PlayerStatus.data()["IncreaseStamMax"]
end

function PlayerStatus.intelligence()
    return PlayerStatus.data()["Intelligence"]
end

function PlayerStatus.increaseIntelligence()
    return PlayerStatus.data()["IncreaseInt"]
end

function PlayerStatus.strength()
    return PlayerStatus.data()["Strength"]
end

function PlayerStatus.increaseStrength()
    return PlayerStatus.data()["IncreaseStr"]
end

function PlayerStatus.dexterity()
    return PlayerStatus.data()["Dexterity"]
end

function PlayerStatus.increaseDexterity()
    return PlayerStatus.data()["IncreaseDex"]
end

function PlayerStatus.damage()
    return PlayerStatus.data()["Damage"]
end

function PlayerStatus.maxDamage()
    return PlayerStatus.data()["MaxDamage"]
end
