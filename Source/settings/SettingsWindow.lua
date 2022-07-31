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
        page = SettingsWindow.Name .. "SoundPage"
    },
    Chat = {
        text = "Chat",
        name = SettingsWindow.TabContainer .. "ChatTab",
        page = SettingsWindow.Name .. "Chat"
    },
    Controls = {
        text = "Controls",
        name = SettingsWindow.TabContainer .. "ControlsTab",
        page = SettingsWindow.Name .. "ControlsPage"
    },
    Interface = {
        text = "Interface",
        name = SettingsWindow.TabContainer .. "InterfaceTab",
        page = SettingsWindow.Name .. "InterfacePage"
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