----------------------------------------------------------------
-- Global Variables
----------------------------------------------------------------

MobileHealthBar = {}

----------------------------------------------------------------
-- Local Variables
----------------------------------------------------------------

MobileHealthBar.hasWindow = {}
MobileHealthBar.windowDisabled = {}
MobileHealthBar.mouseOverId = 0

MobileHealthBar.Changelings = {}
MobileHealthBar.Irks = {}
MobileHealthBar.Guiles = {}
MobileHealthBar.Spites = {}
MobileHealthBar.Travestys = {}

MobileHealthBar.Handled = {}
MobileHealthBar.SummonTimer = {}
MobileHealthBar.CreateTime = {}
MobileHealthBar.CheckStatus = {}
MobileHealthBar.RegisterTime = {}

MobileHealthBar.LegacyCloseStyle = false
MobileHealthBar.PetLegacyCloseStyle = false

----------------------------------------------------------------
-- Functions
----------------------------------------------------------------

function MobileHealthBar.CreateHealthBar(mobileId)
    local windowName = "MobileHealthBar_"..mobileId
	
	-- Create and register if doesn't exist
	if( DoesWindowNameExist(windowName) == false ) then
		CreateWindowFromTemplate(windowName, "MobileHealthBar", "Root")
		MobileHealthBar.CreateTime[mobileId] = Interface.TimeSinceLogin + 2
		WindowSetShowing(windowName.."SummonDuration", false)
		WindowSetTintColor(windowName.."SummonDuration", 106, 106, 255)
		StatusBarSetMaximumValue( windowName.."SummonDuration", 0)
		WindowSetId(windowName, mobileId)
		WindowSetId(windowName.."CloseButton", mobileId)
		
		MobileHealthBar.RegisterHealthBar(windowName)
		
		WindowSetShowing(windowName .. "HealthBarPerc", false)
		WindowSetShowing(windowName .. "GreenButton", false)
		WindowSetShowing(windowName .. "RedButton", false)
		WindowSetShowing(windowName .. "BlueButton", false)
		
		LabelSetFont(windowName.."HealthBarLabel","Arial_Black_Shadow_12",18)
		WindowSetShowing(windowName.."HealthBarLabel", false)
		LabelSetTextColor (windowName.."HealthBarLabel", 255,255,255)
		WindowSetShowing(windowName .. "GreenButton", true)
		WindowSetShowing(windowName .. "RedButton", true)
		WindowSetShowing(windowName .. "BlueButton", true)
		Interface.DestroyWindowOnClose[windowName] = true		
	else		
		MobileHealthBar.ExtractWindow(windowName)
		return
	end	

	MobileHealthBar.UpdateName(mobileId)
	MobileHealthBar.UpdateStatus(mobileId)
	MobileHealthBar.UpdateHealthBarColor(mobileId)
	MobileHealthBar.UpdateHealthBarState(mobileId)
	WindowUtils.LoadScale( "MobileHealthBarSCALE" )
	
	if (MobilesOnScreen.IsPet(mobileId) and not DoesWindowNameExist(windowName.."Inventory")) then
		CreateWindowFromTemplate( windowName.."Inventory", "PetInventoryIconTemplate", windowName)
		WindowClearAnchors(windowName.."Inventory")
		WindowAddAnchor(windowName.."Inventory", "topright", windowName .. "Name", "topleft", -4, 13)
		WindowSetShowing(windowName.."Inventory", false)
	end
	if(DoesWindowNameExist(windowName.."Inventory")) then
		WindowSetScale(windowName.."Inventory", WindowGetScale(windowName))
	end
	RegisterWindowData(WindowData.MobileName.Type, mobileId)
	if (IsMobile(mobileId) and not DoesWindowNameExist(windowName.."Bod") and WindowData.MobileName[mobileId]) then
		if IsBodDealer( mobileId ) then
			CreateWindowFromTemplate( windowName.."Bod", "BodIconTemplate", windowName)
			WindowClearAnchors(windowName.."Bod")
			WindowAddAnchor(windowName.."Bod", "topright", windowName .. "Name", "topleft", -7, 20)
			WindowSetShowing(windowName.."Bod", true)
		end
	end
	if(DoesWindowNameExist(windowName.."Bod")) then
		WindowSetScale(windowName.."Bod", WindowGetScale(windowName))
	end
	
	if (IsMobile(mobileId) and not DoesWindowNameExist(windowName.."Talk")) and WindowData.MobileName[mobileId] then
		
		if (IsOldQuestGiver( mobileId )) then
			CreateWindowFromTemplate( windowName.."Talk", "TalkIconTemplate", windowName)
			WindowClearAnchors(windowName.."Talk")
			WindowAddAnchor(windowName.."Talk", "topright", windowName .. "Name", "topleft", -4, 20)
		end
	end
	if(DoesWindowNameExist(windowName.."Talk")) then
		WindowSetScale(windowName.."Talk", WindowGetScale(windowName))
	end
		
	if (IsMobile(mobileId) and not DoesWindowNameExist(windowName.."Bank")) and WindowData.MobileName[mobileId] then
		
		if (IsBanker( mobileId )) then
			CreateWindowFromTemplate( windowName.."Bank", "BankIconTemplate", windowName)
			WindowClearAnchors(windowName.."Bank")
			WindowAddAnchor(windowName.."Bank", "topright", windowName .. "Name", "topleft", -4, 20)			
		end	
	end
	if(DoesWindowNameExist(windowName.."Bank")) then
		WindowSetScale(windowName.."Bank", WindowGetScale(windowName))
	end
	
	if(MobileHealthBar.Forced) then
		MobileHealthBar.Handled[mobileId] = false
		if (Interface.ShowCloseExtract) then
			WindowSetShowing( windowName .. "CloseButton", false)
			WindowSetShowing( windowName .. "Extract", true)
		else
			WindowSetShowing( windowName .. "CloseButton", false)
			WindowSetShowing( windowName .. "Extract", false)
		end
		
		MobileHealthBar.HandleAnchorWindow(windowName)		
	else		
		MobileHealthBar.ExtractWindow(windowName)
	end
end

--Sets the Window close to where the player dragged their mouse
function MobileHealthBar.HandleAnchorWindow(healthWindow)
	local mobileId = WindowGetId(healthWindow)

	if healthWindow ~= "StatusWindow" then
		WindowSetScale(healthWindow, SystemData.Settings.Interface.customUiScale * 0.80)
		WindowUtils.LoadScale( "MobileHealthBarSCALE" )
	end

	if ( healthWindow == "StatusWindow" or (MobileHealthBar.Forced == false and not MobileHealthBar.Handled[mobileId])) then
		local propWindowX
		local propWindowY
		local scaleFactor = 1 / InterfaceCore.scale
		local propWindowWidth = 180
		local propWindowHeight = 38
		
		-- Set the position
		local mouseX = SystemData.MousePosition.x - 30
		if mouseX + (propWindowWidth / scaleFactor) > SystemData.screenResolution.x then
			propWindowX = mouseX - (propWindowWidth / scaleFactor)
		else
			propWindowX = mouseX
		end
			
		local mouseY = SystemData.MousePosition.y - 15
		if mouseY + (propWindowHeight / scaleFactor) > SystemData.screenResolution.y then
			propWindowY = mouseY - (propWindowHeight / scaleFactor)
		else
			propWindowY = mouseY
		end
		
		SnapUtils.StartWindowSnap(healthWindow)

		local parent = WindowGetParent(healthWindow)
		if parent ~= nil and parent ~= "" then			
			WindowSetOffsetFromParent(healthWindow, propWindowX * scaleFactor, propWindowY * scaleFactor)		
		end		
	end
end

function MobileHealthBar.RegisterHealthBar(windowName)
	local mobileId = WindowGetId(windowName)
	
	WindowRegisterEventHandler(windowName, WindowData.MobileStatus.Event, "MobileHealthBar.HandleMobileStatusUpdate")
	WindowRegisterEventHandler(windowName, WindowData.MobileName.Event, "MobileHealthBar.HandleMobileNameUpdate")
	WindowRegisterEventHandler(windowName, WindowData.HealthBarColor.Event, "MobileHealthBar.HandleHealthBarColorUpdate")
	WindowRegisterEventHandler(windowName, SystemData.Events.ENABLE_HEALTHBAR_WINDOW, "MobileHealthBar.HandleHealthBarStateUpdate")
	WindowRegisterEventHandler(windowName, SystemData.Events.DISABLE_HEALTHBAR_WINDOW, "MobileHealthBar.HandleHealthBarStateUpdate")
	
	RegisterWindowData(WindowData.MobileStatus.Type, mobileId)
	RegisterWindowData(WindowData.MobileName.Type, mobileId)
	RegisterWindowData(WindowData.HealthBarColor.Type, mobileId)
		
	MobileHealthBar.hasWindow[mobileId] = true
	MobileHealthBar.windowDisabled[mobileId] = false
	MobileHealthBar.RegisterTime[mobileId] = Interface.TimeSinceLogin
	
	SnapUtils.SnappableWindows[windowName] = true
end

function MobileHealthBar.UnregisterHealthBar(windowName)
	local mobileId = WindowGetId(windowName)
		
	WindowUnregisterEventHandler(windowName, WindowData.MobileStatus.Event)
	WindowUnregisterEventHandler(windowName, WindowData.MobileName.Event)
	WindowUnregisterEventHandler(windowName, WindowData.HealthBarColor.Event)
	WindowUnregisterEventHandler(windowName, SystemData.Events.ENABLE_HEALTHBAR_WINDOW)
	WindowUnregisterEventHandler(windowName, SystemData.Events.DISABLE_HEALTHBAR_WINDOW)

	if WindowData.PlayerStatus.PlayerId ~= mobileId and CurrentTarget.id() ~= mobileId then
		UnregisterWindowData(WindowData.MobileStatus.Type, mobileId)
		UnregisterWindowData(WindowData.MobileName.Type, mobileId)
		UnregisterWindowData(WindowData.HealthBarColor.Type, mobileId)
	end

	MobileHealthBar.hasWindow[mobileId] = nil
	MobileHealthBar.windowDisabled[mobileId] = nil
	
	SnapUtils.SnappableWindows[windowName] = nil
	
	if (MobileHealthBar.mouseOverId == mobileId) then
		MobileHealthBar.OnMouseOverEnd()
	end
end

function MobileHealthBar.HasWindow(mobileId)
	if( MobileHealthBar.hasWindow[mobileId] == true ) then
		return true
	end
	
	return false
end

function MobileHealthBar.GetWindowName(mobileId)
	return "MobileHealthBar_"..mobileId
end

function MobileHealthBar.HandleMobileStatusUpdate()
    MobileHealthBar.UpdateStatus(WindowData.UpdateInstanceId)
end

function MobileHealthBar.UpdateStatus(mobileId)
	local windowName = "MobileHealthBar_"..mobileId
	
	local mobileData = Interface.GetMobileData(mobileId, true)
	local data = WindowData.MobileName[mobileId]
	
	MobileHealthBar.UpdateHealthBarState(mobileId)
	
	if(MobileHealthBar.hasWindow[mobileId] == true and data and mobileData) then
		--Set mobile's health status bar
		local curHealth = mobileData.CurrentHealth
		local maxHealth = mobileData.MaxHealth
		
		StatusBarSetCurrentValue( windowName.."HealthBar", curHealth )	
		StatusBarSetMaximumValue( windowName.."HealthBar", maxHealth )
		
		if (Interface.ShowCloseExtract and MobileHealthBar.Handled[mobileId] ~= nil) then
			WindowSetShowing( windowName .. "CloseButton", MobileHealthBar.Handled[mobileId])
			WindowSetShowing( windowName .. "Extract", not MobileHealthBar.Handled[mobileId])
		else
			WindowSetShowing( windowName .. "CloseButton", false)
			WindowSetShowing( windowName .. "Extract", false)
		end
	
			
		-- Check if the has an accessible backpack (for pets)
		if (DoesWindowNameExist(windowName.."Inventory") ) then
			if HasAccessibleInventory(mobileId) and GetDistanceFromPlayer(mobileId) <=2 then
				WindowSetShowing( windowName.."Inventory", true)
			else
				WindowSetShowing( windowName.."Inventory", false)
			end
		end
		
		local bodDealer = IsBodDealer( mobileId )
		if bodDealer and not DoesWindowNameExist(windowName.."Bod") then
			CreateWindowFromTemplate( windowName.."Bod", "BodIconTemplate", windowName)
			WindowClearAnchors(windowName.."Bod")
			WindowAddAnchor(windowName.."Bod", "topright", windowName .. "Name", "topleft", -7, 20)
			WindowSetShowing(windowName.."Bod", true)
		elseif(DoesWindowNameExist(windowName.."Bod") and not bodDealer) then
			DestroyWindow(windowName.."Bod")
		end
		
		if(DoesWindowNameExist(windowName.."Bod")) then
			WindowSetScale(windowName.."Bod", WindowGetScale(windowName))
		end
		
		-- Update percentage
		local perc = math.floor((curHealth/maxHealth)*100)
		
		if (tostring(perc) == "-1.#IND") then
			perc = 0
			MobileHealthBar.CheckStatus[mobileId] = true
			if Interface.TimeSinceLogin >= MobileHealthBar.RegisterTime[mobileId] + 1 then
				MobileHealthBar.RegisterTime[mobileId] = Interface.TimeSinceLogin
				return
			end
		end
				
	
		WindowSetShowing(windowName .. "GreenButton", data.Notoriety+1 ~= NameColor.Notoriety.INVULNERABLE)
		WindowSetShowing(windowName .. "RedButton", data.Notoriety+1 ~= NameColor.Notoriety.INVULNERABLE)
		WindowSetShowing(windowName .. "BlueButton", data.Notoriety+1 ~= NameColor.Notoriety.INVULNERABLE)			
		LabelSetText(windowName .. "HealthBarPerc", L"0%")
		local dead =  mobileData.IsDead		
		if (perc ~= nil and perc >= 0 and  mobileId ~= WindowData.PlayerStatus.PlayerId and not dead ) then
			perc = math.max(perc, 1)
			MobileHealthBar.CheckStatus[mobileId] = nil
			WindowSetShowing(windowName.."HealthBarPerc",true)
			local gb = math.floor(2.55 * perc)
			LabelSetTextColor(windowName .. "HealthBarPerc", 255, gb, gb)
			LabelSetText(windowName .. "HealthBarPerc", perc .. L"%")
		elseif ((data == nil or tostring(perc) == "-1.#IND") and not MobileHealthBar.Handled[mobileId] and  mobileId ~= WindowData.PlayerStatus.PlayerId ) then
			MobileHealthBar.CheckStatus[mobileId] = true
			
		else
			WindowSetShowing(windowName .. "HealthBarPerc", false)		
		end

	end
end

function MobileHealthBar.ExtractWindow(windowName)
	local mobileId = 0
	if (windowName ~= nil and type(windowName) == "string") then
		mobileId = WindowGetId(windowName)
	else
		 mobileId = WindowGetId(WindowUtils.GetActiveDialog())
		 windowName = "MobileHealthBar_"..mobileId
	end


	local isPet = MobilesOnScreen.IsPet(mobileId)
	if isPet ~= true then
		if HealthBarManager.CappedNumServerHealthBars == HealthBarManager.NumHealthBars then		
			local lastHBWindowName = "MobileHealthBar_"..HealthBarManager.LastHandledHealthBar
			if(DoesWindowNameExist(lastHBWindowName) == false)then			
				return
			end

			if MobilesOnScreen.IsManagedMobileOnScreen(HealthBarManager.LastHandledHealthBar) then			
				return
			end

			if not(MobileHealthBar.CloseWindowByMobileId(HealthBarManager.LastHandledHealthBar))then			
				return
			end
			HealthBarManager.NumHealthBars = HealthBarManager.NumHealthBars + 1
		elseif MobileHealthBar.Handled[mobileId] ~= true then
			HealthBarManager.NumHealthBars = HealthBarManager.NumHealthBars + 1
		end
		MobilesOnScreen.isDirty = true
		
		if MobilesOnScreen.IsManagedMobileOnScreen(mobileId) then
			HealthBarManager.LastHandledHealthBar = mobileId		
			MobilesOnScreen.RemoveMobileOnScreenCount(mobileId)
		end
	end	

	MobileHealthBar.Handled[mobileId] = true
	
	if (MobilesOnScreen.IsPet(mobileId)) then		
		PetWindow.UpdateAnchors()
	elseif (IsMobile(mobileId)) then			
		MobilesOnScreen.HandleAnchors()
	else
		MobileHealthBar.HandleAnchorWindow(windowName)
		return
	end
	
	if (Interface.ShowCloseExtract and MobileHealthBar.Handled[mobileId] ~= nil) then
		WindowSetShowing( windowName .. "CloseButton", MobileHealthBar.Handled[mobileId])
		WindowSetShowing( windowName .. "Extract", not MobileHealthBar.Handled[mobileId])
	else
		WindowSetShowing( windowName .. "CloseButton", false)
		WindowSetShowing( windowName .. "Extract", false)
	end
		
	MobileHealthBar.HandleAnchorWindow(windowName)
	WindowClearAnchors(windowName)
	local propWindowX
	local propWindowY
	local scale = WindowGetScale(windowName)
	
	local scaleFactor = 1/scale

	-- Set the position
	local mouseX = SystemData.MousePosition.x - 30	
	propWindowX = mouseX	
		
	local mouseY = SystemData.MousePosition.y - 15
	propWindowY = mouseY	
	
	local parent = WindowGetParent(windowName)
	if parent ~= nil and parent ~= "" then
		WindowSetOffsetFromParent(windowName, propWindowX * scaleFactor, propWindowY * scaleFactor)		
	end
	SnapUtils.StartWindowSnap(windowName)
	
end

function MobileHealthBar.HandleMobileNameUpdate()
	if (IsMobile(WindowData.UpdateInstanceId)) then		
		MobileHealthBar.UpdateName(WindowData.UpdateInstanceId)
	else		
		DestroyWindow("MobileHealthBar_"..WindowData.UpdateInstanceId)
	end
end

function MobileHealthBar.UpdateName(mobileId)
	if(MobileHealthBar.hasWindow[mobileId] == true) then
		local windowName = "MobileHealthBar_"..mobileId
		if(WindowData.MobileName[mobileId] ~= nil) then
			local data = WindowData.MobileName[mobileId]			
			OverheadText.ChangelingNameCheck(data, windowName, mobileId)			
			WindowUtils.FitTextToLabel(windowName.."Name", data.MobName)
			NameColor.UpdateLabelNameColor(windowName.."Name", data.Notoriety+1)
			local noto = NameColor.TextColors[data.Notoriety+1]

			if (mobileId == Interface.CurrentHonor) then				
				LabelSetTextColor(windowName.."Name", 163, 73, 164)
			end		
			WindowSetTintColor(windowName .. "Background", noto.r,noto.g,noto.b)
		else
			local name = LabelGetText(windowName.."Name")
			if wstring.len(name) <=0 or name ~= L"???" then
				name = ItemProperties.GetObjectProperties( mobileId, 1, "Healthbar name update - checking if in the properties there is a name")
				if name then
					LabelSetText(windowName.."Name", name )
				else
					LabelSetText(windowName.."Name", L"???" )
				end
			end
		end
	end
end

function MobileHealthBar.HandleHealthBarColorUpdate()
    MobileHealthBar.UpdateHealthBarColor(WindowData.UpdateInstanceId)
end

function MobileHealthBar.UpdateHealthBarColor(mobileId)
	if(MobileHealthBar.hasWindow[mobileId] == true) then
		local windowName = "MobileHealthBar_"..mobileId
		local healthBarWindow = windowName.."HealthBar"
		
		HealthBarColor.UpdateHealthBarColor(healthBarWindow, WindowData.HealthBarColor[mobileId].VisualStateId)
	end
end

function MobileHealthBar.HandleHealthBarStateUpdate()
	local mobileId = WindowGetId(SystemData.ActiveWindow.name)
	MobileHealthBar.UpdateHealthBarState(mobileId)
end

function MobileHealthBar.UpdateHealthBarState(mobileId)
	if(MobileHealthBar.hasWindow[mobileId] == true) then
		-- enable window
		if( IsHealthBarEnabled(mobileId) == true and MobileHealthBar.windowDisabled[mobileId]==true ) then
			local windowName = "MobileHealthBar_"..mobileId
			WindowSetShowing(windowName.."HealthBar", true)
			
			LabelSetTextColor(windowName.."HealthBarLabel", 255, 255, 255)
			
			MobileHealthBar.windowDisabled[mobileId] = false		
			if(MobileHealthBar.Handled[mobileId] ~= true and not MobilesOnScreen.IsPet(mobileId))then
				MobilesOnScreen.UnMarkHealthBarForDeletion(mobileId)				
			end
		-- disable window
		elseif( IsHealthBarEnabled(mobileId) == false and MobileHealthBar.windowDisabled[mobileId]==false ) then
			local windowName = "MobileHealthBar_"..mobileId
			WindowSetShowing(windowName.."HealthBar",false)			
			--LabelSetTextColor(windowName.."Name", 128, 128, 128)
			LabelSetTextColor(windowName.."HealthBarLabel", 128, 128, 128)			
			MobileHealthBar.windowDisabled[mobileId] = true
			MobilesOnScreen.isDirty = true			
			if(MobileHealthBar.Handled[mobileId] ~= true and not MobilesOnScreen.IsPet(mobileId)) then
				MobilesOnScreen.MarkHealthBarForDeletion(mobileId)				
			end		
		end
	end
end


function MobileHealthBar.CloseWindow()
	local mobileId = WindowGetId(SystemData.ActiveWindow.name)
	local windowName = "MobileHealthBar_"..mobileId	
	if DoesWindowNameExist(windowName) then		
		DestroyWindow(windowName)
		MobilesOnScreen.isDirty = true		
	end
end

function MobileHealthBar.CloseWindowByMobileId(mobileId)	
	local windowName = "MobileHealthBar_"..mobileId
	if DoesWindowNameExist(windowName) then			
		DestroyWindow(windowName)		
		return true	
	end
	return false
end

function MobileHealthBar.HealthbarCloseWindow()
	local mobileId = WindowGetId(SystemData.ActiveWindow.name)
	
	if not MobilesOnScreen.IsPet(mobileId) then
		MobileHealthBar.CloseWindowByMobileId(mobileId)
	else
		if (not MobileHealthBar.windowDisabled[mobileId] and MobilesOnScreen.IsPet(mobileId)) then
			MobileHealthBar.Handled[mobileId] = false
			if (Interface.ShowCloseExtract) then
				WindowSetShowing( SystemData.ActiveWindow.name .. "CloseButton", false)
				WindowSetShowing( SystemData.ActiveWindow.name .. "Extract", true)
			else
				WindowSetShowing( SystemData.ActiveWindow.name .. "CloseButton", false)
				WindowSetShowing( SystemData.ActiveWindow.name .. "Extract", false)
			end			
			PetWindow.UpdatePet()
			return
		end
		MobileHealthBar.CloseWindowByMobileId(mobileId)
	end

end

function MobileHealthBar.CloseAllHealthbars(avoidHandled)
	for mob, _ in pairs(MobileHealthBar.hasWindow) do
		if not avoidHandled and not MobileHealthBar.Handled[mob] then
			local windowName = "MobileHealthBar_"..mob
			if (MobileHealthBar.Handled[mob] and DoesWindowExist(windowName)) then
				MobileHealthBar.CloseWindowByMobileId(mob)
			end
		end
	end
end

function MobileHealthBar.OnShutdown()
    local windowName = WindowUtils.GetActiveDialog()
	local mobileId = WindowGetId(SystemData.ActiveWindow.name)
	HealthBarManager.UpdateRemovedHealthBarCount(mobileId)
	MobileHealthBar.Handled[mobileId] = nil	
	MobileHealthBar.UnregisterHealthBar(windowName)	
	MobileHealthBar.CreateTime[mobileId] = nil
	if (not MobileHealthBar.Forced) then			
		if (MobilesOnScreen.IsPet(mobileId)) then			
			MobilesOnScreen.isDirty = true			
		end
	end	
	
end

function MobileHealthBar.OnMouseDrag()
    SnapUtils.StartWindowSnap(WindowUtils.GetActiveDialog())
end

function MobileHealthBar.OnLButtonDown(flags, _, _)
	local mobileId = WindowGetId(WindowUtils.GetActiveDialog())
	local windowName = "MobileHealthBar_"..mobileId
	if (flags == SystemData.ButtonFlags.CONTROL and not MobileHealthBar.Handled[mobileId] and not (WindowData.Cursor and WindowData.Cursor.target == true) and not Interface.ShowCloseExtract) then		
		MobileHealthBar.ExtractWindow(windowName)
		return
	end
	
	if (flags == SystemData.ButtonFlags.ALT and MobileHealthBar.Handled[mobileId] and not (WindowData.Cursor and WindowData.Cursor.target == true) and not Interface.ShowCloseExtract) then
		MobileHealthBar.HealthbarCloseWindow()
		return
	end
	
	if(MobileHealthBar.windowDisabled[mobileId] == false) then
		HandleSingleLeftClkTarget(mobileId)
	end
	
	if ( not MobileHealthBar.Handled[mobileId] ) then
		return
	end
	
	WindowSetMoving(WindowUtils.GetActiveDialog(),true)
	SnapUtils.StartWindowSnap(windowName)

end

function MobileHealthBar.OnLButtonUp()
	if(SystemData.DragItem.DragType == SystemData.DragItem.TYPE_ITEM) then
		local mobileId = WindowGetId(WindowUtils.GetActiveDialog())
	    DragSlotDropObjectToObject(mobileId)
	end
end

function MobileHealthBar.OnLButtonDblClk()
	local mobileId = WindowGetId(WindowUtils.GetActiveDialog())
	if(MobileHealthBar.windowDisabled[mobileId] == false) then
		UserActionUseItem(mobileId,false)
	end
end

function MobileHealthBar.OnRButtonUp()
	local mobileId = WindowGetId(SystemData.ActiveWindow.name)
	if (MobilesOnScreen.IsPet(mobileId)) then
		if (not MobileHealthBar.PetLegacyCloseStyle) then
			if(MobileHealthBar.windowDisabled[mobileId] == false) then
				RequestContextMenu(mobileId)
			end
		else
			MobileHealthBar.CloseWindowByMobileId(mobileId)
		end
	else
		if (not MobileHealthBar.LegacyCloseStyle) then
			if(MobileHealthBar.windowDisabled[mobileId] == false) then
				RequestContextMenu(mobileId)
			end
		else
			MobileHealthBar.CloseWindowByMobileId(mobileId)
		end
	end
end

function MobileHealthBar.CloseButton_OnMouseOver()
	Tooltips.CreateTextOnlyTooltip(SystemData.ActiveWindow.name, GetStringFromTid(1061046))
	Tooltips.Finalize()
	Tooltips.AnchorTooltip( Tooltips.ANCHOR_WINDOW_TOP )
end

function MobileHealthBar.Extract_OnMouseOver()
	Tooltips.CreateTextOnlyTooltip(SystemData.ActiveWindow.name, GetStringFromTid(1153469) )
	Tooltips.Finalize()
	Tooltips.AnchorTooltip( Tooltips.ANCHOR_WINDOW_TOP )
end

function MobileHealthBar.OnMouseOver()
	
	if (string.find(SystemData.ActiveWindow.name, "Inventory")) then
		mobileId = WindowGetId(WindowGetParent(SystemData.ActiveWindow.name))
		local backpackId = 0
		if WindowData.Paperdoll[mobileId] then
			backpackId = WindowData.Paperdoll[mobileId].backpackId
		else
			RegisterWindowData(WindowData.Paperdoll.Type, mobileId)
			if WindowData.Paperdoll[mobileId] then
				backpackId = WindowData.Paperdoll[mobileId].backpackId
			end
			UnregisterWindowData(WindowData.Paperdoll.Type, mobileId)
		end

		local itemData = {
			windowName = name,
			itemId = backpackId,
			itemType = WindowData.ItemProperties.TYPE_ITEM
		}
							   
		ItemProperties.SetActiveItem(itemData)

		return
	end
	if(string.find(SystemData.ActiveWindow.name, "Bod")) then
		local itemData = { windowName = SystemData.ActiveWindow.name,
							itemId = 5555,
							itemType = WindowData.ItemProperties.TYPE_WSTRINGDATA,
							binding = L"",
							detail = nil,
							title =	GetStringFromTid(3006152), -- Bulk Order Info
							body = GetStringFromTid(1154853)}
							
		ItemProperties.SetActiveItem(itemData)
		return
	end
	if(string.find(SystemData.ActiveWindow.name, "Talk")) then
		local itemData = { windowName = SystemData.ActiveWindow.name,
							itemId = 5555,
							itemType = WindowData.ItemProperties.TYPE_WSTRINGDATA,
							binding = L"",
							detail = nil,
							title =	GetStringFromTid(3006146), -- Talk
							body = GetStringFromTid(1154854)}
							
		ItemProperties.SetActiveItem(itemData)
		return
	end
	if(string.find(SystemData.ActiveWindow.name, "Bank")) then
		local itemData = { windowName = SystemData.ActiveWindow.name,
							itemId = 5555,
							itemType = WindowData.ItemProperties.TYPE_WSTRINGDATA,
							binding = L"",
							detail = nil,
							title =	GetStringFromTid(1023083),
							body = GetStringFromTid(1154855)}
							
		ItemProperties.SetActiveItem(itemData)
		return
	end

	if(not MobileHealthBar.windowDisabled[mobileId] and WindowGetMoving(SystemData.ActiveWindow.name) == false) then
		
		local mobileId = WindowGetId(SystemData.ActiveWindow.name)
		MobileHealthBar.mouseOverId = mobileId
		local itemData =
		{
			windowName = SystemData.ActiveWindow.name,
			itemId = mobileId,
			itemType = WindowData.ItemProperties.TYPE_ITEM,
		}				
		ItemProperties.SetActiveItem(itemData)
		
	end
end

function MobileHealthBar.OnMouseOverEnd()
	ItemProperties.ClearMouseOverItem()
	MobileHealthBar.mouseOverId = 0
	if (DoesWindowNameExist("MobileArrow")) then
		DestroyWindow("MobileArrow")
	end
end

function MobileHealthBar.Null()
end

function MobileHealthBar.kill(mobileId)
	local spellId = 614
	UserActionCastSpellOnId(spellId, mobileId)
end

function MobileHealthBar.OnBPackLButtonUp()
	local parent = WindowGetParent(SystemData.ActiveWindow.name)
	local mobileId = WindowGetId( parent )
	if WindowData.Paperdoll[mobileId] then
		backpackId = WindowData.Paperdoll[mobileId].backpackId
	else
		RegisterWindowData(WindowData.Paperdoll.Type, mobileId)
		if WindowData.Paperdoll[mobileId] then
			backpackId = WindowData.Paperdoll[mobileId].backpackId
		end
		UnregisterWindowData(WindowData.Paperdoll.Type, mobileId)
	end
	
	if backpackId and
	backpackId ~= 0 then
		UserActionUseItem(backpackId, false)
	end
end

function MobileHealthBar.OnBodLButtonUp()
	local parent = WindowGetParent(SystemData.ActiveWindow.name)
	local mobileId = WindowGetId( parent )
	ContextMenu.RequestContextAction(mobileId, ContextMenu.DefaultValues.BodRequest)
end

function MobileHealthBar.OnTalkLButtonUp()
	local parent = WindowGetParent(SystemData.ActiveWindow.name)
	local mobileId = WindowGetId( parent )
	ContextMenu.RequestContextAction(mobileId, ContextMenu.DefaultValues.NPCTalk)
end

function MobileHealthBar.OnBankLButtonUp()
	local parent = WindowGetParent(SystemData.ActiveWindow.name)
	local mobileId = WindowGetId( parent )
	ContextMenu.RequestContextAction(mobileId, ContextMenu.DefaultValues.OpenBankbox)
end
