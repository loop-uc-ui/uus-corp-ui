UusCorpControlsSettingsWindow = {}

UusCorpControlsSettingsWindow.Name = "UusCorpSettingsWindowControlsPage"

UusCorpControlsSettingsWindow.List = UusCorpControlsSettingsWindow.Name .. "List"

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

local function updateBindings()
    for i = 1, #UserControlSettings.Keybindings do
        local item = UserControlSettings.Keybindings[i]
        local name = "KeyBindingRow" .. i

        if WindowApi.createFromTemplate(
            name,
            "KeybindingRowTemplate",
            UusCorpControlsSettingsWindow.List .. "ScrollChild"
        ) and i > 1 then
            WindowApi.addAnchor(
                name,
                "bottom",
                "KeyBindingRow" .. i - 1,
                "top",
                0
            )
        end

        WindowApi.setId(
            name,
            i
        )

        LabelApi.setText(
            name .. "ItemLabel",
            StringFormatter.fromTid(item.tid)
        )

        LabelApi.setText(
            name .. "ItemValue",
            StringFormatter.toWString(
                UserControlSettings.updateKeyBindings()[item.type]
            )
        )
    end
end

function UusCorpControlsSettingsWindow.onInitialize()
    WindowApi.registerEventHandler(
        Active.window(),
        Events.keyRecorded(),
        "UusCorpControlsSettingsWindow.onKeyRecorded"
    )

    WindowApi.registerEventHandler(
        Active.window(),
        Events.keyRecordCanceled(),
        "UusCorpControlsSettingsWindow.onKeyRecordCanceled"
    )

    updateBindings()
    ScrollWindowApi.updateScrollRect(UusCorpControlsSettingsWindow.List)
end

function UusCorpControlsSettingsWindow.onShutdown()
    recordingKey = nil
    UserControlSettings.isRecording(false)
    WindowApi.unregisterEventHandler(
        Active.window(),
        Events.keyRecorded()
    )
    WindowApi.unregisterEventHandler(
        Active.window(),
        Events.keyRecordCanceled()
    )
end

function UusCorpControlsSettingsWindow.onKeyRecorded()
    if UusCorpControlsSettingsWindow.Keybindings ~= L"" then
        local id = WindowApi.getId(recordingKey)
        local key = UserControlSettings.recordedKey()
        local binding = UserControlSettings.Keybindings[id]

        if binding.type ~= nil then
            for k, v in pairs(UserControlSettings.recordedKeybindings()) do
                if key == v then
                    UserControlSettings.recordedKeybindings()[k] = L""
                    break
                end
            end

            UserControlSettings.recordedKeybindings()[binding.type] = key

            LabelApi.setText(
                recordingKey .. "ItemValue",
                key
            )

            EventApi.broadcast(
                Events.keybindingsUpdated()
            )

            updateBindings()
        end
    end

    UserControlSettings.isRecording(false)
    toggleRecordingTextColor()
    recordingKey = nil
end

function UusCorpControlsSettingsWindow.onKeyRecordCanceled()
    UserControlSettings.isRecording(false)
    toggleRecordingTextColor()
    recordingKey = nil
end

function UusCorpControlsSettingsWindow.onKeybindingClick()
    if not UserControlSettings.isRecording() then
        recordingKey = Active.window()
        UserControlSettings.isRecording(true)
        toggleRecordingTextColor()
        EventApi.broadcast(
            Events.keyRecord()
        )
    end
end

function UusCorpControlsSettingsWindow.onReset()
    UserControlSettings.resetKeyBindings()
    updateBindings()
    EventApi.broadcast(Events.userSettingsUpdated())
end