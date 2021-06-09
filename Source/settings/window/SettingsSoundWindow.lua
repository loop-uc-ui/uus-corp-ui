SettingsSoundWindow = ListWindow:new(SettingsWindow.WINDOWS.Sound)

local SliderBars = {
    MasterVolume = "MasterVolumeSliderBar",
    EffectsVolume = "EffectsVolumeSliderBar",
    MusicVolume = "MusicVolumeSliderBar"
}

local Buttons = {
    MasterVolume = "MasterVolumeToggleButton",
    EffectsVolume = "EffectsVolumeToggleButton",
    MusicVolume = "MusicVolumeToggleButton",
    Footsteps = "PlayFootstepsToggleButton"
}

function SettingsSoundWindow.Initialize()
    SettingsSoundWindow.adapter:addLabel("SettingsSoundSoundSubSectionLabel", 3000390)
            :addCheckBox(Buttons.MasterVolume, true)
            :addLabel("MasterVolumeText", 1094691)
            :addLabel("MasterVolumeToggleLabel", 1077823)
            :addLabel("MasterVolumeVal", L""..(math.floor( UserSoundSettings.masterVolume() * 100)))
            :addCheckBox(Buttons.EffectsVolume, true)
            :addLabel("EffectsVolumeText",1078576)
            :addLabel("EffectsVolumeToggleLabel", 1078575)
            :addLabel("EffectsVolumeVal", L""..(math.floor( UserSoundSettings.effectsVolume() * 100)))
            :addCheckBox(Buttons.MusicVolume, true)
            :addLabel("MusicVolumeText", 1078578)
            :addLabel("MusicVolumeToggleLabel", 1078577)
            :addLabel("MusicVolumeVal", L""..(math.floor(UserSoundSettings.musicVolume() * 100)))
            :addCheckBox(Buttons.Footsteps, true)
            :addLabel("PlayFootstepsToggleLabel", 1078077)
    SettingsSoundWindow:setOffset(0):updateScrollRect()
end

function SettingsSoundWindow.UpdateVolumeSliderSettings()
    local masterVolume = math.floor( 100 * SettingsSoundWindow.adapter.views[SliderBars.MasterVolume]:getPosition())
    local effectsVolume = math.floor( 100 * SettingsSoundWindow.adapter.views[SliderBars.EffectsVolume]:getPosition())
    local musicVolume = math.floor( 100 * SettingsSoundWindow.adapter.views[SliderBars.MusicVolume]:getPosition())
    SettingsSoundWindow.adapter:addLabel("MasterVolumeVal", L""..masterVolume)
            :addLabel("EffectsVolumeVal", L""..effectsVolume)
            :addLabel( "MusicVolumeVal", L""..musicVolume)
end

function SettingsSoundWindow.UpdateSettings()
    SettingsSoundWindow.adapter.views[Buttons.MasterVolume]:setChecked(UserSoundSettings.masterEnabled())
    SettingsSoundWindow.adapter.views[Buttons.EffectsVolume]:setChecked(UserSoundSettings.effectsEnabled())
    SettingsSoundWindow.adapter.views[Buttons.MusicVolume]:setChecked(UserSoundSettings.musicEnabled())
    SettingsSoundWindow.adapter.views[Buttons.Footsteps]:setChecked(UserSoundSettings.footstepsEnabled())
    SettingsSoundWindow.adapter:addSlider(SliderBars.MasterVolume, UserSoundSettings.masterVolume())
            :addSlider(SliderBars.EffectsVolume, UserSoundSettings.effectsVolume())
            :addSlider(SliderBars.MusicVolume, UserSoundSettings.musicVolume())
end

function SettingsSoundWindow.OnApplyButton()
    UserSoundSettings.masterEnabled(SettingsSoundWindow.adapter.views[Buttons.MasterVolume]:isChecked())
    UserSoundSettings.effectsEnabled(SettingsSoundWindow.adapter.views[Buttons.EffectsVolume]:isChecked())
    UserSoundSettings.musicEnabled(SettingsSoundWindow.adapter.views[Buttons.MusicVolume]:isChecked())
    UserSoundSettings.footstepsEnabled(SettingsSoundWindow.adapter.views[Buttons.Footsteps]:isChecked())
    UserSoundSettings.musicVolume(SettingsSoundWindow.adapter.views[SliderBars.MasterVolume]:getPosition())
    UserSoundSettings.effectsVolume(SettingsSoundWindow.adapter.views[SliderBars.EffectsVolume]:getPosition())
    UserSoundSettings.musicVolume(SettingsSoundWindow.adapter.views[SliderBars.MusicVolume]:getPosition())
end