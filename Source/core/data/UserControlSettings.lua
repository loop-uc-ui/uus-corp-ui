UserControlSettings = {}

UserControlSettings.Keybindings = TableFormatter:sortTable(SystemData.Settings.Keybindings)

function UserControlSettings.scrollWheelBehaviors()
    return  {
        {
            id = SystemData.Settings.GameOptions.MOUSESCROLL_ZOOM_IN_CAMERA,
            tid = 1079288
        },
        {
            id = SystemData.Settings.GameOptions.MOUSESCROLL_ZOOM_OUT_CAMERA,
            tid = 1079289

        },
        {
            id = SystemData.Settings.GameOptions.MOUSESCROLL_TARGET_NEXT_FRIENDLY,
            tid = 1079177
        },
        {
            id = SystemData.Settings.GameOptions.MOUSESCROLL_TARGET_LAST_FRIENDLY,
            tid = 1111940
        },
        {
            id = SystemData.Settings.GameOptions.MOUSESCROLL_TARGET_NEXT_ENEMY,
            tid = 1079178
        },
        {
            id = SystemData.Settings.GameOptions.MOUSESCROLL_TARGET_LAST_ENEMY,
            tid = 1111941
        },
        {
            id = SystemData.Settings.GameOptions.MOUSESCROLL_TARGET_NEXT_ANY,
            tid = 1094824
        },
        {
            id = SystemData.Settings.GameOptions.MOUSESCROLL_TARGET_LAST_ANY,
            tid = 1111942
        },
        {
            id = SystemData.Settings.GameOptions.MOUSESCROLL_CURSOR_TARGET_LAST,
            tid = 1079156
        },
        {
            id = SystemData.Settings.GameOptions.MOUSESCROLL_CURSOR_TARGET_SELF,
            tid = 1079158
        },
        {
            id = SystemData.Settings.GameOptions.MOUSESCROLL_CURSOR_TARGET_CURRENT,
            tid = 1079157
        },
        {
            id = SystemData.Settings.GameOptions.MOUSESCROLL_CYCLE_CURSOR_TARGET,
            tid = 1112413
        },
        {
            id = SystemData.Settings.GameOptions.MOUSESCROLL_CLEAR_TARGET_QUEUE,
            tid = 1115342
        },
        {
            id = SystemData.Settings.GameOptions.MOUSESCROLL_NONE,
            tid = 1011051
        }
    }
end

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
