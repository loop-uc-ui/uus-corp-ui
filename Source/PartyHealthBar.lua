----------------------------------------------------------------
-- Global Variables
----------------------------------------------------------------

PartyHealthBar = {}

----------------------------------------------------------------
-- Local Variables
----------------------------------------------------------------

PartyHealthBar.PartyMembers = {}

PartyHealthBar.hasWindow = {}
PartyHealthBar.windowDisabled = {}

PartyHealthBar.mouseOverId = 0

PartyHealthBar.DEFAULT_WINDOW_START_X = 0
PartyHealthBar.DEFAULT_WINDOW_START_Y = 110

PartyHealthBar.WINDOW_WIDTH = 175
PartyHealthBar.WINDOW_HEIGHT = 55

PartyHealthBar.Spells = { Heal = 29, Cure = 11, GreaterCure = 25, Cleanse = 201, CloseWounds = 202 }
PartyHealthBar.SpellsTID = { Heal = 1015012, Cure = 1015023, Cleanse = 1060493, CloseWounds = 1060494 }

PartyHealthBar.hasPortrait = false

----------------------------------------------------------------
-- Functions
----------------------------------------------------------------
function PartyHealthBar.CrownMouseOver()
	Tooltips.CreateTextOnlyTooltip(SystemData.ActiveWindow.name, GetStringFromTid(1154872))
	Tooltips.Finalize()
	Tooltips.AnchorTooltip( Tooltips.ANCHOR_WINDOW_TOP )
end

function PartyHealthBar.CreateHealthBar(mobileId, useDefaultPos)
	if (mobileId == WindowData.PlayerStatus.PlayerId) then
		PartyHealthBar.RequestUpdate = true
		return
	end
	
	local memberIndex = HealthBarManager.GetMemberIndex(mobileId)
	local windowName = "PartyHealthBar_"..memberIndex
	
	-- Create and register if doesn't exist
	if( DoesWindowNameExist(windowName) == false ) then
		CreateWindowFromTemplate(windowName, "PartyHealthBar", "Root")
		if(WindowData.PartyMember.partyLeaderId == mobileId) then
			WindowSetShowing(windowName .. "Crown", true)
		else
			WindowSetShowing(windowName .. "Crown", false)
		end
		if not WindowData.Paperdoll[WindowData.PlayerStatus.PlayerId] then
			RegisterWindowData(WindowData.Paperdoll.Type, WindowData.PlayerStatus.PlayerId)
		end
		local textureData = SystemData.PaperdollTexture[mobileId]	
		if (not DoesWindowNameExist("PartyHealthBarPortraitBgA_"..mobileId)) then
			CreateWindowFromTemplate("PartyHealthBarPortraitBgA_"..mobileId, "PartyHealthBarPortraitBgA", windowName)
		end
		if (not DoesWindowNameExist("PartyHealthBarPortraitA_"..mobileId)) then
			CreateWindowFromTemplate("PartyHealthBarPortraitA_"..mobileId, "PartyHealthBarPortraitA", windowName)
		end
	
		local mobileData = Interface.GetMobileData(mobileId, true)
		if( textureData ~= nil and IsHealthBarEnabled(mobileId)) then
			if mobileData.Race == PaperdollWindow.HUMAN then
				if mobileData.Gender == 1 then
					CircleImageSetTexture("PartyHealthBarPortraitA_"..mobileId,"paperdoll_texture"..mobileId,-textureData.xOffset,-textureData.yOffset-205)
				else
					CircleImageSetTexture("PartyHealthBarPortraitA_"..mobileId,"paperdoll_texture"..mobileId,-textureData.xOffset-11,-textureData.yOffset-195)
				end
			elseif mobileData.Race == PaperdollWindow.ELF then
				if mobileData.Gender == 1 then
					CircleImageSetTexture("PartyHealthBarPortraitA_"..mobileId,"paperdoll_texture"..mobileId,-textureData.xOffset,-textureData.yOffset-205)
				else
					CircleImageSetTexture("PartyHealthBarPortraitA_"..mobileId,"paperdoll_texture"..mobileId,-textureData.xOffset-11,-textureData.yOffset-195)
				end
			elseif mobileData.Race == PaperdollWindow.GARGOYLE then
				if mobileData.Gender == 1 then
					CircleImageSetTexture("PartyHealthBarPortraitA_"..mobileId,"paperdoll_texture"..mobileId,-textureData.xOffset,-textureData.yOffset-212)
				else
					CircleImageSetTexture("PartyHealthBarPortraitA_"..mobileId,"paperdoll_texture"..mobileId,-textureData.xOffset-11,-textureData.yOffset-193)
				end
			end
			WindowSetShowing("PartyHealthBarPortraitA_"..mobileId, true)
		else
			WindowSetShowing("PartyHealthBarPortraitA_"..mobileId, false)
		end

		WindowSetShowing("PartyHealthBarPortraitA_"..mobileId, true)
		--WindowSetShowing(windowName .. "PortraitBgA", true)

		WindowSetId(windowName, mobileId)
		WindowSetId(windowName.."CloseButton", mobileId)
		WindowSetId(windowName.."RedButton", mobileId)
		WindowSetId(windowName.."GreenButton", mobileId)
		
		LabelSetText(windowName.."Number", L""..memberIndex)
		
		PartyHealthBar.RegisterHealthBar(windowName)
		
		Interface.DestroyWindowOnClose[windowName] = true
		UnregisterWindowData(WindowData.Paperdoll.Type, WindowData.PlayerStatus.PlayerId)
	end
	

	PartyHealthBar.UpdateStatus(mobileId)
	PartyHealthBar.UpdateName(mobileId)
	PartyHealthBar.UpdateHealthBarColor(mobileId)

	WindowUtils.RestoreWindowPosition(windowName)

	PartyHealthBar.HandleAnchorWindow(windowName, useDefaultPos)
	WindowAssignFocus(windowName, true)
	WindowUtils.LoadScale( "PrtyHealthBarSCALE" )
end


function PartyHealthBar.RefreshHealthBar(windowIndex, mobileId)
	local windowName = "PartyHealthBar_"..windowIndex
	
	if (DoesWindowNameExist(windowName)) then
		local currentId = WindowGetId(windowName)
		if (currentId ~= mobileId) then			
			if(currentId ~= 0 and not HealthBarManager.IsPartyMember(currentId)) then
				MobileHealthBar.Forced = true
				MobileHealthBar.CreateHealthBar(currentId)
				MobileHealthBar.Handled[currentId] = true
				local newWindowName = "MobileHealthBar_"..currentId
				WindowUtils.CopyScreenPosition( windowName, newWindowName, 0, 0)
				MobileHealthBar.Forced = nil
			end
			PartyHealthBar.CloseWindowByIndex(windowIndex)
			if (mobileId ~= 0) then
				PartyHealthBar.CreateHealthBar(mobileId, true)
			end
		end
	end
end

function PartyHealthBar.OnShutdown()
    local windowName = WindowUtils.GetActiveDialog()
	PartyHealthBar.UnregisterHealthBar(windowName)
end

--Sets the Window close to where the player dragged their mouse
function PartyHealthBar.HandleAnchorWindow(windowName, useDefaultPos)
	if (useDefaultPos == true) then
		if(WindowUtils.CanRestorePosition(windowName) == false) then
			local mobileId = WindowGetId(windowName)
			local windowIndex = HealthBarManager.GetMemberIndex(mobileId)
			
			local xPos = PartyHealthBar.DEFAULT_WINDOW_START_X + ( math.floor((windowIndex - 1) / 5) * PartyHealthBar.WINDOW_WIDTH )
			local yPos = PartyHealthBar.DEFAULT_WINDOW_START_Y + ( ((windowIndex - 1) % 5) * PartyHealthBar.WINDOW_HEIGHT )
			
			WindowSetOffsetFromParent(windowName, xPos, yPos)
			return
		end
		
		return
	end

	local propWindowX = 0
	local propWindowY = 0
	local scaleFactor = 1/InterfaceCore.scale
	
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
	
	SnapUtils.StartWindowSnap(windowName)
	
	WindowSetOffsetFromParent(windowName, propWindowX * scaleFactor, propWindowY * scaleFactor)
end

function PartyHealthBar.RegisterHealthBar(windowName)
	local mobileId = WindowGetId(windowName)
	
	WindowRegisterEventHandler(windowName, WindowData.MobileStatus.Event, "PartyHealthBar.HandleMobileStatusUpdate")
	WindowRegisterEventHandler(windowName, WindowData.MobileName.Event, "PartyHealthBar.HandleMobileNameUpdate")
	WindowRegisterEventHandler(windowName, WindowData.HealthBarColor.Event, "PartyHealthBar.HandleHealthBarColorUpdate")
	WindowRegisterEventHandler(windowName, SystemData.Events.ENABLE_HEALTHBAR_WINDOW, "PartyHealthBar.HandleHealthBarStateUpdate")
	WindowRegisterEventHandler(windowName, SystemData.Events.DISABLE_HEALTHBAR_WINDOW, "PartyHealthBar.HandleHealthBarStateUpdate")
	
	RegisterWindowData(WindowData.MobileStatus.Type, mobileId)
	RegisterWindowData(WindowData.MobileName.Type, mobileId)
	RegisterWindowData(WindowData.HealthBarColor.Type, mobileId)
	PartyHealthBar.PartyMembers[mobileId]={}
		
	PartyHealthBar.hasWindow[mobileId] = true
	PartyHealthBar.windowDisabled[mobileId] = false
	
	SnapUtils.SnappableWindows[windowName] = true
end

function PartyHealthBar.UnregisterHealthBar(windowName)
	local mobileId = WindowGetId(windowName)
	
	WindowUnregisterEventHandler(windowName, WindowData.MobileStatus.Event)
	WindowUnregisterEventHandler(windowName, WindowData.MobileName.Event)
	WindowUnregisterEventHandler(windowName, WindowData.HealthBarColor.Event)
	WindowUnregisterEventHandler(windowName, SystemData.Events.ENABLE_HEALTHBAR_WINDOW)
	WindowUnregisterEventHandler(windowName, SystemData.Events.DISABLE_HEALTHBAR_WINDOW)

	if WindowData.PlayerStatus.PlayerId ~= mobileId and TargetWindow.TargetId ~= mobileId then		
		UnregisterWindowData(WindowData.MobileStatus.Type, mobileId)
		UnregisterWindowData(WindowData.MobileName.Type, mobileId)
		UnregisterWindowData(WindowData.HealthBarColor.Type, mobileId)
	end
	PartyHealthBar.hasWindow[mobileId] = nil
	PartyHealthBar.windowDisabled[mobileId] = nil
	
	SnapUtils.SnappableWindows[windowName] = nil
	
	WindowUtils.SaveWindowPosition(windowName)
	PartyHealthBar.PartyMembers[mobileId] = nil
	if (PartyHealthBar.mouseOverId == mobileId) then
		PartyHealthBar.OnMouseOverEnd()
	end
end

function PartyHealthBar.HasWindow(mobileId)
	if( PartyHealthBar.hasWindow[mobileId] == true ) then
		return true
	end
	
	return false
end

function PartyHealthBar.HasWindowByIndex(windowIndex)
	return DoesWindowNameExist("PartyHealthBar_"..windowIndex)
end

function PartyHealthBar.GetWindowName(mobileId)
	local memberIndex = HealthBarManager.GetMemberIndex(mobileId)
	return "PartyHealthBar_"..memberIndex
end

function PartyHealthBar.HandleMobileStatusUpdate()

	
    PartyHealthBar.UpdateStatus(WindowData.UpdateInstanceId)
end

function PartyHealthBar.UpdateStatus(mobileId)
	local mobileData = Interface.GetMobileData(mobileId, true)
	if(PartyHealthBar.hasWindow[mobileId] == true and mobileData) then
		
		
		local windowName = PartyHealthBar.GetWindowName(mobileId)
				
		local memberIndex = HealthBarManager.GetMemberIndex(mobileId)
		local windowName = "PartyHealthBar_"..memberIndex

		--Set mobile's health status bar
		local curHealth = mobileData.CurrentHealth
		local maxHealth = mobileData.MaxHealth
		local curMana =  mobileData.CurrentMana
		local maxMana =  mobileData.MaxMana
		local curStamina = mobileData.CurrentStamina
		local maxStamina = mobileData.MaxStamina
		
		PartyHealthBar.PartyMembers[mobileId].MaxHealth = maxHealth
		PartyHealthBar.PartyMembers[mobileId].CurrentHealth = curHealth
		
		-- If current and max mana and stamina are zero and mobileId isn't dead, then updates have not come in yet
		if( curMana == 0 and maxMana == 0 and mobileData.IsDead == false) then
			curMana = 1
			maxMana = 1
		end
		if( curStamina == 0 and maxStamina == 0 and mobileData.IsDead == false) then
			curStamina = 1
			maxStamina = 1
		end
		
		StatusBarSetCurrentValue( windowName.."HealthBar", curHealth )
		StatusBarSetMaximumValue( windowName.."HealthBar", maxHealth )
		StatusBarSetCurrentValue( windowName.."ManaBar", curMana )
		StatusBarSetMaximumValue( windowName.."ManaBar", maxMana )
		StatusBarSetCurrentValue( windowName.."StaminaBar", curStamina )
		StatusBarSetMaximumValue( windowName.."StaminaBar", maxStamina )
	end
end

function PartyHealthBar.HandleMobileNameUpdate()
    PartyHealthBar.UpdateName(WindowData.UpdateInstanceId)
end

function PartyHealthBar.UpdateName(mobileId)
	if(PartyHealthBar.hasWindow[mobileId] == true) then
		
		local windowName = PartyHealthBar.GetWindowName(mobileId)
		
		if(WindowData.MobileName[mobileId] ~= nil) then
			
			local memberIndex = HealthBarManager.GetMemberIndex(mobileId)
			local windowName = "PartyHealthBar_"..memberIndex

			local data = WindowData.MobileName[mobileId]
			local textureData = SystemData.PaperdollTexture[mobileId]
			if not WindowData.Paperdoll[mobileId] then
				RegisterWindowData(WindowData.Paperdoll.Type, mobileId)
			end
			if (not DoesWindowNameExist("PartyHealthBarPortraitA_"..mobileId) ) then
				CreateWindowFromTemplate("PartyHealthBarPortraitA_"..mobileId, "PartyHealthBarPortraitA", windowName)
			end
			local mobileData = Interface.GetMobileData(mobileId, true)
			if( textureData ~= nil and IsHealthBarEnabled(mobileId)) then
				if mobileData.Race == PaperdollWindow.HUMAN then
					if mobileData.Gender == 1 then
						CircleImageSetTexture("PartyHealthBarPortraitA_"..mobileId,"paperdoll_texture"..mobileId,-textureData.xOffset,-textureData.yOffset-205)
					else
						CircleImageSetTexture("PartyHealthBarPortraitA_"..mobileId,"paperdoll_texture"..mobileId,-textureData.xOffset-11,-textureData.yOffset-195)
					end
				elseif mobileData.Race == PaperdollWindow.ELF then
					if mobileData.Gender == 1 then
						CircleImageSetTexture("PartyHealthBarPortraitA_"..mobileId,"paperdoll_texture"..mobileId,-textureData.xOffset,-textureData.yOffset-205)
					else
						CircleImageSetTexture("PartyHealthBarPortraitA_"..mobileId,"paperdoll_texture"..mobileId,-textureData.xOffset-11,-textureData.yOffset-195)
					end
				elseif mobileData.Race == PaperdollWindow.GARGOYLE then
					if mobileData.Gender == 1 then
						CircleImageSetTexture("PartyHealthBarPortraitA_"..mobileId,"paperdoll_texture"..mobileId,-textureData.xOffset,-textureData.yOffset-212)
					else
						CircleImageSetTexture("PartyHealthBarPortraitA_"..mobileId,"paperdoll_texture"..mobileId,-textureData.xOffset-11,-textureData.yOffset-193)
					end
				end
				WindowSetShowing("PartyHealthBarPortraitA_"..mobileId, true)
			else
				WindowSetShowing("PartyHealthBarPortraitBgA_"..mobileId, false)
			end
			PartyHealthBar.PartyMembers[mobileId].name = data.MobName
			LabelSetText(windowName.."Name", data.MobName)
			WindowUtils.FitTextToLabel(windowName.."Name", data.MobName)
			NameColor.UpdateLabelNameColor(windowName.."Name", data.Notoriety+1)
		else
			local memberIndex = HealthBarManager.GetMemberIndex(mobileId)
			local windowName = "PartyHealthBar_"..memberIndex
			if (PartyHealthBar.PartyMembers[mobileId] and PartyHealthBar.PartyMembers[mobileId].name) then
				LabelSetText(windowName.."Name", PartyHealthBar.PartyMembers[mobileId].name )
			else
				LabelSetText(windowName.."Name", L"???" )
			end
		end
	end
end

function PartyHealthBar.HandleHealthBarColorUpdate()
    PartyHealthBar.UpdateHealthBarColor(WindowData.UpdateInstanceId)
end

function PartyHealthBar.UpdateHealthBarColor(mobileId)
	if(PartyHealthBar.hasWindow[mobileId] == true) then
		local memberIndex = HealthBarManager.GetMemberIndex(mobileId)
		local windowName = "PartyHealthBar_"..memberIndex
		local healthBarWindow = windowName.."HealthBar"

		local textureData = SystemData.PaperdollTexture[mobileId]
			
			if (not DoesWindowNameExist("PartyHealthBarPortraitA_"..mobileId) ) then
				CreateWindowFromTemplate("PartyHealthBarPortraitA_"..mobileId, "PartyHealthBarPortraitA", windowName)
			end
			local mobileData = Interface.GetMobileData(mobileId, true)
			if( textureData ~= nil and IsHealthBarEnabled(mobileId)) then
				if mobileData.Race == PaperdollWindow.HUMAN then
					if mobileData.Gender == 1 then
						CircleImageSetTexture("PartyHealthBarPortraitA_"..mobileId,"paperdoll_texture"..mobileId,-textureData.xOffset,-textureData.yOffset-205)
					else
						CircleImageSetTexture("PartyHealthBarPortraitA_"..mobileId,"paperdoll_texture"..mobileId,-textureData.xOffset-11,-textureData.yOffset-195)
					end
				elseif mobileData.Race == PaperdollWindow.ELF then
					if mobileData.Gender == 1 then
						CircleImageSetTexture("PartyHealthBarPortraitA_"..mobileId,"paperdoll_texture"..mobileId,-textureData.xOffset,-textureData.yOffset-205)
					else
						CircleImageSetTexture("PartyHealthBarPortraitA_"..mobileId,"paperdoll_texture"..mobileId,-textureData.xOffset-11,-textureData.yOffset-195)
					end
				elseif mobileData.Race == PaperdollWindow.GARGOYLE then
					if mobileData.Gender == 1 then
						CircleImageSetTexture("PartyHealthBarPortraitA_"..mobileId,"paperdoll_texture"..mobileId,-textureData.xOffset,-textureData.yOffset-212)
					else
						CircleImageSetTexture("PartyHealthBarPortraitA_"..mobileId,"paperdoll_texture"..mobileId,-textureData.xOffset-11,-textureData.yOffset-193)
					end
				end
				WindowSetShowing("PartyHealthBarPortraitA_"..mobileId, true)
			else
				WindowSetShowing("PartyHealthBarPortraitBgA_"..mobileId, false)
			end
		HealthBarColor.UpdateHealthBarColor(healthBarWindow, WindowData.HealthBarColor[mobileId].VisualStateId)
	end
end

function PartyHealthBar.HandleHealthBarStateUpdate()
	local mobileId = WindowGetId(SystemData.ActiveWindow.name)
	PartyHealthBar.UpdateHealthBarState(mobileId)
end

function PartyHealthBar.UpdateHealthBarState(mobileId)
	if(PartyHealthBar.hasWindow[mobileId] == true) then
	
		local memberIndex = HealthBarManager.GetMemberIndex(mobileId)
		local windowName = "PartyHealthBar_"..memberIndex
		-- enable window
		if( IsHealthBarEnabled(mobileId) == true and PartyHealthBar.windowDisabled[mobileId]==true ) then
			WindowSetShowing(windowName.."HealthBar", true)
			WindowSetShowing(windowName.."ManaBar", true)
			WindowSetShowing(windowName.."StaminaBar", true)
			PartyHealthBar.UpdateStatus(mobileId)
			PartyHealthBar.windowDisabled[mobileId] = false
			WindowSetShowing("PartyHealthBarPortraitA_"..mobileId, true)
		-- disable window
		elseif( IsHealthBarEnabled(mobileId) == false and PartyHealthBar.windowDisabled[mobileId]==false ) then
			WindowSetShowing("PartyHealthBarPortraitA_"..mobileId, false)
			WindowSetShowing(windowName.."HealthBar",false)
			WindowSetShowing(windowName.."ManaBar", false)
			WindowSetShowing(windowName.."StaminaBar", false)
			--WindowSetShowing("PartyHealthBarPortraitA_"..mobileId, false)
			LabelSetTextColor(windowName.."Name", 128, 128, 128)
			if not PartyHealthBar.PartyMembers[mobileId].sharing then
				PartyHealthBar.PartyMembers[mobileId].MaxHealth = 0
				PartyHealthBar.PartyMembers[mobileId].CurrentHealth = 0
			end
						
			PartyHealthBar.windowDisabled[mobileId] = true
		end
	end
end

function PartyHealthBar.CloseWindow()
	local mobileId = WindowGetId(SystemData.ActiveWindow.name)
	local memberIndex = HealthBarManager.GetMemberIndex(mobileId)
	local windowName = "PartyHealthBar_"..memberIndex
	DestroyWindow(windowName)
end

function PartyHealthBar.CloseWindowByIndex(windowIndex)
	local windowName = "PartyHealthBar_"..windowIndex
	DestroyWindow(windowName)
end

function PartyHealthBar.CloseWindowByMobileId(mobileId)
	local memberIndex = HealthBarManager.GetMemberIndex(mobileId)
	local windowName = "PartyHealthBar_"..memberIndex
	DestroyWindow(windowName)
end

function PartyHealthBar.OnMouseDrag()
    SnapUtils.StartWindowSnap(WindowUtils.GetActiveDialog())
end

function PartyHealthBar.OnLButtonDown()
	local mobileId = WindowGetId(WindowUtils.GetActiveDialog())
	if(PartyHealthBar.windowDisabled[mobileId] == false) then
		HandleSingleLeftClkTarget(mobileId)
	end
end

function PartyHealthBar.OnLButtonUp()
	if(SystemData.DragItem.DragType == SystemData.DragItem.TYPE_ITEM) then
		local mobileId = WindowGetId(WindowUtils.GetActiveDialog())
	    DragSlotDropObjectToObject(mobileId)
	end
end

function PartyHealthBar.OnLButtonDblClk()
	local mobileId = WindowGetId(WindowUtils.GetActiveDialog())
	if(PartyHealthBar.windowDisabled[mobileId] == false) then
		UserActionUseItem(mobileId,false)
	end
end

function PartyHealthBar.OnRButtonUp()
	local mobileId = WindowGetId(SystemData.ActiveWindow.name)
	if(PartyHealthBar.windowDisabled[mobileId] == false) then
		TargetWindow.Context = nil
		RequestContextMenu(mobileId)
	end
end

function PartyHealthBar.OnMouseOver()
	local mobileId = WindowGetId(SystemData.ActiveWindow.name)
	local memberIndex = HealthBarManager.GetMemberIndex(mobileId)
	local windowName = "PartyHealthBar_"..memberIndex
	if(PartyHealthBar.windowDisabled[mobileId] == false and WindowGetMoving(windowName) == false) then
		local itemData =
		{
			windowName = windowName,
			itemId = mobileId,
			itemType = WindowData.ItemProperties.TYPE_ITEM,
		}					
		ItemProperties.SetActiveItem(itemData)
		PartyHealthBar.mouseOverId = mobileId
	end
end

function PartyHealthBar.OnMouseOverEnd()
	ItemProperties.ClearMouseOverItem()
	if (string.find(SystemData.ActiveWindow.name, "MobileHealthbar")) then
		MobileHealthBar.mouseOverId = WindowGetId(WindowUtils.GetActiveDialog())
	elseif( not string.find(SystemData.ActiveWindow.name, "StatusWindow")) then
		PartyHealthBar.mouseOverId = 0
		if (DoesWindowNameExist("MobileArrow")) then
			DestroyWindow("MobileArrow")
		end
	end
	
end

function PartyHealthBar.RedButton_OnLButtonUp()
	local mobileId = WindowGetId(SystemData.ActiveWindow.name)
	if (string.find(SystemData.ActiveWindow.name , "StatusWindow")) then
		mobileId = WindowData.PlayerStatus.PlayerId
	end
	if (string.find(SystemData.ActiveWindow.name , "MobileHealthBar_")) then
		mobileId = WindowGetId(WindowUtils.GetActiveDialog())
	end
	local buttonDef = Interface.LoadNumber("RedButtonDef_" .. mobileId, Interface.RedDef)
	if(mobileId) then
		local spellId = 0
		if (buttonDef == 1) then
			spellId = UserHealthBarsSettings.redButtonSpell1()
		elseif (buttonDef == 2) then
			spellId = UserHealthBarsSettings.redButtonSpell2()
		elseif (buttonDef == 3) then
			spellId = UserHealthBarsSettings.redButtonSpell3()
		end
		UserActionCastSpellOnId(spellId, mobileId)
	end
end

function PartyHealthBar.RedButton_OnMouseOver()
	local mobileId = WindowGetId(SystemData.ActiveWindow.name)
	if (string.find(SystemData.ActiveWindow.name , "StatusWindow")) then
		mobileId = WindowData.PlayerStatus.PlayerId
	end
	if (string.find(SystemData.ActiveWindow.name , "MobileHealthBar_")) then
		mobileId = WindowGetId(WindowUtils.GetActiveDialog())
	end
	
	local buttonDef = Interface.LoadNumber("RedButtonDef_" .. mobileId, Interface.RedDef)
	local spellId = 0
	if (buttonDef == 1) then
		spellId = UserHealthBarsSettings.redButtonSpell1()
	elseif (buttonDef == 2) then
		spellId = UserHealthBarsSettings.redButtonSpell2()
	elseif (buttonDef == 3) then
		spellId = UserHealthBarsSettings.redButtonSpell3()
	end
	local icon, serverId, tid, desctid = GetAbilityData(spellId)
	if (not tid) then
		tid = 1011051
	end
	local itemData = { windowName = SystemData.ActiveWindow.name,
							itemId = 1234,
							itemType = WindowData.ItemProperties.TYPE_WSTRINGDATA,
							binding = L"",
							detail = nil,
							title =	GetStringFromTid(tid),
							body = GetStringFromTid(1154873)}
							
				
	ItemProperties.SetActiveItem(itemData)
	if (string.find(SystemData.ActiveWindow.name, "MobileHealthbar")) then
		MobileHealthBar.mouseOverId = mobileId
	elseif( not string.find(SystemData.ActiveWindow.name, "StatusWindow")) then
		PartyHealthBar.mouseOverId = mobileId
	end
end

function PartyHealthBar.GreenButton_OnLButtonUp()
	local mobileId = WindowGetId(SystemData.ActiveWindow.name)
	if (string.find(SystemData.ActiveWindow.name , "StatusWindow")) then
		mobileId = WindowData.PlayerStatus.PlayerId
	end
	if (string.find(SystemData.ActiveWindow.name , "MobileHealthBar_")) then
		mobileId = WindowGetId(WindowUtils.GetActiveDialog())
	end
	local buttonDef = Interface.LoadNumber("GreenButtonDef_" .. mobileId, Interface.GreenDef)
	if(mobileId) then
		local spellId = 0
		if (buttonDef == 1) then
			spellId = UserHealthBarsSettings.greenButtonSpell1()
		elseif (buttonDef == 2) then
			spellId = UserHealthBarsSettings.greenButtonSpell2()
		elseif (buttonDef == 3) then
			spellId = UserHealthBarsSettings.greenButtonSpell3()
		end
		
		UserActionCastSpellOnId(spellId, mobileId)
	end
end

function PartyHealthBar.GreenButton_OnMouseOver()
	local mobileId = WindowGetId(SystemData.ActiveWindow.name)
	if (string.find(SystemData.ActiveWindow.name , "StatusWindow")) then
		mobileId = WindowData.PlayerStatus.PlayerId
	end
	if (string.find(SystemData.ActiveWindow.name , "MobileHealthBar_")) then
		mobileId = WindowGetId(WindowUtils.GetActiveDialog())
	end
	
	local buttonDef = Interface.LoadNumber("GreenButtonDef_" .. mobileId, Interface.GreenDef)
	
	local spellId = 0
	if (buttonDef == 1) then
		spellId = UserHealthBarsSettings.greenButtonSpell1()
	elseif (buttonDef == 2) then
		spellId = UserHealthBarsSettings.greenButtonSpell2()
	elseif (buttonDef == 3) then
		spellId = UserHealthBarsSettings.greenButtonSpell3()
	end
		

	local icon, serverId, tid, desctid = GetAbilityData(spellId)
	if (not tid) then
		tid = 1011051
	end
	local itemData = { windowName = SystemData.ActiveWindow.name,
							itemId = 1234,
							itemType = WindowData.ItemProperties.TYPE_WSTRINGDATA,
							binding = L"",
							detail = nil,
							title =	GetStringFromTid(tid),
							body = GetStringFromTid(1154873)}
						
	ItemProperties.SetActiveItem(itemData)
	if (string.find(SystemData.ActiveWindow.name, "MobileHealthbar")) then
		MobileHealthBar.mouseOverId = mobileId
	elseif( not string.find(SystemData.ActiveWindow.name, "StatusWindow")) then
		PartyHealthBar.mouseOverId = mobileId
	end
end

function PartyHealthBar.BlueButton_OnLButtonUp()
	local mobileId = WindowGetId(WindowUtils.GetActiveDialog())
	if (string.find(SystemData.ActiveWindow.name , "StatusWindow")) then
		mobileId = WindowData.PlayerStatus.PlayerId
	end
	local buttonDef = Interface.LoadNumber("BlueButtonDef_" .. mobileId, Interface.BlueDef)
	if(mobileId) then
		local spellId = 0
		if (buttonDef == 1) then
			spellId = UserHealthBarsSettings.blueButtonSpell1()
		elseif (buttonDef == 2) then
			spellId = UserHealthBarsSettings.blueButtonSpell2()
		elseif (buttonDef == 3) then
			spellId = UserHealthBarsSettings.blueButtonSpell3()
		end
		
		UserActionCastSpellOnId(spellId, mobileId)
	end
end

function PartyHealthBar.BlueButton_OnMouseOver()
	local mobileId = WindowGetId(WindowUtils.GetActiveDialog())
	if (string.find(SystemData.ActiveWindow.name , "StatusWindow")) then
		mobileId = WindowData.PlayerStatus.PlayerId
	end
	
	local buttonDef = Interface.LoadNumber("BlueButtonDef_" .. mobileId, Interface.BlueDef)
	
	local spellId = 0
	if (buttonDef == 1) then
		spellId = UserHealthBarsSettings.blueButtonSpell1()
	elseif (buttonDef == 2) then
		spellId = UserHealthBarsSettings.blueButtonSpell2()
	elseif (buttonDef == 3) then
		spellId = UserHealthBarsSettings.blueButtonSpell3()
	end

	local icon, serverId, tid, desctid = GetAbilityData(spellId)
	if (not tid) then
		tid = 1011051
	end
	local itemData = { windowName = SystemData.ActiveWindow.name,
							itemId = 1234,
							itemType = WindowData.ItemProperties.TYPE_WSTRINGDATA,
							binding = L"",
							detail = nil,
							title =	GetStringFromTid(tid),
							body = GetStringFromTid(1154873)}
						
	ItemProperties.SetActiveItem(itemData)
	if (string.find(SystemData.ActiveWindow.name, "MobileHealthbar")) then
		MobileHealthBar.mouseOverId = mobileId
	elseif( not string.find(SystemData.ActiveWindow.name, "StatusWindow")) then
		PartyHealthBar.mouseOverId = mobileId
	end
end

local CurrMobileId = 0
function PartyHealthBar.Button_OnRButtonUp()
	local mobileId = WindowGetId(WindowUtils.GetActiveDialog())
	if (string.find(SystemData.ActiveWindow.name , "StatusWindow")) then
		mobileId = WindowData.PlayerStatus.PlayerId
	end
	CurrMobileId = mobileId
	if (string.find(SystemData.ActiveWindow.name, "Red")) then
		local buttonDef = Interface.LoadNumber("RedButtonDef_" .. mobileId, Interface.RedDef)
		
		local spellId = UserHealthBarsSettings.redButtonSpell1()
		local icon, serverId, tid, desctid = GetAbilityData(spellId)
		if (not tid) then
			tid = 1011051
		end
		ContextMenu.CreateLuaContextMenuItemWithString(GetStringFromTid(tid),0,"r1",2,buttonDef ==1)
		
		spellId = UserHealthBarsSettings.redButtonSpell2()
		local icon, serverId, tid, desctid = GetAbilityData(spellId)
		if (not tid) then
			tid = 1011051
		end
		ContextMenu.CreateLuaContextMenuItemWithString(GetStringFromTid(tid),0,"r2",2,buttonDef==2)
		
		spellId = UserHealthBarsSettings.redButtonSpell3()
		local icon, serverId, tid, desctid = GetAbilityData(spellId)
		if (not tid) then
			tid = 1011051
		end
		ContextMenu.CreateLuaContextMenuItemWithString(GetStringFromTid(tid),0,"r3",2,buttonDef==3)
		
	elseif (string.find(SystemData.ActiveWindow.name, "Green")) then
		local buttonDef = Interface.LoadNumber("GreenButtonDef_" .. mobileId, Interface.GreenDef)
		local spellId = UserHealthBarsSettings.greenButtonSpell1()
		local icon, serverId, tid, desctid = GetAbilityData(spellId)
		if (not tid) then
			tid = 1011051
		end
		ContextMenu.CreateLuaContextMenuItemWithString(GetStringFromTid(tid),0,"g1",2,buttonDef==1)
		
		spellId = UserHealthBarsSettings.greenButtonSpell2()
		local icon, serverId, tid, desctid = GetAbilityData(spellId)
		if (not tid) then
			tid = 1011051
		end
		ContextMenu.CreateLuaContextMenuItemWithString(GetStringFromTid(tid),0,"g2",2,buttonDef==2)
		
		spellId = UserHealthBarsSettings.greenButtonSpell3()
		local icon, serverId, tid, desctid = GetAbilityData(spellId)
		if (not tid) then
			tid = 1011051
		end
		ContextMenu.CreateLuaContextMenuItemWithString(GetStringFromTid(tid),0,"g3",2,buttonDef==3)
		
	elseif (string.find(SystemData.ActiveWindow.name, "Blue")) then
		local buttonDef = Interface.LoadNumber("BlueButtonDef_" .. mobileId, Interface.BlueDef)
		local spellId = UserHealthBarsSettings.blueButtonSpell1()
		local icon, serverId, tid, desctid = GetAbilityData(spellId)
		if (not tid) then
			tid = 1011051
		end
		ContextMenu.CreateLuaContextMenuItemWithString(GetStringFromTid(tid),0,"b1",2,buttonDef==1)
		
		spellId = UserHealthBarsSettings.blueButtonSpell2()
		local icon, serverId, tid, desctid = GetAbilityData(spellId)
		if (not tid) then
			tid = 1011051
		end
		ContextMenu.CreateLuaContextMenuItemWithString(GetStringFromTid(tid),0,"b2",2,buttonDef==2)
		
		spellId = UserHealthBarsSettings.blueButtonSpell3()
		local icon, serverId, tid, desctid = GetAbilityData(spellId)
		if (not tid) then
			tid = 1011051
		end
		ContextMenu.CreateLuaContextMenuItemWithString(GetStringFromTid(tid),0,"b3",2,buttonDef==3)
	end
	
	ContextMenu.ActivateLuaContextMenu(PartyHealthBar.ContextMenuCallback)
end

function PartyHealthBar.ContextMenuCallback(returnCode, param)
	
	if (string.find(returnCode, "r")) then
		local val = string.gsub(returnCode,"r", "")
		if CurrMobileId == 0 then
			Interface.RedDef = tonumber(val )
			Interface.SaveNumber( "RedDef", Interface.RedDef )
		else
			Interface.SaveNumber("RedButtonDef_" .. CurrMobileId, tonumber(val ))
		end
	elseif (string.find(returnCode, "g")) then
		local val = string.gsub(returnCode,"g", "")
		if CurrMobileId == 0 then
			Interface.GreenDef = tonumber(val )
			Interface.SaveNumber( "GreenDef", Interface.GreenDef )
		else
			Interface.SaveNumber("GreenButtonDef_" .. CurrMobileId, tonumber(val ))
		end
	elseif (string.find(returnCode, "b")) then
		local val = string.gsub(returnCode,"b", "")
		if CurrMobileId == 0 then
			Interface.BlueDef = tonumber(val )
			Interface.SaveNumber( "BlueDef", Interface.BlueDef )
		else
			Interface.SaveNumber("BlueButtonDef_" .. CurrMobileId, tonumber(val ))
		end
	end
	CurrMobileId = 0
end