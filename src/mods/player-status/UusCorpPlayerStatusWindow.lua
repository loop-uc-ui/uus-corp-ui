local function Name(id)
    return UusCorp.Interface.Label {
        events = {
            ---@param self Label
            OnInitialize = function (self)
                self.setId(id)
                self.anchorToParenTop(0, 4)
            end,

            ---@param self Label
            OnUpdateMobileStatus = function (self, mobileStatus)
                self.matchParentWidth(0.9)
                self.centerText()
                self.setText(mobileStatus.MobName)
                self.setColor(UusCorp.Constants.Colors.Notoriety[mobileStatus.Notoriety + 1])
            end
        }
    }
end

local function HealthStatusBar(id)
    return UusCorp.Interface.StatusBar {
        events = {
            ---@param self StatusBar
            OnInitialize = function (self)
                self.setId(id)
                self.setForegroundTint(UusCorp.Constants.Colors.Red)
            end,

            ---@param self StatusBar
            OnUpdatePlayerStatus = function (self, playerStatus)
                self.setMaxValue(playerStatus.MaxHealth)
                self.matchParentWidth(0.9)
                self.setCurrentValue(playerStatus.CurrentHealth)
            end,

            ---@param self StatusBar
            OnUpdateHealthBarColor = function (self, healthBarColor)
                self.setForegroundTint(UusCorp.Constants.Colors.HealhBar[healthBarColor.VisualStateId + 1])
            end
        }
    }
end

---@param id integer
---@param onUpdate fun(self: Label, playerStatus: WindowData.PlayerStatus)
---@return Label
local function StatusLabel(id, onUpdate)
    return UusCorp.Interface.Label {
        events = {
            OnInitialize = function (self)
                self.setId(id)
            end,

            ---@param self Label
            OnUpdatePlayerStatus = function (self, playerStatus)
                self.centerText()
                self.matchParentWidth(0.9)
                onUpdate(self, playerStatus)
            end
        }
    }
end

local function ManaStatusBar(id)
    return UusCorp.Interface.StatusBar {
        events = {
            ---@param self StatusBar
            OnInitialize = function (self)
                self.setId(id)
                self.setForegroundTint(UusCorp.Constants.Colors.Blue)
            end,

            ---@param self StatusBar
            OnUpdatePlayerStatus = function (self, playerStatus)
                self.setMaxValue(playerStatus.MaxMana)
                self.matchParentWidth(0.9)
                self.setCurrentValue(playerStatus.CurrentMana)
            end
        }
    }
end

local function StaminaStatusBar(id)
    return UusCorp.Interface.StatusBar {
        events = {
            ---@param self StatusBar
            OnInitialize = function (self)
                self.setId(id)
                self.setForegroundTint(UusCorp.Constants.Colors.YellowDark)
            end,

            ---@param self StatusBar
            OnUpdatePlayerStatus = function (self, playerStatus)
                self.setMaxValue(playerStatus.MaxStamina)
                self.matchParentWidth(0.9)
                self.setCurrentValue(playerStatus.CurrentStamina)
            end
        }
    }
end

function UusCorpPlayerStatusWindow()
    return UusCorp.Interface.Window {
        name = "PlayerHealthBar",
        events = {
            OnInitialize = function (self)
                local id = UusCorp.Data.Window().PlayerStatus.PlayerId
                self.setId(id)
                local name = Name(id)

                local health = HealthStatusBar(id)
                local healthLabel = StatusLabel(id, function (label, playerStatus)
                    label.setText(playerStatus.CurrentHealth .. "/" .. playerStatus.MaxHealth)
                    label.clearAnchors()
                    label.centerInWindow(health)
                end)

                local mana = ManaStatusBar(id)
                local manaLabel = StatusLabel(id , function (label, playerStatus)
                    label.setText(playerStatus.CurrentMana .. "/" .. playerStatus.MaxMana)
                    label.clearAnchors()
                    label.centerInWindow(mana)
                end)

                local stamina = StaminaStatusBar(id)
                local staminaLabel = StatusLabel(id , function (label, playerStatus)
                    label.setText(playerStatus.CurrentStamina .. "/" .. playerStatus.MaxStamina)
                    label.clearAnchors()
                    label.centerInWindow(stamina)
                end)

                self.setChildren {
                    name,
                    health,
                    healthLabel,
                    mana,
                    manaLabel,
                    stamina,
                    staminaLabel
                }
            end,

            OnRButtonUp = function (self, flags)
                if flags == UusCorp.Constants.ButtonFlags.Control then
                    UusCorp.Api.ContextMenu.RequestMenu(self.getId())
                else
                    self.setShowing(false)
                end
            end,

            OnLButtonDblClk = function (self)
                UusCorp.Api.UserAction.UseItem(self.getId(), false)
            end,

            OnUpdatePlayerStatus = function (self, playerStatus)
                if playerStatus.InWarMode then
                    self.getFrame().setColor(UusCorp.Constants.Colors.Red)
                else
                    self.getFrame().setColor(UusCorp.Constants.Colors.White)
                end
            end,

            OnLButtonDown = function (self)
                if UusCorp.Data.Window().Cursor.target then
                    UusCorp.Api.Target.LeftClick(self.getId())
                end
            end,

            OnLButtonUp = function (self)
                if UusCorp.Data.System().isDragItem() then
                    UusCorp.Api.Drag.DragToObject(self.getId())
                end
            end,

            OnEndHealthBarDrag = function (self)
                self.setMoving(false)
            end
        }
    }
end

-- UusCorpPlayerStatusWindow.Name = "PlayerHealthBar"
-- UusCorpPlayerStatusWindow.isPlayerStatusOpen = false

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

UusCorpPlayerStatusWindowMod = {}
function UusCorpPlayerStatusWindowMod.initialize()
    -- UusCorpCore.loadResources(
    --     "/src/mods/player-status",
    --     "UusCorpPlayerStatusWindow.xml"
    -- )

    WindowApi.setShowing("StatusWindow", false)

    WindowApi.unregisterEventHandler(
        "StatusWindow",
        PlayerStatus.event()
    )

    UusCorpCore.overrideFunctions(StatusWindow)
    local window = UusCorpPlayerStatusWindow()
    window.create(true)
    WindowUtilsWrapper.restoreWindowPosition(window.getName(), true)
end

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

-- function UusCorpPlayerStatusWindow.onShutdown()
--     isInitialized = true
--     WindowDataApi.unregisterData(PlayerStatus.type(), 0)
--     WindowDataApi.unregisterData(MobileStatus.type(), PlayerStatus.id())
--     WindowDataApi.unregisterData(HealthBarColorData.type(), PlayerStatus.id())
--     WindowApi.unregisterEventHandler(UusCorpPlayerStatusWindow.Name, PlayerStatus.event())
--     WindowApi.unregisterEventHandler(UusCorpPlayerStatusWindow.Name, MobileStatus.event())
--     WindowApi.unregisterEventHandler(UusCorpPlayerStatusWindow.Name, HealthBarColorData.event())
-- end

-- function UusCorpPlayerStatusWindow.updateHealthBarColor()
--     StatusBarApi.setForegroundTint(
--         UusCorpPlayerStatusWindow.Name .. "HealthBar",
--         Colors.HealthBar[HealthBarColorData.visualState(PlayerStatus.id()) + 1]
--     )
-- end

-- function UusCorpPlayerStatusWindow.updateNotoriety()
--     LabelApi.setTextColor(
--         UusCorpPlayerStatusWindow.Name .. "Name",
--         Colors.Notoriety[MobileStatus.notoriety(PlayerStatus.id())]
--     )
-- end

-- function UusCorpPlayerStatusWindow.update()
--     WindowApi.setShowing(Active.window() .. "Frame", not PlayerStatus.inWarMode())
--     WindowApi.setShowing(Active.window() .. "FrameWar", PlayerStatus.inWarMode())

--     LabelApi.setText(
--         UusCorpPlayerStatusWindow.Name .. "Name",
--         MobileStatus.name(PlayerStatus.id())
--     )

--     LabelApi.setText(
--         UusCorpPlayerStatusWindow.Name .. "HealthBarPerc",
--         PlayerStatus.currentHealth() .. " / " .. PlayerStatus.maxHealth()
--     )
--     LabelApi.setText(
--         UusCorpPlayerStatusWindow.Name .. "ManaBarPerc",
--         PlayerStatus.currentMana() .. " / " .. PlayerStatus.maxMana()
--     )
--     LabelApi.setText(
--         UusCorpPlayerStatusWindow.Name .. "StaminaBarPerc",
--         PlayerStatus.currentStamina() .. " / " .. PlayerStatus.maxStamina()
--     )

--     local bar = UusCorpPlayerStatusWindow.Name .. "HealthBar"
--     StatusBarApi.setCurrentValue(bar, PlayerStatus.currentHealth())
--     StatusBarApi.setMaximumValue(bar, PlayerStatus.maxHealth())

--     bar = UusCorpPlayerStatusWindow.Name .. "ManaBar"
--     StatusBarApi.setCurrentValue(bar, PlayerStatus.currentMana())
--     StatusBarApi.setMaximumValue(bar, PlayerStatus.maxMana())
--     StatusBarApi.setForegroundTint(bar, Colors.Blue)

--     bar = UusCorpPlayerStatusWindow.Name .. "StaminaBar"
--     StatusBarApi.setCurrentValue(bar, PlayerStatus.currentStamina())
--     StatusBarApi.setMaximumValue(bar, PlayerStatus.maxStamina())
--     StatusBarApi.setForegroundTint(bar, Colors.YellowDark)

--     setStat(PlayerStatus.followers(), PlayerStatus.maxFollowers(), "Follower")
--     setStat(PlayerStatus.weight(), PlayerStatus.maxWeight(), "Weight")
-- end

-- function UusCorpPlayerStatusWindow.offset()
--     WindowApi.setOffsetFromParent(
--         UusCorpPlayerStatusWindow.Name,
--         MousePosition.x() - 30,
--         MousePosition.y() - 15
--     )
-- end

-- function UusCorpPlayerStatusWindow.onRightClick(flags)
--     if ButtonFlags.isControl(flags) then
--         ContextMenuApi.requestMenu(PlayerStatus.id())
--     else
--         WindowApi.destroyWindow(UusCorpPlayerStatusWindow.Name)
--     end
-- end

-- function UusCorpPlayerStatusWindow.onDoubleClick()
--     UserAction.useItem(PlayerStatus.id(), false)
-- end

-- function UusCorpPlayerStatusWindow.onLeftClickDown()
--     if Cursor.hasTarget() then
--         TargetApi.clickTarget(
--             PlayerStatus.id()
--         )
--     end
-- end

-- function UusCorpPlayerStatusWindow.onLeftClickUp()
--     if Drag.isItem() then
--         DragApi.dragToObject(PlayerStatus.id())
--     end
-- end