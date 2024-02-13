---@class UusCorpContainerSlot:UusCorpButton
---@field icon UusCorpDynamicImage
---@field containerId number
---@field gridIndex number
UusCorpContainerSlot = UusCorpButton:new("UusCorpContainerSlot")


---@param name string
---@return UusCorpContainerSlot
function UusCorpContainerSlot:new(name, containerId)
    local slot = UusCorpButton.new(self, name) --[[@as UusCorpContainerSlot]]
    slot.icon = slot:addDynamicImage("Icon")
    self.containerId = containerId
    return slot
end

function UusCorpContainerSlot:createIcon(objectId)
    if objectId == nil or objectId == 0 then
        return
    end

    self:setId(objectId)
    self.icon:setTexture(ObjectInfo.iconName(objectId))
    self.icon:setTextureScale(ObjectInfo.iconScale(objectId))
    self.icon:setCustomShader(DynamicImageApi.Shaders.Sprite, {
        ObjectInfo.hueId(objectId),
        ObjectInfo.objectType(objectId)
    })
    self.icon:setTextureDimensions(
        ObjectInfo.newWidth(objectId),
        ObjectInfo.newHeight(objectId)
    )
    self.icon:setDimensions(
        ObjectInfo.newWidth(objectId),
        ObjectInfo.newHeight(objectId)
    )
    self.icon:setColor(ObjectInfo.hue(objectId))
    self.icon:setAlpha(ObjectInfo.hue(objectId).a / 255)
    return self.icon
end

function UusCorpContainerSlot:onSearchUpdate(text)
    local properties = self:properties()
    local isFound = properties == "" or string.find(
        string.lower(properties),
        string.lower(StringFormatter.fromWString(text))
    ) ~= nil
    self:setShowing(isFound)
end

function UusCorpContainerSlot:onMouseOver()
    local itemData = {
        windowName = self.name,
        itemId = self:getId(),
        itemType = WindowData.ItemProperties.TYPE_ITEM,
        detail = ItemProperties.DETAIL_LONG
    }
    ItemProperties.SetActiveItem(itemData)
end

function UusCorpContainerSlot:properties()
    local properties = ItemPropertiesData.propertiesList(self:getId())
    local search = ""
    if properties ~= nil and #properties > 0 then
        for j = 1 , #properties do
            search = search .. " " .. StringFormatter.fromWString(properties[j])
        end
    end
    return search
end

function UusCorpContainerSlot:onSingleClick()
    if Drag.isItem() then
        DragApi.dragObjectToObjectAtIndex(self:getId(), self.gridIndex)
    elseif Cursor.hasTarget() then
        TargetApi.clickTarget(self:getId())
    else
        DragApi.setObjectMouseClickData(self:getId(), Drag.sourceContainer())
        self:unregisterData(ObjectInfo.type(), self:getId())
        self:unregisterData(ItemPropertiesData.type(), self:getId())
    end
end

function UusCorpContainerSlot:onSingleClickUp()
    if Drag.isItem() then
        DragApi.dragObjectToObjectAtIndex(self:getId(), self.gridIndex)
    end
end

function UusCorpContainerSlot:onDoubleClick()
    UserAction.useItem(self:getId(), false)
end

function UusCorpContainerSlot:onRightClick(flags)
    if ButtonFlags.isControl(flags) then
        ContextMenuApi.requestMenu(self:getId())
    elseif self.containerId ~= PlayerEquipment.slotId(PlayerEquipment.Slots.Backpack) then
        DragApi.autoPickUpObject(self:getId())
    else
        WindowApi.destroyWindow(UusCorpContainerWindow.name .. self.containerId)
    end
end

function UusCorpContainerSlot:onShutdown()
    local id = self:getId()
    if id ~= nil and id ~= 0 then
        WindowDataApi.unregisterData(ObjectInfo.type(), id)
        WindowDataApi.unregisterData(ItemPropertiesData.type(), id)
    end
end