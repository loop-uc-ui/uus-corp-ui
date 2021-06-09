SettingsKeyBindingsWindow = ListWindow:new(SettingsWindow.WINDOWS.KeyBindings)

local mouseComboBoxes = {
    ScrollUp = "SettingsKeyBindingsScrollWheelUpCombo",
    ScrollDown = "SettingsKeyBindingsScrollWheelDownCombo"
}

local keyBindingValues = {} do
    for i = 1, #UserControlSettings.Keybindings do
        keyBindingValues[i] = "SettingsKeyBindings"..i.."ActionValue"
    end
end

local keyBindingLabels = {} do
    for i = 1, #UserControlSettings.Keybindings do
        keyBindingLabels[i] = "SettingsKeyBindings"..i.."Action"
    end
end

local keyBinder

local keyBindingRequest = {}

local keyBindings = {}

local function refreshKeyBindingViews()
    for i = 1, #UserControlSettings.Keybindings do
        local binding = UserControlSettings.Keybindings[i].value
        if binding ~= nil then
            SettingsKeyBindingsWindow.adapter:addLabel(
                    keyBindingValues[i],
                    binding,
                    255,
                    255,
                    255
            )
            SettingsKeyBindingsWindow.adapter.views[keyBindingValues[i]].tag = UserControlSettings.Keybindings[i].key
        end
    end
end

function SettingsKeyBindingsWindow.Initialize()
    keyBindingRequest = {}
    SettingsKeyBindingsWindow.adapter:addLabel("SettingsKeyBindingsMouseSubSectionLabel", 1094694)
           :addLabel("SettingsKeyBindingsKeyboardSubSectionLabel", 1077816)
           :addLabel("SettingsKeyBindingsScrollWheelUpLabel", 1111944)
           :addLabel("SettingsKeyBindingsScrollWheelDownLabel", 1111945)
           :addLabel("SettingsKeyDefaultWindowMMOKeysName", 1111866)

    SettingsKeyBindingsWindow:setOffset(0):updateScrollRect()

    local scrollWheelBehaviors = {
        1079288,
        1079289,
        1079177,
        1111940,
        1079178,
        1111941,
        1094824,
        1111942,
        1079156,
        1079158,
        1079157,
        1112413,
        1115342,
        1011051
    }

    SettingsKeyBindingsWindow.adapter:addComboBox(
            mouseComboBoxes.ScrollUp,
            scrollWheelBehaviors,
            1
    )
           :addComboBox(
            mouseComboBoxes.ScrollDown,
            scrollWheelBehaviors,
            2
    )

    for i = 1, #UserControlSettings.Keybindings do
        SettingsKeyBindingsWindow.adapter:addLabel(
                keyBindingLabels[i],
                StringFormatter.toLower(
                        StringFormatter:replaceChar(
                                UserControlSettings.Keybindings[i].key,
                                "_",
                                " "
                        )
                )
        )
    end

    keyBinder = KeyBinder:new(
            SettingsKeyBindingsWindow.id,
            "SettingsKeyBindingsWindow.KeyRecorded",
            "SettingsKeyBindingsWindow.KeyCancelRecord"
    )
end

function SettingsKeyBindingsWindow.UpdateSettings()
    for i = 1, #UserControlSettings.ScrollWheelBehaviors do
        if (UserControlSettings.mouseScrollUpAction() == UserControlSettings.ScrollWheelBehaviors[i]) then
            SettingsKeyBindingsWindow.adapter.views[mouseComboBoxes.ScrollUp]:setSelectedItem(i)
        end
    end

    for i = 1, #UserControlSettings.ScrollWheelBehaviors do
        if (UserControlSettings.mouseScrollDownAction() == UserControlSettings.ScrollWheelBehaviors[i]) then
            SettingsKeyBindingsWindow.adapter.views[mouseComboBoxes.ScrollDown]:setSelectedItem(i)
        end
    end

    refreshKeyBindingViews()
    keyBindings = UserControlSettings.Keybindings
end

function SettingsKeyBindingsWindow.UpdateKeyBindings()
    UserControlSettings.updateKeyBindings(keyBindings)
end

function SettingsKeyBindingsWindow.OnApplyButton()
    SettingsKeyBindingsWindow.UpdateKeyBindings()
    refreshKeyBindingViews()
    UserControlSettings.mouseScrollUpAction(
            SettingsKeyBindingsWindow.adapter.views[mouseComboBoxes.ScrollUp]:getSelectedItem() - 1
    )
    UserControlSettings.mouseScrollDownAction(
            SettingsKeyBindingsWindow.adapter.views[mouseComboBoxes.ScrollDown]:getSelectedItem() - 1
    )
    keyBindingRequest = {}
end

function SettingsKeyBindingsWindow.ClearTempKeybindings()
    for key = 1, #UserControlSettings.Keybindings do
        UserControlSettings.Keybindings[key].newValue = nil
    end
end

function SettingsKeyBindingsWindow.OnKeyPicked()
    local keyIndex = -1
    for key = 1, #UserControlSettings.Keybindings do
        if SystemData.ActiveWindow.name == "SettingsKeyBindings"..key then
            keyIndex = key
            break
        end
    end

    if keyIndex == -1 then
        return
    end

    SettingsKeyBindingsWindow.adapter.views[keyBindingLabels[keyIndex]]:setTextColor(250, 250, 0)
    SettingsKeyBindingsWindow.adapter.views[keyBindingValues[keyIndex]]:setTextColor(250, 250, 0)
    keyBindingRequest = {
        index = keyIndex,
        key = SettingsKeyBindingsWindow.adapter.views[keyBindingValues[keyIndex]].tag
    }
    keyBinder:onKeyPicked(
            "topleft",
            SystemData.ActiveWindow.name.."ActionValue",
            "bottomleft",
            0,
            -6
    )
end

function SettingsKeyBindingsWindow.KeyRecorded()
    SettingsKeyBindingsWindow.adapter.views[keyBindingLabels[keyBindingRequest.index]]:setTextColor(
            255,
            255,
            255
    )
    SettingsKeyBindingsWindow.adapter.views[keyBindingValues[keyBindingRequest.index]]:setTextColor(
            255,
            255,
            255
    )
    keyBinder:onKeyRecorded(
            KeyBinder.BindTypes.BINDTYPE_SETTINGS,
            keyBindings,
            keyBindingRequest,
            SettingsKeyBindingsWindow.id,
            L"KeyBinding Conflict",
            function ()
                SettingsKeyBindingsWindow.adapter.views[keyBindingValues[keyBindingRequest.index]]:setText(keyBinder.recordedKey())
                keyBindings[keyBindingRequest.index].value = keyBinder.recordedKey()
            end
    )
end

function SettingsKeyBindingsWindow.KeyCancelRecord()
    if keyBindingRequest.index ~= nil then
        SettingsKeyBindingsWindow.adapter.views[keyBindingLabels[keyBindingRequest.index]]:setTextColor(
                255,
                255,
                255
        )
        SettingsKeyBindingsWindow.adapter.views[keyBindingValues[keyBindingRequest.index]]:setTextColor(
                255,
                255,
                255
        )
    end
    keyBinder:onKeyCanceled()
end

function SettingsKeyBindingsWindow.OnDefaultKeyPressed()
    local yesButton = {
        textTid = TextIds.YES,
        callback = function()
            UserControlSettings.resetKeyBindings()
            refreshKeyBindingViews()
            keyBindings = UserControlSettings.Keybindings
        end
    }
    local noButton = {
        textTid = TextIds.NO
    }
    local windowData = {
        windowName = SettingsKeyBindingsWindow.id,
        titleTid = TextIds.INFO,
        bodyTid = 1094698,
        buttons = { yesButton, noButton }
    }
    UO_StandardDialog.CreateDialog( windowData )
end