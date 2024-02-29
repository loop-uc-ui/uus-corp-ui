---@class UusCorpViewData
---@field type number
---@field id number
local UusCorpViewData = {}

UusCorpViewDataFactory = {}

---@param id number
---@return UusCorpViewData
function UusCorpViewDataFactory.container(id)
    return { type = Container.type(), id = id }
end

---@return UusCorpViewData
function UusCorpViewDataFactory.playerStatus()
    return { type = PlayerStatus.type(), id = 0}
end