---@param id string
---@return SettingsTab
local function tab(id)
    ---@class SettingsTab
    ---@field text string
    ---@field name string
    ---@field page string
    return {
        text = id,
        name = UusCorpSettingsWindow.TabContainer .. id .. "Tab",
        page = UusCorpSettingsWindow.name .. id
    }
end

---@param id string
---@param labels? table
---@param comboBoxes? table
---@param sliders? table
---@return SettingsPage
local function page(id, labels, comboBoxes, checkBoxes, sliders)
    ---@class SettingsPage
    ---@field name string
    ---@field labels table
    ---@field comboBoxes table
    ---@field checkBoxes table
    ---@field sliders table
    return {
        name = UusCorpSettingsWindow.name .. id,
        labels = labels or {},
        comboBoxes = comboBoxes or {},
        checkBoxes = checkBoxes or {},
        sliders = sliders or {}
    }
end

---@param id string
---@param text string | number
---@return SettingsLabel
local function label(id, text)
    ---@class SettingsLabel
    ---@field name string
    ---@field text string | number
    return {
        name = UusCorpSettingsWindow.name .. id,
        text = text
    }
end

---@param id string
---@param list function
---@param isSelected function
---@param setting function
---@return SettingsComboBox
local function comboBox(id, list, isSelected, setting)
    ---@class SettingsComboBox
    ---@field name string
    ---@field list function
    ---@field isSeleced function
    ---@field setting function
    return {
        name = UusCorpSettingsWindow.name .. id,
        list = list,
        isSelected = isSelected,
        setting = setting
    }
end

---@param id string
---@param setting function
---@return SettingsCheckBox
local function checkBox(id, setting)
    ---@class SettingsCheckBox
    ---@field name string
    ---@field setting function
    return {
        name = UusCorpSettingsWindow.name .. id,
        setting = setting
    }
end

---@param id string
---@param value string
---@param setting function
---@param formatValue function
---@return SettingsSlider
local function slider(id, value, setting, formatValue)
    ---@class SettingsSlider
    ---@field name string
    ---@field value string
    ---@field setting function
    ---@field formatValue function
    return {
        name = UusCorpSettingsWindow.name .. id,
        value = UusCorpSettingsWindow.name .. value,
        setting = setting,
        formatValue = formatValue
    }
end

---@class UusCorpSettingsWindow:UusCorpWindow
UusCorpSettingsWindow = UusCorpWindow:new("UusCorpSettingsWindow")

UusCorpSettingsWindow.TabContainer = UusCorpSettingsWindow.name .. "TabContainer"

UusCorpSettingsWindow.Tabs = {
    Graphics = tab("Graphics"),
    Sound = tab("Sound"),
    Chat = tab("Chat"),
    Controls = tab("Controls"),
    Interface = tab("Interface")
}

UusCorpSettingsWindow.SelectedTab = UusCorpSettingsWindow.Tabs.Graphics

UusCorpSettingsWindow.Pages = {
    Graphics = page(
        "GraphicsScrollPage",
        {
            Resolution = label("GraphicsScrollPageResComboLabel", "Resolution"),
            FrameRate = label("GraphicsScrollPageFrameRateComboLabel", 1112340),
            UseFullScreen = label("GraphicsScrollPageFullScreenCheckBoxLabel", 1077821),
            PlayFlyingAnimation = label("GraphicsScrollPageFlyingAnimationCheckBoxLabel", 1158627),
            ShowWindowFrame = label("GraphicsScrollPageWindowFrameCheckBoxLabel", 1077820),
            HouseContents = label("GraphicsScrollPageHouseContentsCheckBoxLabel", 1159003),
            DeathEffect = label("GraphicsScrollPageDeathEffectCheckBoxLabel", 1115993),
            VSync = label("GraphicsScrollPageVSyncCheckBoxLabel", 1112689),
            IdleAnimation = label("GraphicsScrollPageIdleAnimationCheckBoxLabel", 1094692),
            Foliage = label("GraphicsScrollPageFoliageCheckBoxLabel", 1079814),
            Shadows = label("GraphicsScrollPageShadowsCheckBoxLabel", 1079286),
            Brightness = label("GraphicsScrollPageBrightnessSliderLabel", 3000166),
            DiskCache = label("GraphicsScrollPageDiskCacheSliderLabel", 1079480),
            ParticleDetail = label("GraphicsScrollPageParticleDetailComboLabel", 1079213),
            ParticleFilter = label("GraphicsScrollPageParticleFilterComboLabel", 1112330),
            CircleOfTransparency = label("GraphicsScrollPageCircleOfTransparencyCheckBoxLabel", 1078079),
            AnimationQuality = label("GraphicsScrollPageAnimationQualityComboLabel", 1079368)
        },
        {
            Resolution = comboBox(
                "GraphicsScrollPageResComboBox",
                function ()
                    local list = {}
                    for i = 1, #UserGraphicsSettings.availableResolutions().widths do
                        local width = UserGraphicsSettings.availableResolutions().widths[i]
                        local height = UserGraphicsSettings.availableResolutions().heights[i]
                        table.insert(
                            list,
                            width .. " x " .. height
                        )
                    end
                    return list
                end,
                function (index)
                    local width = UserGraphicsSettings.availableResolutions().widths[index]
                    local height = UserGraphicsSettings.availableResolutions().heights[index]
                    local resolution = UserGraphicsSettings.resolution()
                    return resolution.width == width and resolution.height == height
                end,
                function (newValue)
                    if newValue == nil then
                        return UserGraphicsSettings.resolution()
                    else
                        local width = UserGraphicsSettings.availableResolutions().widths[newValue]
                        local height = UserGraphicsSettings.availableResolutions().heights[newValue]
                        return UserGraphicsSettings.resolution({
                            width = width,
                            height = height
                        })
                    end
                end
            ),
            FrameRate = comboBox(
                "GraphicsScrollPageFrameRateComboBox",
                function ()
                    return {
                        1112341,
                        1112342,
                        1112343,
                        1112344,
                        1112345,
                        L"70 FPS", --No clue why these are enumerated in the Default UI
                        L"80 FPS",
                        L"90 FPS",
                        L"100 FPS",
                        L"110 FPS",
                        L"120 FPS",
                        L"130 FPS",
                        L"140 FPS",
                        L"150 FPS",
                        L"160 FPS",
                        L"170 FPS",
                        L"180 FPS",
                        L"190 FPS",
                        L"200 FPS"
                    }
                end,
                function (index)
                    return index == UserGraphicsSettings.frameRate() / 10 - 1
                end,
                function (newValue)
                    UserGraphicsSettings.frameRate((newValue + 1) * 10)
                end
            ),
            ParticleDetail = comboBox(
                "GraphicsScrollPageParticleDetailComboBox",
                function ()
                    return { 1079210, 1079211, 1079212 }
                end,
                function (index)
                    return index == UserGraphicsSettings.particleDetail() + 1
                end,
                function (newValue)
                    return UserGraphicsSettings.particleDetail(newValue -1)
                end
            ),
            ParticleFilter = comboBox(
                "GraphicsScrollPageParticleFilterComboBox",
                function ()
                    return { 1112331, 1112332, 1112333, 1112334, 1158020 }
                end,
                function (index)
                    return index == UserGraphicsSettings.particleFilter() + 1
                end,
                function (newValue)
                    return UserGraphicsSettings.particleFilter(newValue - 1)
                end
            ),
            AnimationQuality = comboBox(
                "GraphicsScrollPageAnimationQualityComboBox",
                function ()
                    return { 1079210, 1079211, 1079212 }
                end,
                function (index)
                    return index == UserGraphicsSettings.animationDetail() + 1
                end,
                function (newValue)
                    return UserGraphicsSettings.animationDetail(newValue - 1)
                end
            )
        },
        {
            UseFullScreen = checkBox(
                "GraphicsScrollPageFullScreenCheckBox",
                function (newValue)
                    return UserGraphicsSettings.fullScreen(newValue)
                end
            ),
            PlayFlyingAnimation = checkBox(
                "GraphicsScrollPageFlyingAnimationCheckBox",
                function (newValue)
                    return UserGraphicsSettings.flyingAnimation(newValue)
                end
            ),
            ShowWindowFrame = checkBox(
                "GraphicsScrollPageWindowFrameCheckBox",
                function (newValue)
                    return UserGraphicsSettings.showFrame(newValue)
                end
            ),
            HouseContents = checkBox(
                "GraphicsScrollPageHouseContentsCheckBox",
                function (newValue)
                    return UserGraphicsSettings.displayHousingContents(newValue)
                end
            ),
            DeathEffect = checkBox(
                "GraphicsScrollPageDeathEffectCheckBox",
                function (newValue)
                    return UserGraphicsSettings.hardwareDeathEffect(newValue)
                end
            ),
            VSync = checkBox(
                "GraphicsScrollPageVSyncCheckBox",
                function (newValue)
                    return UserGraphicsSettings.enableVSync(newValue)
                end
            ),
            IdleAnimation = checkBox(
                "GraphicsScrollPageIdleAnimationCheckBox",
                function (newValue)
                    return UserGraphicsSettings.idleAnimation(newValue)
                end
            ),
            Foliage = checkBox(
                "GraphicsScrollPageFoliageCheckBox",
                function (newValue)
                    return UserGraphicsSettings.foliage(newValue)
                end
            ),
            Shadows = checkBox(
                "GraphicsScrollPageShadowsCheckBox",
                function (newValue)
                    return UserGraphicsSettings.showShadows(newValue)                    
                end
            ),
            CircleOfTransparency = checkBox(
                "GraphicsScrollPageCircleOfTransparencyCheckBox",
                function (newValue)
                    return UserGraphicsSettings.circleOfTransparency(newValue)
                end
            )
        },
        {
            Brightness = slider(
                "GraphicsScrollPageBrightnessSliderBar",
                "GraphicsScrollPageBrightnessSliderValue",
                function (newValue)
                    return UserGraphicsSettings.gamma(newValue)
                end,
                function (value)
                    return StringFormatter.toTwoDecimalPlaces(
                        StringFormatter.toWString(
                            value
                        )
                    )
                end
            ),
            DiskCache = slider(
                "GraphicsScrollPageDiskCacheSliderBar",
                "GraphicsScrollPageDiskCacheSliderValue",
                function (newValue)
                    return UserOptionsSettings.cacheSize((newValue or 1024) / 1024)
                end,
                function (value)
                    return tostring(math.floor(value) * 1024)
                end
            )
        }
    ),
    Chat = page(
        "ChatPage",
        {
            DisableSpells = label(
                "ChatPageDisableSpellsCheckBoxLabel",
                1155334
            ),
            ShowSpellName = label(
                "ChatPageShowSpellNameCheckBoxLabel",
                1155336
            ),
            DisablePoisonText = label(
                "ChatPageDisablePoisonTextCheckBoxLabel",
                1155338
            ),
            SaveJournal = label(
                "ChatPageSaveJournalCheckBoxLabel",
                1149998
            ),
        },
        nil,
        {
            DisableSpells = checkBox(
                "ChatPageDisableSpellsCheckBox",
                function(newValue)
                    return UserOverheadTextSettings.disableSpells(newValue)
                end
            ),
            ShowSpellName = checkBox(
                "ChatPageShowSpellNameCheckBox",
                function(newValue)
                    return UserOverheadTextSettings.showSpellNames(newValue)
                end
            ),
            DisablePoisonText = checkBox(
                "ChatPageDisablePoisonTextCheckBox",
                function(newValue)
                    return UserOverheadTextSettings.disablePoison(newValue)
                end
            ),
            SaveJournal = checkBox(
                "ChatPageSaveJournalCheckBox",
                function(newValue)
                    return UserOptionsSettings.enableChatLog(newValue)
                end
            )
        },
        nil
    ),
    Interface = page(
        "InterfacePage",
        {
            Mode = label(
                "InterfacePageModComboLabel",
                1079523
            ),
            LegacyContainers = label(
                "InterfacePageLegacyContainersCheckBoxLabel",
                1094708
            ),
            LegacyPaperdoll = label(
                "InterfacePageLegacyPaperdollCheckBoxLabel",
                1150185
            ),
            ObjectHandleFilter = label(
                "InterfacePageObjectHandleComboLabel",
                1079461
            ),
            AlwaysRun = label(
                "InterfacePageAlwaysRunCheckBoxLabel",
                1078078
            ),
            AutoRun = label(
                "InterfacePageAutoRunCheckBoxLabel",
                1115321
            ),
            AutoNavigate = label(
                "InterfacePageAutoNavigateCheckBoxLabel",
                1115324
            ),
            AlwaysAttack = label(
                "InterfacePageAlwaysAttackCheckBoxLabel",
                1078858
            ),
            QueryCriminal = label(
                "InterfacePageQueryCriminalCheckBoxLabel",
                1078080
            ),
            IgnoreMouse = label(
                "InterfacePageIgnoreMouseCheckBoxLabel",
                1115918
            ),
            ContextMenu = label(
                "InterfacePageContextMenuCheckBoxLabel",
                1115355
            ),
            TargetQueue = label(
                "InterfacePageTargetQueueCheckBoxLabel",
                1115337
            ),
            BlockWarPets = label(
                "InterfacePageBlockWarPetsCheckBoxLabel",
                1155300
            ),
            BlockWarParty = label(
                "InterfacePageBlockWarPartyCheckBoxLabel",
                1155302
            ),
            BlockWarFriendly = label(
                "InterfacePageBlockWarFriendlyCheckBoxLabel",
                "Block War on Friendly"
            )
        },
        {
            Mod = comboBox(
                "InterfacePageModComboBox",
                function()
                    local list = {}
                    for i = 1, #UserOptionsSettings.customUiList() do
                        local item = UserOptionsSettings.customUiList()[i]
                        if item == "" then
                            table.insert(
                                list,
                                StringFormatter.fromTid(
                                    3000094
                                )
                            )
                        else
                            table.insert(
                                list,
                                item
                            )
                        end
                    end
                    return list
                end,
                function (index)
                    return UusCorpSettingsWindow.Pages.Interface.comboBoxes.Mod.list()[index]
                        == UserOptionsSettings.customUI()
                end,
                function(newValue)
                    return UserOptionsSettings.customUI(newValue)
                end
            ),
            ObjectHandleFilter = comboBox(
                "InterfacePageObjectHandleComboBox",
                function ()
                    return {
                        1079457,
                        1078368,
                        1079458,
                        1079459,
                        1075672
                        --Items Only and Lost Items Only.
                        --Disabling these since they are not applied automatically.
                        --They require client-side interventions.
                        -- 1154804,
                        -- 1154805
                    }
                end,
                function (index)
                    return index == UserOptionsSettings.objectHandleFilter() + 1
                end,
                function (newValue)
                    if newValue == nil then
                        return UserOptionsSettings.objectHandleFilter() + 1
                    else
                        return UserOptionsSettings.objectHandleFilter(newValue - 1)
                    end
                end
            )
        },
        {
            LegacyContainers = checkBox(
                "InterfacePageLegacyContainersCheckBox",
                function(newValue)
                    return UserContainerSettings.legacyContainers(newValue)
                end
            ),
            LegacyPaperdoll = checkBox(
                "InterfacePageLegacyPaperdollCheckBox",
                function (newValue)
                    return Paperdoll.useLegacy(newValue)
                end
            ),
            AlwaysRun = checkBox(
                "InterfacePageAlwaysRunCheckBox",
                function (newValue)
                    return UserOptionsSettings.alwaysRun(newValue)
                end
            ),
            AutoRun = checkBox(
                "InterfacePageAutoRunCheckBox",
                function (newValue)
                    return UserOptionsSettings.autoRun(newValue)
                end
            ),
            AutoNavigate = checkBox(
                "InterfacePageAutoNavigateCheckBox",
                function (newValue)
                    return UserOptionsSettings.pathfinding(newValue)
                end
            ),
            AlwaysAttack = checkBox(
                "InterfacePageAlwaysAttackCheckBox",
                function (newValue)
                    return UserOptionsSettings.alwaysAttack(newValue)
                end
            ),
            QueryCriminal = checkBox(
                "InterfacePageQueryCriminalCheckBox",
                function (newValue)
                    return UserOptionsSettings.queryBeforeCriminalAction(newValue)
                end
            ),
            IgnoreMouse = checkBox(
                "InterfacePageIgnoreMouseCheckBox",
                function (newValue)
                    return UserOptionsSettings.ignoreMouseActionsOnSelf(newValue)
                end
            ),
            ContextMenu = checkBox(
                "InterfacePageContextMenuCheckBox",
                function (newValue)
                    return UserOptionsSettings.shiftRightClickContextMenus(newValue)
                end
            ),
            TargetQueue = checkBox(
                "InterfacePageTargetQueueCheckBox",
                function (newValue)
                    return UserOptionsSettings.targetQueueing(newValue)
                end
            ),
            BlockWarPets = checkBox(
                "InterfacePageBlockWarPetsCheckBox",
                function (newValue)
                    return UserOptionsSettings.blockWarOnPets(newValue)
                end
            ),
            BlockWarParty = checkBox(
                "InterfacePageBlockWarPartyCheckBox",
                function (newValue)
                    return UserOptionsSettings.blockWarOnParty(newValue)
                end
            ),
            BlockWarFriendly = checkBox(
                "InterfacePageBlockWarFriendlyCheckBox",
                function (newValue)
                    return UserOptionsSettings.blockWarOnFriendly(newValue)
                end
            )
        },
        nil
    ),
    Sound = page(
        "SoundPage",
        {
            MasterVolume = label(
                "SoundPageMasterVolumeCheckBoxLabel",
                1077823
            ),
            EffectsVolume = label(
                "SoundPageEffectsVolumeCheckBoxLabel",
                1078575
            ),
            MusicVolume = label(
                "SoundPageMusicVolumeCheckBoxLabel",
                1078577
            ),
            PlayFootsteps = label(
                "SoundPageToggleFootstepsCheckBoxLabel",
                1078077
            )
        },
        nil,
        {
            MasterVolume = checkBox(
                "SoundPageMasterVolumeCheckBox",
                function (newValue)
                    return UserSoundSettings.masterEnabled(newValue)
                end
            ),
            EffectsVolume = checkBox(
                "SoundPageEffectsVolumeCheckBox",
                function (newValue)
                    return UserSoundSettings.effectsEnabled(newValue)
                end
            ),
            MusicVolume = checkBox(
                "SoundPageMusicVolumeCheckBox",
                function (newValue)
                    return UserSoundSettings.musicEnabled(newValue)
                end
            ),
            PlayFootsteps = checkBox(
                "SoundPageToggleFootstepsCheckBox",
                function (newValue)
                    return UserSoundSettings.footstepsEnabled(newValue)
                end
            )
        },
        {
            MasterVolume = slider(
                "SoundPageMasterVolumeSliderBar",
                "SoundPageMasterVolumeSliderValue",
                function(newValue)
                    return UserSoundSettings.masterVolume(newValue)
                end,
                function (value)
                    return StringFormatter.toWString(
                        math.floor(
                            100 * value
                        )
                    )
                end
            ),
            EffectsVolume = slider(
                "SoundPageEffectsVolumeSliderBar",
                "SoundPageEffectsVolumeSliderValue",
                function(newValue)
                    return UserSoundSettings.effectsVolume(newValue)
                end,
                function (value)
                    return StringFormatter.toWString(
                        math.floor(
                            100 * value
                        )
                    )
                end
            ),
            MusicVolume = slider(
                "SoundPageMusicVolumeSliderBar",
                "SoundPageMusicVolumeSliderValue",
                function(newValue)
                    return UserSoundSettings.musicVolume(newValue)
                end,
                function (value)
                    return StringFormatter.toWString(
                        math.floor(
                            100 * value
                        )
                    )
                end
            )
        }
    ),
    Controls = page(
        "ControlsPage",
        {
            ScrollWheelUp = label(
                "ControlsPageScrollUpComboLabel",
                1111944
            ),
            ScrollWheelDown = label(
                "ControlsPageScrollDownComboLabel",
                1111945
            )
        },
        {
            ScrollWheelUp = comboBox(
                "ControlsPageScrollUpComboBox",
                function()
                    local list = {}
                    local scrollWheelBehaviors = UserControlSettings.scrollWheelBehaviors()

                    for i = 1, #scrollWheelBehaviors do
                        table.insert(
                            list,
                            scrollWheelBehaviors[i].tid
                        )
                    end

                    return list
                end,
                function (index)
                    local scrollWheelBehaviors = UserControlSettings.scrollWheelBehaviors()
                    local item = scrollWheelBehaviors[index]
                    return item.id == UserControlSettings.mouseScrollUpAction()
                end,
                function(newValue)
                    if newValue == nil then
                        return UserControlSettings.mouseScrollUpAction()
                    else
                        return UserControlSettings.mouseScrollUpAction(
                            UserControlSettings.scrollWheelBehaviors()[newValue].id
                        )
                    end
                end
            ),
            ScrollWheelDown = comboBox(
                "ControlsPageScrollDownComboBox",
                function()
                    local list = {}
                    local scrollWheelBehaviors = UserControlSettings.scrollWheelBehaviors()

                    for i = 1, #scrollWheelBehaviors do
                        table.insert(
                            list,
                            scrollWheelBehaviors[i].tid
                        )
                    end

                    return list
                end,
                function (index)
                    local scrollWheelBehaviors = UserControlSettings.scrollWheelBehaviors()
                    local item = scrollWheelBehaviors[index]
                    return item.id == UserControlSettings.mouseScrollDownAction()
                end,
                function(newValue)
                    if newValue == nil then
                        return UserControlSettings.mouseScrollDownAction()
                    else
                        return UserControlSettings.mouseScrollDownAction(
                            UserControlSettings.scrollWheelBehaviors()[newValue].id
                        )
                    end
                end
            )
        }
    )
}

function UusCorpSettingsWindow.initialize()
    WindowApi.destroyWindow("TipoftheDayWindow")

    local defaultSettings = "SettingsWindow"

    UusCorpCore.overrideFunctions(SettingsWindow)

    WindowApi.unregisterEventHandler(
        "Root",
        Events.profanityListUpdated()
    )

    WindowApi.unregisterEventHandler(
        defaultSettings,
        Events.keyRecordCanceled()
    )

    WindowApi.unregisterEventHandler(
        defaultSettings,
        Events.userSettingsUpdated()
    )

    WindowApi.unregisterEventHandler(
        defaultSettings,
        Events.keyRecorded()
    )

    WindowApi.unregisterEventHandler(
        defaultSettings,
        Events.toggleUserPreference()
    )

    UusCorpCore.loadResources(
        "/src/mods/settings",
        "UusCorpSettingsWindow.xml"
    )

    --- Overriding settings that don't add much value
    UserOptionsSettings.genericGumpScale(1.2)
    UserOptionsSettings.uiScale(1.0)
    UserOptionsSettings.partyInvitePopUp(true)
    UserOptionsSettings.objectHandleQuantity(-1)
    UserOptionsSettings.showTooltips(false)
    UserOptionsSettings.showTipOfTheDay(false)

    WindowApi.createWindow(UusCorpSettingsWindow.name, false)
    EventApi.broadcast(Events.userSettingsUpdated())
end

function UusCorpSettingsWindow.onInitialize()
    UusCorpSettingsWindow:registerEvent(
        Events.userSettingsUpdated(),
        "onSettingsUpdate"
    )

    for _, v in pairs(UusCorpSettingsWindow.Pages) do
        if v.labels ~= nil then
            for _, l in pairs(v.labels) do
                LabelApi.setText(
                    l.name,
                    l.text
                )
            end
        end

        if v.checkBoxes ~= nil then
            for _, c in pairs(v.checkBoxes) do
                ButtonApi.setChecked(
                    c.name,
                    c.setting()
                )
                ButtonApi.setStayDown(
                    c.name,
                    true
                )
            end
        end

        if v.comboBoxes ~= nil then
            for _, c in pairs(v.comboBoxes) do
                local list = c.list()

                for i = 1, #list do
                    local item = list[i]

                    ComboBoxApi.addItem(
                        c.name,
                        item
                    )

                    if c.isSelected(i) then
                        ComboBoxApi.setSelectedItem(
                            c.name,
                            i
                        )
                    end
                end
            end
        end

        if v.sliders ~= nil then
            for _, s in pairs(v.sliders) do
                LabelApi.setText(
                    s.value,
                    s.formatValue(
                        s.setting()
                    )
                )
                SliderApi.setPosition(
                    s.name,
                    s.setting()
                )
            end
        end
    end

    for _, v in pairs(UusCorpSettingsWindow.Tabs) do
        ButtonApi.setText(
            v.name,
            v.text
        )
        WindowApi.setShowing(v.page, UusCorpSettingsWindow.SelectedTab == v)
        ButtonApi.setChecked(v.name, UusCorpSettingsWindow.SelectedTab == v)
    end

    ScrollWindowApi.updateScrollRect(UusCorpSettingsWindow.name .. "Graphics")
    UusCorpControlsSettingsWindow.onInitialize()
end

function UusCorpSettingsWindow.onShutdown()
    UusCorpSettingsWindow:unregisterEvent(
        Events.userSettingsUpdated()
    )
    UusCorpControlsSettingsWindow.onShutdown()
end

function UusCorpSettingsWindow.onRightClick()
    UusCorpSettingsWindow:setShowing(false)
end

function UusCorpSettingsWindow.onTabClick()
    local window = Active.window()

    if window == UusCorpSettingsWindow.SelectedTab.name then
        return
    end

    for _, v in pairs(UusCorpSettingsWindow.Tabs) do
        if v.name == window then
            UusCorpSettingsWindow.SelectedTab = v
            break
        end
    end

    for _, v in pairs(UusCorpSettingsWindow.Tabs) do
        WindowApi.setShowing(v.page, UusCorpSettingsWindow.SelectedTab == v)
        ButtonApi.setChecked(v.name, UusCorpSettingsWindow.SelectedTab == v)
    end
end

function UusCorpSettingsWindow.onSettingsUpdate()
    --Some settings (Show Mob Shadows, for example) are bugged.
    --Applying them will fail and changes will not reflect until you
    --log in/out. For this reason, we use pcall to catch the error.
    pcall(function ()
        if SettingsApi.settingsChanged() then
            InterfaceCore.ReloadUI()
        end
    end)
end

function UusCorpSettingsWindow.onCheckBoxClicked()
    local active = Active.window()
    local parent = WindowApi.getParent(active)

    for _, v in pairs(UusCorpSettingsWindow.Pages) do
        if parent == v.name then
            for _, c in pairs(v.checkBoxes) do
                if c.name == active then
                    c.setting(not c.setting())
                    ButtonApi.setChecked(
                        c.name,
                        c.setting()
                    )
                    EventApi.broadcast(Events.userSettingsUpdated())
                    break
                end
            end
        end
    end
end

function UusCorpSettingsWindow.onComboBoxChanged(index)
    local active = Active.window()
    local parent = WindowApi.getParent(
        WindowApi.getParent(
            active
        )
    )

    for _, v in pairs(UusCorpSettingsWindow.Pages) do
        if parent == v.name then
            for _, c in pairs(v.comboBoxes) do
                if c.name == active then
                    c.setting(index)
                    EventApi.broadcast(Events.userSettingsUpdated())
                    break
                end
            end
        end
    end
end

function UusCorpSettingsWindow.onSliderChanged(position)
    local active = Active.window()
    local parent = WindowApi.getParent(
        WindowApi.getParent(
            active
        )
    )

    for _, v in pairs(UusCorpSettingsWindow.Pages) do
        if parent == v.name then
            for _, s in pairs(v.sliders) do
                if s.name == active then
                    LabelApi.setText(
                        s.value,
                        s.formatValue(
                            position
                        )
                    )

                    s.setting(position)

                    EventApi.broadcast(Events.userSettingsUpdated())
                    break
                end
            end
        end
    end
end