MobileData = {}

function MobileData.nameType()
    return WindowData.MobileName.Type
end

function MobileData.statusType()
    return WindowData.MobileStatus.Type
end

function MobileData.statusEvent()
    return WindowData.MobileStatus.Event
end

function MobileData.nameEvent()
    return WindowData.MobileName.Event
end

function MobileData.healthBarColorType()
    return WindowData.HealthBarColor.Type
end

function MobileData.status(id)
    return WindowData.MobileStatus[id]
end

function MobileData.name(id)
    return WindowData.MobileName[id].MobName
end

function MobileData.currentHealth(id)
    return MobileData.status(id).CurrentHealth
end

function MobileData.maxHealth(id)
    return MobileData.status(id).MaxHealth
end