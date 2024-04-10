---@class UusCorpPlayerStatusWindow:UusCorpWindow
UusCorpPlayerStatusWindow = UusCorpWindow:new {
    name = "PlayerHealthBar",
    eventHandler = "UusCorpPlayerStatusEventHandler"
}

UusCorpPlayerStatusWindow.isPlayerStatusOpen = false

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

---@param data WindowData
function UusCorpPlayerStatusWindow:onInitialize(data)
    self:setId(data.PlayerStatus.PlayerId)
    UusCorpWindow.onInitialize(self)
    self.views.frames.war:setColor(Colors.NotoMurderer)
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

-- local isInitialized = false

-- local function setStat(value, max, name)
--     local index = 1

--     if name == "Follower" then
--         index = 13
--     elseif name == "Weight" then
--         index = 11
--     end

--     local texture, _, _ = IconApi.getIconData(
--         PlayerStatus.stats()[index].iconId
--     )

--     local icon = UusCorpPlayerStatusWindow.Name .. name .. "Icon"
--     WindowApi.setDimensions(icon, 22, 22)
--     DynamicImageApi.setTexture(icon, texture, 4, 3)
--     DynamicImageApi.setTextureScale(icon, 1)

--     LabelApi.setText(
--         UusCorpPlayerStatusWindow.Name .. name .. "Count",
--         value .. "/" .. max
--     )
-- end

-- function UusCorpPlayerStatusWindow.shutdown()
--     UusCorpPlayerStatusWindow.isPlayerStatusOpen = WindowApi.doesExist(UusCorpPlayerStatusWindow.Name)
--     WindowUtilsWrapper.saveWindowPosition(UusCorpPlayerStatusWindow.Name)
-- end

-- function UusCorpPlayerStatusWindow.onInitialize()
--     WindowDataApi.registerData(PlayerStatus.type(), 0)
--     WindowDataApi.registerData(MobileStatus.type(), PlayerStatus.id())
--     WindowDataApi.registerData(HealthBarColorData.type(), PlayerStatus.id())

--     WindowApi.registerEventHandler(
--         UusCorpPlayerStatusWindow.Name,
--         PlayerStatus.event(),
--         "UusCorpPlayerStatusWindow.update"
--     )

--     WindowApi.registerEventHandler(
--         UusCorpPlayerStatusWindow.Name,
--         MobileStatus.event(),
--         "UusCorpPlayerStatusWindow.updateNotoriety"
--     )

--     WindowApi.registerEventHandler(
--         UusCorpPlayerStatusWindow.Name,
--         HealthBarColorData.event(),
--         "UusCorpPlayerStatusWindow.updateHealthBarColor"
--     )

--     -- can't reference SavedVariables during mod initialization
--     if not UusCorpPlayerStatusWindow.isPlayerStatusOpen and not isInitialized then
--         WindowApi.destroyWindow(Active.window())
--         return
--     end

--     WindowApi.setColor(Active.window() .. "FrameWar", Colors.NotoMurderer)

--     -- Avoid it being set to white, which sometimes happens
--     -- right after logging in.
--     StatusBarApi.setForegroundTint(
--         UusCorpPlayerStatusWindow.Name .. "HealthBar",
--         Colors.HealthBar[1]
--     )

--     UusCorpPlayerStatusWindow.update()
--     UusCorpPlayerStatusWindow.updateHealthBarColor()
--     UusCorpPlayerStatusWindow.updateNotoriety()
--     UusCorpPlayerStatusWindow.isPlayerStatusOpen = true
-- end

-- function UusCorpPlayerStatusWindow.updateNotoriety()
--     LabelApi.setTextColor(
--         UusCorpPlayerStatusWindow.Name .. "Name",
--         Colors.Notoriety[MobileStatus.notoriety(PlayerStatus.id())]
--     )
-- end

-- function UusCorpPlayerStatusWindow.offset()
--     WindowApi.setOffsetFromParent(
--         UusCorpPlayerStatusWindow.Name,
--         MousePosition.x() - 30,
--         MousePosition.y() - 15
--     )
-- end

function UusCorpPlayerStatusWindow:onLButtonDown()
    if Cursor.hasTarget() then
        TargetApi.clickTarget(self:getId())
    end
end

function UusCorpPlayerStatusWindow:onLButtonUp()
    if Drag.isItem() then
        DragApi.dragToObject(self:getId())
    end
end