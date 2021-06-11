StatusWindow = ListWindow:new("StatusWindow")

StatusWindow.CurPlayerId = 0

StatusWindow.Locked = false

StatusWindow.DisableDelta = 0

function StatusWindow.Initialize(reinit)
	StatusWindow:registerData(WindowData.PlayerStatus.Type, 0)
			:registerData(WindowData.MobileName.Type, WindowData.PlayerStatus.PlayerId)
			:registerData(WindowData.Paperdoll.Type, WindowData.PlayerStatus.PlayerId)
	
	if not reinit then
		WindowRegisterEventHandler( "StatusWindow", WindowData.PlayerStatus.Event, "StatusWindow.UpdateStatus")
	end
	
	StatusWindow.UpdateStatus()
	StatusWindow:addLock()
end

function StatusWindow.Shutdown()
	UnregisterWindowData(WindowData.PlayerStatus.Type,0)
	WindowUtils.SaveWindowPosition("StatusWindow")
end

function StatusWindow.Lock()
	StatusWindow.Locked = not StatusWindow.Locked 
	Interface.SaveBoolean( "StatusWindowLocked", StatusWindow.Locked  )
end

function StatusWindow.Menu()
	RequestContextMenu(WindowData.PlayerStatus.PlayerId, true)
end

StatusWindow.TempDisabled = false

function StatusWindow.ClickOutside()
	StatusWindow.TempDisabled = true
end

function StatusWindow.EnableInput(timePassed)
	if StatusWindow.TempDisabled then
		StatusWindow.DisableDelta = StatusWindow.DisableDelta + timePassed
		if StatusWindow.DisableDelta > 1 then
			StatusWindow.TempDisabled = false
			StatusWindow.DisableDelta = 0
		end
	end
end

function StatusWindow.UpdateStatus()
	--Debug.PrintToDebugConsole(L"UPDATING STATUS")
	if WindowData.PlayerStatus.PlayerId == 0 then
		return
	end
	StatusBarSetMaximumValue( "StatusWindowHealthBar", WindowData.PlayerStatus.MaxHealth )
	StatusBarSetMaximumValue( "StatusWindowManaBar", WindowData.PlayerStatus.MaxMana )
	StatusBarSetMaximumValue( "StatusWindowStaminaBar", WindowData.PlayerStatus.MaxStamina )
	StatusBarSetCurrentValue( "StatusWindowHealthBar", WindowData.PlayerStatus.CurrentHealth )
	StatusBarSetCurrentValue( "StatusWindowManaBar", WindowData.PlayerStatus.CurrentMana )
	StatusBarSetCurrentValue( "StatusWindowStaminaBar", WindowData.PlayerStatus.CurrentStamina )
	--Colors the health bar to the correct color
	HealthBarColor.UpdateHealthBarColor("StatusWindowHealthBar", WindowData.PlayerStatus.VisualStateId)
	--Update label tooltip health, mana, and stamina
	StatusWindow.UpdateLabelContent()
	
	UnregisterWindowData(WindowData.MobileName.Type, WindowData.PlayerStatus.PlayerId)
	RegisterWindowData(WindowData.MobileName.Type, WindowData.PlayerStatus.PlayerId)
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

function StatusWindow.UpdateLabelContent()
	local healthLabelName = "StatusWindowHealthTooltip"
	local manaLabelName = "StatusWindowManaTooltip"
	local staminaLabelName = "StatusWindowStaminaTooltip"
	local healthStr = L""..WindowData.PlayerStatus.CurrentHealth..L"/"..WindowData.PlayerStatus.MaxHealth
	local manaStr = WindowData.PlayerStatus.CurrentMana..L"/"..WindowData.PlayerStatus.MaxMana
	local staminaStr = WindowData.PlayerStatus.CurrentStamina..L"/"..WindowData.PlayerStatus.MaxStamina
	--local statStr = healthStr..L"<BR>"..manaStr..L"<BR>"..staminaStr
	LabelSetText(healthLabelName, WindowUtils.translateMarkup(healthStr))
	LabelSetText(manaLabelName, WindowUtils.translateMarkup(manaStr))
	LabelSetText(staminaLabelName, WindowUtils.translateMarkup(staminaStr))
end

function StatusWindow.OnMouseOver()
	local itemData =
	{
		windowName = "ActionsWindow",
		itemId = StatusWindow.CurPlayerId,
		itemType = WindowData.ItemProperties.TYPE_ITEM,
	}					
	ItemProperties.SetActiveItem(itemData)
end

function StatusWindow.OnMouseOverEnd()
	ItemProperties.ClearMouseOverItem()
end

function StatusWindow.OnMouseDlbClk()
    UserActionUseItem(StatusWindow.CurPlayerId,false)
end

StatusWindow.MPHeight = 193
StatusWindow.MPWidth = 200
StatusWindow.LastMPHeight = -2

function StatusWindow.SetMana( current, maximum )
    local height = math.ceil( ( StatusWindow.MPHeight * current ) / maximum )
    if height ~= StatusWindow.LastMPHeight then
        StatusWindow.LastMPHeight = height
    end
end

StatusWindow.HPHeight = 193
StatusWindow.HPWidth = 200
StatusWindow.LastHPHeight = -2

function StatusWindow.SetHealth( current, maximum )
	if maximum == 0 then
		return
	end
    local height = math.ceil( ( StatusWindow.HPHeight * current ) / maximum )
    if height ~= StatusWindow.LastHPHeight then
        StatusWindow.LastHPHeight = height
    end
end