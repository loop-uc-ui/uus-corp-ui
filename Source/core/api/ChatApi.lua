ChatApi = {}

function ChatApi.send(channel, text)
    if type(channel) == "string" then
        channel = StringFormatter.toWString(channel)
    end
    SendChat(channel, text)
end