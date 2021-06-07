----------------------------------------------------------------
-- Global Variables
----------------------------------------------------------------

StatusWindow = {}

----------------------------------------------------------------
-- Local Variables
----------------------------------------------------------------

StatusWindow.CurPlayerId = 0

StatusWindow.Locked = false
StatusWindow.HPLocked = false
StatusWindow.MANALocked = false
StatusWindow.STAMLocked = false

StatusWindow.DisableDelta = 0

----------------------------------------------------------------
-- Functions
----------------------------------------------------------------

function StatusWindow.Initialize(reinit)
	RegisterWindowData(WindowData.PlayerStatus.Type,0)
	RegisterWindowData(WindowData.MobileName.Type, WindowData.PlayerStatus.PlayerId)
	RegisterWindowData(WindowData.Paperdoll.Type, WindowData.PlayerStatus.PlayerId)
	
	if not reinit then
		WindowRegisterEventHandler( "StatusWindow", WindowData.PlayerStatus.Event, "StatusWindow.UpdateStatus")
	end
	
	StatusWindow.UpdateStatus()
	-- TODO: Once someone fixes the baseline alignment of the various fonts (so that English isn't 3 pixels above every other language), remove this hack.
	-- START HACK
	if GetStringFromTid( 1011036 ) ~= L"OKAY" then -- assume not English
		local healthLabelName = "StatusWindowHealthTooltip"
		local manaLabelName = "StatusWindowManaTooltip"
		local staminaLabelName = "StatusWindowStaminaTooltip"
		local healthBarName = "StatusWindowHealthBar"
		local manaBarName = "StatusWindowManaBar"
		local staminaBarName = "StatusWindowStaminaBar"
		WindowClearAnchors( healthLabelName )
		WindowClearAnchors( manaLabelName )
		WindowClearAnchors( staminaLabelName )
		WindowAddAnchor( healthLabelName, "top", healthBarName, "top", 0, -6 )
		WindowAddAnchor( manaLabelName, "top", manaBarName, "top", 0, -6 )
		WindowAddAnchor( staminaLabelName, "top", staminaBarName, "top", 0, -6 )
	end	
	-- END HACK
	WindowUtils.RestoreWindowPosition("StatusWindow")
	WindowUtils.LoadScale("StatusWindow")
	
	Interface.StatusWindowStyle = Interface.LoadNumber( "StatusWindowStyle", Interface.StatusWindowStyle )
	StatusWindow.Locked = Interface.LoadBoolean( "StatusWindowLocked", StatusWindow.Locked )
	local this = "StatusWindow"
	local texture = "UO_Core"
	if ( StatusWindow.Locked  ) then		
		ButtonSetTexture(this.."Lock", InterfaceCore.ButtonStates.STATE_NORMAL, texture, 69,341)
		ButtonSetTexture(this.."Lock",InterfaceCore.ButtonStates.STATE_NORMAL_HIGHLITE, texture, 92,341)
		ButtonSetTexture(this.."Lock", InterfaceCore.ButtonStates.STATE_PRESSED, texture, 92,341)
		ButtonSetTexture(this.."Lock", InterfaceCore.ButtonStates.STATE_PRESSED_HIGHLITE, texture, 92,341)
	else
		ButtonSetTexture(this.."Lock", InterfaceCore.ButtonStates.STATE_NORMAL, texture, 117,341)
		ButtonSetTexture(this.."Lock",InterfaceCore.ButtonStates.STATE_NORMAL_HIGHLITE, texture, 142,341)
		ButtonSetTexture(this.."Lock", InterfaceCore.ButtonStates.STATE_PRESSED, texture, 142,341)
		ButtonSetTexture(this.."Lock", InterfaceCore.ButtonStates.STATE_PRESSED_HIGHLITE, texture, 142,341)		
	end
	
	ButtonSetTexture("StatusWindowMenu", InterfaceCore.ButtonStates.STATE_NORMAL, "arrowdown", 0, 0)
	ButtonSetTexture("StatusWindowMenu",InterfaceCore.ButtonStates.STATE_NORMAL_HIGHLITE, "arrowdown", 22, 0)
	ButtonSetTexture("StatusWindowMenu", InterfaceCore.ButtonStates.STATE_PRESSED, "arrowdown", 22, 0) 
	ButtonSetTexture("StatusWindowMenu", InterfaceCore.ButtonStates.STATE_PRESSED_HIGHLITE, "arrowdown", 22, 0)

	StatusWindow.HPLocked = Interface.LoadBoolean( "StatusWindowHPLocked", StatusWindow.HPLocked )
	StatusWindow.MANALocked = Interface.LoadBoolean( "StatusWindowMANALocked", StatusWindow.MANALocked )
	StatusWindow.STAMLocked = Interface.LoadBoolean( "StatusWindowSTAMLocked", StatusWindow.STAMLocked )
end

function StatusWindow.Shutdown()
	UnregisterWindowData(WindowData.PlayerStatus.Type,0)
	WindowUtils.SaveWindowPosition("StatusWindow")
end

function StatusWindow.LockTooltip()
	if ( StatusWindow.Locked ) then
		Tooltips.CreateTextOnlyTooltip(SystemData.ActiveWindow.name, GetStringFromTid(1155250))
	else
		Tooltips.CreateTextOnlyTooltip(SystemData.ActiveWindow.name, GetStringFromTid(1155251))
	end
	
	Tooltips.Finalize()
	Tooltips.AnchorTooltip( Tooltips.ANCHOR_WINDOW_TOP )
end

function StatusWindow.Lock()
	StatusWindow.Locked = not StatusWindow.Locked 
	Interface.SaveBoolean( "StatusWindowLocked", StatusWindow.Locked  )
	
	local this = "StatusWindow"	
	local texture = "UO_Core"
	if ( StatusWindow.Locked  ) then		
		ButtonSetTexture(this.."Lock", InterfaceCore.ButtonStates.STATE_NORMAL, texture, 69,341)
		ButtonSetTexture(this.."Lock",InterfaceCore.ButtonStates.STATE_NORMAL_HIGHLITE, texture, 92,341)
		ButtonSetTexture(this.."Lock", InterfaceCore.ButtonStates.STATE_PRESSED, texture, 92,341)
		ButtonSetTexture(this.."Lock", InterfaceCore.ButtonStates.STATE_PRESSED_HIGHLITE, texture, 92,341)
	else
		ButtonSetTexture(this.."Lock", InterfaceCore.ButtonStates.STATE_NORMAL, texture, 117,341)
		ButtonSetTexture(this.."Lock",InterfaceCore.ButtonStates.STATE_NORMAL_HIGHLITE, texture, 142,341)
		ButtonSetTexture(this.."Lock", InterfaceCore.ButtonStates.STATE_PRESSED, texture, 142,341)
		ButtonSetTexture(this.."Lock", InterfaceCore.ButtonStates.STATE_PRESSED_HIGHLITE, texture, 142,341)		
	end
end

function StatusWindow.LockTooltipHP()
	if ( StatusWindow.HPLocked ) then
		Tooltips.CreateTextOnlyTooltip(SystemData.ActiveWindow.name, GetStringFromTid(1155255))
	else
		Tooltips.CreateTextOnlyTooltip(SystemData.ActiveWindow.name, GetStringFromTid(1155256))
	end
	
	Tooltips.Finalize()
	Tooltips.AnchorTooltip( Tooltips.ANCHOR_WINDOW_TOP )
end

function StatusWindow.LockHP()
	StatusWindow.HPLocked = not StatusWindow.HPLocked 
	Interface.SaveBoolean( "StatusWindowHPLocked", StatusWindow.HPLocked  )
end

function StatusWindow.LockTooltipMANA()
	if ( StatusWindow.MANALocked ) then
		Tooltips.CreateTextOnlyTooltip(SystemData.ActiveWindow.name, GetStringFromTid(1155257))
	else
		Tooltips.CreateTextOnlyTooltip(SystemData.ActiveWindow.name, GetStringFromTid(1155258))
	end
	
	Tooltips.Finalize()
	Tooltips.AnchorTooltip( Tooltips.ANCHOR_WINDOW_TOP )
end

function StatusWindow.LockMANA()
	StatusWindow.MANALocked = not StatusWindow.MANALocked 
	Interface.SaveBoolean( "StatusWindowMANALocked", StatusWindow.MANALocked  )
end

function StatusWindow.LockTooltipSTAM()
	if ( StatusWindow.STAMLocked ) then
		Tooltips.CreateTextOnlyTooltip(SystemData.ActiveWindow.name, GetStringFromTid(1155259))
	else
		Tooltips.CreateTextOnlyTooltip(SystemData.ActiveWindow.name, GetStringFromTid(1155260))
	end
	
	Tooltips.Finalize()
	Tooltips.AnchorTooltip( Tooltips.ANCHOR_WINDOW_TOP )
end

function StatusWindow.LockSTAM()
	StatusWindow.STAMLocked = not StatusWindow.STAMLocked 
	Interface.SaveBoolean( "StatusWindowSTAMLocked", StatusWindow.STAMLocked  )
end

function StatusWindow.MenuTooltip()
	
	Tooltips.CreateTextOnlyTooltip(SystemData.ActiveWindow.name, GetStringFromTid(1155252))
	
	Tooltips.Finalize()
	Tooltips.AnchorTooltip( Tooltips.ANCHOR_WINDOW_TOP )
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

	if (not StatusWindow.Locked ) then
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