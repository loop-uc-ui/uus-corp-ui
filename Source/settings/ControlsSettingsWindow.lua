ControlsSettingsWindow = {}

ControlsSettingsWindow.Name = SettingsWindow.Name .. "ControlsPage"

ControlsSettingsWindow.List = ControlsSettingsWindow.Name .. "List"

ControlsSettingsWindow.Keybindings = {}

local recordingKey = nil

local function toggleRecordingTextColor()
    if recordingKey == nil then
        return
    end

    local color = Colors.CoreBlue

    if UserControlSettings.isRecording() then
        color = Colors.YellowDark
    end

    LabelApi.setTextColor(
        recordingKey .. "ItemLabel",
        color
    )
    LabelApi.setTextColor(
        recordingKey .. "ItemValue",
        color
    )
end

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
    recordingKey = nil
    UserControlSettings.isRecording(false)
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
        local id = WindowApi.getId(recordingKey)
        local key = UserControlSettings.recordedKey()
        local binding = UserControlSettings.Keybindings[id]

        if binding.type ~= nil then
            for k, _ in pairs(UserControlSettings.recordedKeybindings()) do
                if binding.type == k then
                    UserControlSettings.recordedKeybindings()[k] = key
                    LabelApi.setText(
                        recordingKey .. "ItemValue",
                        key
                    )
                    EventApi.broadcast(
                        Events.keybindingsUpdated()
                    )
                    break
                end
            end
        end
    end
    UserControlSettings.isRecording(false)
    toggleRecordingTextColor()
    recordingKey = nil
end

function ControlsSettingsWindow.onKeyRecordCanceled()
    UserControlSettings.isRecording(false)
    toggleRecordingTextColor()
    recordingKey = nil
end

function ControlsSettingsWindow.onKeybindingClick()
    if not UserControlSettings.isRecording() then
        recordingKey = Active.window()
        UserControlSettings.isRecording(true)
        toggleRecordingTextColor()
        EventApi.broadcast(
            Events.keyRecord()
        )
    end
end