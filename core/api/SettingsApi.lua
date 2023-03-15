SettingsApi = {}

function SettingsApi.settingsChanged()
    --This is some variable that the client understands
    needsReload = UserSettingsChanged()
    return needsReload
end