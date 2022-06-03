Chat = {}

function Chat.filters()
    return SystemData.ChatLogFilters
end

function Chat.filterCustom()
    return Chat.filters().CUSTOM
end

function Chat.fitlerGuild()
    return Chat.filters().GUILD
end

function Chat.filterEmote()
    return Chat.filters().EMOTE
end

function Chat.filterGameMaster()
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