---@class UusCorpSlotWindow:UusCorpButton
---@field data UusCorpContainerItem
UusCorpContainerSlotWindow = UusCorpButton:new {
    name = "UusCorpContainerSlot",
    template = "ContainerSlotTemplate"
}

---@return UusCorpSlotWindow
function UusCorpContainerSlotWindow:new(model)
    return UusCorpButton.new(self, model) --[[@as UusCorpSlotWindow]]
end

function UusCorpContainerSlotWindow:onInitialize()
end

-- UusCorpContainerSlotEventHandler = UusCorpEventHandler:new {
--     name = "UusCorpContainerSlotEventHandler",
--     ---@param model UusCorpSlotWindow
--     getView = function (model)
--         return UusCorpContainerSlotWindow:new(model)
--     end,
--     events = {
--         UusCorpEvents.ObjectInfo
--     }
-- }