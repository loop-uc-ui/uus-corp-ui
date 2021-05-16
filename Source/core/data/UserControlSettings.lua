UserControlSettings = {}

UserControlSettings.ScrollWheelBehaviors = {
    SystemData.Settings.GameOptions.MOUSESCROLL_ZOOM_IN_CAMERA,
    SystemData.Settings.GameOptions.MOUSESCROLL_ZOOM_OUT_CAMERA,
    SystemData.Settings.GameOptions.MOUSESCROLL_TARGET_NEXT_FRIENDLY,
    SystemData.Settings.GameOptions.MOUSESCROLL_TARGET_LAST_FRIENDLY,
    SystemData.Settings.GameOptions.MOUSESCROLL_TARGET_NEXT_ENEMY,
    SystemData.Settings.GameOptions.MOUSESCROLL_TARGET_LAST_ENEMY,
    SystemData.Settings.GameOptions.MOUSESCROLL_TARGET_NEXT_ANY,
    SystemData.Settings.GameOptions.MOUSESCROLL_TARGET_LAST_ANY,
    SystemData.Settings.GameOptions.MOUSESCROLL_CURSOR_TARGET_LAST,
    SystemData.Settings.GameOptions.MOUSESCROLL_CURSOR_TARGET_SELF,
    SystemData.Settings.GameOptions.MOUSESCROLL_CURSOR_TARGET_CURRENT,
    SystemData.Settings.GameOptions.MOUSESCROLL_CYCLE_CURSOR_TARGET,
    SystemData.Settings.GameOptions.MOUSESCROLL_CLEAR_TARGET_QUEUE,
    SystemData.Settings.GameOptions.MOUSESCROLL_NONE
}

UserControlSettings.Keybindings = TableFormatter:sortTable(SystemData.Settings.Keybindings)

function UserControlSettings.mouseScrollUpAction(newValue)
    if newValue ~= nil then
        SystemData.Settings.GameOptions.mouseScrollUpAction = newValue
    end
    return SystemData.Settings.GameOptions.mouseScrollUpAction
end

function UserControlSettings.mouseScrollDownAction(newValue)
    if newValue ~= nil then
        SystemData.Settings.GameOptions.mouseScrollDownAction = newValue
    end
    return SystemData.Settings.GameOptions.mouseScrollDownAction
end

function UserControlSettings.isRecording(newValue)
    if newValue ~= nil then
        SystemData.IsRecordingSettings = newValue
    end
    return SystemData.IsRecordingSettings
end

function UserControlSettings.resetKeyBindings()
    ResetMMOKeyBinding()
    SystemData.Settings.Keybindings = SystemData.Settings.DefaultKeybindings
    UserControlSettings.Keybindings = TableFormatter:sortTable(SystemData.Settings.Keybindings)
end

function UserControlSettings.updateKeyBindings(bindings)
    if next(bindings) ~= nil then
        for _, v in pairs(bindings) do
            SystemData.Settings.Keybindings[v.key] = v.value
        end
        UserControlSettings.Keybindings = TableFormatter:sortTable(SystemData.Settings.Keybindings)
    end
end
