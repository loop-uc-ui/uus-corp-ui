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

    WindowApi.registerEventHandler(
        Active.window(),
        Events.keyRecorded(),
        "ControlsSettingsWindow.onKeyRecorded"
    )

    WindowApi.registerEventHandler(
        Active.window(),
        Events.keyRecordCanceled(),
        "ControlsSettingsWindow.onKeyRecordCanceled"
    )
end

function ControlsSettingsWindow.onShutdown()
    ControlsSettingsWindow.Keybindings = {}
    WindowApi.unregisterEventHandler(
        Active.window(),
        Events.keyRecorded()
    )
    WindowApi.unregisterEventHandler(
        Active.window(),
        Events.keyRecordCanceled()
    )
end

function ControlsSettingsWindow.onPopulateKeybindings(data)
    for k, v in ipairs(data) do
        local row = ControlsSettingsWindow.List .. "Row" .. k
        WindowApi.setId(row, v)
    end
end

function ControlsSettingsWindow.onKeyRecorded()
    if ControlsSettingsWindow.Keybindings ~= L"" then
        
    end
end

function ControlsSettingsWindow.onKeyRecordCanceled()

end

function ControlsSettingsWindow.onKeybindingClick()
    UserControlSettings.isRecording(true)
    EventApi.broadcast(
        Events.keyRecord()
    )
end