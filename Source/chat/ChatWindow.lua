ChatWindow = {}
ChatWindow.Name = "ChatWindow"
ChatWindow.CurrentChannel = Chat.Channels.Say
ChatWindow.ChannelLabel = ChatWindow.Name .. "ChannelLabel"
ChatWindow.TextInput = ChatWindow.Name .. "TextInput"
ChatWindow.LogDisplay = ChatWindow.Name .. "Log"

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

    TextLogApi.enableLog(ChatWindow.LogDisplay)

    LogDisplayApi.addLog(ChatWindow.LogDisplay, Chat.Log)

    for _, v in pairs(Chat.Channels) do
        LogDisplayApi.setFilterState(
            ChatWindow.LogDisplay,
            Chat.Log,
            v.filter,
            true
        )

        LogDisplayApi.setFilterColor(
            ChatWindow.LogDisplay,
            Chat.Log,
            v.filter,
            v.color
        )
    end

    LabelApi.setText(ChatWindow.ChannelLabel, ChatWindow.CurrentChannel.display .. ":")
    LabelApi.setTextColor(ChatWindow.ChannelLabel, ChatWindow.CurrentChannel.color)
    EditTextBoxApi.setTextColor(ChatWindow.TextInput, ChatWindow.CurrentChannel.color)
end

function ChatWindow.onShutdown()
    TextLogApi.clearLog(ChatWindow.LogDisplay)
end

function ChatWindow.onEnterChatText()

end

function ChatWindow.onTextArrived()

end

function ChatWindow.onUserSettingsUpdated()

end

function ChatWindow.onGChatRosterUpdate()

end

function ChatWindow.sendChat()
    local text = tostring(EditTextBoxApi.getText(Active.window()))

    if text == nil or #text == 0 then
        return
    end

    ChatApi.send(ChatWindow.CurrentChannel.command, EditTextBoxApi.getText(Active.window()))
    EditTextBoxApi.setText(Active.window())
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