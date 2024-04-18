---@class UusCorpContainerSlotWindow:UusCorpButton
---@field onUpdateContainer fun(view: UusCorpContainerSlotWindow, data: WindowData.Container.Item, previousSlot: string?)
UusCorpContainerSlotWindow = UusCorpButton:new {
    name = "UusCorpContainerSlot",

    template = "ContainerSlotTemplate",

    ---@param view UusCorpButton
    ---@param data WindowData.Container.Item
    ---@param previousSlot string?
    ---@diagnostic disable-next-line: redundant-parameter
    onUpdateContainer = function (view, data, previousSlot)
        if previousSlot ~= nil then
            view:addAnchor(
                {
                    anchorPoint = "right",
                    relativePoint = "left",
                    relativeTo = previousSlot
                }
            )
        else
            local _, parentWidth = view:getParent():getDimensions()
            local _, itemWidth = view:getDimensions()
            local index = data.gridIndex
        end
    end,

    onUpdateObjectInfo = function (view, data)
        
    end
}