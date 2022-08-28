SettingsWindow = {}

SettingsWindow.Name = "SettingsWindow"

SettingsWindow.TabContainer = SettingsWindow.Name .. "TabContainer"

SettingsWindow.Tabs = {
    Graphics = {
        text = "Graphics",
        name = SettingsWindow.TabContainer .. "GraphicsTab",
        page = SettingsWindow.Name .. "Graphics"
    },
    Sound = {
        text = "Sound",
        name = SettingsWindow.TabContainer .. "SoundTab",
        page = SettingsWindow.Name .. "Sound"
    },
    Chat = {
        text = "Chat",
        name = SettingsWindow.TabContainer .. "ChatTab",
        page = SettingsWindow.Name .. "Chat"
    },
    Controls = {
        text = "Controls",
        name = SettingsWindow.TabContainer .. "ControlsTab",
        page = SettingsWindow.Name .. "Controls"
    },
    Interface = {
        text = "Interface",
        name = SettingsWindow.TabContainer .. "InterfaceTab",
        page = SettingsWindow.Name .. "Interface"
    }
}

SettingsWindow.SelectedTab = SettingsWindow.Tabs.Graphics

SettingsWindow.Pages = {
    Graphics = {
        name = SettingsWindow.Name .. "GraphicsPage",
        labels = {
            Resolution = {
                name = SettingsWindow.Name .. "GraphicsPageResComboLabel",
                text = "Resolution"
            },
            UseFullScreen = {
                name = SettingsWindow.Name .. "GraphicsPageFullScreenCheckBoxLabel",
                text = 1077821
            },
            PlayFlyingAnimation = {
                name = SettingsWindow.Name .. "GraphicsPageFlyingAnimationCheckBoxLabel",
                text = 1158627
            },
            ShowWindowFrame = {
                name = SettingsWindow.Name .. "GraphicsPageWindowFrameCheckBoxLabel",
                text = 1077820
            },
            HouseContents = {
                name = SettingsWindow.Name .. "GraphicsPageHouseContentsCheckBoxLabel",
                text = 1159003
            },
            DeathEffect = {
                name = SettingsWindow.Name .. "GraphicsPageDeathEffectCheckBoxLabel",
                text = 1115993
            },
            VSync = {
                name = SettingsWindow.Name .. "GraphicsPageVSyncCheckBoxLabel",
                text = 1112689
            },
            IdleAnimation = {
                name = SettingsWindow.Name .. "GraphicsPageIdleAnimationCheckBoxLabel",
                text = 1094692
            },
            Foliage = {
                name = SettingsWindow.Name .. "GraphicsPageFoliageCheckBoxLabel",
                text = 1079814
            },
            Shadows = {
                name = SettingsWindow.Name .. "GraphicsPageShadowsCheckBoxLabel",
                text = 1079286
            },
            CircleOfTransparency = {
                name = SettingsWindow.Name .. "GraphicsPageCircleOfTransparencyCheckBoxLabel",
                text = 1078079
            },
            Brightness = {
                name = SettingsWindow.Name .. "GraphicsPageBrightnessSliderLabel",
                text = 3000166
            },
            ParticleDetail = {
                name = SettingsWindow.Name .. "GraphicsPageParticleDetailComboLabel",
                text = 1079213
            },
            ParticleFilter = {
                name = SettingsWindow.Name .. "GraphicsPageParticleFilterComboLabel",
                text = 1112330
            }
        },
        comboBoxes = {
            Resolution = {
                name = SettingsWindow.Name .. "GraphicsPageResComboBox",
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
                name = SettingsWindow.Name .. "GraphicsPageParticleDetailComboBox",
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
                name = SettingsWindow.Name .. "GraphicsPageParticleFilterComboBox",
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
                name = SettingsWindow.Name .. "GraphicsPageFullScreenCheckBox",
                setting = function(newValue)
                    return UserGraphicsSettings.fullScreen(newValue)
                end
            },
            PlayFlyingAnimation = {
                name = SettingsWindow.Name .. "GraphicsPageFlyingAnimationCheckBox",
                setting = function (newValue)
                    return UserGraphicsSettings.flyingAnimation(newValue)
                end
            },
            ShowWindowFrame = {
                name = SettingsWindow.Name .. "GraphicsPageWindowFrameCheckBox",
                setting = function (newValue)
                    return UserGraphicsSettings.showFrame(newValue)
                end
            },
            HouseContents = {
                name = SettingsWindow.Name .. "GraphicsPageHouseContentsCheckBox",
                setting = function (newValue)
                    return UserGraphicsSettings.displayHousingContents(newValue)
                end
            },
            DeathEffect = {
                name = SettingsWindow.Name .. "GraphicsPageDeathEffectCheckBox",
                setting = function (newValue)
                    return UserGraphicsSettings.hardwareDeathEffect(newValue)
                end
            },
            VSync = {
                name = SettingsWindow.Name .. "GraphicsPageVSyncCheckBox",
                setting = function (newValue)
                    return UserGraphicsSettings.enableVSync(newValue)
                end
            },
            IdleAnimation = {
                name = SettingsWindow.Name .. "GraphicsPageIdleAnimationCheckBox",
                setting = function (newValue)
                    return UserGraphicsSettings.idleAnimation(newValue)
                end
            },
            Foliage = {
                name = SettingsWindow.Name .. "GraphicsPageFoliageCheckBox",
                setting = function (newValue)
                    return UserGraphicsSettings.foliage(newValue)
                end
            },
            Shadows = {
                name = SettingsWindow.Name .. "GraphicsPageShadowsCheckBox",
                setting = function (newValue)
                    return UserGraphicsSettings.showShadows(newValue)
                end
            },
            CircleOfTransparency = {
                name = SettingsWindow.Name .. "GraphicsPageCircleOfTransparencyCheckBox",
                setting = function (newValue)
                    return UserGraphicsSettings.circleOfTransparency(newValue)
                end
            }
        },
        sliders = {
            Brightness = {
                name = SettingsWindow.Name .. "GraphicsPageBrightnessSliderBar",
                value = SettingsWindow.Name .. "GraphicsPageBrightnessSliderValue",
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
        name =  SettingsWindow.Name .. "ChatPage",
        checkBoxes = {
            DisableSpells = {
                name = SettingsWindow.Name .. "ChatPageDisableSpellsCheckBox",
                setting = function(newValue)
                    return UserOverheadTextSettings.disableSpells(newValue)
                end
            },
            ShowSpellName = {
                name = SettingsWindow.Name .. "ChatPageShowSpellNameCheckBox",
                setting = function(newValue)
                    return UserOverheadTextSettings.showSpellNames(newValue)
                end
            },
            DisablePoisonText = {
                name = SettingsWindow.Name .. "ChatPageDisablePoisonTextCheckBox",
                setting = function(newValue)
                    return UserOverheadTextSettings.disablePoison(newValue)
                end
            },
            SaveJournal = {
                name = SettingsWindow.Name .. "ChatPageSaveJournalCheckBox",
                setting = function(newValue)
                    return UserOptionsSettings.enableChatLog(newValue)
                end
            }
        },
        labels = {
            DisableSpells = {
                name = SettingsWindow.Name .. "ChatPageDisableSpellsCheckBoxLabel",
                text = 1155334
            },
            ShowSpellName = {
                name = SettingsWindow.Name .. "ChatPageShowSpellNameCheckBoxLabel",
                text = 1155336
            },
            DisablePoisonText = {
                name = SettingsWindow.Name .. "ChatPageDisablePoisonTextCheckBoxLabel",
                text = 1155338
            },
            SaveJournal = {
                name = SettingsWindow.Name .. "ChatPageSaveJournalCheckBoxLabel",
                text = 1149998
            }
        }
    },
    Interface = {
        name = SettingsWindow.Name .. "InterfacePage",
        comboBoxes = {
            Mod = {
                name = SettingsWindow.Name .. "InterfacePageModComboBox",
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
                    return SettingsWindow.Pages.Interface.comboBoxes.Mod.list()[index]
                        == UserOptionsSettings.customUI()
                end,
                setting = function(newValue)
                    return UserOptionsSettings.customUI(newValue)
                end
            },
            ObjectHandleFilter = {
                name = SettingsWindow.Name .. "InterfacePageObjectHandleComboBox",
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
                name = SettingsWindow.Name .. "InterfacePageLegacyContainersCheckBox",
                setting = function(newValue)
                    return  UserContainerSettings.legacyContainers(newValue)
                end
            }
        },
        labels = {
            Mod = {
                name = SettingsWindow.Name .. "InterfacePageModComboLabel",
                text = 1079523
            },
            LegacyContainers = {
                name = SettingsWindow.Name .. "InterfacePageLegacyContainersCheckBoxLabel",
                text = "Use Legacy Containers"
            },
            ObjectHandleFilter = {
                name = SettingsWindow.Name .. "InterfacePageObjectHandleComboLabel",
                text = 1079461
            }
        }
    },
    Sound = {
        name = SettingsWindow.Name .. "SoundPage",
        labels = {
            MasterVolume = {
                name = SettingsWindow.Name .. "SoundPageMasterVolumeCheckBoxLabel",
                text = 1077823
            },
            EffectsVolume = {
                name = SettingsWindow.Name .. "SoundPageEffectsVolumeCheckBoxLabel",
                text = 1078575
            },
            MusicVolume = {
                name = SettingsWindow.Name .. "SoundPageMusicVolumeCheckBoxLabel",
                text = 1078577
            },
            PlayFootsteps = {
                name = SettingsWindow.Name .. "SoundPageToggleFootstepsCheckBoxLabel",
                text = 1078077
            }
        },
        checkBoxes = {
            MasterVolume = {
                name =  SettingsWindow.Name .. "SoundPageMasterVolumeCheckBox",
                setting = function (newValue)
                    return UserSoundSettings.masterEnabled(newValue)
                end
            },
            EffectsVolume = {
                name =  SettingsWindow.Name .. "SoundPageEffectsVolumeCheckBox",
                setting = function (newValue)
                    return UserSoundSettings.effectsEnabled(newValue)
                end
            },
            MusicVolume = {
                name =  SettingsWindow.Name .. "SoundPageMusicVolumeCheckBox",
                setting = function (newValue)
                    return UserSoundSettings.musicEnabled(newValue)
                end
            },
            PlayFootsteps = {
                name =  SettingsWindow.Name .. "SoundPageToggleFootstepsCheckBox",
                setting = function (newValue)
                    return UserSoundSettings.footstepsEnabled(newValue)
                end
            }
        },
        sliders = {
            MasterVolume = {
                name = SettingsWindow.Name .. "SoundPageMasterVolumeSliderBar",
                value = SettingsWindow.Name .. "SoundPageMasterVolumeSliderValue",
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
                name = SettingsWindow.Name .. "SoundPageEffectsVolumeSliderBar",
                value = SettingsWindow.Name .. "SoundPageEffectsVolumeSliderValue",
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
                name = SettingsWindow.Name .. "SoundPageMusicVolumeSliderBar",
                value = SettingsWindow.Name .. "SoundPageMusicVolumeSliderValue",
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
        name = SettingsWindow.Name .. "ControlsPage",
        labels = {
            ScrollWheelUp = {
                name = SettingsWindow.Name .. "ControlsPageScrollUpComboLabel",
                text = 1111944
            },
            ScrollWheelDown = {
                name = SettingsWindow.Name .. "ControlsPageScrollDownComboLabel",
                text = 1111945
            }
        },
        comboBoxes = {
            ScrollWheelUp = {
                name = SettingsWindow.Name .. "ControlsPageScrollUpComboBox",
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
                name = SettingsWindow.Name .. "ControlsPageScrollDownComboBox",
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

function SettingsWindow.onInitialize()
    WindowApi.registerEventHandler(
        SettingsWindow.Name,
        Events.userSettingsUpdated(),
        "SettingsWindow.onSettingsUpdate"
    )

    for _, v in pairs(SettingsWindow.Pages) do
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

    for _, v in pairs(SettingsWindow.Tabs) do
        ButtonApi.setText(
            v.name,
            v.text
        )
        WindowApi.setShowing(v.page, SettingsWindow.SelectedTab == v)
        ButtonApi.setChecked(v.name, SettingsWindow.SelectedTab == v)
    end
end

function SettingsWindow.onShutdown()
    WindowApi.unregisterEventHandler(
        SettingsWindow.Name,
        Events.userSettingsUpdated()
    )
end

function SettingsWindow.onRightClick()
    WindowApi.destroyWindow(SettingsWindow.Name)
end

function SettingsWindow.onTabClick()
    local window = Active.window()

    if window == SettingsWindow.SelectedTab.name then
        return
    end

    for _, v in pairs(SettingsWindow.Tabs) do
        if v.name == window then
            SettingsWindow.SelectedTab = v
            break
        end
    end

    for _, v in pairs(SettingsWindow.Tabs) do
        WindowApi.setShowing(v.page, SettingsWindow.SelectedTab == v)
        ButtonApi.setChecked(v.name, SettingsWindow.SelectedTab == v)
    end
end

function SettingsWindow.onSettingsUpdate()
    --Some settings (Show Mob Shadows, for example) are bugged.
    --Applying them will fail and changes will not reflect until you
    --log in/out. For this reason, we use pcall to catch the error.
    pcall(function ()
        if SettingsApi.settingsChanged() then
            InterfaceCore.ReloadUI()
        end
    end)
end

function SettingsWindow.onCheckBoxClicked()
    local active = Active.window()
    local parent = WindowApi.getParent(active)

    for _, v in pairs(SettingsWindow.Pages) do
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

function SettingsWindow.onComboBoxChanged(index)
    local active = Active.window()
    local parent = WindowApi.getParent(
        WindowApi.getParent(
            active
        )
    )

    for _, v in pairs(SettingsWindow.Pages) do
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

function SettingsWindow.onSliderChanged(position)
    local active = Active.window()
    local parent = WindowApi.getParent(
        WindowApi.getParent(
            active
        )
    )

    for _, v in pairs(SettingsWindow.Pages) do
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