StatusWindow = ListWindow:new("StatusWindow")

function StatusWindow.Initialize()
	StatusWindow.eventRegister:registerEventHandler(
			WindowData.PlayerStatus.Event,
			"StatusWindow.UpdateStatus"
	)
	StatusWindow:addLock()
	StatusWindow.UpdateStatus()
end

function StatusWindow.Shutdown()
	WindowUtils.SaveWindowPosition(StatusWindow.id)
end

function StatusWindow.UpdateStatus()
	if WindowData.PlayerStatus.PlayerId == 0 then
		return
	end

	StatusWindow.adapter:addStatusBar(
			"StatusWindowHealthBar",
			WindowData.PlayerStatus.MaxHealth,
			WindowData.PlayerStatus.CurrentHealth,
			WindowData.PlayerStatus.VisualStateId
	):addStatusBar(
			"StatusWindowManaBar",
			WindowData.PlayerStatus.MaxMana,
			WindowData.PlayerStatus.CurrentMana
	):addStatusBar(
			"StatusWindowStaminaBar",
			WindowData.PlayerStatus.MaxStamina,
			WindowData.PlayerStatus.CurrentStamina
	):addLabel(
			"StatusWindowHealthTooltip",
			L""..WindowData.PlayerStatus.CurrentHealth..L"/"..WindowData.PlayerStatus.MaxHealth
	):addLabel(
			"StatusWindowManaTooltip",
			WindowData.PlayerStatus.CurrentMana..L"/"..WindowData.PlayerStatus.MaxMana
	):addLabel(
			"StatusWindowStaminaTooltip",
			WindowData.PlayerStatus.CurrentStamina..L"/"..WindowData.PlayerStatus.MaxStamina
	)
end

function StatusWindow.Menu(flags)
	if flags == SystemData.ButtonFlags.CONTROL then
		ContextMenuApi.requestMenu(WindowData.PlayerStatus.PlayerId, true)
	end
end

function StatusWindow.OnLButtonUp()
	StatusWindow:onLeftClickUp()
end

function StatusWindow.OnLButtonDown()
	StatusWindow:onLeftClickDown()
end

function StatusWindow.OnMouseDoubleClick()
	UserActionApi.useItem(WindowData.PlayerStatus.PlayerId, true)
end