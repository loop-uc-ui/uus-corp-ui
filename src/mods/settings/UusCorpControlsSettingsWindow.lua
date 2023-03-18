UusCorpControlsSettingsWindow = {}

UusCorpControlsSettingsWindow.Name = "SettingsWindowControlsPage"

UusCorpControlsSettingsWindow.List = UusCorpControlsSettingsWindow.Name .. "List"

UusCorpControlsSettingsWindow.Keybindings = {}

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
    local order = {}

    for i = 1, #UserControlSettings.Keybindings do
        local item = UserControlSettings.Keybindings[i]

        if item.type ~= nil then
            table.insert(
                UusCorpControlsSettingsWindow.Keybindings,
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
        UusCorpControlsSettingsWindow.List,
        order
    )
end

function UusCorpControlsSettingsWindow.onInitialize()
    updateBindings()
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
end

function UusCorpControlsSettingsWindow.onShutdown()
    recordingKey = nil
    UserControlSettings.isRecording(false)
    UusCorpControlsSettingsWindow.Keybindings = {}
    WindowApi.unregisterEventHandler(
        Active.window(),
        Events.keyRecorded()
    )
    WindowApi.unregisterEventHandler(
        Active.window(),
        Events.keyRecordCanceled()
    )
end

function UusCorpControlsSettingsWindow.onPopulateKeybindings(data)
    for k, v in ipairs(data) do
        local row = UusCorpControlsSettingsWindow.List .. "Row" .. k
        WindowApi.setId(row, v)
    end
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