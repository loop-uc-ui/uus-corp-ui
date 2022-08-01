ControlsSettingsWindow = {}

ControlsSettingsWindow.Name = SettingsWindow.Name .. "ControlsPage"

ControlsSettingsWindow.List = ControlsSettingsWindow.Name .. "List"

ControlsSettingsWindow.Keybindings = {}

function ControlsSettingsWindow.onInitialize()
    local order = {}

    for i = 1, #UserControlSettings.Keybindings do
        local item = UserControlSettings.Keybindings[i]

        if item.type ~= nil then
            table.insert(
                ControlsSettingsWindow.Keybindings,
                i,
                {
                    label = StringFormatter.fromTid(item.tid),
                    value = StringFormatter.toWString(
                        UserControlSettings.updateKeyBindings()[item.type]
                    )
                }
            )

            table.insert(
                order,
                i
            )
        end
    end

    ListBoxApi.setDisplayOrder(
        ControlsSettingsWindow.List,
        order
    )
end

function ControlsSettingsWindow.onShutdown()
    ControlsSettingsWindow.Keybindings = {}
end