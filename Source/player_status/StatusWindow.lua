StatusWindow = setmetatable({}, {__index = UusCorpWindow})
StatusWindow.__index = StatusWindow
StatusWindow.Name = "StatusWindow"

function StatusWindow:init()
	local this = UusCorpWindow.init(self, StatusWindow.Name)

	local HEALTH_BAR = this.name .. "HealthBar"
	local HEALTH_TEXT = this.name .. "HealthTooltip"

	local MANA_BAR = this.name .. "ManaBar"
	local MANA_TEXT = this.name .. "ManaTooltip"

	local STAMINA_BAR = this.name .. "StaminaBar"
	local STAMINA_TEXT = this.name .. "StaminaTooltip"

	local healthBar = UusCorpStatusBar:init(HEALTH_BAR)
	this.childAdapter:addChild(healthBar)
	local healthText = UusCorpLabel:init(HEALTH_TEXT)
	this.childAdapter:addChild(healthText)

	local manaBar = UusCorpStatusBar:init(MANA_BAR)
	this.childAdapter:addChild(manaBar)
	local manaText = UusCorpLabel:init(MANA_TEXT)
	this.childAdapter:addChild(manaText)

	local staminaBar = UusCorpStatusBar:init(STAMINA_BAR)
	this.childAdapter:addChild(staminaBar)
	local staminaText = UusCorpLabel:init(STAMINA_TEXT)
	this.childAdapter:addChild(staminaText)

	this.dataAdapter:addData(PlayerStatus.type())
	this.dataAdapter:addData(MobileName.type(), PlayerStatus.id())
	this.dataAdapter:addData(Paperdoll.type(), PlayerStatus.id())

	this.eventAdapter:onEvent(PlayerStatus.event(), function()
		if not PlayerStatus.id() then return end

		local healthColor

		if PlayerStatus.isPoisoned() or PlayerStatus.isCursed() then
			healthColor = Colors.YellowDark
		else
			healthColor = Colors.Red
		end

		healthBar:setCurrentValue(PlayerStatus.currentHealth())
		healthBar:setMaximumValue(PlayerStatus.maxHealth())
		healthBar:setColor(healthColor)
		healthText:setText(L"" .. PlayerStatus.currentHealth() .. L" / " ..
							PlayerStatus.maxHealth())

		manaBar:setCurrentValue(PlayerStatus.currentMana())
		manaBar:setMaximumValue(PlayerStatus.maxMana())
		manaBar:setColor(Colors.Blue)
		manaText:setText(PlayerStatus.currentMana() .. L" / " ..
							PlayerStatus.maxMana())

		staminaBar:setCurrentValue(PlayerStatus.currentStamina())
		staminaBar:setMaximumValue(PlayerStatus.maxStamina())
		staminaBar:setColor(Colors.Green)
		staminaText:setText(PlayerStatus.currentStamina() .. L" / " ..
								PlayerStatus.maxStamina())
	end)

	this.eventAdapter:onShown(function ()
		UserInterfaceVariables.SaveBoolean(this.name.."Closed", false)
		MobileHealthBar.HandleAnchorWindow(this.name)
	end)

	return this
end
