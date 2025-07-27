local function Name(id)
    return UusCorp.Interface.Label {
        events = {
            OnInitialize = function (self)
                self:setId(id)
                self:anchorToParentTop(0, 4)
            end,

            OnUpdateMobileStatus = function (self, mobileStatus)
                self:matchParentWidth(0.9)
                self:centerText()
                self:setText(mobileStatus.MobName)
                self:setColor(UusCorp.Constants.Colors.Notoriety[mobileStatus.Notoriety + 1])
            end
        }
    }
end

local function HealthStatusBar(id)
    return UusCorp.Interface.StatusBar {
        events = {
            OnInitialize = function (self)
                self:setId(id)
                self:setForegroundTint(UusCorp.Constants.Colors.Red)
            end,

            OnUpdatePlayerStatus = function (self, playerStatus)
                self:setMaxValue(playerStatus.MaxHealth)
                self:matchParentWidth(0.9)
                self:setCurrentValue(playerStatus.CurrentHealth)
            end,

            OnUpdateHealthBarColor = function (self, healthBarColor)
                self:setForegroundTint(UusCorp.Constants.Colors.HealthBar[healthBarColor.VisualStateId + 1])
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
                self:setId(id)
            end,

            OnUpdatePlayerStatus = function (self, playerStatus)
                self:centerText()
                self:matchParentWidth(0.9)
                onUpdate(self, playerStatus)
            end
        }
    }
end

local function ManaStatusBar(id)
    return UusCorp.Interface.StatusBar {
        events = {
            OnInitialize = function (self)
                self:setId(id)
                self:setForegroundTint(UusCorp.Constants.Colors.Blue)
            end,

            OnUpdatePlayerStatus = function (self, playerStatus)
                self:setMaxValue(playerStatus.MaxMana)
                self:matchParentWidth(0.9)
                self:setCurrentValue(playerStatus.CurrentMana)
            end
        }
    }
end

local function StaminaStatusBar(id)
    return UusCorp.Interface.StatusBar {
        events = {
            OnInitialize = function (self)
                self:setId(id)
                self:setForegroundTint(UusCorp.Constants.Colors.YellowDark)
            end,

            OnUpdatePlayerStatus = function (self, playerStatus)
                self:setMaxValue(playerStatus.MaxStamina)
                self:matchParentWidth(0.9)
                self:setCurrentValue(playerStatus.CurrentStamina)
            end
        }
    }
end

function UusCorpPlayerStatusWindow()
    return UusCorp.Interface.Window {
        name = "PlayerHealthBar",
        events = {
            OnInitialize = function (self)
                local id = UusCorp.PlayerStatus().getId()
                self:setId(id)
                local name = Name(id)

                local health = HealthStatusBar(id)
                local healthLabel = StatusLabel(id, function (label, playerStatus)
                    label:setText(playerStatus.CurrentHealth .. "/" .. playerStatus.MaxHealth)
                    label:clearAnchors()
                    label:centerInWindow(health)
                end)

                local mana = ManaStatusBar(id)
                local manaLabel = StatusLabel(id , function (label, playerStatus)
                    label:setText(playerStatus.CurrentMana .. "/" .. playerStatus.MaxMana)
                    label:clearAnchors()
                    label:centerInWindow(mana)
                end)

                local stamina = StaminaStatusBar(id)
                local staminaLabel = StatusLabel(id , function (label, playerStatus)
                    label:setText(playerStatus.CurrentStamina .. "/" .. playerStatus.MaxStamina)
                    label:clearAnchors()
                    label:centerInWindow(stamina)
                end)

                self:setChildren {
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
                    UusCorp.Api.ContextMenu.RequestMenu(self:getId())
                else
                    self:setShowing(false)
                end
            end,

            OnLButtonDblClk = function (self)
                UusCorp.Api.UserAction.UseItem(self:getId(), false)
            end,

            OnUpdatePlayerStatus = function (self, playerStatus)
                self:setDimensions(192, 148)
                if playerStatus.InWarMode then
                    self:getFrame():setColor(UusCorp.Constants.Colors.Red)
                else
                    self:getFrame():setColor(UusCorp.Constants.Colors.White)
                end
            end,

            OnLButtonDown = function (self)
                if UusCorp.Cursor().isTarget() then
                    UusCorp.Api.Target.LeftClick(self:getId())
                end
            end,

            OnLButtonUp = function (self)
                if UusCorp.Drag().isDraggingItem() then
                    UusCorp.Api.Drag.DragToObject(self:getId())
                end
            end,

            OnEndHealthBarDrag = function (self)
                self:setMoving(false)
            end
        }
    }
end