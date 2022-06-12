ChatWindow = {}
ChatWindow.Name = "ChatWindow"
ChatWindow.CurrentChannel = Chat.Channels.Say
ChatWindow.ChannelLabel = ChatWindow.Name .. "ChannelLabel"
ChatWindow.TextInput = ChatWindow.Name .. "TextInput"
ChatWindow.InputBackground = ChatWindow.TextInput .. "Background"
ChatWindow.LogDisplay = ChatWindow.Name .. "Log"
ChatWindow.Row = ChatWindow.Name .. "Row"

function ChatWindow.onInitialize()
    WindowApi.registerEventHandler(
        ChatWindow.Name,
        Events.chatEnterStart(),
        "ChatWindow.onEnterChatText"
    )

    WindowApi.registerEventHandler(
        ChatWindow.Name,
        Events.textArrived(),
        "ChatWindow.onTextArrived"
    )

    WindowApi.registerEventHandler(
        ChatWindow.Name,
        Events.userSettingsUpdated(),
        "ChatWindow.onUserSettingsUpdated"
    )

    WindowApi.registerEventHandler(
        ChatWindow.Name,
        Events.gChatRosterUpdate(),
        "ChatWindow.onGChatRosterUpdate"
    )

    TextLogApi.enableLog(Chat.Log)

    LabelApi.setText(ChatWindow.ChannelLabel, ChatWindow.CurrentChannel.display .. ":")
    LabelApi.setTextColor(ChatWindow.ChannelLabel, ChatWindow.CurrentChannel.color)
    ChatWindow.clearFocus()
    EditTextBoxApi.setTextColor(ChatWindow.TextInput, ChatWindow.CurrentChannel.color)
end

function ChatWindow.onShutdown()
    TextLogApi.clearLog(Chat.Log)
end

function ChatWindow.onEnterChatText()
    WindowApi.setShowing(ChatWindow.ChannelLabel, true)
    WindowApi.setShowing(ChatWindow.TextInput, true)
    WindowApi.setShowing(ChatWindow.InputBackground, true)
    WindowApi.assignFocus(ChatWindow.TextInput, true)
end

function ChatWindow.onTextArrived()
    WindowApi.createFromTemplate(
        ChatWindow.Row .. TextLogApi.getNumEntries(Chat.Log) - 1,
        "ChatRowTemplate",
        ChatWindow.LogDisplay
    )
end

function ChatWindow.onRowInitialize()
    local numEntries = TextLogApi.getNumEntries(Chat.Log) - 1

    local _, _, text = TextLogApi.getEntry(Chat.Log, numEntries)

    WindowApi.setId(Active.window(), numEntries)

    WindowApi.startAlphaAnimation(
        Active.window(),
        Animation.singleNoReset(),
        1.0,
        0,
        3,
        false,
        15,
        0
    )

    WindowApi.clearAnchors(Active.window())

    if numEntries >= 1 then
        WindowApi.addAnchor(
            ChatWindow.Row .. numEntries - 1,
            "topleft",
            Active.window(),
            "bottomleft",
            0,
            0
        )
    end

    LabelApi.setText(Active.window() .. "ItemText", text)
end

function ChatWindow.onRowUpdate()
    if (WindowApi.getAlpha(Active.window()) <= 0) then
        WindowApi.destroyWindow(Active.window())
    end
end

function ChatWindow.onUserSettingsUpdated()

end

function ChatWindow.onGChatRosterUpdate()

end

function ChatWindow.sendChat()
    local text = tostring(EditTextBoxApi.getText(Active.window()))

    if text == nil or #text == 0 then
        ChatWindow.clearFocus()
        return
    end

    ChatApi.send(ChatWindow.CurrentChannel.command, EditTextBoxApi.getText(Active.window()))
    EditTextBoxApi.setText(Active.window())
    ChatWindow.clearFocus()
end

function ChatWindow.onTextChanged(text)
    local words = tostring(text)

    if words == nil or #words == 0 then
        return
    end

    for k, v in pairs(Chat.Channels) do
        if v.prefix ~= nil and v.command ~= nil then
            local prefix = words:sub(1, #v.prefix)

            if prefix == v.prefix then
                if ChatWindow.CurrentChannel.filter ~= v.filter then
                    ChatWindow.CurrentChannel = Chat.Channels[k]
                    LabelApi.setText(ChatWindow.ChannelLabel, ChatWindow.CurrentChannel.display .. ":")
                    LabelApi.setTextColor(ChatWindow.ChannelLabel, ChatWindow.CurrentChannel.color)
                    EditTextBoxApi.setText(Active.window(), words:sub(#v.prefix + 1, #words))
                    EditTextBoxApi.setTextColor(Active.window(), ChatWindow.CurrentChannel.color)
                end
                break
            end
        end
    end
end

function ChatWindow.clearFocus()
    WindowApi.setShowing(ChatWindow.ChannelLabel, false)
    WindowApi.setShowing(ChatWindow.TextInput, false)
    WindowApi.setShowing(ChatWindow.InputBackground, false)
    WindowApi.assignFocus(ChatWindow.TextInput, false)
end