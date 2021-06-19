----------------------------------------------------------------
-- Global Variables
----------------------------------------------------------------

PaperdollWindow = {}

PaperdollWindow.MenuRequest = 0
PaperdollWindow.CurrentBG = ""
PaperdollWindow.TID = {}
PaperdollWindow.TID.CLOTHING	= 1077861	--CLOTHING
PaperdollWindow.TID.ARMOR		= 1077862	--ARMOR
PaperdollWindow.TID.PAPERDOLL	= 1077863 	--PAPERDOLL
PaperdollWindow.TID.PROFILE 	= 1078990   --PROFILE

PaperdollWindow.PAPERDOLLSLOTID 	= {}

PaperdollWindow.PAPERDOLLSLOTID.FEET 		= 13
PaperdollWindow.PAPERDOLLSLOTID.HEAD 		= 1
PaperdollWindow.PAPERDOLLSLOTID.SHIRT 		= 14   
PaperdollWindow.PAPERDOLLSLOTID.PANTS 		= 19 
PaperdollWindow.PAPERDOLLSLOTID.KILT		= 11
PaperdollWindow.PAPERDOLLSLOTID.WINGARMOR   = 17
PaperdollWindow.PAPERDOLLSLOTID.TALONS		= 13

PaperdollWindow.HUMAN = 1
PaperdollWindow.ELF = 2
PaperdollWindow.GARGOYLE = 3

PaperdollWindow.WINDOWSCALE = 1

PaperdollWindow.Organize = false
PaperdollWindow.OrganizeBag = nil
PaperdollWindow.OrganizeParent = nil
PaperdollWindow.CanPickUp = true
PaperdollWindow.TimePassedSincePickUp = 0
PaperdollWindow.BlockClosing = false

----------------------------------------------------------------
-- Local Variables
----------------------------------------------------------------

----------------------------------------------------------------
-- Functions
----------------------------------------------------------------
ItemSlot = {}
ItemSlot.NUM_BUTTONS = 12

ItemSlot.BUTTONSTATE_EMPTY = 0
ItemSlot.BUTTONSTATE_NORMAL = 1
ItemSlot.BUTTONSTATE_ACTIVE = 2
ItemSlot.BUTTONSTATE_DISABLED = 3

ItemSlot.ItemIds = {}
ItemSlot.ObjectTypes = {}
ItemSlot.ButtonStates = {}

PaperdollWindow.OpenPaperdolls = {}
PaperdollWindow.ActivePaperdollImage = 0
PaperdollWindow.ActivePaperdollObject = 0
PaperdollWindow.ArmorSlots = 12

PaperdollWindow.Locked = false

PaperdollWindow.BlankSlot = {}
PaperdollWindow.BlankSlot[1]  = { SlotNameTid = 1079897, SlotDescTid = 1079916 }
PaperdollWindow.BlankSlot[2]  = { SlotNameTid = 1079898, SlotDescTid = 1079916 }
PaperdollWindow.BlankSlot[3]  = { SlotNameTid = 1079899, SlotDescTid = 1079916 }
PaperdollWindow.BlankSlot[4]  = { SlotNameTid = 1079900, SlotDescTid = 1079917 }
PaperdollWindow.BlankSlot[5]  = { SlotNameTid = 1079901, SlotDescTid = 1079918 }
PaperdollWindow.BlankSlot[6]  = { SlotNameTid = 1079902, SlotDescTid = 1079916 }
PaperdollWindow.BlankSlot[7]  = { SlotNameTid = 1079903, SlotDescTid = 1079919 }
PaperdollWindow.BlankSlot[8]  = { SlotNameTid = 1079904, SlotDescTid = 1079916 }
PaperdollWindow.BlankSlot[9]  = { SlotNameTid = 1079905, SlotDescTid = 1079920 }
PaperdollWindow.BlankSlot[10] = { SlotNameTid = 1079906, SlotDescTid = 1079917 }
PaperdollWindow.BlankSlot[11] = { SlotNameTid = 1079907, SlotDescTid = 1079916, SlotNameTidTwo = 1115375}
PaperdollWindow.BlankSlot[12] = { SlotNameTid = 1079908, SlotDescTid = 1079921 }
PaperdollWindow.BlankSlot[13] = { SlotNameTid = 1079909, SlotDescTid = nil, SlotNameTidTwo = 1115377}
PaperdollWindow.BlankSlot[14] = { SlotNameTid = 1079910, SlotDescTid = nil }
PaperdollWindow.BlankSlot[15] = { SlotNameTid = 1079911, SlotDescTid = nil }
PaperdollWindow.BlankSlot[16] = { SlotNameTid = 1079912, SlotDescTid = nil }
PaperdollWindow.BlankSlot[17] = { SlotNameTid = 1079913, SlotDescTid = nil, SlotNameTidTwo = 1115376 }
PaperdollWindow.BlankSlot[18] = { SlotNameTid = 1079914, SlotDescTid = nil }
PaperdollWindow.BlankSlot[19] = { SlotNameTid = 1079915, SlotDescTid = nil }

PaperdollWindow.RefreshPlayer = false

---------------------------------------------------------------------

function PaperdollWindow.Initialize()	
	local id = SystemData.Paperdoll.Id
	
	local windowName = "PaperdollWindow"..id
	WindowSetScale(windowName, SystemData.Settings.Interface.customUiScale * 0.70)
	WindowForceProcessAnchors(windowName)	
	
	WindowSetShowing(windowName, false)
	Interface.DestroyWindowOnClose[windowName] = true

	RegisterWindowData(WindowData.Paperdoll.Type,id)
	RegisterWindowData(WindowData.PlayerStatus.Type,0)
	RegisterWindowData(WindowData.MobileStatus.Type, id)

	WindowRegisterEventHandler( windowName, WindowData.Paperdoll.Event, "PaperdollWindow.HandleUpdatePaperdollEvent")

	WindowSetId(windowName, id)
	WindowSetId(windowName.."ToggleInventory", id)
	
	PaperdollWindow.OpenPaperdolls[id] = true
	
	
	-- set the bar at the bottom to the full name
	if( SystemData.Paperdoll.Name ~= nil ) then
		SystemData.Paperdoll.Name = wstring.gsub(SystemData.Paperdoll.Name, L", ", L"<BR>")
		LabelSetText(windowName.."TitleName", SystemData.Paperdoll.Name)
	end

	WindowSetShowing(windowName.."ToggleCharacterSheet", false)
	WindowSetShowing(windowName.."ToggleCharacterAbilities", false)
	
	local mobileData = Interface.GetMobileData(id, true)
	if (mobileData.Race == PaperdollWindow.GARGOYLE) then

		local button = windowName.."ItemSlotButton"..tostring(PaperdollWindow.PAPERDOLLSLOTID.SHIRT)
		ButtonSetTexture(button, InterfaceCore.ButtonStates.STATE_NORMAL, "", 0, 0)
		ButtonSetTexture(button, InterfaceCore.ButtonStates.STATE_NORMAL_HIGHLITE, "", 0, 0)
		ButtonSetTexture(button, InterfaceCore.ButtonStates.STATE_PRESSED, "", 0, 0)
		ButtonSetTexture(button, InterfaceCore.ButtonStates.STATE_DISABLED, "", 0, 0)
				
		button = windowName.."ItemSlotButton"..tostring(PaperdollWindow.PAPERDOLLSLOTID.PANTS)
		ButtonSetTexture(button, InterfaceCore.ButtonStates.STATE_NORMAL, "", 0, 0)
		ButtonSetTexture(button, InterfaceCore.ButtonStates.STATE_NORMAL_HIGHLITE, "", 0, 0)
		ButtonSetTexture(button, InterfaceCore.ButtonStates.STATE_PRESSED, "", 0, 0)
		ButtonSetTexture(button, InterfaceCore.ButtonStates.STATE_DISABLED, "", 0, 0)

		button = windowName.."ItemSlotButton"..tostring(PaperdollWindow.PAPERDOLLSLOTID.HEAD)
		ButtonSetTexture(button, InterfaceCore.ButtonStates.STATE_NORMAL, "", 0, 0)
		ButtonSetTexture(button, InterfaceCore.ButtonStates.STATE_NORMAL_HIGHLITE, "", 0, 0)
		ButtonSetTexture(button, InterfaceCore.ButtonStates.STATE_PRESSED, "", 0, 0)
		ButtonSetTexture(button, InterfaceCore.ButtonStates.STATE_DISABLED, "", 0, 0)
		
		button = windowName.."ItemSlotButton"..tostring(PaperdollWindow.PAPERDOLLSLOTID.KILT)
		ButtonSetTexture(button, InterfaceCore.ButtonStates.STATE_NORMAL, "slot_11_garg", 0, 0)
		ButtonSetTexture(button, InterfaceCore.ButtonStates.STATE_NORMAL_HIGHLITE, "slot_11_garg", 0, 0)
		ButtonSetTexture(button, InterfaceCore.ButtonStates.STATE_PRESSED, "slot_11_garg", 0, 0)
		ButtonSetTexture(button, InterfaceCore.ButtonStates.STATE_DISABLED, "slot_11_garg", 0, 0)
			
		button = windowName.."ItemSlotButton"..tostring(PaperdollWindow.PAPERDOLLSLOTID.WINGARMOR)
		ButtonSetTexture(button, InterfaceCore.ButtonStates.STATE_NORMAL, "slot_16_garg", 0, 0)
		ButtonSetTexture(button, InterfaceCore.ButtonStates.STATE_NORMAL_HIGHLITE, "slot_16_garg", 0, 0)
		ButtonSetTexture(button, InterfaceCore.ButtonStates.STATE_PRESSED, "slot_16_garg", 0, 0)
		ButtonSetTexture(button, InterfaceCore.ButtonStates.STATE_DISABLED, "slot_16_garg", 0, 0)
		
		button = windowName.."ItemSlotButton"..tostring(PaperdollWindow.PAPERDOLLSLOTID.TALONS)
		ButtonSetTexture(button, InterfaceCore.ButtonStates.STATE_NORMAL, "slot_13_garg", 0, 0)
		ButtonSetTexture(button, InterfaceCore.ButtonStates.STATE_NORMAL_HIGHLITE, "slot_13_garg", 0, 0)
		ButtonSetTexture(button, InterfaceCore.ButtonStates.STATE_PRESSED, "slot_13_garg", 0, 0)
		ButtonSetTexture(button, InterfaceCore.ButtonStates.STATE_DISABLED, "slot_13_garg", 0, 0)
		
	end
	
	for index = 1, WindowData.Paperdoll[id].numSlots  do
		local button = windowName.."ItemSlotButton"..index
		
		ButtonSetTexture(button, InterfaceCore.ButtonStates.STATE_NORMAL, "", 0, 0)
		ButtonSetTexture(button, InterfaceCore.ButtonStates.STATE_NORMAL_HIGHLITE, "", 0, 0)
		ButtonSetTexture(button, InterfaceCore.ButtonStates.STATE_PRESSED, "", 0, 0)
		ButtonSetTexture(button, InterfaceCore.ButtonStates.STATE_DISABLED, "", 0, 0)
		
		WindowSetShowing(button.. "SquareDamage", false)
		WindowSetShowing(button.. "RoundDamage", false)
		WindowSetShowing(button.. "SquareIcon", false)		
	end		
	PaperdollWindow.UpdatePaperdoll(windowName,id)
	
	local playerId = WindowData.PlayerStatus.PlayerId
	-- if this is the players backpack then use the saved position
	if( id == playerId ) then
		if(WindowData.Paperdoll[id].backpackId ~= nil ) then
			local backpackName = "ContainerWindow_"..WindowData.Paperdoll[id].backpackId
			if DoesWindowNameExist(backpackName) and WindowGetShowing(backpackName) then
				ButtonSetPressedFlag( windowName.."ToggleInventory", true )
			end		
		end
		WindowUtils.RestoreWindowPosition(windowName, false)
		if (Interface.PaperdollFirstPositioning or not WindowUtils.CanRestorePosition(windowName)) and DoesWindowNameExist("PaperdollWindow"..WindowData.PlayerStatus.PlayerId) then
			WindowClearAnchors("PaperdollWindow"..WindowData.PlayerStatus.PlayerId)
			WindowAddAnchor("PaperdollWindow"..WindowData.PlayerStatus.PlayerId, "bottomright", "ResizeWindow", "bottomleft", 0, -50)
			local x, y= WindowGetOffsetFromParent("PaperdollWindow"..WindowData.PlayerStatus.PlayerId)
			WindowClearAnchors("PaperdollWindow"..WindowData.PlayerStatus.PlayerId)
			WindowSetOffsetFromParent("PaperdollWindow"..WindowData.PlayerStatus.PlayerId, x,y)
			Interface.PaperdollFirstPositioning = nil
		end
		
		Interface.PaperdollOpen = true
		Interface.SaveBoolean( "PaperdollOpen",Interface.PaperdollOpen )
		
		WindowSetShowing(windowName.."ToggleCharacterSheet", true)
		WindowSetShowing(windowName.."ToggleCharacterAbilities", true)
		
		local showing = WindowGetShowing("CharacterSheet")
		ButtonSetPressedFlag( windowName.."ToggleCharacterSheet", showing )
		WindowSetShowing(windowName, true)
    else
		WindowUtils.RestoreWindowPosition(windowName, false,"PaperdollOthers", false )
		local x, y = WindowGetOffsetFromParent(windowName)
		if x < 0 and y < 0 then
			WindowClearAnchors(windowName)
			WindowAddAnchor(windowName,  "right", "ResizeWindow", "right", 0, 0)
			x, y = WindowGetOffsetFromParent(windowName)
			WindowClearAnchors(windowName)
			WindowSetOffsetFromParent(windowName, x, y)
		end
		WindowSetShowing(windowName, true)
	end

	
	SnapUtils.SnappableWindows[windowName] = true
	
	
	if (id ~= WindowData.PlayerStatus.PlayerId) then
		WindowSetShowing(windowName .. "ToggleLock", false)
	else
		WindowSetShowing(windowName .. "ToggleLock", true)
		PaperdollWindow.GotDamage = true
	end

	ButtonSetPressedFlag(windowName .. "ToggleLock",PaperdollWindow.Locked)
end

function PaperdollWindow.LockTooltip()
	if ( PaperdollWindow.Locked ) then
		Tooltips.CreateTextOnlyTooltip(SystemData.ActiveWindow.name, GetStringFromTid(1154924))
	else
		Tooltips.CreateTextOnlyTooltip(SystemData.ActiveWindow.name, GetStringFromTid(1154925))
	end
	
	Tooltips.Finalize()
	Tooltips.AnchorTooltip( Tooltips.ANCHOR_WINDOW_TOP )
end


function PaperdollWindow.Lock()
	PaperdollWindow.Locked = not PaperdollWindow.Locked 
	Interface.SaveBoolean( "PdollWindowLocked", PaperdollWindow.Locked  )
	local paperdollId = WindowGetId(WindowUtils.GetActiveDialog())
	local windowName = "PaperdollWindow"..paperdollId
	ButtonSetPressedFlag(windowName .. "ToggleLock",PaperdollWindow.Locked)
end

function PaperdollWindow.CloseWindow()
	if PaperdollWindow.BlockClosing then
		PaperdollWindow.BlockClosing = false
		return
	end
	local id = WindowGetId(WindowUtils.GetActiveDialog())
	if (id == WindowData.PlayerStatus.PlayerId) then
		Interface.PaperdollOpen = false
		Interface.SaveBoolean( "PaperdollOpen",Interface.PaperdollOpen )
	end
	UO_DefaultWindow.CloseDialog()
end

		
function PaperdollWindow.Shutdown()
	PaperdollWindow.CurrentBG = ""
	local paperdollId = WindowGetId(WindowUtils.GetActiveDialog())
	local windowName = "PaperdollWindow"..paperdollId
	
		
	-- only save the position of the players character window
	local playerId = WindowData.PlayerStatus.PlayerId
	
	if( paperdollId == playerId ) then
		WindowUtils.SaveWindowPosition(windowName, false)
		PaperdollWindow.Organize = false
		if ( DoesWindowNameExist("UndressWarningDialog")) then
			DestroyWindow("UndressWarningDialog")
		end
		
	else
		WindowUtils.SaveWindowPosition(windowName, false, "PaperdollOthers")
	end
	if paperdollId ~= WindowData.CurrentTarget.TargetId and WindowData.PlayerStatus.PlayerId ~= paperdollId then
		if WindowData.Paperdoll[paperdollId] then
			UnregisterWindowData(WindowData.Paperdoll.Type,paperdollId)	
		end
	end

	if WindowData.PlayerStatus.PlayerId ~= paperdollId and not MobileHealthBar.HasWindow(paperdollId) and CurrentTarget.id() ~= paperdollId then
		UnregisterWindowData(WindowData.MobileStatus.Type,paperdollId)
	end	
	PaperdollWindow.OpenPaperdolls[paperdollId] = nil
	
	if( ItemProperties.GetCurrentWindow() == windowName ) then
		ItemProperties.ClearMouseOverItem()
	end
	
	-- removes the paperdoll from uo_interface's list of open paperdolls
	ClosePaperdoll(paperdollId)
	SnapUtils.SnappableWindows[windowName] = nil
	PaperdollWindow.OpenPaperdolls[paperdollId] = nil
	
end

function PaperdollWindow.OnMouseDrag()
	local paperdollId = WindowGetId(WindowUtils.GetActiveDialog())
	windowName = "PaperdollWindow"..paperdollId
	if (paperdollId == WindowData.PlayerStatus.PlayerId) then
		if (not PaperdollWindow.Locked ) then
			SnapUtils.StartWindowSnap(windowName, PaperdollWindow.WINDOWSCALE)
			WindowSetMoving(windowName,true)
		else
			WindowSetMoving(windowName,false)
		end
	end
	
end

function PaperdollWindow.HandleUpdatePaperdollEvent()
	
    PaperdollWindow.UpdatePaperdoll(SystemData.ActiveWindow.name,WindowData.UpdateInstanceId)
end

function PaperdollWindow.UpdatePaperdoll(windowName,paperdollId)
	if (not DoesWindowNameExist(windowName) or not WindowData.Paperdoll[paperdollId]) then
		return
	end

	if( paperdollId == WindowGetId(windowName) ) then
		local elementIcon		
		local element
		local topButton 
		local pdscale = WindowGetScale(windowName)
		local mobileData = Interface.GetMobileData(paperdollId, true)
		
		if mobileData.Race == PaperdollWindow.GARGOYLE then	
			local button = windowName.."ItemSlotButton"..tostring(PaperdollWindow.PAPERDOLLSLOTID.SHIRT)
			ButtonSetTexture(button, InterfaceCore.ButtonStates.STATE_NORMAL, "", 0, 0)
			ButtonSetTexture(button, InterfaceCore.ButtonStates.STATE_NORMAL_HIGHLITE, "", 0, 0)
			ButtonSetTexture(button, InterfaceCore.ButtonStates.STATE_PRESSED, "", 0, 0)
			ButtonSetTexture(button, InterfaceCore.ButtonStates.STATE_DISABLED, "", 0, 0)
					
			button = windowName.."ItemSlotButton"..tostring(PaperdollWindow.PAPERDOLLSLOTID.PANTS)
			ButtonSetTexture(button, InterfaceCore.ButtonStates.STATE_NORMAL, "", 0, 0)
			ButtonSetTexture(button, InterfaceCore.ButtonStates.STATE_NORMAL_HIGHLITE, "", 0, 0)
			ButtonSetTexture(button, InterfaceCore.ButtonStates.STATE_PRESSED, "", 0, 0)
			ButtonSetTexture(button, InterfaceCore.ButtonStates.STATE_DISABLED, "", 0, 0)

			button = windowName.."ItemSlotButton"..tostring(PaperdollWindow.PAPERDOLLSLOTID.HEAD)
			ButtonSetTexture(button, InterfaceCore.ButtonStates.STATE_NORMAL, "", 0, 0)
			ButtonSetTexture(button, InterfaceCore.ButtonStates.STATE_NORMAL_HIGHLITE, "", 0, 0)
			ButtonSetTexture(button, InterfaceCore.ButtonStates.STATE_PRESSED, "", 0, 0)
			ButtonSetTexture(button, InterfaceCore.ButtonStates.STATE_DISABLED, "", 0, 0)
			
			button = windowName.."ItemSlotButton"..tostring(PaperdollWindow.PAPERDOLLSLOTID.KILT)
			ButtonSetTexture(button, InterfaceCore.ButtonStates.STATE_NORMAL, "slot_11_garg", 0, 0)
			ButtonSetTexture(button, InterfaceCore.ButtonStates.STATE_NORMAL_HIGHLITE, "slot_11_garg", 0, 0)
			ButtonSetTexture(button, InterfaceCore.ButtonStates.STATE_PRESSED, "slot_11_garg", 0, 0)
			ButtonSetTexture(button, InterfaceCore.ButtonStates.STATE_DISABLED, "slot_11_garg", 0, 0)
				
			button = windowName.."ItemSlotButton"..tostring(PaperdollWindow.PAPERDOLLSLOTID.WINGARMOR)
			ButtonSetTexture(button, InterfaceCore.ButtonStates.STATE_NORMAL, "slot_16_garg", 0, 0)
			ButtonSetTexture(button, InterfaceCore.ButtonStates.STATE_NORMAL_HIGHLITE, "slot_16_garg", 0, 0)
			ButtonSetTexture(button, InterfaceCore.ButtonStates.STATE_PRESSED, "slot_16_garg", 0, 0)
			ButtonSetTexture(button, InterfaceCore.ButtonStates.STATE_DISABLED, "slot_16_garg", 0, 0)
			
			button = windowName.."ItemSlotButton"..tostring(PaperdollWindow.PAPERDOLLSLOTID.TALONS)
			ButtonSetTexture(button, InterfaceCore.ButtonStates.STATE_NORMAL, "slot_13_garg", 0, 0)
			ButtonSetTexture(button, InterfaceCore.ButtonStates.STATE_NORMAL_HIGHLITE, "slot_13_garg", 0, 0)
			ButtonSetTexture(button, InterfaceCore.ButtonStates.STATE_PRESSED, "slot_13_garg", 0, 0)
			ButtonSetTexture(button, InterfaceCore.ButtonStates.STATE_DISABLED, "slot_13_garg", 0, 0)
		end
		
		for index = 1, WindowData.Paperdoll[paperdollId].numSlots  do
			
			element = windowName.."ItemSlotButton"..tostring(index)
			elementIcon = windowName.."ItemSlotButton"..tostring(index).."SquareIcon"			
			elementSquareDMG =  windowName.."ItemSlotButton"..tostring(index).."SquareDamage"
			elementRoundDMG =  windowName.."ItemSlotButton"..tostring(index).."RoundDamage"
			elementSquareBroken =  windowName.."ItemSlotButton"..tostring(index).."SquareBroken"
			elementRoundBroken =  windowName.."ItemSlotButton"..tostring(index).."RoundBroken"
			topButton = windowName.."ItemSlotButton"..index
			
			
			--Debug.Print("Index = "..index.." window name = "..tostring(elementIcon))

			WindowSetShowing(elementSquareDMG, false)
			WindowSetShowing(elementRoundDMG, false)
			WindowSetShowing(elementSquareBroken, false)
			WindowSetShowing(elementRoundBroken, false)
			WindowSetShowing(element, false)	
			
			
			if (WindowData.Paperdoll[paperdollId][index].slotId == 0) then
				ItemSlot.ButtonStates[index] = ItemSlot.BUTTONSTATE_EMPTY
				ItemSlot.ItemIds[index] = 0
				ItemSlot.ObjectTypes[index] = 0	
				WindowSetShowing(elementIcon, false)				
				local id = WindowGetId(element)
				
				if (mobileData.Race ~= PaperdollWindow.GARGOYLE) or 
				(index ~= PaperdollWindow.PAPERDOLLSLOTID.SHIRT and
				index ~= PaperdollWindow.PAPERDOLLSLOTID.PANTS and
				index ~= PaperdollWindow.PAPERDOLLSLOTID.HEAD and
				index ~= PaperdollWindow.PAPERDOLLSLOTID.KILT and
				index ~= PaperdollWindow.PAPERDOLLSLOTID.WINGARMOR and
				index ~= PaperdollWindow.PAPERDOLLSLOTID.TALONS) then

					ButtonSetTexture(element, InterfaceCore.ButtonStates.STATE_NORMAL, "slot_" .. id, 0, 0)
					ButtonSetTexture(element, InterfaceCore.ButtonStates.STATE_NORMAL_HIGHLITE, "slot_" .. id, 0, 0)
					ButtonSetTexture(element, InterfaceCore.ButtonStates.STATE_PRESSED, "slot_" .. id, 0, 0)
					ButtonSetTexture(element, InterfaceCore.ButtonStates.STATE_DISABLED, "slot_" .. id, 0, 0)
					
				end
			else	
				
				ButtonSetTexture(element, InterfaceCore.ButtonStates.STATE_NORMAL, "", 0, 0)
				ButtonSetTexture(element, InterfaceCore.ButtonStates.STATE_NORMAL_HIGHLITE, "", 0, 0)
				ButtonSetTexture(element, InterfaceCore.ButtonStates.STATE_PRESSED, "", 0, 0)
				ButtonSetTexture(element, InterfaceCore.ButtonStates.STATE_DISABLED, "", 0, 0)
				--Debug.Print(" window name slotId textureName = "..tostring(WindowData.Paperdoll[paperdollId][index].slotTextureName))
				
				ItemSlot.ItemIds[index] = WindowData.Paperdoll[paperdollId][index].slotId
				WindowData.UpdateInstanceId = ItemSlot.ItemIds[index]
				HotbarSystem.UpdateItemSlot()
				ItemSlot.ObjectTypes[index] = WindowData.Paperdoll[paperdollId][index].slotTextureName
				ItemSlot.ButtonStates[index] = ItemSlot.BUTTONSTATE_NORMAL
	
				data = WindowData.Paperdoll[paperdollId][index]
				EquipmentData.UpdateItemIcon(elementIcon, data)			
						
				-- DAB TODO UPDATE ANCHORS
				parent = WindowGetParent(elementIcon)
				
				
	
				local elem = elementSquareDMG
				if index == 12 then
					elem = elementRoundDMG
					WindowSetShowing(elementSquareDMG, false)	
					WindowSetShowing(elementRoundDMG, true)					
					WindowClearAnchors(elementIcon)
					WindowAddAnchor(elementIcon, "center", elementRoundDMG, "center", 0, 2)
				else
					WindowSetShowing(elementSquareDMG, true)
					WindowSetShowing(elementRoundDMG, false)
					WindowClearAnchors(elementIcon)
					WindowAddAnchor(elementIcon, "center", elementSquareDMG, "center", 0, 2)
				end
				WindowSetShowing(elementIcon, true)		
				
				WindowSetTintColor(elem, 0, 255, 0)
				if WindowData.Paperdoll[WindowData.PlayerStatus.PlayerId][index].Durability then
										
					local curr = WindowData.Paperdoll[WindowData.PlayerStatus.PlayerId][index].Durability.Current
					local max = WindowData.Paperdoll[WindowData.PlayerStatus.PlayerId][index].Durability.Max

					local perc = math.floor((curr/max)*100)
					if perc > 50 then
						WindowSetShowing(elementSquareDMG, false)
						WindowSetShowing(elementRoundDMG, false)
					elseif perc > 10 then
						WindowSetTintColor(elem, 255, 102, 0)
					else
						WindowSetTintColor(elem, 255, 0, 0)
					end
					
					
					if perc == 0 and curr == 0 then
						if index == 12 then
							WindowSetShowing(elementRoundBroken, true)
						else
							WindowSetShowing(elementSquareBroken, true)
						end
					end
				else
					WindowSetShowing(elementSquareDMG, false)
					WindowSetShowing(elementRoundDMG, false)
				end

			end	
			WindowSetShowing(element, true)
		end
		
		
		local textureData = SystemData.PaperdollTexture[paperdollId]
		if textureData ~= nil then
			
			local tabNames = { windowName.."" }
			
			-- Check if the paperdoll texture has changed by comparing old/new dimensions
			local texWidth, texHeight = WindowGetDimensions(tabNames[1])
			local newWidth, newHeight = textureData.Width, textureData.Height
			if texWidth ~= newWidth or texHeight ~= newHeight then
				
				local visibleTextures = { tabNames[1].."Texture" }

				local mobileData = Interface.GetMobileData(paperdollId, true)
				local paperdollTextureName = "paperdoll_texture"..paperdollId
				for index, paperdollTexture in ipairs(visibleTextures) do
					WindowSetShowing(paperdollTexture, true)
					WindowSetHandleInput(paperdollTexture, true)
					WindowSetDimensions(paperdollTexture, newWidth, newHeight)
					WindowClearAnchors(paperdollTexture)
	
					if mobileData.Race == PaperdollWindow.GARGOYLE then
						--[[ GARGOYLE FEMALE --]]
						if mobileData.Gender == 1 then
							WindowAddAnchor(paperdollTexture, "center", tabNames[index], "topleft", textureData.xOffset - 10, textureData.yOffset + 30)	
							DynamicImageSetTexture(paperdollTexture, paperdollTextureName, 0, 0)
						else
						--[[ GARGOYLE MALE --]]
							WindowAddAnchor(paperdollTexture, "center", tabNames[index], "topleft", textureData.xOffset, textureData.yOffset + 30)	
							DynamicImageSetTexture(paperdollTexture, paperdollTextureName, 0, 0)
						end
					elseif mobileData.Race == PaperdollWindow.HUMAN then
						--[[ HUMAN FEMALE --]]
						if mobileData.Gender == 1 then
							WindowAddAnchor(paperdollTexture, "center", tabNames[index], "topleft", textureData.xOffset -5, textureData.yOffset + 30)	
							DynamicImageSetTexture(paperdollTexture, paperdollTextureName, 0, 0)
						else
						--[[ HUMAN MALE --]]
							WindowAddAnchor(paperdollTexture, "center", tabNames[index], "topleft", textureData.xOffset +5, textureData.yOffset + 30 )	
							DynamicImageSetTexture(paperdollTexture, paperdollTextureName, 0, 0)
						end
					elseif mobileData.Race == PaperdollWindow.ELF then
						--[[ ELF FEMALE --]]
						if mobileData.Gender == 1 then
							WindowAddAnchor(paperdollTexture, "center", tabNames[index], "topleft", textureData.xOffset -5, textureData.yOffset + 30)	
							DynamicImageSetTexture(paperdollTexture, paperdollTextureName, 0, 0)
						else
						--[[ ELF MALE --]]
							WindowAddAnchor(paperdollTexture, "center", tabNames[index], "topleft", textureData.xOffset +5, textureData.yOffset + 30)	
							DynamicImageSetTexture(paperdollTexture, paperdollTextureName, 0, 0)
						end
					end
				end
			end
		end	
	end

	WindowUtils.LoadScale( windowName )
end

function PaperdollWindow.GetMouseSlotId()
	local paperdollId = WindowGetId(WindowUtils.GetActiveDialog())
	local windowName = "PaperdollWindow"..paperdollId
	local slotId = GetPaperdollObject(paperdollId, WindowGetScale(windowName))
	return paperdollId, slotId
end

function PaperdollWindow.OnPaperdollTextureLButtonDown(flags)
	local paperdollId, slotId = PaperdollWindow.GetMouseSlotId()
	
	if( WindowData.Cursor ~= nil and WindowData.Cursor.target == true and slotId ~= 0 )
	then
		RegisterWindowData(WindowData.ObjectInfo.Type, slotId)
        HandleSingleLeftClkTarget(slotId)
		UnregisterWindowData(WindowData.ObjectInfo.Type, slotId)
		return
	end
	
	--Debug.Print("PaperdollWindow.OnPaperdollTextureLButtonDblClk()"..paperdollId)
	if( slotId ~= 0 ) then	
		if flags == SystemData.ButtonFlags.CONTROL and DoesPlayerHaveItem(slotId) then
			local itemData = WindowData.ObjectInfo[slotId]
			local blockBar = HotbarSystem.GetNextHotbarId()
			Interface.SaveBoolean("Hotbar" .. blockBar .. "_IsBlockbar", true)
			HotbarSystem.SpawnNewHotbar()
			
			HotbarSystem.SetActionOnHotbar(SystemData.UserAction.TYPE_USE_ITEM, slotId, itemData.iconId, blockBar,  1)
			
			local scaleFactor = 1/InterfaceCore.scale	
			
			local propWindowWidth = Hotbar.BUTTON_SIZE
			local propWindowHeight = Hotbar.BUTTON_SIZE
			
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
			
			WindowSetOffsetFromParent("Hotbar" .. blockBar, propWindowX * scaleFactor, propWindowY * scaleFactor)
			WindowSetMoving("Hotbar" .. blockBar, true)
		else
			DragSlotSetObjectMouseClickData(slotId, SystemData.DragSource.SOURCETYPE_PAPERDOLL)
		end
	end
end

function PaperdollWindow.OnPaperdollTextureLButtonUp()
	local paperdollId, slotId = PaperdollWindow.GetMouseSlotId()

	if( SystemData.DragItem.DragType == SystemData.DragItem.TYPE_ITEM ) then
		if( slotId ~= 0 ) then
			DragSlotDropObjectToPaperdollEquipment(slotId)
		else
			DragSlotDropObjectToPaperdoll(paperdollId)
		end
		PaperdollWindow.GotDamage = true
	end
end

function PaperdollWindow.OnPaperdollTextureLButtonDblClk()
	local paperdollId, slotId = PaperdollWindow.GetMouseSlotId()
	UserActionUseItem(slotId,false)
end


function PaperdollWindow.OnPaperdollTextureRButtonDown()
	local paperdollId, slotId = PaperdollWindow.GetMouseSlotId()

	
	if( slotId ~= 0 ) then
		PaperdollWindow.MenuRequest = slotId
		RequestContextMenu(slotId)
	end
end

			
function PaperdollWindow.OnPaperdollTextureMouseOver()
	local ok, paperdollId, slotId  = pcall(PaperdollWindow.GetMouseSlotId)	
	Interface.ErrorTracker(ok, paperdollId)
	if type(paperdollId) ~= "function" then
		PaperdollWindow.ActivePaperdollImage = paperdollId
	end
end

function PaperdollWindow.OnPaperdollTextureMouseEnd()
	PaperdollWindow.ActivePaperdollImage = 0
	PaperdollWindow.ActivePaperdollObject = 0
	ItemProperties.ClearMouseOverItem()
end

function PaperdollWindow.SlotLButtonDown(flags)
	local slotIndex = WindowGetId(SystemData.ActiveWindow.name)
	local paperdollId = WindowGetId(WindowUtils.GetActiveDialog())
	local slotId = WindowData.Paperdoll[paperdollId][slotIndex].slotId
	
	if( WindowData.Cursor ~= nil and WindowData.Cursor.target == true and slotId ~= 0 )
	then
		RegisterWindowData(WindowData.ObjectInfo.Type, slotId)
		HandleSingleLeftClkTarget(slotId)		
		UnregisterWindowData(WindowData.ObjectInfo.Type, slotId)
		return
	end
	if flags == SystemData.ButtonFlags.CONTROL and DoesPlayerHaveItem(slotId) then
		local itemData = WindowData.ObjectInfo[slotId]
		local blockBar = HotbarSystem.GetNextHotbarId()
		Interface.SaveBoolean("Hotbar" .. blockBar .. "_IsBlockbar", true)
		HotbarSystem.SpawnNewHotbar()
		
		HotbarSystem.SetActionOnHotbar(SystemData.UserAction.TYPE_USE_ITEM, slotId, itemData.iconId, blockBar,  1)
		
		local scaleFactor = 1/InterfaceCore.scale	
		
		local propWindowWidth = Hotbar.BUTTON_SIZE
		local propWindowHeight = Hotbar.BUTTON_SIZE
		
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
		
		WindowSetOffsetFromParent("Hotbar" .. blockBar, propWindowX * scaleFactor, propWindowY * scaleFactor)
		WindowSetMoving("Hotbar" .. blockBar, true)
	else
		DragSlotSetObjectMouseClickData(slotId, SystemData.DragSource.SOURCETYPE_PAPERDOLL)
	end
end

function PaperdollWindow.SlotLButtonUp()
	local slotIndex = WindowGetId(SystemData.ActiveWindow.name)
	local paperdollId = WindowGetId(WindowUtils.GetActiveDialog())
	local objectId = WindowData.Paperdoll[paperdollId][slotIndex].slotId
	
	if( SystemData.DragItem.DragType == SystemData.DragItem.TYPE_ITEM ) then
		if( objectId ~= 0 ) then
			DragSlotDropObjectToPaperdollEquipment(objectId)
		else
			DragSlotDropObjectToPaperdoll(paperdollId)
		end
		PaperdollWindow.GotDamage = true
	end
end

function PaperdollWindow.SlotLButtonDblClk()
    local dialog = WindowUtils.GetActiveDialog()
	local PaperdollId = WindowGetId(dialog)
	local SlotNum = WindowGetId(SystemData.ActiveWindow.name)
	local SlotId = WindowData.Paperdoll[PaperdollId][SlotNum].slotId	
	
	UserActionUseItem(SlotId,false)
end

function PaperdollWindow.SlotRButtonDown()
	local slotIndex = WindowGetId(SystemData.ActiveWindow.name)
	local paperdollId = WindowGetId(WindowUtils.GetActiveDialog())
	local slotId = WindowData.Paperdoll[paperdollId][slotIndex].slotId

	local playerId = WindowData.PlayerStatus.PlayerId
	if( paperdollId == playerId and slotId ~= 0 ) then
		RequestContextMenu(slotId)
		PaperdollWindow.MenuRequest = slotId
		PaperdollWindow.BlockClosing = true
	end
end

function PaperdollWindow.ItemMouseOver()
	local SlotNum = WindowGetId(SystemData.ActiveWindow.name)
	local dialog = WindowUtils.GetActiveDialog()
	local PaperdollId = WindowGetId(dialog)
	local SlotId = WindowData.Paperdoll[PaperdollId][SlotNum].slotId
	local itemData
	local slotTitle
--Debug.Print(SlotNum)
	local mobileData = Interface.GetMobileData(PaperdollId, true)

	if SlotId ~= 0 then
		itemData = {
			windowName = dialog,
			itemId = SlotId,
			itemType = WindowData.ItemProperties.TYPE_ITEM,
			detail = ItemProperties.DETAIL_LONG,
			data = WindowData.Paperdoll[PaperdollId][SlotNum]
		}
	elseif (mobileData) then
		local EmptySlotBodyText		
		if ( ((mobileData.Race == PaperdollWindow.GARGOYLE) and ((PaperdollWindow.PAPERDOLLSLOTID.TALONS == SlotNum) or ( PaperdollWindow.PAPERDOLLSLOTID.WINGARMOR == SlotNum) or (PaperdollWindow.PAPERDOLLSLOTID.KILT == SlotNum))) ) then											
				slotTitle =	GetStringFromTid( PaperdollWindow.BlankSlot[SlotNum].SlotNameTidTwo)			
		elseif ( ((mobileData.Race == PaperdollWindow.GARGOYLE) and ((PaperdollWindow.PAPERDOLLSLOTID.SHIRT == SlotNum) or ( PaperdollWindow.PAPERDOLLSLOTID.PANTS == SlotNum) or (PaperdollWindow.PAPERDOLLSLOTID.HEAD == SlotNum))) ) then
			slotTitle = L""
		else				
			
			slotTitle =	GetStringFromTid( PaperdollWindow.BlankSlot[SlotNum].SlotNameTid )									
		end				
		
		if (PaperdollWindow.BlankSlot[SlotNum].SlotDescTid and slotTitle ~= L"") then			
			EmptySlotBodyText = GetStringFromTid(  PaperdollWindow.BlankSlot[SlotNum].SlotDescTid )
		else
			EmptySlotBodyText = L""			
		end
		
		itemData = {
			windowName = "EmptyPaperdollSlot"..SlotNum,
			itemId = SlotNum,
			itemType = WindowData.ItemProperties.TYPE_WSTRINGDATA,
			binding = L"",
			detail = ItemProperties.DETAIL_LONG,
			title = slotTitle,
			body = EmptySlotBodyText,
		}	

	end
	ItemProperties.SetActiveItem(itemData)
end

function PaperdollWindow.OnUpdate(timePassed)
	if( PaperdollWindow.ActivePaperdollImage ~= 0 ) then
		local dialog = WindowUtils.GetActiveDialog()
		local windowName = "PaperdollWindow"..PaperdollWindow.ActivePaperdollImage
		if not DoesWindowNameExist(windowName) then
			PaperdollWindow.ActivePaperdollImage = 0
			return
		end
		local SlotId = GetPaperdollObject(PaperdollWindow.ActivePaperdollImage, WindowGetScale(windowName))
		

		if SlotId ~= 0 and (PaperdollWindow.ActivePaperdollObject == 0 or
		                   PaperdollWindow.ActivePaperdollObject ~= SlotId) then
			PaperdollWindow.ActivePaperdollObject = SlotId
			local itemData = { windowName = dialog,
								itemId = SlotId,
								itemType = WindowData.ItemProperties.TYPE_ITEM,
								detail = ItemProperties.DETAIL_LONG }
			
			ItemProperties.SetActiveItem(itemData)
		elseif SlotId == 0 and PaperdollWindow.ActivePaperdollObject ~= 0 then
			PaperdollWindow.ActivePaperdollObject = 0
			ItemProperties.ClearMouseOverItem()
		end
	end
end

function PaperdollWindow.ToggleInventoryWindow()
	local id = WindowGetId(WindowUtils.GetActiveDialog())
	local windowName = "PaperdollWindow"..id
	local inventoryName = windowName.."ToggleInventory"
	if (ButtonGetDisabledFlag(inventoryName) ) then
		return
	end
	if( WindowData.Cursor ~= nil and WindowData.Cursor.target == true  ) then
		local backpackId = WindowData.PlayerEquipmentSlot[EquipmentData.EQPOS_BACKPACK].objectId
		HandleSingleLeftClkTarget(backpackId)
		ButtonSetPressedFlag( inventoryName, true )
	elseif( SystemData.DragItem.DragType == SystemData.DragItem.TYPE_ITEM ) then
	    DragSlotDropObjectToObject(WindowData.PlayerStatus.PlayerId)
	    ButtonSetPressedFlag( inventoryName, true )
	else
		local showing = false
		local playerId = WindowData.PlayerStatus.PlayerId
		if( id == playerId ) then
			Actions.ToggleInventoryWindow()	
		elseif( WindowData.Paperdoll[id].backpackId ~= nil ) then
			UserActionUseItem(WindowData.Paperdoll[id].backpackId,false)
		end
		
		local backpackName = "ContainerWindow_"..WindowData.Paperdoll[id].backpackId
		if(DoesWindowNameExist(backpackName)) then
			showing = WindowGetShowing(backpackName)
		end
	end		
end

function PaperdollWindow.OnMouseOverToggleCharacterAbilities()
	local text = GetStringFromTid(1112228)
	local buttonName = SystemData.ActiveWindow.name
	Tooltips.CreateTextOnlyTooltip(buttonName, text)
	Tooltips.Finalize()
	Tooltips.AnchorTooltip( Tooltips.ANCHOR_WINDOW_TOP )
end

function PaperdollWindow.OnMouseOverToggleCharacterSheet()
	local text = GetStringFromTid(1077437)
	local buttonName = SystemData.ActiveWindow.name
	Tooltips.CreateTextOnlyTooltip(buttonName, text)
	Tooltips.Finalize()
	Tooltips.AnchorTooltip( Tooltips.ANCHOR_WINDOW_TOP )
end

function PaperdollWindow.ToggleCharacterSheet()
	local id = WindowGetId(WindowUtils.GetActiveDialog())
	local windowName = "PaperdollWindow"..id
	local characterSheetName = windowName.."ToggleCharacterSheet"
	if (ButtonGetDisabledFlag(characterSheetName) ) then
		return
	end
	showing = WindowGetShowing("CharacterSheet")
	local playerId = WindowData.PlayerStatus.PlayerId
	-- if this is the players paperdoll toggle character sheet
	if( id == playerId ) then
		ToggleWindowByName("CharacterSheet", "", nil)
		ButtonSetPressedFlag( characterSheetName, not showing )
	end
end

function PaperdollWindow.ToggleCharacterAbilities()
	local id = WindowGetId(WindowUtils.GetActiveDialog())
	local windowName = "PaperdollWindow"..id
	local characterSheetName = windowName.."ToggleCharacterAbilities"
	if (ButtonGetDisabledFlag(characterSheetName) ) then
		return
	end
	showing = WindowGetShowing("CharacterAbilities")
	local playerId = WindowData.PlayerStatus.PlayerId
	-- if this is the players paperdoll toggle character sheet
	if( id == playerId ) then
		ToggleWindowByName("CharacterAbilities", "", nil)
		ButtonSetPressedFlag( characterSheetName, not showing )
	end
end

function PaperdollWindow.OnMouseOverToggleInventory()
	local buttonName = SystemData.ActiveWindow.name
	local paperdollId = WindowGetId(buttonName)
	
	if(paperdollId == WindowData.PlayerStatus.PlayerId) then
		ItemProperties.OnPlayerBackpackMouseover()
	end
end

PaperdollWindow.GotDamage = false

function PaperdollWindow.UpdateDurabilities(timePassed)
	
	if not PaperdollWindow.GotDamage then
		return
	end
	
	local paperdoll = false
	if WindowData.Paperdoll[WindowData.PlayerStatus.PlayerId] then
		paperdoll =true
	else
		RegisterWindowData(WindowData.Paperdoll.Type, WindowData.PlayerStatus.PlayerId)
		if WindowData.Paperdoll[WindowData.PlayerStatus.PlayerId] then
			paperdoll =true
		end
	end
	if paperdoll then
		for index = 1, WindowData.Paperdoll[WindowData.PlayerStatus.PlayerId].numSlots  do
			if (WindowData.Paperdoll[WindowData.PlayerStatus.PlayerId][index].slotId ~= 0) then
				local objectId = WindowData.Paperdoll[WindowData.PlayerStatus.PlayerId][index].slotId
				
				local dur = ItemProperties.GetObjectPropertiesParamsForTid( objectId, 1060639, "getting durability values" )
				
				if dur then		
					local actual = tonumber(dur[1])
					local max = tonumber(dur[2])
					
					if WindowData.Paperdoll[WindowData.PlayerStatus.PlayerId][index].Durability then
						if WindowData.Paperdoll[WindowData.PlayerStatus.PlayerId][index].Durability.Current ~= actual then
							PaperdollWindow.OnItemDamaged(WindowData.Paperdoll[WindowData.PlayerStatus.PlayerId][index], index, actual - WindowData.Paperdoll[WindowData.PlayerStatus.PlayerId][index].Durability.Current)
						end
						if WindowData.Paperdoll[WindowData.PlayerStatus.PlayerId][index].Durability.Max ~= max then
							PaperdollWindow.OnItemSeverelyDamaged(WindowData.Paperdoll[WindowData.PlayerStatus.PlayerId][index], index, max - WindowData.Paperdoll[WindowData.PlayerStatus.PlayerId][index].Durability.Max)
						end
					end
					
					WindowData.Paperdoll[WindowData.PlayerStatus.PlayerId][index].Durability = {Current=actual, Max=max}
				else
					WindowData.Paperdoll[WindowData.PlayerStatus.PlayerId][index].Durability = nil
				end
			end
		end
		PaperdollWindow.GotDamage = false
	end
	
	if DoesWindowNameExist("PaperdollWindow"..WindowData.PlayerStatus.PlayerId) then
		PaperdollWindow.UpdatePaperdoll("PaperdollWindow"..WindowData.PlayerStatus.PlayerId,WindowData.PlayerStatus.PlayerId)
	end
	
end

-- Triggered when an item loses durability
function PaperdollWindow.OnItemDamaged(id, slotId, durabilityLost)

end

-- Triggered when an item loses MAX durability
function PaperdollWindow.OnItemSeverelyDamaged(id, slotId, MAXdurabilityLost)

end