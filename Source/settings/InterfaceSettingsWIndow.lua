InterfaceSettingsWindow = {}

InterfaceSettingsWindow.Name = SettingsWindow.Name .. "InterfacePage"

InterfaceSettingsWindow.Container = InterfaceSettingsWindow.Name .. "Container"

InterfaceSettingsWindow.ModLabel = InterfaceSettingsWindow.Container .. "ModLabel"

InterfaceSettingsWindow.ModCombo = InterfaceSettingsWindow.Container .. "ModCombo"

InterfaceSettingsWindow.TextIds = {
    UseCustom = 1079523,
    Default = 3000094
}

function InterfaceSettingsWindow.onInitialize()
    LabelApi.setText(
        InterfaceSettingsWindow.ModLabel,
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
end

function InterfaceSettingsWindow.onModChanged(index)
    UserOptionsSettings.customUI(index)
    InterfaceCore.ReloadUI()
end