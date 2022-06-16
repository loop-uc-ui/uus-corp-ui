GraphicsSettingsWindow = {}

GraphicsSettingsWindow.Name = SettingsWindow.Name .. "GraphicsPage"

GraphicsSettingsWindow.Container = GraphicsSettingsWindow.Name .. "Container"

GraphicsSettingsWindow.Labels = {
    Resolution = GraphicsSettingsWindow.Container .. "ResLabel",
    UseFullScreen = GraphicsSettingsWindow.Container .. "FullScreenLabel"
}

GraphicsSettingsWindow.ComboBoxes = {
    Resolution = GraphicsSettingsWindow.Container .. "ResCombo"
}

GraphicsSettingsWindow.CheckBoxes = {
    UseFullScreen = GraphicsSettingsWindow.Container .. "FullScreenCheckBox"
}

GraphicsSettingsWindow.TextIds = {
    UseFullScreen = 1077821
}

function GraphicsSettingsWindow.onInitialize()
    LabelApi.setText(
        GraphicsSettingsWindow.Labels.Resolution,
        "Resolution"
    )

    LabelApi.setText(
        GraphicsSettingsWindow.Labels.UseFullScreen,
        GraphicsSettingsWindow.TextIds.UseFullScreen
    )

    ButtonApi.setChecked(
        GraphicsSettingsWindow.CheckBoxes.UseFullScreen,
        UserGraphicsSettings.fullScreen()
    )

    ButtonApi.setStayDown(
        GraphicsSettingsWindow.CheckBoxes.UseFullScreen,
        true
    )

    for i = 1, #UserGraphicsSettings.availableResolutions().widths do
        local width = UserGraphicsSettings.availableResolutions().widths[i]
        local height = UserGraphicsSettings.availableResolutions().heights[i]

        ComboBoxApi.addItem(
            GraphicsSettingsWindow.ComboBoxes.Resolution,
            width .. " x " .. height
        )

        local resolution = UserGraphicsSettings.resolution()

        if width == resolution.width and height == resolution.height then
            ComboBoxApi.setSelectedItem(
                GraphicsSettingsWindow.ComboBoxes.Resolution,
                i
            )
        end
    end
end

function GraphicsSettingsWindow.onResolutionChanged(index)
    local width = UserGraphicsSettings.availableResolutions().widths[index]
    local height = UserGraphicsSettings.availableResolutions().heights[index]
    UserGraphicsSettings.resolution({
        width = width,
        height = height
    })
    EventApi.broadcast(Events.userSettingsUpdated())
end

function GraphicsSettingsWindow.onFullScreenCheck()
    UserGraphicsSettings.fullScreen(not UserGraphicsSettings.fullScreen())

    ButtonApi.setChecked(
        GraphicsSettingsWindow.CheckBoxes.UseFullScreen,
        UserGraphicsSettings.fullScreen()
    )

    EventApi.broadcast(Events.userSettingsUpdated())
end