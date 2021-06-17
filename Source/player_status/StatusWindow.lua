StatusWindow = ListWindow:new("StatusWindow", false)

function StatusWindow.Initialize()
	StatusWindow.eventRegister:registerEventHandler(
			PlayerStatus.event(),
			"StatusWindow.UpdateStatus"
	)
	StatusWindow.adapter:addLock()
	StatusWindow.UpdateStatus()
	WindowUtils.RestoreWindowPosition(StatusWindow.id, true)
end

function StatusWindow.Shutdown()
	UserInterfaceVariables.SaveBoolean(StatusWindow.id.."Closed", StatusWindow:isShowing())
	WindowUtils.SaveWindowPosition(StatusWindow.id)
end

function StatusWindow.UpdateStatus()
	if PlayerStatus.id() == 0 then
		return
	end

	local health = Colors.Red

	if PlayerStatus.isPoisoned() then
		health = Colors.Green
	elseif PlayerStatus.isCursed() then
		health = Colors.Yellow
	end

	StatusWindow.adapter:addStatusBar(
			"StatusWindowHealthBar",
			PlayerStatus.maxHealth(),
			PlayerStatus.currentHealth(),
			health
	):addStatusBar(
			"StatusWindowManaBar",
			PlayerStatus.maxMana(),
			PlayerStatus.currentMana(),
			Colors.Blue
	):addStatusBar(
			"StatusWindowStaminaBar",
			PlayerStatus.maxStamina(),
			PlayerStatus.currentStamina(),
			Colors.Green
	):addLabel(
			"StatusWindowHealthTooltip",
			L""..PlayerStatus.currentHealth()..L" / "..PlayerStatus.maxHealth()
	):addLabel(
			"StatusWindowManaTooltip",
			PlayerStatus.currentMana()..L" / "..PlayerStatus.maxMana()
	):addLabel(
			"StatusWindowStaminaTooltip",
			PlayerStatus.currentStamina()..L" / "..PlayerStatus.maxStamina()
	)
end

function StatusWindow.OnRButtonUp(flags)
	if flags == SystemData.ButtonFlags.SHIFT then
		ContextMenuApi.requestMenu(PlayerStatus.id(), true)
	elseif not StatusWindow:isLocked() then
		StatusWindow:setShowing(false)
	end
end

function StatusWindow.OnLButtonUp()
	StatusWindow:onLeftClickUp()
end

function StatusWindow.onMouseOver()
	if Drag.isItem() then
		DragApi.dragToObject(PlayerStatus.id())
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

function StatusWindow.create()
	--TODO refactor this so we're not calling MobileHealthBar
	StatusWindow:setShowing(true)
	StatusWindow:setLocked(false)
	MobileHealthBar.HandleAnchorWindow(StatusWindow.id)
end