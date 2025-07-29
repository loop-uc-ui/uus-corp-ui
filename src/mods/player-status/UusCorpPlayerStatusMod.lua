---@param context Context
local function Name(context, id)
    return context.Views.Label {
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

---@param context Context
local function HealthStatusBar(context, id)
    return context.Views.StatusBar {
        events = {
            OnInitialize = function (self)
                self:setId(id)
                self:setForegroundTint(context.Constants.Colors.Red)
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

---@param context Context
---@param id integer
---@param onUpdate fun(self: Label, playerStatus: PlayerStatusWrapper)
---@return Label
local function StatusLabel(context, id, onUpdate)
    return context.Views.Label {
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

---@param context Context
local function ManaStatusBar(context, id)
    return context.Views.StatusBar {
        events = {
            OnInitialize = function (self)
                self:setId(id)
                self:setForegroundTint(context.Constants.Colors.Blue)
            end,

            OnUpdatePlayerStatus = function (self, playerStatus)
                self:setMaxValue(playerStatus:getMaxMana())
                self:matchParentWidth(0.9)
                self:setCurrentValue(playerStatus:getCurrentMana())
            end
        }
    }
end

---@param context Context
local function StaminaStatusBar(context, id)
    return context.Views.StatusBar {
        events = {
            OnInitialize = function (self)
                self:setId(id)
                self:setForegroundTint(context.Constants.Colors.YellowDark)
            end,

            OnUpdatePlayerStatus = function (self, playerStatus)
                self:setMaxValue(playerStatus:getMaxStamina())
                self:matchParentWidth(0.9)
                self:setCurrentValue(playerStatus:getCurrentStamina())
            end
        }
    }
end

---@param context Context
local function UusCorpPlayerStatusWindow(context)
    return context.Views.Window {
        name = "PlayerHealthBar",
        persistPosition = true,
        events = {
            OnInitialize = function (self)
                local id = context.Data.PlayerStatus():getId()
                self:setId(id)
                local name = Name(context, id)

                local health = HealthStatusBar(context, id)
                local healthLabel = StatusLabel(context, id, function (label, playerStatus)
                    label:setText(playerStatus:getCurrentHealth() .. "/" .. playerStatus:getMaxHealth())
                    label:clearAnchors()
                    label:centerInWindow(health)
                end)

                local mana = ManaStatusBar(context, id)
                local manaLabel = StatusLabel(context, id , function (label, playerStatus)
                    label:setText(playerStatus:getCurrentMana() .. "/" .. playerStatus:getMaxMana())
                    label:clearAnchors()
                    label:centerInWindow(mana)
                end)

                local stamina = StaminaStatusBar(context, id)
                local staminaLabel = StatusLabel(context, id , function (label, playerStatus)
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
                if flags == context.Constants.ButtonFlags.Control then
                    context.Api.ContextMenu.RequestMenu(self:getId())
                else
                    self:setShowing(false)
                end
            end,

            OnLButtonDblClk = function (self)
                context.Api.UserAction.UseItem(self:getId(), false)
            end,

            OnUpdatePlayerStatus = function (self, playerStatus)
                self:setDimensions(192, 148)
                if playerStatus:isInWarMode() then
                    self:getFrame():setColor(context.Constants.Colors.Red)
                else
                    self:getFrame():setColor(context.Constants.Colors.White)
                end
            end,

            OnLButtonDown = function (self)
                if context.Data.Cursor():isTarget() then
                    context.Api.Target.LeftClick(self:getId())
                end
            end,

            OnLButtonUp = function (self)
                if context.Data.Drag():isDraggingItem() then
                    context.Api.Drag.DragToObject(self:getId())
                end
            end,

            OnEndHealthBarDrag = function (self)
                self:setMoving(false)
            end
        }
    }
end

UusCorpPlayerStatusMod = UusCorp.Mod {
    Name = "UusCorpPlayerStatus",

    Path = "/src/mods/player-status",

    OnInitialize = function (context)
        local statusWindow = context.Views.Defaults.StatusWindow
        statusWindow:setShowing(false)
        statusWindow:unregisterEventHandler(context.Data.PlayerStatus():getEvent())
        context.Utils.Table.OverrideFunctions(statusWindow:getDefault())
        local window = UusCorpPlayerStatusWindow(context)
        window:create(true)
        window:setShowing(true)
        window:setOffsetFromParent(0, 0)
    end
}