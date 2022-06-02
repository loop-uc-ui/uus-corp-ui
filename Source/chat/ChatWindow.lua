ChatWindow = {}
ChatWindow.Name = "ChatWindow"

function ChatWindow.Initialize()
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

    for _, v in pairs(Chat.filters()) do
        LogApi.setFilterState(
            ChatWindow.Name .. "Log",
            "Chat",
            v,
            true
        )
    end

    ChatApi.send("/say", "test")
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
    ChatApi.send("/say", EditTextBoxApi.getText(Active.window()))
    EditTextBoxApi.setText(Active.window())
end