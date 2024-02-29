---@class UusCorpEvent
---@field event number
---@field callback string
local UusCorpEvent = {
    event = 0,
    callback = ""
}

UusCorpEventFactory = {}

---@return UusCorpEvent
function UusCorpEventFactory.container()
    return { event = Container.event(), callback = "UusCorpEventHandler.onUpdateContainer" }
end

---@return UusCorpEvent
function UusCorpEventFactory.playerStatus()
    return { event = PlayerStatus.event(), callback = "UusCorpEventHandler.onUpdatePlayerStatus" }
end

---@return UusCorpEvent
function UusCorpEventFactory.objectInfo()
    return { event = ObjectInfo.event(), callback = "UusCorpEventHandler.onUpdateObjectInfo" }
end