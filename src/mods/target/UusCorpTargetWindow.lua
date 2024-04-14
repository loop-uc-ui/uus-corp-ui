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

---@param data WindowData.ObjectInfo
function UusCorpTargetWindow:onUpdateObjectInfo(data)
    self.NameLabel:setText(data.name)
    self.StatusBar:setShowing(false)
    self.HealthBarPercent:setShowing(false)
end


function UusCorpTargetWindow:onUpdate()
    local distance = ObjectApi.getDistanceFromPlayer(self:getId())
    if distance <= 0 then
        self.Distance:setText("")
    else
        self.Distance:setText(tostring(distance))
    end
end

function UusCorpTargetWindow:onRButtonDown(flags)
    if ButtonFlags.isControl(flags) then
        ContextMenuApi.requestMenu(UusCorpTargetWindow:getId())
    else
        UusCorpWindow.onRButtonDown(self, flags)
    end
end

function UusCorpTargetWindow.onLButtonDblClk()
    UserActionApi.useItem(UusCorpTargetWindow:getId(), false)
end

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