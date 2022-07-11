GraphicsSettingsWindow = {}

GraphicsSettingsWindow.Name = SettingsWindow.Name .. "GraphicsPage"

GraphicsSettingsWindow.Container = GraphicsSettingsWindow.Name .. "Container"

GraphicsSettingsWindow.Labels = {
    Resolution = {
        name = GraphicsSettingsWindow.Container .. "ResLabel",
        text = "Resolution"
    },
    UseFullScreen = {
        name = GraphicsSettingsWindow.Container .. "FullScreenLabel",
        text = 1077821
    },
    PlayFlyingAnimation = {
        name = GraphicsSettingsWindow.Container .. "FlyingAnimationLabel",
        text = 1158627
    },
    ShowWindowFrame = {
        name = GraphicsSettingsWindow.Container .. "WindowFrameLabel",
        text = 1077820
    },
    HouseContents = {
        name = GraphicsSettingsWindow.Container .. "HouseContentsLabel",
        text = 1159003
    },
    DeathEffect = {
        name = GraphicsSettingsWindow.Container .. "DeathEffectLabel",
        text = 1115993
    }
}

GraphicsSettingsWindow.ComboBoxes = {
    Resolution = {
        name = GraphicsSettingsWindow.Container .. "ResCombo",
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
    }
}

GraphicsSettingsWindow.CheckBoxes = {
    UseFullScreen = {
        name = GraphicsSettingsWindow.Container .. "FullScreenCheckBox",
        setting = function(newValue)
            return UserGraphicsSettings.fullScreen(newValue)
        end
    },
    PlayFlyingAnimation = {
        name = GraphicsSettingsWindow.Container .. "FlyingAnimationCheckBox",
        setting = function (newValue)
            return UserGraphicsSettings.flyingAnimation(newValue)
        end
    },
    ShowWindowFrame = {
        name = GraphicsSettingsWindow.Container .. "WindowFrameCheckBox",
        setting = function (newValue)
            return UserGraphicsSettings.showFrame(newValue)
        end
    },
    HouseContents = {
        name = GraphicsSettingsWindow.Container .. "HouseContentsCheckBox",
        setting = function (newValue)
            return UserGraphicsSettings.displayHousingContents(newValue)
        end
    },
    DeathEffect = {
        name = GraphicsSettingsWindow.Container .. "DeathEffectCheckBox",
        setting = function (newValue)
            return UserGraphicsSettings.hardwareDeathEffect(newValue)
        end
    }
}

function GraphicsSettingsWindow.onInitialize()
    for _, v in pairs(GraphicsSettingsWindow.Labels) do
        LabelApi.setText(
            v.name,
            v.text
        )
    end

    for _, v in pairs(GraphicsSettingsWindow.CheckBoxes) do
        ButtonApi.setChecked(
            v.name,
            v.setting()
        )
        ButtonApi.setStayDown(
            v.name,
            true
        )
    end

    for _, v in pairs(GraphicsSettingsWindow.ComboBoxes) do
        local list = v.list()

        for i = 1, #list do
            local item = list[i]

            ComboBoxApi.addItem(
                v.name,
                item
            )

            if v.isSelected(i) then
                ComboBoxApi.setSelectedItem(
                    v.name,
                    i
                )
            end
        end
    end
end

function GraphicsSettingsWindow.onGraphicSettingChanged(index)
    for _, v in pairs(GraphicsSettingsWindow.ComboBoxes) do
        if v.name == Active.window() then
            v.setting(index)
            EventApi.broadcast(Events.userSettingsUpdated())
            break
        end
    end
end

function GraphicsSettingsWindow.onGraphicSettingChecked()
    for _, v in pairs(GraphicsSettingsWindow.CheckBoxes) do
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