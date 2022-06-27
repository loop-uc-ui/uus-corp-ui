InterfaceSettingsWindow = {}

InterfaceSettingsWindow.Name = SettingsWindow.Name .. "InterfacePage"

InterfaceSettingsWindow.Container = InterfaceSettingsWindow.Name .. "Container"

InterfaceSettingsWindow.ModCombo = InterfaceSettingsWindow.Container .. "ModCombo"

InterfaceSettingsWindow.Labels = {
    Mod = InterfaceSettingsWindow.Container .. "ModLabel",
    LegacyContainers = InterfaceSettingsWindow.Container .. "LegacyContainersLabel"
}

InterfaceSettingsWindow.CheckBoxes = {
    LegacyContainers = InterfaceSettingsWindow.Container .. "LegacyContainersCheckBox"
}

InterfaceSettingsWindow.TextIds = {
    UseCustom = 1079523,
    Default = 3000094
}

function InterfaceSettingsWindow.onInitialize()
    LabelApi.setText(
        InterfaceSettingsWindow.Labels.Mod,
        InterfaceSettingsWindow.TextIds.UseCustom
    )

    for i = 1, #UserOptionsSettings.customUiList() do
        local text = UserOptionsSettings.customUiList()[i]

        if text == "" then
            ComboBoxApi.addItem(
                InterfaceSettingsWindow.ModCombo,
                InterfaceSettingsWindow.TextIds.Default
            )
        else
            ComboBoxApi.addItem(
                InterfaceSettingsWindow.ModCombo,
                text
            )
        end

        if text == UserOptionsSettings.customUI() then
            ComboBoxApi.setSelectedItem(
                InterfaceSettingsWindow.ModCombo,
                i
            )
        end
    end

    LabelApi.setText(
        InterfaceSettingsWindow.Labels.LegacyContainers,
        "Default to Legacy Containers"
    )

    ButtonApi.setChecked(
        InterfaceSettingsWindow.CheckBoxes.LegacyContainers,
        UserContainerSettings.legacyContainers()
    )

    ButtonApi.setStayDown(
        InterfaceSettingsWindow.CheckBoxes.LegacyContainers,
        true
    )
end

function InterfaceSettingsWindow.onModChanged(index)
    UserOptionsSettings.customUI(index)
    EventApi.broadcast(Events.userSettingsUpdated())
end

function InterfaceSettingsWindow.onLegacyContainersCheck()
    UserContainerSettings.legacyContainers(not UserContainerSettings.legacyContainers())

    ButtonApi.setChecked(
        InterfaceSettingsWindow.CheckBoxes.LegacyContainers,
        UserContainerSettings.legacyContainers()
    )

    EventApi.broadcast(Events.userSettingsUpdated())
end