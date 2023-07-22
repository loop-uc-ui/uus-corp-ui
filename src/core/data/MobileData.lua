MobileData = {}

function MobileData.nameType()
    return WindowData.MobileName.Type
end

function MobileData.nameEvent()
    return WindowData.MobileName.Event
end

function MobileData.notoriety(id)
    return WindowData.MobileName[id].Notoriety
end

function MobileData.name(id)
    return WindowData.MobileName[id].MobName
end