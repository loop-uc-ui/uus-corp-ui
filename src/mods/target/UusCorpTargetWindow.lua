---@class UusCorpTargetWindow:UusCorpWindow
UusCorpTargetWindow = UusCorpWindow:new {
    name = "UusCorpTargetWindow",
    eventHandler = "UusCorpTargetEventHandler"
}

---@private
UusCorpTargetWindow.NameLabel = UusCorpTargetWindow:addLabel("Name")

---@private
UusCorpTargetWindow.HealthBarPercent = UusCorpTargetWindow:addLabel("HealthBarPerc")

---@private
UusCorpTargetWindow.StatusBar = UusCorpTargetWindow:addStatusBar("HealthBar")

---@private
UusCorpTargetWindow.Distance = UusCorpTargetWindow:addLabel("Distance")

---@param windowData WindowData
function UusCorpTargetWindow:onInitialize(windowData)
    self:setId(windowData.CurrentTarget.TargetId)
    UusCorpWindow.onInitialize(self)
    self:setScale(1.0)

    -- local id = CurrentTarget.id()
    -- UusCorpTargetWindow:setId(id)
    -- UusCorpTargetWindow:setScale(1.0)

    -- if CurrentTarget.isMobile() then
    --     UusCorpTargetWindow:registerData(MobileStatus.type(), id)
    --     UusCorpTargetWindow:registerEvent(MobileStatus.event(), "UusCorpTargetWindow.onUpdateMobileStatus")
    --     UusCorpTargetWindow:registerData(HealthBarColorData.type(), id)
    --     UusCorpTargetWindow:registerEvent(HealthBarColorData.event(), "UusCorpTargetWindow.onUpdateHealthBarColor")


    --     if MobileStatus.status(id) ~= nil then
    --         UusCorpTargetWindow.onUpdateMobileStatus(id)
    --     end

    --     if HealthBarColorData.data(id) ~= nil then
    --         UusCorpTargetWindow.onUpdateHealthBarColor(id)
    --     end
    -- elseif CurrentTarget.isObject() or CurrentTarget.isCorpse() then
    --     UusCorpTargetWindow:registerData(ObjectInfo.type(), id)
    --     UusCorpTargetWindow:registerEvent(ObjectInfo.event(), "UusCorpTargetWindow.onUpdateObjectInfo")
    --     UusCorpTargetWindow.StatusBar:setShowing(false)
    --     UusCorpTargetWindow.HealthBarPercent:setShowing(false)
    --     UusCorpTargetWindow.onUpdateObjectInfo()
    -- end
end

---@param data WindowData.MobileStatus
function UusCorpTargetWindow:onUpdateMobileStatus(data)
    self.NameLabel:setText(data.MobName)
    self.NameLabel:setTextColor(Colors.Notoriety[data.Notoriety])

    local maxHealth = data.MaxHealth
    local currentHealth = data.CurrentHealth

    -- There's a delay in updating the mobile's status where
    -- values are initialy 0'd out
    self.StatusBar:setShowing(maxHealth ~= 0)
    self.HealthBarPercent:setShowing(maxHealth ~= 0)

    self.StatusBar:setCurrentValue(currentHealth)
    self.StatusBar:setMaxValue(maxHealth)

    self.HealthBarPercent:setText(
        tostring(math.floor(currentHealth / maxHealth * 100)) .. "%"
    )
end

function UusCorpTargetWindow:onUpdateObjectInfo(data)
end


-- function UusCorpTargetWindow.onUpdate()
--     local id = UusCorpTargetWindow:getId()
--     local distance = ObjectApi.getDistanceFromPlayer(id)

--     if distance <= 0 then
--         UusCorpTargetWindow.Distance:setText("")
--     else
--         UusCorpTargetWindow.Distance:setText(tostring(distance))
--     end

--     if not CurrentTarget.hasTarget() then
--         UusCorpTargetWindow:destroy()
--     end
-- end

-- function UusCorpTargetWindow.onShutdown()
--     local id = UusCorpTargetWindow:getId()

--     if CurrentTarget.isMobile() then
--         UusCorpTargetWindow:unregisterData(MobileStatus.type(), id)
--         UusCorpTargetWindow:unregisterEvent(MobileStatus.event())
--         UusCorpTargetWindow:unregisterData(HealthBarColorData.type(), id)
--         UusCorpTargetWindow:unregisterEvent(HealthBarColorData.event())
--     elseif CurrentTarget.isObject() or CurrentTarget.isCorpse() then
--         UusCorpTargetWindow:unregisterData(ObjectInfo.type(), id)
--         UusCorpTargetWindow:unregisterEvent(ObjectInfo.event())
--     end

--     UusCorpTargetWindow:savePosition()
-- end

-- function UusCorpTargetWindow.onUpdateObjectInfo()
--     UusCorpTargetWindow.NameLabel:setText(ObjectInfo.name(UusCorpTargetWindow:getId()))
-- end

-- function UusCorpTargetWindow.onRightClick(flags)
--     if ButtonFlags.isControl(flags) then
--         ContextMenuApi.requestMenu(UusCorpTargetWindow:getId())
--     end
-- end

-- function UusCorpTargetWindow.onDoubleClick()
--     UserActionApi.useItem(UusCorpTargetWindow:getId(), false)
-- end

---@param data WindowData.HealthBarColor
function UusCorpTargetWindow:onUpdateHealthBarColor(data)
    self.StatusBar:setForegroundTint(Colors.HealthBar[data.VisualStateId + 1])
end

function UusCorpTargetWindow:onLButtonUp()
    if Drag.isItem() then
        DragApi.dragToObject(self:getId())
    end
    TargetApi.clickTarget(self:getId())
end