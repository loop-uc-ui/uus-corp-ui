HealthBarColorData = {}

function HealthBarColorData.type()
    return WindowData.HealthBarColor.Type
end

function HealthBarColorData.event()
    return WindowData.HealthBarColor.Event
end

function HealthBarColorData.visualState(id)
    return WindowData.HealthBarColor[id].VisualStateId
end