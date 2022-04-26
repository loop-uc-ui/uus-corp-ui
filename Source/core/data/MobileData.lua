MobileData = {}

function MobileData.nameType()
    return WindowData.MobileName.Type
end

function MobileData.statusType()
    return WindowData.MobileStatus.Type
end

function MobileData.healthBarColorType()
    return WindowData.HealthBarColor.Type
end

function MobileData.status(id)
    return WindowData.MobileStatus[id]
end