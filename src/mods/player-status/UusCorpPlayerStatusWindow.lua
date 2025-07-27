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
                self:setText(mobileStatus:getName())
                self:setColor(mobileStatus:getNotorietyColor())
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
                self:setMaxValue(playerStatus:getMaxHealth())
                self:matchParentWidth(0.9)
                self:setCurrentValue(playerStatus:getCurrentHealth())
            end,

            OnUpdateHealthBarColor = function (self, healthBarColor)
                self:setForegroundTint(healthBarColor:getVisualStateColor())
            end
        }
    }
end

---@param id integer
---@param onUpdate fun(self: Label, playerStatus: PlayerStatusWrapper)
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
                self:setMaxValue(playerStatus:getMaxMana())
                self:matchParentWidth(0.9)
                self:setCurrentValue(playerStatus:getCurrentMana())
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
                self:setMaxValue(playerStatus:getMaxStamina())
                self:matchParentWidth(0.9)
                self:setCurrentValue(playerStatus:getCurrentStamina())
            end
        }
    }
end

function UusCorpPlayerStatusWindow()
    return UusCorp.Interface.Window {
        name = "PlayerHealthBar",
        events = {
            OnInitialize = function (self)
                local id = UusCorp.Data.PlayerStatus():getId()
                self:setId(id)
                local name = Name(id)

                local health = HealthStatusBar(id)
                local healthLabel = StatusLabel(id, function (label, playerStatus)
                    label:setText(playerStatus:getCurrentHealth() .. "/" .. playerStatus:getMaxHealth())
                    label:clearAnchors()
                    label:centerInWindow(health)
                end)

                local mana = ManaStatusBar(id)
                local manaLabel = StatusLabel(id , function (label, playerStatus)
                    label:setText(playerStatus:getCurrentMana() .. "/" .. playerStatus:getMaxMana())
                    label:clearAnchors()
                    label:centerInWindow(mana)
                end)

                local stamina = StaminaStatusBar(id)
                local staminaLabel = StatusLabel(id , function (label, playerStatus)
                    label:setText(playerStatus:getCurrentStamina() .. "/" .. playerStatus:getMaxStamina())
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
                if playerStatus:isInWarMode() then
                    self:getFrame():setColor(UusCorp.Constants.Colors.Red)
                else
                    self:getFrame():setColor(UusCorp.Constants.Colors.White)
                end
            end,

            OnLButtonDown = function (self)
                if UusCorp.Data.Cursor():isTarget() then
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