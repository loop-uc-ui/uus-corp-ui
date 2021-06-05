SettingsGraphicsWindow = {}

local adapter = ViewAdapter:new("SettingsGraphicsWindow", "SettingsGraphics")

local checkBoxes = {
    UseFullScreen = "SettingsGraphicsUseFullscreenButton",
    ShowFrame = "SettingsGraphicsShowFrameButton",
    ShowFoliage = "SettingsGraphicsShowFoliageButton",
    ShowShadows = "SettingsGraphicsShowShadowsButton",
    EnableVSync = "SettingsGraphicsEnableVSyncButton",
    CircleOfTransparency = "SettingsGraphicsCircleOfTransparencyButton",
    HardwareDeathEffect = "SettingsGraphicsHardwareDeathEffectButton",
    IdleAnimation = "SettingsGraphicsPlayIdleAnimationButton",
    FlyingAnimation = "SettingsGraphicsPlayFlyingAnimationButton",
    DisplayHousingContents = "SettingsGraphicsDisplayAllHouseContentsButton"
}

local comboBoxes = {
    Resolution = "SettingsGraphicsFullScreenResCombo",
    FrameRate = "SettingsGraphicsFramerateMaxCombo",
    ParticleDetail = "SettingsGraphicsParticleLODCombo",
    ParticleFilter = "SettingsGraphicsParticleFilterCombo",
    AnimationDetail = "SettingsGraphicsAnimationCombo"
}

local slider = {
    id = "GammaSliderBar",
    value = "GammaVal"
}

function SettingsGraphicsWindow.Initialize()
    adapter:addLabel("SettingsGraphicsDisplaySubSectionLabel", 3000396)
            :addLabel("SettingsGraphicsDisplaySubSectionLabel", 3000396)
            :addLabel("SettingsGraphicsEnvironmentSubSectionLabel", 1077415)
            :addLabel("SettingsGraphicsUseFullscreenLabel", 1077821)
            :addCheckBox(checkBoxes.UseFullScreen)
            :addLabel("SettingsGraphicsFullScreenResLabel", 1077819)
            :addLabel("SettingsGraphicsShowFrameLabel", 1077820)
            :addCheckBox(checkBoxes.ShowFrame)
            :addLabel("GammaText", 3000166)
            :addLabel("SettingsGraphicsShowFoliageLabel", 1079814)
            :addCheckBox(checkBoxes.ShowFoliage)
            :addLabel("SettingsGraphicsShowShadowsLabel", 1079286)
            :addCheckBox(checkBoxes.ShowShadows)
            :addLabel("SettingsGraphicsEnableVSyncLabel", 1112689)
            :addCheckBox(checkBoxes.EnableVSync)
            :addLabel("SettingsGraphicsCircleOfTransparencyLabel", 1078079)
            :addCheckBox(checkBoxes.CircleOfTransparency)
            :addLabel("SettingsGraphicsHardwareDeathEffectLabel", 1115993)
            :addCheckBox(checkBoxes.HardwareDeathEffect)
            :addLabel("SettingsGraphicsParticleLODLabel", 1079213)
            :addLabel("SettingsGraphicsParticleFilterLabel", 1112330)
            :addLabel("SettingsGraphicsFramerateMaxLabel", 1112340)
            :addLabel("SettingsGraphicsParticleFilterLabel", 1112330)
            :addLabel("SettingsGraphicsPlayIdleAnimationLabel", 1094692)
            :addCheckBox(checkBoxes.IdleAnimation)
            :addLabel("SettingsGraphicsAnimationLabel", 1079368)
            :addLabel("SettingsGraphicsPlayFlyingAnimationLabel", 1158627)
            :addCheckBox(checkBoxes.FlyingAnimation)
            :addLabel("SettingsGraphicsDisplayAllHouseContentsLabel", 1159003)
            :addCheckBox(checkBoxes.DisplayHousingContents)
            :addSlider(slider.id, 0.50)
            :addLabel(slider.value, "0.50")
            :setOffset(0)
            :updateScrollRect()

    local resolutions = {}
    for res = 1, #UserGraphicsSettings.Resolutions.widths do
        resolutions[res] = L"".. UserGraphicsSettings.Resolutions.widths[res]..L" x ".. UserGraphicsSettings.Resolutions.heights[res]
    end
    adapter:addComboBox(comboBoxes.Resolution, resolutions)
    
    local frameRates = {
        1112341,
        1112342,
        1112343,
        1112344,
        1112345
    }
    adapter:addComboBox(comboBoxes.FrameRate, frameRates)
    
    local particleDetails = {
        1079210,
        1079211,
        1079212
    } 
    adapter:addComboBox(comboBoxes.ParticleDetail, particleDetails)
    
    local particleFilters = {
        1112331,
        1112332,
        1112333,
        1112334,
        1158020
    } 
    adapter:addComboBox(comboBoxes.ParticleFilter, particleFilters)
    
    local animations = { 1079210, 1079211, 1079212 }
    adapter:addComboBox(comboBoxes.AnimationDetail, animations)
end

function SettingsGraphicsWindow.UpdateSettings()
    for res = 1, #UserGraphicsSettings.Resolutions.widths do
        if (UserGraphicsSettings.resolution().width == UserGraphicsSettings.Resolutions.widths[res] and
                UserGraphicsSettings.resolution().height == UserGraphicsSettings.Resolutions.heights[res] )then
            adapter.views[comboBoxes.Resolution]:setSelectedItem(res)
        end
    end

    adapter.views[comboBoxes.FrameRate]:setSelectedItem(UserGraphicsSettings.frameRate() / 10 - 1)
    adapter.views[comboBoxes.ParticleDetail]:setSelectedItem(UserGraphicsSettings.particleDetail())
    adapter.views[comboBoxes.ParticleFilter]:setSelectedItem(UserGraphicsSettings.particleFilter() + 1)
    adapter.views[comboBoxes.AnimationDetail]:setSelectedItem(UserGraphicsSettings.animationDetail() + 1)
    
    adapter.views[checkBoxes.ShowFrame]:setChecked(UserGraphicsSettings.showFrame())
    adapter.views[checkBoxes.ShowShadows]:setChecked(UserGraphicsSettings.showShadows())
    adapter.views[checkBoxes.EnableVSync]:setChecked(UserGraphicsSettings.enableVSync())
    adapter.views[checkBoxes.CircleOfTransparency]:setChecked(UserGraphicsSettings.circleOfTransparency())
    adapter.views[checkBoxes.HardwareDeathEffect]:setChecked(UserGraphicsSettings.hardwareDeathEffect())
    adapter.views[checkBoxes.UseFullScreen]:setChecked(UserGraphicsSettings.fullScreen())
    adapter.views[checkBoxes.IdleAnimation]:setChecked(UserGraphicsSettings.idleAnimation())
    adapter.views[checkBoxes.FlyingAnimation]:setChecked(UserGraphicsSettings.flyingAnimation())
    adapter.views[checkBoxes.DisplayHousingContents]:setChecked(UserGraphicsSettings.displayHousingContents())
    adapter.views[checkBoxes.ShowFoliage]:setChecked(UserGraphicsSettings.foliage())
    adapter.views[slider.id]:setPosition(UserGraphicsSettings.gamma())
    adapter.views[slider.value]:setText(StringFormatter.toTwoDecimalPlaces(UserGraphicsSettings.gamma()))
end

function SettingsGraphicsWindow.OnApplyButton()
    local fullScreenRes = adapter.views[comboBoxes.Resolution]:getSelectedItem()
    UserGraphicsSettings.resolution({
        width = UserGraphicsSettings.Resolutions.widths[fullScreenRes],
        height = UserGraphicsSettings.Resolutions.heights[fullScreenRes]
    })

    UserGraphicsSettings.frameRate((adapter.views[comboBoxes.FrameRate]:getSelectedItem() + 1) * 10)
    UserGraphicsSettings.showFrame(adapter.views[checkBoxes.ShowFrame]:isChecked())
    UserGraphicsSettings.showShadows(adapter.views[checkBoxes.ShowShadows]:isChecked())
    UserGraphicsSettings.enableVSync(adapter.views[checkBoxes.EnableVSync]:isChecked())
    UserGraphicsSettings.circleOfTransparency(adapter.views[checkBoxes.CircleOfTransparency]:isChecked())
    UserGraphicsSettings.hardwareDeathEffect(adapter.views[checkBoxes.HardwareDeathEffect]:isChecked())
    UserGraphicsSettings.fullScreen(adapter.views[checkBoxes.UseFullScreen]:isChecked())
    UserGraphicsSettings.idleAnimation(adapter.views[checkBoxes.IdleAnimation]:isChecked())
    UserGraphicsSettings.flyingAnimation(adapter.views[checkBoxes.FlyingAnimation]:isChecked())
    UserGraphicsSettings.displayHousingContents(adapter.views[checkBoxes.DisplayHousingContents]:isChecked())
    UserGraphicsSettings.foliage(adapter.views[checkBoxes.ShowFoliage]:isChecked())
    UserGraphicsSettings.gamma(adapter.views[slider.id]:getPosition())
    UserGraphicsSettings.particleDetail(adapter.views[comboBoxes.ParticleDetail]:getSelectedItem())
    UserGraphicsSettings.particleFilter(adapter.views[comboBoxes.ParticleFilter]:getSelectedItem() - 1)
    UserGraphicsSettings.animationDetail(adapter.views[comboBoxes.AnimationDetail]:getSelectedItem() - 1)
end

function SettingsGraphicsWindow.UpdateGammaVal()
    local gamma = adapter.views[slider.id]:getPosition()
    adapter:addLabel(slider.value, StringFormatter.toTwoDecimalPlaces(gamma))
end