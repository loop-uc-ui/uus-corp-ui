SoundSettingsWindow = {}

SoundSettingsWindow.Name = SettingsWindow.Name .. "SoundPage"

SoundSettingsWindow.Container = SoundSettingsWindow.Name .. "Container"

SoundSettingsWindow.CheckBoxes = {
    MasterVolume = {
        name = SoundSettingsWindow.Container .. "MasterVolumeToggleButton",
        setting = function (newValue)
            return UserSoundSettings.masterEnabled(newValue)
        end
    },
    EffectsVolume = {
        name = SoundSettingsWindow.Container .. "EffectsVolumeToggleButton",
        setting = function (newValue)
            return UserSoundSettings.effectsEnabled(newValue)
        end
    },
    MusicVolume = {
        name = SoundSettingsWindow.Container .. "MusicVolumeToggleButton",
        setting = function (newValue)
            return UserSoundSettings.musicEnabled(newValue)
        end
    },
    PlayFootsteps = {
        name = SoundSettingsWindow.Container .. "ToggleFootstepsCheckbox",
        setting = function (newValue)
            return UserSoundSettings.footstepsEnabled(newValue)
        end
    }
}

SoundSettingsWindow.Labels = {
    MasterVolume = {
        name = SoundSettingsWindow.Container .. "MasterVolumeText",
        text = 1077823
    },
    EffectsVolume = {
        name = SoundSettingsWindow.Container .. "EffectsVolumeText",
        text = 1078575
    },
    MusicVolume = {
        name = SoundSettingsWindow.Container .. "MusicVolumeText",
        text = 1078577
    },
    PlayFootsteps = {
        name = SoundSettingsWindow.Container .. "ToggleFootstepsLabel",
        text = 1078077
    }
}

SoundSettingsWindow.Sliders = {
    MasterVolume = {
        name = SoundSettingsWindow.Container .. "MasterVolumeSliderBar",
        value = SoundSettingsWindow.Container .. "MasterVolumeVal",
        setting = function(newValue)
            return UserSoundSettings.masterVolume(newValue)
        end
    },
    EffectsVolume = {
        name = SoundSettingsWindow.Container .. "EffectsVolumeSliderBar",
        value = SoundSettingsWindow.Container .. "EffectsVolumeVal",
        setting = function(newValue)
            return UserSoundSettings.effectsVolume(newValue)
        end
    },
    MusicVolume = {
        name = SoundSettingsWindow.Container .. "MusicVolumeSliderBar",
        value = SoundSettingsWindow.Container .. "MusicVolumeVal",
        setting = function(newValue)
            return UserSoundSettings.musicVolume(newValue)
        end
    }
}

function SoundSettingsWindow.onInitialize()
    for _, v in pairs(SoundSettingsWindow.Labels) do
        LabelApi.setText(
            v.name,
            v.text
        )
    end

    for _, v in pairs(SoundSettingsWindow.CheckBoxes) do
        ButtonApi.setChecked(
            v.name,
            v.setting()
        )

        ButtonApi.setStayDown(
            v.name,
            true
        )
    end

    for _, v in pairs(SoundSettingsWindow.Sliders) do
        LabelApi.setText(
            v.value,
            StringFormatter.toWString(math.floor(v.setting() * 100))
        )
        SliderApi.setPosition(
            v.name,
            v.setting()
        )
    end
end

function SoundSettingsWindow.onVolumeSlide()
    for _, v in pairs(SoundSettingsWindow.Sliders) do
        if v.name == Active.window() then
            LabelApi.setText(
                v.value,
                StringFormatter.toWString(
                    math.floor(
                        100 * SliderApi.getPosition(v.name)
                    )
                )
            )

            v.setting(
                SliderApi.getPosition(v.name)
            )

            EventApi.broadcast(Events.userSettingsUpdated())
            break
        end
    end
end

function SoundSettingsWindow.onSoundSettingChecked()
    for _, v in pairs(SoundSettingsWindow.CheckBoxes) do
        if v.name == Active.window() then
            v.setting(not v.setting())

            ButtonApi.setChecked(
                v.name,
                v.setting()
            )

            EventApi.broadcast(Events.userSettingsUpdated())
            break
        end
    end
end