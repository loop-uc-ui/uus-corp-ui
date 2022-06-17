ControlsSettingsWindow = {}

ControlsSettingsWindow.Name = SettingsWindow.Name .. "ControlsPage"

ControlsSettingsWindow.Container = ControlsSettingsWindow.Name .. "Container"

ControlsSettingsWindow.Labels = {
    ScrollWheelUp = ControlsSettingsWindow.Container .. "ScrollUpLabel",
    ScrollWheelDown = ControlsSettingsWindow.Container .. "ScrollDownLabel"
}

ControlsSettingsWindow.ComboBoxes = {
    ScrollWheelUp = ControlsSettingsWindow.Container .. "ScrollUpCombo",
    ScrollWheelDown = ControlsSettingsWindow.Container .. "ScrollDownCombo"
}

ControlsSettingsWindow.TextIds = {
    ScrollWheelUp = 1111944,
    ScrollWheelDown = 1111945
}

function ControlsSettingsWindow.onInitialize()
    LabelApi.setText(
        ControlsSettingsWindow.Labels.ScrollWheelUp,
        ControlsSettingsWindow.TextIds.ScrollWheelUp
    )

    LabelApi.setText(
        ControlsSettingsWindow.Labels.ScrollWheelDown,
        ControlsSettingsWindow.TextIds.ScrollWheelDown
    )

    local scrollWheelBehaviors = UserControlSettings.scrollWheelBehaviors()

    for i = 1, #scrollWheelBehaviors do
        local item = scrollWheelBehaviors[i]
        ComboBoxApi.addItem(
            ControlsSettingsWindow.ComboBoxes.ScrollWheelUp,
            item.tid
        )

        if item.id == UserControlSettings.mouseScrollUpAction() then
            ComboBoxApi.setSelectedItem(
                ControlsSettingsWindow.ComboBoxes.ScrollWheelUp,
                i
            )
        end

        ComboBoxApi.addItem(
            ControlsSettingsWindow.ComboBoxes.ScrollWheelDown,
            item.tid
        )

        if item.id == UserControlSettings.mouseScrollDownAction() then
            ComboBoxApi.setSelectedItem(
                ControlsSettingsWindow.ComboBoxes.ScrollWheelDown,
                i
            )
        end
    end
end

function ControlsSettingsWindow.onScrollChanged(index)
    local item = UserControlSettings.scrollWheelBehaviors()[index]
    if Active.window() == ControlsSettingsWindow.ComboBoxes.ScrollWheelUp then
        UserControlSettings.mouseScrollUpAction(item.id)
    elseif Active.window() == ControlsSettingsWindow.ComboBoxes.ScrollWheelDown then
        UserControlSettings.mouseScrollDownAction(item.id)
    end
    EventApi.broadcast(Events.userSettingsUpdated())
end