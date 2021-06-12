StatusWindow = ListWindow:new("StatusWindow")

StatusWindow.CurPlayerId = 0

function StatusWindow.Initialize()
	StatusWindow.eventRegister:registerEventHandler(
			WindowData.PlayerStatus.Event,
			"StatusWindow.UpdateStatus"
	)
	StatusWindow:addLock()
end

function StatusWindow.Shutdown()
	WindowUtils.SaveWindowPosition(StatusWindow.id)
end

function StatusWindow.Menu()
	ContextMenuApi.requestMenu(WindowData.PlayerStatus.PlayerId, true)
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

function StatusWindow.OnLButtonUp()
	if( SystemData.DragItem.DragType == SystemData.DragItem.TYPE_ITEM ) then
	    DragSlotDropObjectToObject(StatusWindow.CurPlayerId)
	else
		WindowSetMoving("StatusWindow",false)
		HandleSingleLeftClkTarget(WindowData.PlayerStatus.PlayerId)
	end
end

function StatusWindow.OnLButtonDown()
	if not StatusWindow:isLocked() then
		SnapUtils.StartWindowSnap("StatusWindow")
		WindowSetMoving("StatusWindow",true)
	else
		WindowSetMoving("StatusWindow",false)
	end
end

function StatusWindow.OnHPLButtonUp()
	HandleSingleLeftClkTarget(WindowData.PlayerStatus.PlayerId)
end

function StatusWindow.OnHPLButtonDown()

end

function StatusWindow.OnMLANAButtonUp()
	HandleSingleLeftClkTarget(WindowData.PlayerStatus.PlayerId)
end

function StatusWindow.OnMANALButtonDown()

end

function StatusWindow.OnSTAMLButtonUp()
	HandleSingleLeftClkTarget(WindowData.PlayerStatus.PlayerId)
end

function StatusWindow.OnSTAMLButtonDown()

end

function StatusWindow.OnRButtonUp()
	RequestContextMenu(WindowData.PlayerStatus.PlayerId)
end

function StatusWindow.OnMouseDlbClk()
    UserActionUseItem(StatusWindow.CurPlayerId,false)
end