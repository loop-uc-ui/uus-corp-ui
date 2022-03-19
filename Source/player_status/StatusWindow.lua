StatusWindow = middleclass.class("StatusWindow", UusCorpWindow)

local HEALTH_BAR = StatusWindow.name .. "HealthBar"
local HEALTH_TEXT = StatusWindow.name .. "HealthTooltip"

local MANA_BAR = StatusWindow.name .. "ManaBar"
local MANA_TEXT = StatusWindow.name .. "ManaTooltip"

local STAMINA_BAR = StatusWindow.name .. "StaminaBar"
local STAMINA_TEXT = StatusWindow.name .. "StaminaTooltip"

function StatusWindow:init() 
	UusCorpWindow.init(self, "StatusWindow")
end

function StatusWindow:onInitialize()
	local healthBar = UusCorpStatusBar:new(HEALTH_BAR)
	self:addChild(healthBar)
	local healthText = UusCorpLabel:new(HEALTH_TEXT)
	self:addChild(healthText)

	local manaBar = UusCorpStatusBar:new(MANA_BAR)
	self:addChild(manaBar)
	local manaText = UusCorpLabel:new(MANA_TEXT)
	self:addChild(manaText)
	
	local staminaBar = UusCorpStatusBar:new(STAMINA_BAR)
	self:addChild(UusCorpStatusBar:new(STAMINA_BAR))
	local staminaText = UusCorpStatusBar:new(STAMINA_TEXT)
	self:addChild(UusCorpStatusBar:new(STAMINA_TEXT))

	self:registerData(PlayerStatus.type())
	self:registerData(MobileName.type(), PlayerStatus.id())
	self:registerData(Paperdoll.type(), PlayerStatus.id())
	self:registerEventHandler(PlayerStatus.event())

	UusCorpWindow.onInitialize(self)
	self:onEvent()
end

function StatusWindow:onEvent()
	if not PlayerStatus.id() then
		return
	end

	local healthColor

	if PlayerStatus.isPoisoned() or PlayerStatus.isCursed() then
		healthColor = Colors.YellowDark
	else 
		healthColor = Colors.Red
	end

	local healthBar = self.children[HEALTH_BAR]
	healthBar:setCurrentValue(PlayerStatus.currentHealth())
	healthBar:setMaximumValue(PlayerStatus.maxHealth())
	--healthBar:setColor(healthColor)
	local healthText = self.children[HEALTH_TEXT]
	healthText:setText(L""..PlayerStatus.currentHealth()..L" / "..PlayerStatus.maxHealth())

	local manaBar = self.children[MANA_BAR]
	manaBar:setCurrentValue(PlayerStatus.currentMana())
	manaBar:setMaximumValue(PlayerStatus.maxMana())
	--manaBar:setColor(Colors.Blue)
	local manaText = self.children[MANA_TEXT]
	manaText:setText(PlayerStatus.currentMana()..L" / "..PlayerStatus.maxMana())

	local staminaBar = self.children[STAMINA_BAR]
	staminaBar:setCurrentValue(PlayerStatus.currentStamina())
	staminaBar:setMaximumValue(PlayerStatus.maxStamina())
	--staminaBar:setColor(Colors.Green)
	local staminaText = self.children[STAMINA_TEXT]
	staminaText:setText(PlayerStatus.currentStamina()..L" / "..PlayerStatus.maxStamina())
end

function StatusWindow.Shutdown()
	WindowUtils.SaveWindowPosition(StatusWindow.id)
end

function StatusWindow.OnRButtonUp(flags)
	if StatusWindow:isLocked() then
		ContextMenuApi.requestMenu(PlayerStatus.id(), true)
	elseif flags == SystemData.ButtonFlags.SHIFT then
		ContextMenuApi.requestMenu(PlayerStatus.id(), true)
	else
		UserInterfaceVariables.SaveBoolean(StatusWindow.id.."Closed", true)
		StatusWindow:destroy()
	end
end

function StatusWindow.OnLButtonUp()
	if Drag.isItem() then
		DragApi.dragToObject(PlayerStatus.id())
	else
		StatusWindow:onLeftClickUp()
	end
end

function StatusWindow.OnLButtonDown()
	if Cursor.exists() and Cursor.target() then
		TargetApi.clickTarget(PlayerStatus.id())
	else
		StatusWindow:onLeftClickDown()
	end
end

function StatusWindow.OnMouseDoubleClick()
	UserActionApi.useItem(PlayerStatus.id(), true)
end

function StatusWindow.OnShown()
	UserInterfaceVariables.SaveBoolean(StatusWindow.id.."Closed", false)
	StatusWindow:setLocked(false)
	MobileHealthBar.HandleAnchorWindow(StatusWindow.id)
end