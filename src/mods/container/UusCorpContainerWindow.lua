---@class UusCorpContainerWindow:UusCorpWindow
---@field maxSlots number
---@field gridView UusCorpScrollWindow
---@field background UusCorpWindow
---@field freeformView UusCorpDynamicImage
---@field freeformBackground UusCorpDynamicImage
---@field title UusCorpLabel
---@field lootAll UusCorpButton
---@field toggleView UusCorpButton
---@field search UusCorpButton
---@field searchBox UusCorpEditTextBox
---@field searchLine UusCorpWindow
---@field frame UusCorpWindow
---@field resizeButton UusCorpButton
---@field slots UusCorpContainerSlot[]
UusCorpContainerWindow = UusCorpWindow:new("ContainerWindow_")

local MAX_SLOTS = 125

---@param id number
---@return UusCorpContainerWindow
function UusCorpContainerWindow:new(id)
    local window = UusCorpWindow.new(self, self.name .. tostring(id)) --[[@as UusCorpContainerWindow]]
    window.gridView = window:addScrollWindow("GridView")
    window.background = window:addWindow("Background")
    window.freeformView = window:addDynamicImage("FreeformView")
    window.freeformBackground = window:addDynamicImage("FreeformBackground")
    window.title = window:addLabel("Title")
    window.lootAll = window:addButton("LootAll")
    window.toggleView = window:addButton("ToggleView")
    window.search = window:addButton("Search")
    window.searchBox = window:addEditTextBox("Box")
    window.searchLine = window:addWindow("Line")
    window.frame = window:addWindow("Frame")
    window.resizeButton = window:addButton("ResizeButton")
    window.slots = {}
    return window
end

function UusCorpContainerWindow:onInitialize(id)
    self:setId(id)
    self:registerData(Container.type(), id)
    self:registerEvent(Container.event(), "UusCorpContainerRootWindow.updateContainer")
    self:registerEvent(ObjectInfo.event(), "UusCorpContainerRootWindow.updateObject")
    self:registerEvent(ItemPropertiesData.event(),  "UusCorpContainerRootWindow.updateObject")
    self:setUpdateFrequency(1)
    self:toggleState(UserContainerSettings.legacyContainers())
    self.searchBox:setShowing(false)
    self.searchLine:setShowing(false)
    return self
end

function UusCorpContainerWindow:onUpdateContainer()
    local name = StringFormatter.fromWString(Container.name(self:getId()))

    if #name > 12 then
        name = string.sub(name, 1, 13) .. "..."
    end

    self.title:setText(name)

    if #self.slots <= 0 then
        self:createSlots()
    end

    for i = 1, self:getItemCount() do
        local item = self:getItems()[i]
        local objectId = item.objectId
        self:registerData(ObjectInfo.type(), objectId)
        self:registerData(ItemPropertiesData.type(), objectId)
        local slot = self.slots[i]

        if slot:getId() ~= objectId then
            slot:createIcon(objectId)
        end
    end

    self.gridView:updateScrollRect()
end

function UusCorpContainerWindow:onShutdown()
    ItemProperties.ClearMouseOverItem()
    self:unregisterData(Container.type(), self:getId())
    self:unregisterEvent(Container.event())
    self:unregisterEvent(ObjectInfo.event())
    self:unregisterEvent(ItemPropertiesData.event())

    for i = 1, #self.slots do
        self.slots[i]:onShutdown()
    end

    GumpApi.onCloseContainer(self:getId())
end

function UusCorpContainerWindow:isPlayer()
    return self:getId() == PlayerEquipment.slotId(PlayerEquipment.Slots.Backpack)
end

function UusCorpContainerWindow:getItemCount()
    return Container.itemCount(self:getId())
end

function UusCorpContainerWindow:toggleState(isLegacy)
    self.gridView:setShowing(not isLegacy)
    self.freeformBackground:setShowing(isLegacy)
    self.freeformView:setShowing(isLegacy)
    self.title:setShowing(not isLegacy)
    self.background:setShowing(not isLegacy)
    self.frame:setShowing(not isLegacy)
    self.resizeButton:setShowing(not isLegacy)
    self.search:setShowing(not isLegacy)
    self.lootAll:setShowing(not self:isPlayer() and not isLegacy)

    if not self.lootAll:isShowing() then
        self.search:clearAnchors()
        self.search:addAnchor(UusCorpAnchor.new("topleft", "topright", self.toggleView.name, -6, -6))
    end
end

function UusCorpContainerWindow:isLegacy()
    return self.freeformBackground:isShowing()
end

function UusCorpContainerWindow:getGumpId()
    return Container.gumpNum(self:getId())
end

function UusCorpContainerWindow:getItems()
    return Container.items(self:getId())
end

function UusCorpContainerWindow:onSearchUpdate(text)
    for i = 1, #self.slots do
        self.slots[i]:onSearchUpdate(text)
    end
end

function UusCorpContainerWindow:createSlots()
    local sizeMultiplier = 1
    local scrollWindow = self.gridView.scrollChild
    local slots = MAX_SLOTS
    if self:getItemCount() > MAX_SLOTS then
        slots = self:getItemCount()
    end

    for i = 1, slots do
        local x, _ = scrollWindow:getDimensions()
        local slot = UusCorpContainerSlot:new(
            scrollWindow.name .. "Slot" .. tostring(i),
            self:getId()
        )
        slot:createFromTemplate("ContainerSlotTemplate", scrollWindow.name)

        local slotX, _ = slot:getDimensions()
        local rowSize = sizeMultiplier * slotX

        if i ~= 1 then
            slot:clearAnchors()
            if rowSize < x then
                slot:addAnchor(
                    UusCorpAnchor.new(
                        "right",
                        "left",
                        scrollWindow.name .. "Slot" .. tostring(i - 1)
                    )
                )
                sizeMultiplier = sizeMultiplier + 1
            else
                slot:addAnchor(
                    UusCorpAnchor.new(
                        "bottomleft",
                        "topleft",
                        scrollWindow.name .. "Slot" .. tostring(i - sizeMultiplier)
                    )
                )
                sizeMultiplier = 1
            end
        end

        slot.icon:setTexture("")
        slot.gridIndex = i
        table.insert(self.slots, slot)
    end
end

function UusCorpContainerWindow:onUpdate()
    if self:getItemCount() > 0 then
        DragApi.autoPickUpObject(self:getItems()[1].objectId)
    else
        self:unregisterCoreEvent("OnUpdate")
    end
end