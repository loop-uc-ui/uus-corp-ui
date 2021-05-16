UserSoundSettings = {}

function UserSoundSettings.masterEnabled(newValue)
    if newValue ~= nil then
        SystemData.Settings.Sound.master.enabled = newValue
    end
    return SystemData.Settings.Sound.master.enabled
end

function UserSoundSettings.masterVolume(newValue)
    if newValue ~= nil then
        SystemData.Settings.Sound.master.volume = newValue
    end
    return SystemData.Settings.Sound.master.volume
end

function UserSoundSettings.effectsEnabled(newValue)
    if newValue ~= nil then
        SystemData.Settings.Sound.effects.enabled = newValue
    end
    return SystemData.Settings.Sound.effects.enabled
end

function UserSoundSettings.effectsVolume(newValue)
    if newValue ~= nil then
        SystemData.Settings.Sound.effects.volume = newValue
    end
    return SystemData.Settings.Sound.effects.volume
end

function UserSoundSettings.musicEnabled(newValue)
    if newValue ~= nil then
        SystemData.Settings.Sound.music.enabled = newValue
    end
    return  SystemData.Settings.Sound.music.enabled
end

function UserSoundSettings.musicVolume(newValue)
    if newValue ~= nil then
        SystemData.Settings.Sound.music.volume = newValue
    end
    return SystemData.Settings.Sound.music.volume
end

function UserSoundSettings.footstepsEnabled(newValue)
    if newValue ~= nil then
        SystemData.Settings.Sound.footsteps.enabled = newValue
    end
    return SystemData.Settings.Sound.footsteps.enabled
end