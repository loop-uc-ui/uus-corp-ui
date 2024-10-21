---@class UusCorpPlayerStatusWindow:UusCorpWindow
UusCorpPlayerStatusWindow = UusCorpWindow:new {
    name = "PlayerHealthBar",
    eventHandler = "UusCorpPlayerStatusEventHandler"
}

UusCorpPlayerStatusWindow.isInitialized = false

UusCorpPlayerStatusWindow.views = {
    name = UusCorpPlayerStatusWindow:addLabel("Name"),
    health = {
        bar = UusCorpPlayerStatusWindow:addStatusBar("HealthBar"),
        label = UusCorpPlayerStatusWindow:addLabel("HealthBarPerc")
    },
    mana = {
        bar = UusCorpPlayerStatusWindow:addStatusBar("ManaBar"),
        label = UusCorpPlayerStatusWindow:addLabel("ManaBarPerc")
    },
    stamina = {
        bar = UusCorpPlayerStatusWindow:addStatusBar("StaminaBar"),
        label = UusCorpPlayerStatusWindow:addLabel("StaminaBarPerc")
    },
    stats = {
        followers = {
            icon = UusCorpPlayerStatusWindow:addDynamicImage("FollowerIcon"),
            count = UusCorpPlayerStatusWindow:addLabel("FollowerCount")
        },
        weight = {
            icon = UusCorpPlayerStatusWindow:addDynamicImage("WeightIcon"),
            count = UusCorpPlayerStatusWindow:addLabel("WeightCount")
        }
    },
    frames = {
        peace = UusCorpPlayerStatusWindow:addWindow("Frame"),
        war = UusCorpPlayerStatusWindow:addWindow("FrameWar")
    }
}

---@param windowData WindowData
---@param systemData SystemData
function UusCorpPlayerStatusWindow:onInitialize(windowData, systemData)
    local window = UusCorpGenericWindow:new {
        name = "Test",
        onPostInitialize = function (view, _, _)
            local label = UusCorpLabel:new()
            label:create()
            -- label:setText("hi")
            -- label:setParent(view.name)
        end
    }
    window:create()
    
    self:setId(windowData.PlayerStatus.PlayerId)
    self:setUpdateFrequency(1.0)
    UusCorpWindow.onInitialize(self)
    self.views.frames.war:setColor(Colors.NotoMurderer)
    self:clearAnchors()
    if self:isMoving() then
        self:addAnchor(
            {
                anchorPoint = "topleft",
                relativePoint = "topleft",
                relativeTo = "Root",
                x =  systemData.MousePosition.x,
                y = systemData.MousePosition.y
            }
        )
    end
end

function UusCorpPlayerStatusWindow:onUpdate()
    --- We need to restore the position on a delay at startup
    if not self.isInitialized then
        self:restorePosition()
        self:unregisterCoreEvent(UusCorpEvents.OnUpdate.id)
        self.isInitialized = true
    end
end

---@param data WindowData.MobileStatus
function UusCorpPlayerStatusWindow:onUpdateMobileStatus(data)
    self.views.name:setText(data.MobName)
end

---@param data WindowData.PlayerStatus
---@param stats PlayerStat[]
function UusCorpPlayerStatusWindow:onUpdatePlayerStatus(data, stats)
    self.views.frames.peace:setShowing(not data.InWarMode)
    self.views.frames.war:setShowing(data.InWarMode)
    self.views.health.label:setText(data.CurrentHealth .. " / " .. data.MaxHealth)
    self.views.mana.label:setText(data.CurrentMana .. " / " .. data.MaxMana)
    self.views.stamina.label:setText(data.CurrentStamina .. " / " .. data.MaxStamina)

    local bar = self.views.health.bar
    bar:setCurrentValue(data.CurrentHealth)
    bar:setMaxValue(data.MaxHealth)
    bar:setForegroundTint(Colors.HealthBar[data.VisualStateId + 1])

    bar = self.views.mana.bar
    bar:setCurrentValue(data.CurrentMana)
    bar:setMaxValue(data.MaxMana)
    bar:setForegroundTint(Colors.Blue)

    bar = self.views.stamina.bar
    bar:setCurrentValue(data.CurrentStamina)
    bar:setMaxValue(data.MaxStamina)
    bar:setForegroundTint(Colors.YellowDark)

    local icon = self.views.stats.followers.icon
    local texture, _, _ = IconApi.getIconData(stats[13].iconId)
    icon:setDimensions(22, 22)
    icon:setTexture(texture, 4, 3)
    icon:setTextureScale(1)

    self.views.stats.followers.count:setText(
        data.Followers .. "/" .. data.MaxFollowers
    )

    icon = self.views.stats.weight.icon
    texture, _, _ = IconApi.getIconData(stats[11].iconId)
    icon:setDimensions(22, 22)
    icon:setTexture(texture, 4, 3)
    icon:setTextureScale(1.0)

    self.views.stats.weight.count:setText(
        data.Weight .. "/" .. data.MaxWeight
    )
end

---@param data WindowData.HealthBarColor
function UusCorpPlayerStatusWindow:onUpdateHealthBarColor(data)
    self.views.health.bar:setForegroundTint(
        Colors.HealthBar[data.VisualStateId + 1]
    )
end

function UusCorpPlayerStatusWindow:onRButtonDown(flags)
    if ButtonFlags.isControl(flags) then
        ContextMenuApi.requestMenu(self:getId())
    else
        UusCorpWindow.onRButtonDown(self, flags)
    end
end

function UusCorpPlayerStatusWindow:onLButtonDblClk()
    UserAction.useItem(self:getId(), false)
end

function UusCorpPlayerStatusWindow:onLButtonDown()
    if Cursor.hasTarget() then
        TargetApi.clickTarget(self:getId())
    end
    self:setMoving(true)
end

function UusCorpPlayerStatusWindow:onLButtonUp()
    if Drag.isItem() then
        DragApi.dragToObject(self:getId())
    end
    self:setMoving(false)
end