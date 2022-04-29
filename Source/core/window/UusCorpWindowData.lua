UusCorpWindowData = {}
UusCorpWindowData.__index = UusCorpWindowData

function UusCorpWindowData.new(type, id)
    return setmetatable({
        type = type,
        id = id
    }, UusCorpWindowData)
end