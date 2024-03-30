---@return UusCorpContainer
UusCorpContainer = function (id)
    ---@class UusCorpContainerItem
    ---@field objectId number
    ---@field gridIndex number

    ---@class UusCorpContainer
    ---@field containerName string
    ---@field ContainedItems UusCorpContainerItem[]
    ---@field numCreatedSlots number
    ---@field numItems number
    ---@field isCorpse boolean
    ---@field gumpNum number
    ---@field isSnooped boolean
    return WindowData.ContainerWindow[id]
end