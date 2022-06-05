local function channel(filter, display, prefix, command)
    return {
        filter = filter,
        display = display,
        prefix = prefix,
        command = command
    }

end

Chat = {}

function Chat.filters()
    return SystemData.ChatLogFilters
end

function Chat.filtersCustom()
    return Chat.filters().CUSTOM
end

function Chat.filtersGuild()
    return Chat.filters().GUILD
end

function Chat.filtersEmote()
    return Chat.filters().EMOTE
end

function Chat.filtersGameMaster()
    return Chat.filters().GM
end

function Chat.filtersParty()
    return Chat.filters().PARTY
end

function Chat.filtersGlobal()
    return Chat.filters().GLOBAL_CHAT
end

function Chat.filtersYell()
    return Chat.filters().YELL
end

function Chat.filtersAlliance()
    return Chat.filters().ALLIANCE
end

function Chat.filtersGesture()
    return Chat.filters().GESTURE
end

function Chat.filtersWhisper()
    return Chat.filters().WHISPER
end

function Chat.filtersSay()
    return Chat.filters().SAY
end

function Chat.filtersPrivate()
    return Chat.filters().PRIVATE
end

function Chat.filtersSystem()
    return Chat.filters().SYSTEM
end

Chat.Channels = {
    Say = channel(
        Chat.filtersSay(),
        "Say",
        "/s",
        "/say"
    ),
    Whisper = channel(
        Chat.filtersWhisper(),
        "Whisper",
        "/w",
        "/whisper"
    ),
    Party = channel(
        Chat.filtersParty(),
        "Party",
        "/p",
        "/party"
    ),
    Guild = channel(
        Chat.filtersGuild(),
        "Guild",
        "/g",
        "/guild"
    ),
    Alliance = channel(
        Chat.filtersAlliance(),
        "Alliance",
        "/a",
        "/alliance"
    ),
    Emote = channel(
        Chat.filtersEmote(),
        "Emote",
        "/e",
        "/emote"
    ),
    Yell = channel(
        Chat.filtersYell(),
        "Yell",
        "/y",
        "/yell"
    ),
    GameMaster = channel(
        Chat.filtersGameMaster(),
        "Game Master",
        "/gm",
        "/gm"
    ),
    Custom = channel(
        Chat.filtersCustom(),
        "Custom",
        "/c",
        "/chat"
    ),
    Chat = channel(
        Chat.filtersGlobal(),
        "Chat",
        "/x",
        "/x"
    )
}