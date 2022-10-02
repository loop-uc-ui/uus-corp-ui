UserControlSettings = {}

--[[
    Table copied from default UI.
    The table that comes to us from the client is not sorted
    neatly into functional areas. Additionally, it contains
    entries that we do not want the user to be able to change
    (Escape as'Cancel', for example).
]]--
UserControlSettings.Keybindings = {}

UserControlSettings.Keybindings[1] = { name = "MoveUp", tid = 1077791, type = "FORWARD" }
UserControlSettings.Keybindings[2] = { name = "MoveDown", tid = 1077792, type = "BACKWARD" }
UserControlSettings.Keybindings[3] = { name = "MoveLeft", tid = 1077793, type = "LEFT" }
UserControlSettings.Keybindings[4] = { name = "MoveRight", tid = 1077794, type = "RIGHT" }

UserControlSettings.Keybindings[5] = { name = "AttackMode", tid = 1077813, type = "MELEE_ATTACK" }
UserControlSettings.Keybindings[6] = { name = "PrimaryAttack", tid = 1079153, type = "USE_PRIMARY_ATTACK" }
UserControlSettings.Keybindings[7] = { name = "SecondaryAttack", tid = 1079154, type = "USE_SECONDARY_ATTACK" }

UserControlSettings.Keybindings[8] = { name = "NextGroupTarget", tid = 1079155, type = "NEXT_GROUP_TARGET" }
UserControlSettings.Keybindings[9] = { name = "NextEnemy", tid = 1077807, type = "NEXT_ENEMY_TARGET" }
UserControlSettings.Keybindings[10] = { name = "NextFriend", tid = 1077809, type = "NEXT_FRIENDLY_TARGET" }
UserControlSettings.Keybindings[11] = { name = "NextFollower", tid = 1112417, type = "NEXT_FOLLOWER_TARGET" }
UserControlSettings.Keybindings[12] = { name = "NextObject", tid = 1112424, type = "NEXT_OBJECT_TARGET" }
UserControlSettings.Keybindings[13] = { name = "NextTarget", tid = 1094822, type = "NEXT_TARGET" }

UserControlSettings.Keybindings[14] = { name = "PreviousGroupTarget", tid = 1112425, type = "PREVIOUS_GROUP_TARGET" }
UserControlSettings.Keybindings[15] = { name = "PreviousEnemy", tid = 1112426, type = "PREVIOUS_ENEMY_TARGET" }
UserControlSettings.Keybindings[16] = { name = "PreviousFriend", tid = 1112427, type = "PREVIOUS_FRIENDLY_TARGET" }
UserControlSettings.Keybindings[17] = { name = "PreviousFollower", tid = 1112428, type = "PREVIOUS_FOLLOWER_TARGET" }
UserControlSettings.Keybindings[18] = { name = "PreviousObject", tid = 1112429, type = "PREVIOUS_OBJECT_TARGET" }
UserControlSettings.Keybindings[19] = { name = "PreviousTarget", tid = 1112430, type = "PREVIOUS_TARGET" }

UserControlSettings.Keybindings[20] = { name = "NearestGroup", tid = 1112418, type = "NEAREST_GROUP_TARGET" }
UserControlSettings.Keybindings[21] = { name = "NearestEnemy", tid = 1077811, type = "NEAREST_ENEMY_TARGET" }
UserControlSettings.Keybindings[22] = { name = "NearestFriend", tid = 1077812, type = "NEAREST_FRIENDLY_TARGET" }
UserControlSettings.Keybindings[23] = { name = "NearestFollower", tid = 1112419, type = "NEAREST_FOLLOWER_TARGET" }
UserControlSettings.Keybindings[24] = { name = "NearestObject", tid = 1112423, type = "NEAREST_OBJECT_TARGET" }
UserControlSettings.Keybindings[25] = { name = "NearestTarget", tid = 1094823, type = "NEAREST_TARGET" }

UserControlSettings.Keybindings[26] = { name = "TargetSelf", tid = 1077801, type = "TARGET_SELF" }
UserControlSettings.Keybindings[27] = { name = "TargetG1", tid = 1077802, type = "TARGET_GROUP_MEMBER_1" }
UserControlSettings.Keybindings[28] = { name = "TargetG2", tid = 1077803, type = "TARGET_GROUP_MEMBER_2" }
UserControlSettings.Keybindings[29] = { name = "TargetG3", tid = 1077804, type = "TARGET_GROUP_MEMBER_3" }
UserControlSettings.Keybindings[30] = { name = "TargetG4", tid = 1077805, type = "TARGET_GROUP_MEMBER_4" }
UserControlSettings.Keybindings[31] = { name = "TargetG5", tid = 1077806, type = "TARGET_GROUP_MEMBER_5" }
UserControlSettings.Keybindings[32] = { name = "TargetG6", tid = 1079147, type = "TARGET_GROUP_MEMBER_6" }
UserControlSettings.Keybindings[33] = { name = "TargetG7", tid = 1079148, type = "TARGET_GROUP_MEMBER_7" }
UserControlSettings.Keybindings[34] = { name = "TargetG8", tid = 1079149, type = "TARGET_GROUP_MEMBER_8" }
UserControlSettings.Keybindings[35] = { name = "TargetG9", tid = 1079150, type = "TARGET_GROUP_MEMBER_9" }

UserControlSettings.Keybindings[36] = { name = "CursorTargetCurrent", tid = 1115345, type = "CURSOR_TARGET_CURRENT" }
UserControlSettings.Keybindings[37] = { name = "CursorTargetLast", tid = 1115346, type = "CURSOR_TARGET_LAST" }
UserControlSettings.Keybindings[38] = { name = "CursorTargetSelf", tid = 1115347, type = "CURSOR_TARGET_SELF" }
UserControlSettings.Keybindings[39] = {
    name = "CycleLastCursorTarget",
    tid = 1115348,
    type = "CYCLE_LAST_CURSOR_TARGET"
}
UserControlSettings.Keybindings[40] = { name = "ClearTargetQueue", tid = 1115349, type = "CLEAR_TARGET_QUEUE" }

UserControlSettings.Keybindings[41] = { name = "CharacterWin", tid = 1077795, type = "PAPERDOLL_CHARACTER_WINDOW" }
UserControlSettings.Keybindings[42] = { name = "BackpackWin", tid = 1077796, type = "BACKPACK_WINDOW" }
UserControlSettings.Keybindings[43] = { name = "SkillsWin", tid = 1078992, type = "SKILLS_WINDOW" }
UserControlSettings.Keybindings[44] = { name = "ToggleMap", tid = 1078993, type = "WORLD_MAP_WINDOW" }
UserControlSettings.Keybindings[45] = { name = "QuestLogWin", tid = 1077799, type = "QUEST_LOG_WINDOW" }

UserControlSettings.Keybindings[46] = { name = "ToggleAlwaysRun", tid = 1113150, type = "TOGGLE_ALWAYS_RUN" }

UserControlSettings.Keybindings[47] = { name = "ZoomIn", tid = 1079288, type = "ZOOM_IN" }
UserControlSettings.Keybindings[48] = { name = "ZoomOut", tid = 1079289, type = "ZOOM_OUT" }
UserControlSettings.Keybindings[49] = { name = "ZoomReset", tid = 1079290, type = "ZOOM_RESET" }

UserControlSettings.Keybindings[50] = { name = "Screenshot", tid = 1079819, type = "SCREENSHOT" }
UserControlSettings.Keybindings[51] = { name = "ToggleInterface", tid = 1079817, type = "TOGGLE_UI" }
UserControlSettings.Keybindings[52] = { name = "ReloadInterface", tid = 1079820, type = "RELOAD_UI" }
UserControlSettings.Keybindings[53] = { name = "ToggleCoT", tid = 1079818, type = "TOGGLE_CIRCLE_OF_TRANSPARENCY" }
UserControlSettings.Keybindings[54] = { name = "CycleChatForward", tid = 1115574, type = "CYCLE_CHAT_FORWARD" }
UserControlSettings.Keybindings[55] = { name = "CycleChatBackward", tid = 1115575, type = "CYCLE_CHAT_BACKWARD" }

UserControlSettings.Keybindings[56] = { name = "QuitGame", tid = 1114308, type = "QUIT_GAME" }
UserControlSettings.Keybindings[57] = { name = "LogOut", tid = 1115334, type = "LOG_OUT" }

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

function UserControlSettings.recordedKey()
    return SystemData.RecordedKey
end

function UserControlSettings.bindingConflictIndex()
    return SystemData.BindingConflictItemIndex
end

function UserControlSettings.bindingConflictType()
    return SystemData.BindingConflictType
end

function UserControlSettings.resetKeyBindings()
    ResetMMOKeyBinding()
    SystemData.Settings.Keybindings = SystemData.Settings.DefaultKeybindings
    UserControlSettings.Keybindings = TableFormatter:sortTable(SystemData.Settings.Keybindings)
end

function UserControlSettings.recordedKeybindings()
    return SystemData.Settings.Keybindings
end

function UserContainerSettings.defaultKeybindings()
    return SystemData.Settings.DefaultKeybindings
end

function UserControlSettings.updateKeyBindings(bindings)
    if bindings ~= nil and next(bindings) ~= nil then
        for _, v in pairs(bindings) do
            SystemData.Settings.Keybindings[v.key] = v.value
        end
    end

    return SystemData.Settings.Keybindings
end
