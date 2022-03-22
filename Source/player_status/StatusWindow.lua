StatusWindow = { 
	Name = "StatusWindow",
	init = function()
		local self = UusCorpWindow.init(StatusWindow.Name)

		local HEALTH_BAR = self.getName() .. "HealthBar"
		local HEALTH_TEXT = self.getName() .. "HealthTooltip"

		local MANA_BAR = self.getName() .. "ManaBar"
		local MANA_TEXT = self.getName() .. "ManaTooltip"

		local STAMINA_BAR = self.getName() .. "StaminaBar"
		local STAMINA_TEXT = self.getName() .. "StaminaTooltip"

		local healthBar = UusCorpStatusBar.init(HEALTH_BAR)
		self.addChild(healthBar)
		local healthText = UusCorpLabel.init(HEALTH_TEXT)
		self.addChild(healthText)

		local manaBar = UusCorpStatusBar.init(MANA_BAR)
		self.addChild(manaBar)
		local manaText = UusCorpLabel.init(MANA_TEXT)
		self.addChild(manaText)

		local staminaBar = UusCorpStatusBar.init(STAMINA_BAR)
		self.addChild(staminaBar)
		local staminaText = UusCorpLabel.init(STAMINA_TEXT)
		self.addChild(staminaText)

		self.addData(PlayerStatus.type())
		self.addData(MobileName.type(), PlayerStatus.id())
		self.addData(Paperdoll.type(), PlayerStatus.id())

		self.addEvent(PlayerStatus.event(), function()
			if not PlayerStatus.id() then return end

			local healthColor

			if PlayerStatus.isPoisoned() or PlayerStatus.isCursed() then
				healthColor = Colors.YellowDark
			else
				healthColor = Colors.Red
			end

			healthBar.setCurrentValue(PlayerStatus.currentHealth())
			healthBar.setMaximumValue(PlayerStatus.maxHealth())
			healthBar.setColor(healthColor)
			healthText.setText(L"" .. PlayerStatus.currentHealth() .. L" / " ..
								PlayerStatus.maxHealth())

			manaBar.setCurrentValue(PlayerStatus.currentMana())
			manaBar.setMaximumValue(PlayerStatus.maxMana())
			manaBar.setColor(Colors.Blue)
			manaText.setText(PlayerStatus.currentMana() .. L" / " ..
								PlayerStatus.maxMana())

			staminaBar.setCurrentValue(PlayerStatus.currentStamina())
			staminaBar.setMaximumValue(PlayerStatus.maxStamina())
			staminaBar.setColor(Colors.Green)
			staminaText.setText(PlayerStatus.currentStamina() .. L" / " ..
									PlayerStatus.maxStamina())
		end)

		self.getLifeCycle().onShown = function ()
			UserInterfaceVariables.SaveBoolean(self.getName().."Closed", false)
			MobileHealthBar.HandleAnchorWindow(self.getName())
		end

		return self
	end 
}
