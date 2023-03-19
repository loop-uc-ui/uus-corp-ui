UusCorpSettingsWindow = {}

UusCorpSettingsWindow.Name = "UusCorpSettingsWindow"

UusCorpSettingsWindow.TabContainer = UusCorpSettingsWindow.Name .. "TabContainer"

UusCorpSettingsWindow.Tabs = {
    Graphics = {
        text = "Graphics",
        name = UusCorpSettingsWindow.TabContainer .. "GraphicsTab",
        page = UusCorpSettingsWindow.Name .. "Graphics"
    },
    Sound = {
        text = "Sound",
        name = UusCorpSettingsWindow.TabContainer .. "SoundTab",
        page = UusCorpSettingsWindow.Name .. "Sound"
    },
    Chat = {
        text = "Chat",
        name = UusCorpSettingsWindow.TabContainer .. "ChatTab",
        page = UusCorpSettingsWindow.Name .. "Chat"
    },
    Controls = {
        text = "Controls",
        name = UusCorpSettingsWindow.TabContainer .. "ControlsTab",
        page = UusCorpSettingsWindow.Name .. "Controls"
    },
    Interface = {
        text = "Interface",
        name = UusCorpSettingsWindow.TabContainer .. "InterfaceTab",
        page = UusCorpSettingsWindow.Name .. "Interface"
    }
}

UusCorpSettingsWindow.SelectedTab = UusCorpSettingsWindow.Tabs.Graphics

UusCorpSettingsWindow.Pages = {
    Graphics = {
        name = UusCorpSettingsWindow.Name .. "GraphicsPage",
        labels = {
            Resolution = {
                name = UusCorpSettingsWindow.Name .. "GraphicsPageResComboLabel",
                text = "Resolution"
            },
            UseFullScreen = {
                name = UusCorpSettingsWindow.Name .. "GraphicsPageFullScreenCheckBoxLabel",
                text = 1077821
            },
            PlayFlyingAnimation = {
                name = UusCorpSettingsWindow.Name .. "GraphicsPageFlyingAnimationCheckBoxLabel",
                text = 1158627
            },
            ShowWindowFrame = {
                name = UusCorpSettingsWindow.Name .. "GraphicsPageWindowFrameCheckBoxLabel",
                text = 1077820
            },
            HouseContents = {
                name = UusCorpSettingsWindow.Name .. "GraphicsPageHouseContentsCheckBoxLabel",
                text = 1159003
            },
            DeathEffect = {
                name = UusCorpSettingsWindow.Name .. "GraphicsPageDeathEffectCheckBoxLabel",
                text = 1115993
            },
            VSync = {
                name = UusCorpSettingsWindow.Name .. "GraphicsPageVSyncCheckBoxLabel",
                text = 1112689
            },
            IdleAnimation = {
                name = UusCorpSettingsWindow.Name .. "GraphicsPageIdleAnimationCheckBoxLabel",
                text = 1094692
            },
            Foliage = {
                name = UusCorpSettingsWindow.Name .. "GraphicsPageFoliageCheckBoxLabel",
                text = 1079814
            },
            Shadows = {
                name = UusCorpSettingsWindow.Name .. "GraphicsPageShadowsCheckBoxLabel",
                text = 1079286
            },
            CircleOfTransparency = {
                name = UusCorpSettingsWindow.Name .. "GraphicsPageCircleOfTransparencyCheckBoxLabel",
                text = 1078079
            },
            Brightness = {
                name = UusCorpSettingsWindow.Name .. "GraphicsPageBrightnessSliderLabel",
                text = 3000166
            },
            ParticleDetail = {
                name = UusCorpSettingsWindow.Name .. "GraphicsPageParticleDetailComboLabel",
                text = 1079213
            },
            ParticleFilter = {
                name = UusCorpSettingsWindow.Name .. "GraphicsPageParticleFilterComboLabel",
                text = 1112330
            }
        },
        comboBoxes = {
            Resolution = {
                name = UusCorpSettingsWindow.Name .. "GraphicsPageResComboBox",
                list = function()
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
                isSelected = function(index)
                    local width = UserGraphicsSettings.availableResolutions().widths[index]
                    local height = UserGraphicsSettings.availableResolutions().heights[index]
                    local resolution = UserGraphicsSettings.resolution()
                    return resolution.width == width and resolution.height == height
                end,
                setting = function(newValue)
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
            },
            ParticleDetail = {
                name = UusCorpSettingsWindow.Name .. "GraphicsPageParticleDetailComboBox",
                list = function ()
                    return { 1079210, 1079211, 1079212 }
                end,
                isSelected = function (index)
                    return index == UserGraphicsSettings.particleDetail()
                end,
                setting = function (newValue)
                    return UserGraphicsSettings.particleDetail(newValue)
                end
            },
            ParticleFilter = {
                name = UusCorpSettingsWindow.Name .. "GraphicsPageParticleFilterComboBox",
                list = function ()
                    return { 1112331, 1112332, 1112333, 1112334, 1158020 }
                end,
                isSelected = function (index)
                    return index == UserGraphicsSettings.particleFilter() + 1
                end,
                setting = function (newValue)
                    return UserGraphicsSettings.particleFilter(newValue - 1)
                end
            }
        },
        checkBoxes = {
            UseFullScreen = {
                name = UusCorpSettingsWindow.Name .. "GraphicsPageFullScreenCheckBox",
                setting = function(newValue)
                    return UserGraphicsSettings.fullScreen(newValue)
                end
            },
            PlayFlyingAnimation = {
                name = UusCorpSettingsWindow.Name .. "GraphicsPageFlyingAnimationCheckBox",
                setting = function (newValue)
                    return UserGraphicsSettings.flyingAnimation(newValue)
                end
            },
            ShowWindowFrame = {
                name = UusCorpSettingsWindow.Name .. "GraphicsPageWindowFrameCheckBox",
                setting = function (newValue)
                    return UserGraphicsSettings.showFrame(newValue)
                end
            },
            HouseContents = {
                name = UusCorpSettingsWindow.Name .. "GraphicsPageHouseContentsCheckBox",
                setting = function (newValue)
                    return UserGraphicsSettings.displayHousingContents(newValue)
                end
            },
            DeathEffect = {
                name = UusCorpSettingsWindow.Name .. "GraphicsPageDeathEffectCheckBox",
                setting = function (newValue)
                    return UserGraphicsSettings.hardwareDeathEffect(newValue)
                end
            },
            VSync = {
                name = UusCorpSettingsWindow.Name .. "GraphicsPageVSyncCheckBox",
                setting = function (newValue)
                    return UserGraphicsSettings.enableVSync(newValue)
                end
            },
            IdleAnimation = {
                name = UusCorpSettingsWindow.Name .. "GraphicsPageIdleAnimationCheckBox",
                setting = function (newValue)
                    return UserGraphicsSettings.idleAnimation(newValue)
                end
            },
            Foliage = {
                name = UusCorpSettingsWindow.Name .. "GraphicsPageFoliageCheckBox",
                setting = function (newValue)
                    return UserGraphicsSettings.foliage(newValue)
                end
            },
            Shadows = {
                name = UusCorpSettingsWindow.Name .. "GraphicsPageShadowsCheckBox",
                setting = function (newValue)
                    return UserGraphicsSettings.showShadows(newValue)
                end
            },
            CircleOfTransparency = {
                name = UusCorpSettingsWindow.Name .. "GraphicsPageCircleOfTransparencyCheckBox",
                setting = function (newValue)
                    return UserGraphicsSettings.circleOfTransparency(newValue)
                end
            }
        },
        sliders = {
            Brightness = {
                name = UusCorpSettingsWindow.Name .. "GraphicsPageBrightnessSliderBar",
                value = UusCorpSettingsWindow.Name .. "GraphicsPageBrightnessSliderValue",
                setting = function(newValue)
                    return UserGraphicsSettings.gamma(newValue)
                end,
                formatValue = function(value)
                    return StringFormatter.toTwoDecimalPlaces(
                        StringFormatter.toWString(
                            value
                        )
                    )
                end
            }
        }
    },
    Chat = {
        name =  UusCorpSettingsWindow.Name .. "ChatPage",
        checkBoxes = {
            DisableSpells = {
                name = UusCorpSettingsWindow.Name .. "ChatPageDisableSpellsCheckBox",
                setting = function(newValue)
                    return UserOverheadTextSettings.disableSpells(newValue)
                end
            },
            ShowSpellName = {
                name = UusCorpSettingsWindow.Name .. "ChatPageShowSpellNameCheckBox",
                setting = function(newValue)
                    return UserOverheadTextSettings.showSpellNames(newValue)
                end
            },
            DisablePoisonText = {
                name = UusCorpSettingsWindow.Name .. "ChatPageDisablePoisonTextCheckBox",
                setting = function(newValue)
                    return UserOverheadTextSettings.disablePoison(newValue)
                end
            },
            SaveJournal = {
                name = UusCorpSettingsWindow.Name .. "ChatPageSaveJournalCheckBox",
                setting = function(newValue)
                    return UserOptionsSettings.enableChatLog(newValue)
                end
            }
        },
        labels = {
            DisableSpells = {
                name = UusCorpSettingsWindow.Name .. "ChatPageDisableSpellsCheckBoxLabel",
                text = 1155334
            },
            ShowSpellName = {
                name = UusCorpSettingsWindow.Name .. "ChatPageShowSpellNameCheckBoxLabel",
                text = 1155336
            },
            DisablePoisonText = {
                name = UusCorpSettingsWindow.Name .. "ChatPageDisablePoisonTextCheckBoxLabel",
                text = 1155338
            },
            SaveJournal = {
                name = UusCorpSettingsWindow.Name .. "ChatPageSaveJournalCheckBoxLabel",
                text = 1149998
            }
        }
    },
    Interface = {
        name = UusCorpSettingsWindow.Name .. "InterfacePage",
        comboBoxes = {
            Mod = {
                name = UusCorpSettingsWindow.Name .. "InterfacePageModComboBox",
                list = function()
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
                isSelected = function (index)
                    return UusCorpSettingsWindow.Pages.Interface.comboBoxes.Mod.list()[index]
                        == UserOptionsSettings.customUI()
                end,
                setting = function(newValue)
                    return UserOptionsSettings.customUI(newValue)
                end
            },
            ObjectHandleFilter = {
                name = UusCorpSettingsWindow.Name .. "InterfacePageObjectHandleComboBox",
                list = function ()
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
                isSelected = function (index)
                    return index == UserOptionsSettings.objectHandleFilter() + 1
                end,
                setting = function (newValue)
                    if newValue == nil then
                        return UserOptionsSettings.objectHandleFilter() + 1
                    else
                        return UserOptionsSettings.objectHandleFilter(newValue - 1)
                    end
                end
            }
        },
        checkBoxes = {
            LegacyContainers = {
                name = UusCorpSettingsWindow.Name .. "InterfacePageLegacyContainersCheckBox",
                setting = function(newValue)
                    return  UserContainerSettings.legacyContainers(newValue)
                end
            }
        },
        labels = {
            Mod = {
                name = UusCorpSettingsWindow.Name .. "InterfacePageModComboLabel",
                text = 1079523
            },
            LegacyContainers = {
                name = UusCorpSettingsWindow.Name .. "InterfacePageLegacyContainersCheckBoxLabel",
                text = "Use Legacy Containers"
            },
            ObjectHandleFilter = {
                name = UusCorpSettingsWindow.Name .. "InterfacePageObjectHandleComboLabel",
                text = 1079461
            }
        }
    },
    Sound = {
        name = UusCorpSettingsWindow.Name .. "SoundPage",
        labels = {
            MasterVolume = {
                name = UusCorpSettingsWindow.Name .. "SoundPageMasterVolumeCheckBoxLabel",
                text = 1077823
            },
            EffectsVolume = {
                name = UusCorpSettingsWindow.Name .. "SoundPageEffectsVolumeCheckBoxLabel",
                text = 1078575
            },
            MusicVolume = {
                name = UusCorpSettingsWindow.Name .. "SoundPageMusicVolumeCheckBoxLabel",
                text = 1078577
            },
            PlayFootsteps = {
                name = UusCorpSettingsWindow.Name .. "SoundPageToggleFootstepsCheckBoxLabel",
                text = 1078077
            }
        },
        checkBoxes = {
            MasterVolume = {
                name =  UusCorpSettingsWindow.Name .. "SoundPageMasterVolumeCheckBox",
                setting = function (newValue)
                    return UserSoundSettings.masterEnabled(newValue)
                end
            },
            EffectsVolume = {
                name =  UusCorpSettingsWindow.Name .. "SoundPageEffectsVolumeCheckBox",
                setting = function (newValue)
                    return UserSoundSettings.effectsEnabled(newValue)
                end
            },
            MusicVolume = {
                name =  UusCorpSettingsWindow.Name .. "SoundPageMusicVolumeCheckBox",
                setting = function (newValue)
                    return UserSoundSettings.musicEnabled(newValue)
                end
            },
            PlayFootsteps = {
                name =  UusCorpSettingsWindow.Name .. "SoundPageToggleFootstepsCheckBox",
                setting = function (newValue)
                    return UserSoundSettings.footstepsEnabled(newValue)
                end
            }
        },
        sliders = {
            MasterVolume = {
                name = UusCorpSettingsWindow.Name .. "SoundPageMasterVolumeSliderBar",
                value = UusCorpSettingsWindow.Name .. "SoundPageMasterVolumeSliderValue",
                setting = function(newValue)
                    return UserSoundSettings.masterVolume(newValue)
                end,
                formatValue = function (value)
                    return StringFormatter.toWString(
                        math.floor(
                            100 * value
                        )
                    )
                end
            },
            EffectsVolume = {
                name = UusCorpSettingsWindow.Name .. "SoundPageEffectsVolumeSliderBar",
                value = UusCorpSettingsWindow.Name .. "SoundPageEffectsVolumeSliderValue",
                setting = function(newValue)
                    return UserSoundSettings.effectsVolume(newValue)
                end,
                formatValue = function (value)
                    return StringFormatter.toWString(
                        math.floor(
                            100 * value
                        )
                    )
                end
            },
            MusicVolume = {
                name = UusCorpSettingsWindow.Name .. "SoundPageMusicVolumeSliderBar",
                value = UusCorpSettingsWindow.Name .. "SoundPageMusicVolumeSliderValue",
                setting = function(newValue)
                    return UserSoundSettings.musicVolume(newValue)
                end,
                formatValue = function (value)
                    return StringFormatter.toWString(
                        math.floor(
                            100 * value
                        )
                    )
                end
            }
        }
    },
    Controls = {
        name = UusCorpSettingsWindow.Name .. "ControlsPage",
        labels = {
            ScrollWheelUp = {
                name = UusCorpSettingsWindow.Name .. "ControlsPageScrollUpComboLabel",
                text = 1111944
            },
            ScrollWheelDown = {
                name = UusCorpSettingsWindow.Name .. "ControlsPageScrollDownComboLabel",
                text = 1111945
            }
        },
        comboBoxes = {
            ScrollWheelUp = {
                name = UusCorpSettingsWindow.Name .. "ControlsPageScrollUpComboBox",
                list = function()
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
                isSelected = function (index)
                    local scrollWheelBehaviors = UserControlSettings.scrollWheelBehaviors()
                    local item = scrollWheelBehaviors[index]
                    return item.id == UserControlSettings.mouseScrollUpAction()
                end,
                setting = function(newValue)
                    if newValue == nil then
                        return UserControlSettings.mouseScrollUpAction()
                    else
                        return UserControlSettings.mouseScrollUpAction(
                            UserControlSettings.scrollWheelBehaviors()[newValue].id
                        )
                    end
                end
            },
            ScrollWheelDown = {
                name = UusCorpSettingsWindow.Name .. "ControlsPageScrollDownComboBox",
                list = function()
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
                isSelected = function (index)
                    local scrollWheelBehaviors = UserControlSettings.scrollWheelBehaviors()
                    local item = scrollWheelBehaviors[index]
                    return item.id == UserControlSettings.mouseScrollDownAction()
                end,
                setting = function(newValue)
                    if newValue == nil then
                        return UserControlSettings.mouseScrollDownAction()
                    else
                        return UserControlSettings.mouseScrollDownAction(
                            UserControlSettings.scrollWheelBehaviors()[newValue].id
                        )
                    end
                end
            }
        }
    }
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

    WindowApi.createWindow(UusCorpSettingsWindow.Name, false)
end

function UusCorpSettingsWindow.onInitialize()
    WindowApi.registerEventHandler(
        UusCorpSettingsWindow.Name,
        Events.userSettingsUpdated(),
        "UusCorpSettingsWindow.onSettingsUpdate"
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

    UusCorpControlsSettingsWindow.onInitialize()
end

function UusCorpSettingsWindow.onShutdown()
    WindowApi.unregisterEventHandler(
        UusCorpSettingsWindow.Name,
        Events.userSettingsUpdated()
    )
    UusCorpControlsSettingsWindow.onShutdown()
end

function UusCorpSettingsWindow.onRightClick()
    WindowApi.setShowing(UusCorpSettingsWindow.Name, false)
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