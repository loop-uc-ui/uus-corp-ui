ChatWindow = {}
ChatWindow.Name = "ChatWindow"
ChatWindow.CurrentChannel = Chat.Channels.Say
ChatWindow.ChannelLabel = ChatWindow.Name .. "ChannelLabel"

local LOG = "Chat"

local LOG_DISPLAY = ChatWindow.Name .. "Log"

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

    TextLogApi.enableLog(LOG_DISPLAY)

    LogDisplayApi.addLog(LOG_DISPLAY, LOG)

    for _, v in pairs(Chat.filters()) do
        LogDisplayApi.setFilterState(
            LOG_DISPLAY,
            LOG,
            v,
            true
        )
    end

    LabelApi.setText(ChatWindow.ChannelLabel, ChatWindow.CurrentChannel.display .. ":")
end

function ChatWindow.onShutdown()
    TextLogApi.clearLog(LOG_DISPLAY)
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
    ChatApi.send(ChatWindow.CurrentChannel.command, EditTextBoxApi.getText(Active.window()))
    EditTextBoxApi.setText(Active.window())
end