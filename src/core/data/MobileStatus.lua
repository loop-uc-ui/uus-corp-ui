MobileStatus = {}

function MobileStatus.type()
    return WindowData.MobileStatus.Type
end

function MobileStatus.event()
    return WindowData.MobileStatus.Event
end

function MobileStatus.status(id)
    return WindowData.MobileStatus[id]
end

function MobileStatus.name(id)
    return MobileStatus.status(id).MobName
end

function MobileStatus.notoriety(id)
    return MobileStatus.status(id).Notoriety
end

function MobileStatus.currentHealth(id)
    return MobileStatus.status(id).CurrentHealth
end

function MobileStatus.maxHealth(id)
    return MobileStatus.status(id).MaxHealth
end

function MobileStatus.isDead(id)
    return MobileStatus.status(id).IsDead
end

function MobileStatus.isFemale(id)
    return MobileStatus.status(id).Gender == 1
end

function MobileStatus.race(id)
    return MobileStatus.status(id).Race
end

function MobileStatus.isHuman(id)
    return MobileStatus.race(id) == 1
end

function MobileStatus.isElf(id)
    return MobileStatus.race(id) == 2
end

function MobileStatus.isGargoyle(id)
    return MobileStatus.race(id) == 3
end