local function channel(filter, display, prefix, command, color)
    return {
        filter = filter,
        display = display,
        prefix = prefix,
        command = command,
        color = color
    }

end

Chat = {}

Chat.Log = "Chat"

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
        "/s ",
        "/say",
        {
            r = 215,
            g = 215,
            b = 1
        }
    ),
    Whisper = channel(
        Chat.filtersWhisper(),
        "Whisper",
        "/w ",
        "/tell",
        {
            r = 215,
            g = 215,
            b = 1
        }
    ),
    Party = channel(
        Chat.filtersParty(),
        "Party",
        "/p ",
        "/party",
        {
            r = 56,
            g = 191,
            b = 40
        }
    ),
    Guild = channel(
        Chat.filtersGuild(),
        "Guild",
        "/g ",
        "/guild",
        {
            r = 96,
            g = 231,
            b = 0
        }
    ),
    Alliance = channel(
        Chat.filtersAlliance(),
        "Alliance",
        "/a ",
        "/alliance",
        {
            r = 48,
            g = 215,
            b = 231
        }
    ),
    Emote = channel(
        Chat.filtersEmote(),
        "Emote",
        "/e ",
        "/emote",
        {
            r = 215,
            g = 215,
            b = 1
        }
    ),
    Yell = channel(
        Chat.filtersYell(),
        "Yell",
        "/y ",
        "/yell",
        {
            r = 215,
            g = 215,
            b = 1
        }
    ),
    GameMaster = channel(
        Chat.filtersGameMaster(),
        "Game Master",
        "/gm ",
        "/gm",
        {
            r = 232,
            g = 48,
            b = 88
        }
    ),
    Chat = channel(
        Chat.filtersCustom(),
        "Chat",
        "/c ",
        "/chat",
        {
            r = 75,
            g = 120,
            b = 230
        }
    ),
    Global = channel(
        Chat.filtersGlobal(),
        "Global",
        "/x ",
        "/x",
        {
            r = 75,
            g = 120,
            b = 230
        }
    ),
    System = channel(
        Chat.filtersSystem(),
        "System",
        nil,
        nil,
        {
            r = 255,
            g = 255,
            b = 255
        }
    ),
    Private = channel(
        Chat.filtersParty(),
        "Private",
        nil,
        nil,
        {
            r = 2-7,
            g = 56,
            b = 223
        }
    ),
    Gesture = channel(
        Chat.filtersGesture(),
        "Gesture",
        nil,
        nil,
        {
            r = 215,
            g = 215,
            b = 1
        }
    )
}