StatusWindow = ListWindow:new("StatusWindow")

function StatusWindow.Initialize()
	StatusWindow.eventRegister:registerEventHandler(
			WindowData.PlayerStatus.Event,
			"StatusWindow.UpdateStatus"
	)
	StatusWindow:addLock()
	StatusWindow.UpdateStatus()
	WindowUtils.RestoreWindowPosition(StatusWindow.id, true)
end

function StatusWindow.Shutdown()
	UserInterfaceVariables.SaveBoolean(StatusWindow.id.."Closed", StatusWindow:isShowing())
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

function StatusWindow.OnRButtonUp(flags)
	if flags == SystemData.ButtonFlags.SHIFT then
		ContextMenuApi.requestMenu(WindowData.PlayerStatus.PlayerId, true)
	elseif not StatusWindow:isLocked() then
		StatusWindow:setShowing(false)
	end
end

function StatusWindow.OnLButtonUp()
	StatusWindow:onLeftClickUp()
end

function StatusWindow.OnLButtonDown()
	if WindowData.Cursor ~= nil and WindowData.Cursor.target then
		TargetApi.clickTarget(WindowData.PlayerStatus.PlayerId)
	else
		StatusWindow:onLeftClickDown()
	end
end

function StatusWindow.OnMouseDoubleClick()
	UserActionApi.useItem(WindowData.PlayerStatus.PlayerId, true)
end

function StatusWindow.create()
	--TODO refactor this so we're not calling MobileHealthBar
	StatusWindow:setShowing(true)
	StatusWindow:setLocked(false)
	MobileHealthBar.HandleAnchorWindow(StatusWindow.id)
end