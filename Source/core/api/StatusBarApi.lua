StatusBarApi = {}

function StatusBarApi.setMaximumValue(id, value)
    StatusBarSetMaximumValue(id, value)
end

function StatusBarApi.setCurrentValue(id, value)
    StatusBarSetCurrentValue(id, value)
end

function StatusBarApi.setForegroundTint(id, color)
    StatusBarSetForegroundTint(id, color.r, color.g, color.b)
end

function StatusBarApi.setBackgroundTint(id, color)
    StatusBarSetBackgroundTint(id, color.r, color.g, color.b)
end