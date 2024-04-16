---@class UusCorpContainerSlotWindow:UusCorpButton
---@field onUpdateContainer fun(view: UusCorpContainerSlotWindow, data: WindowData.Container.Item, previousSlot: string?)
UusCorpContainerSlotWindow = UusCorpButton:new {
    name = "UusCorpContainerSlot",

    template = "ContainerSlotTemplate",

    ---@param view UusCorpButton
    ---@param data WindowData.Container.Item
    ---@param previousSlot string?
    onUpdateContainer = function (view, data, previousSlot)
        if previousSlot ~= nil then
            view:addAnchor(
                {
                    anchorPoint = "right",
                    relativePoint = "left",
                    relativeTo = previousSlot
                }
            )
        end
    end
}