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

local adapter = SettingsSoundWindow.adapter

function SettingsSoundWindow.Initialize()
    adapter:addLabel("SettingsSoundSoundSubSectionLabel", 3000390)
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
            :addSlider(SliderBars.MasterVolume, 1.0)
            :addSlider(SliderBars.EffectsVolume, 1.0)
            :addSlider(SliderBars.MusicVolume, 1.0)
    SettingsSoundWindow:setOffset(0):updateScrollRect()
end

function SettingsSoundWindow.UpdateVolumeSliderSettings()
    local masterVolume = math.floor( 100 * adapter.views[SliderBars.MasterVolume]:getPosition())
    local effectsVolume = math.floor( 100 * adapter.views[SliderBars.EffectsVolume]:getPosition())
    local musicVolume = math.floor( 100 * adapter.views[SliderBars.MusicVolume]:getPosition())
    adapter:addLabel("MasterVolumeVal", L""..masterVolume)
            :addLabel("EffectsVolumeVal", L""..effectsVolume)
            :addLabel( "MusicVolumeVal", L""..musicVolume)
end

function SettingsSoundWindow.UpdateSettings()
    adapter.views[Buttons.MasterVolume]:setChecked(UserSoundSettings.masterEnabled())
    adapter.views[Buttons.EffectsVolume]:setChecked(UserSoundSettings.effectsEnabled())
    adapter.views[Buttons.MusicVolume]:setChecked(UserSoundSettings.musicEnabled())
    adapter.views[Buttons.Footsteps]:setChecked(UserSoundSettings.footstepsEnabled())
    adapter.views[SliderBars.MasterVolume]:setPosition(UserSoundSettings.masterVolume())
    adapter.views[SliderBars.EffectsVolume]:setPosition(UserSoundSettings.effectsVolume())
    adapter.views[SliderBars.MusicVolume]:setPosition(UserSoundSettings.musicVolume())
end

function SettingsSoundWindow.OnApplyButton()
    UserSoundSettings.masterEnabled(adapter.views[Buttons.MasterVolume]:isChecked())
    UserSoundSettings.effectsEnabled(adapter.views[Buttons.EffectsVolume]:isChecked())
    UserSoundSettings.musicEnabled(adapter.views[Buttons.MusicVolume]:isChecked())
    UserSoundSettings.footstepsEnabled(adapter.views[Buttons.Footsteps]:isChecked())
    UserSoundSettings.masterVolume(adapter.views[SliderBars.MasterVolume]:getPosition())
    UserSoundSettings.effectsVolume(adapter.views[SliderBars.EffectsVolume]:getPosition())
    UserSoundSettings.musicVolume(adapter.views[SliderBars.MusicVolume]:getPosition())
end