---@param id number
---@return UusCorpObjectInfo
UusCorpObjectInfo = function (id)
    ---@class UusCorpHue
    ---@field a number
    ---@field r number
    ---@field g number
    ---@field b number

    ---@class UusCorpObjectInfo
    ---@field iconName string
    ---@field iconScale number
    ---@field shopName string
    ---@field shopQuantity number
    ---@field containerId number
    ---@field newWidth number
    ---@field quantity number
    ---@field name string
    ---@field newHeight number
    ---@field hueId number
    ---@field objectType number
    ---@field shopValue number
    ---@field iconId number
    return WindowData.ObjectInfo[id]
end