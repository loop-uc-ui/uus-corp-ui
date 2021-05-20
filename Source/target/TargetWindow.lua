----------------------------------------------------------------
-- Global Variables
----------------------------------------------------------------

TargetWindow = {}

----------------------------------------------------------------
-- Local Variables
----------------------------------------------------------------

TargetWindow.TargetId = 0
TargetWindow.HasTarget = false
TargetWindow.TargetType = 0
TargetWindow.MobileType = 2
TargetWindow.ObjectType = 3
TargetWindow.CorpseType = 4

TargetWindow.Buttons = {}

TargetWindow.Delta = 0
TargetWindow.DeltaC = 0

TargetWindow.CurrentCreature = nil

TargetWindow.RegisterTime = {}
TargetWindow.PreviousTargets = {}

TargetWindow.Locked = true

TargetWindow.KnownPlayers = {} 
TargetWindow.KnownTamable = {}

----------------------------------------------------------------
-- Functions
----------------------------------------------------------------

function TargetWindow.Initialize()
	--Debug.PrintToDebugConsole(L"Initialize TARGET WINDOW")
    StatusBarSetCurrentValue( "TargetWindowHealthBar", 0 )
	StatusBarSetMaximumValue( "TargetWindowHealthBar", 100 )

	RegisterWindowData(WindowData.CurrentTarget.Type,0)
	WindowRegisterEventHandler( "TargetWindow", WindowData.CurrentTarget.Event, "TargetWindow.UpdateTarget")
	WindowRegisterEventHandler( "TargetWindow", WindowData.MobileStatus.Event, "TargetWindow.MobileStatusUpdate")
	WindowRegisterEventHandler( "TargetWindow", WindowData.MobileName.Event, "TargetWindow.HandleUpdateNameEvent")
	WindowRegisterEventHandler( "TargetWindow", WindowData.ObjectInfo.Event, "TargetWindow.UpdateObjectInfo")
	WindowRegisterEventHandler( "TargetWindow", WindowData.HealthBarColor.Event, "TargetWindow.HandleTintHealthBarEvent")
	
	TargetWindow.Locked = Interface.LoadBoolean( "TargetWindowLocked", TargetWindow.Locked )
	
	local this = "TargetWindow"
	local texture = "UO_Core"
	if ( TargetWindow.Locked  ) then		
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
	
	WindowUtils.RestoreWindowPosition("TargetWindow")
	
	if WindowData.CurrentTarget.TargetId ~= 0 then
		BroadcastEvent(WindowData.CurrentTarget.Event) 
		TargetWindow.UpdateButtons()
	end
end

function TargetWindow.Shutdown()
	--Debug.PrintToDebugConsole(L"shutdown TARGET WINDOW")
	TargetWindow.ClearPreviousTarget()

	UnregisterWindowData(WindowData.CurrentTarget.Type,0)
	
	WindowUtils.SaveWindowPosition("TargetWindow")
end

function TargetWindow.ClearPreviousTarget()
	for i = 1, #TargetWindow.Buttons do
		if DoesWindowNameExist(TargetWindow.Buttons[i]) then
			DestroyWindow(TargetWindow.Buttons[i])
		end
	end
	TargetWindow.Buttons  = {}
	if( TargetWindow.HasTarget == true ) then
		WindowSetShowing("TargetWindow",false)
		if(TargetWindow.TargetType == TargetWindow.MobileType) then
			if WindowData.PlayerStatus.PlayerId ~= TargetWindow.TargetId and not MobileHealthBar.HasWindow(TargetWindow.TargetId) then
--				Debug.Print("TargetWindow.ClearPreviousTarget")
				UnregisterWindowData(WindowData.MobileName.Type,TargetWindow.TargetId)
				UnregisterWindowData(WindowData.MobileStatus.Type,TargetWindow.TargetId)
				UnregisterWindowData(WindowData.HealthBarColor.Type,TargetWindow.TargetId)
			end
			TargetWindow.RegisterTime[TargetWindow.TargetId] = nil
			local max = table.getn(TargetWindow.PreviousTargets)
			if (TargetWindow.PreviousTargets[max] ~= TargetWindow.TargetId) then
				table.insert(TargetWindow.PreviousTargets,TargetWindow.TargetId) 
			end
		elseif(TargetWindow.TargetType == TargetWindow.ObjectType or
		       TargetWindow.TargetType == TargetWindow.CorpseType) then
			UnregisterWindowData(WindowData.ObjectInfo.Type,TargetWindow.TargetId)				
		end
		LabelSetText("TargetWindowName", L"")
		StatusBarSetCurrentValue( "TargetWindowHealthBar", 0 )
		TargetWindow.TargetType = 0
	end
	MobileHealthBar.HandleBackGround()
end	

function TargetWindow.UnregisterPreviousTargetData()
	--If previous target was a mobile unregister data with the previous target
	if( TargetWindow.HasTarget == true) then
		if(TargetWindow.TargetType == TargetWindow.MobileType) then
			if WindowData.PlayerStatus.PlayerId ~= TargetWindow.TargetId and not MobileHealthBar.HasWindow(TargetWindow.TargetId) then
--				Debug.Print("TargetWindow.UnregisterPreviousTargetData")
				UnregisterWindowData(WindowData.MobileName.Type,TargetWindow.TargetId)
				UnregisterWindowData(WindowData.MobileStatus.Type,TargetWindow.TargetId)	
				UnregisterWindowData(WindowData.HealthBarColor.Type,TargetWindow.TargetId)
			end
			TargetWindow.RegisterTime[TargetWindow.TargetId] = nil
		elseif(TargetWindow.TargetType == TargetWindow.ObjectType or
			   TargetWindow.TargetType == TargetWindow.CorpseType) then
			UnregisterWindowData(WindowData.ObjectInfo.Type,TargetWindow.TargetId)	
		end
	end
end

function TargetWindow.UpdateMobile()
	if( TargetWindow.HasTarget == false or
	(TargetWindow.HasTarget == true and WindowData.CurrentTarget.TargetId ~= TargetWindow.TargetId) ) then
		TargetWindow.UnregisterPreviousTargetData()
				
		--Update the local targetType as a mobile type
		TargetWindow.TargetType = TargetWindow.MobileType
		WindowSetShowing("TargetWindow",true)

--		Debug.Print("TargetWindow.UpdateMobile")
		RegisterWindowData(WindowData.MobileName.Type, WindowData.CurrentTarget.TargetId)
		RegisterWindowData(WindowData.MobileStatus.Type,WindowData.CurrentTarget.TargetId)
		RegisterWindowData(WindowData.HealthBarColor.Type,WindowData.CurrentTarget.TargetId)
		TargetWindow.UpdateStatus(WindowData.CurrentTarget.TargetId)	
		TargetWindow.UpdateName(WindowData.CurrentTarget.TargetId)	
		TargetWindow.TargetId = WindowData.CurrentTarget.TargetId
		TargetWindow.TintHealthBar(WindowData.CurrentTarget.TargetId)
		TargetWindow.RegisterTime[WindowData.CurrentTarget.TargetId] = Interface.TimeSinceLogin
		
		local name = CreaturesDB.GetName(WindowData.CurrentTarget.TargetId)
		TargetWindow.CurrentCreature = CreaturesDB[name]
		TargetWindow.UpdateButtons()
	end
	local max = table.getn(TargetWindow.PreviousTargets)
	if (TargetWindow.PreviousTargets[max] ~= TargetWindow.TargetId) then
		table.insert(TargetWindow.PreviousTargets,TargetWindow.TargetId) 
	end
end

function TargetWindow.ForceUpdate(timePassed)

	if TargetWindow.TargetId ~= 0 and WindowGetShowing("TargetWindow") then
		TargetWindow.Delta = TargetWindow.Delta + timePassed
		TargetWindow.DeltaC = TargetWindow.DeltaC + timePassed
		if TargetWindow.DeltaC > 1 then
			TargetWindow.DeltaC = 0
			if #TargetWindow.Buttons <= 0 then
				TargetWindow.UpdateButtons()
			else
				TargetWindow.RefreshButtons()
			end
		end
		if TargetWindow.Delta > 0.2 then
			local itemData = WindowData.ObjectInfo[TargetWindow.TargetId]
			if not itemData and not IsMobile(TargetWindow.TargetId) then
				UnregisterWindowData(WindowData.ObjectInfo.Type,TargetWindow.TargetId)
				RegisterWindowData(WindowData.ObjectInfo.Type,TargetWindow.TargetId)
			end
			Interface.GetMobileData(TargetWindow.TargetId, true)
			TargetWindow.Delta = 0
		end
	end
	

	if not (DoesPlayerHaveItem(TargetWindow.TargetId) or TargetWindow.TargetId == WindowData.PlayerStatus.PlayerId) then
		WindowSetFontAlpha("TargetWindowDistance", 0.7)
		LabelSetText("TargetWindowDistance", ReplaceTokens(GetStringFromTid(1154905), {towstring(GetDistanceFromPlayer(TargetWindow.TargetId))}))
	else
		WindowSetFontAlpha("TargetWindowDistance", 0)
	end
end


function TargetWindow.RefreshButtons()
	for i = 1, #TargetWindow.Buttons do
		local slot = TargetWindow.Buttons[i]
		local id = WindowGetId(slot)

		if (id == 110 or id == 111 or id == 120) then
			if GetDistanceFromPlayer(WindowData.CurrentTarget.TargetId) > 8 then
				ButtonSetDisabledFlag(slot, true)
				WindowSetShowing(slot.. "Disabled", true)
			else
				ButtonSetDisabledFlag(slot, false)
				WindowSetShowing(slot.. "Disabled", false)
			end
		end
		
		if id == 301 then
			if GetDistanceFromPlayer(TargetWindow.TargetId) > 3 then
				ButtonSetDisabledFlag(slot, true)
				WindowSetShowing(slot.. "Disabled", true)
			else
				ButtonSetDisabledFlag(slot, false)
				WindowSetShowing(slot.. "Disabled", false)
				if TargetWindow.CurrentCreature and TargetWindow.CurrentCreature.tamable then
					local serverId = WindowData.SkillsCSV[4].ServerId
					local skillLevel = WindowData.SkillDynamicData[serverId].TempSkillValue / 10
					if skillLevel < TargetWindow.CurrentCreature.tamable then
						ButtonSetDisabledFlag(slot, true)
						WindowSetShowing(slot.. "Disabled", true)
					end
				end
			end
		end
	end
end

function TargetWindow.GetActionsList(mobileId)
	local items = {}
	if IsBanker(mobileId) then
		--Debug.Print("Banker")
		local it = {returnCode=ContextMenu.DefaultValues.OpenBankbox}
		table.insert(items, it)
	end
	--if IsVendor(mobileId) then
	--	Debug.Print("Vendor")
	--	local it = {returnCode=ContextMenu.DefaultValues.VendorBuy}
	---	table.insert(items, it)
	--	local it = {returnCode=ContextMenu.DefaultValues.VendorSell}
	--	table.insert(items, it)
	--end
	if IsBodDealer(mobileId) then
		--Debug.Print("BOD")
		local it = {returnCode=ContextMenu.DefaultValues.BodRequest}
		table.insert(items, it)
		local it = {returnCode=ContextMenu.DefaultValues.Bribe}
		table.insert(items, it)
	end
	if IsPartyMember(mobileId) then
		--Debug.Print("Party")
		local it = {returnCode=ContextMenu.DefaultValues.RemovePartyMember}
		table.insert(items, it)
	elseif IsPlayer(mobileId)  then
		--Debug.Print("Known")
		local it = {returnCode=ContextMenu.DefaultValues.AddPartyMember}
		table.insert(items, it)
	end
	if MobilesOnScreen.IsPet(mobileId) then
		--Debug.Print("Pet")
		local it = {returnCode=ContextMenu.DefaultValues.PetGuard}
		table.insert(items, it)
		local it = {returnCode=ContextMenu.DefaultValues.PetFollow}
		table.insert(items, it)
		local it = {returnCode=ContextMenu.DefaultValues.PetKill}
		table.insert(items, it)
		local it = {returnCode=ContextMenu.DefaultValues.PetStay}
		table.insert(items, it)
		local it = {returnCode=ContextMenu.DefaultValues.PetStop}
		table.insert(items, it)
	elseif TargetWindow.KnownTamable[mobileId] ~= nil and TargetWindow.KnownTamable[mobileId] == true then
		--Debug.Print("KnownTame")
		local it = {returnCode=ContextMenu.DefaultValues.Tame}
		table.insert(items, it)
	elseif TargetWindow.KnownTamable[mobileId] == nil and IsTamable(mobileId) then
		--Debug.Print("IsTamable")
		local it = {returnCode=ContextMenu.DefaultValues.Tame}
		table.insert(items, it)
	end
	return items
end

function TargetWindow.UpdateButtons()
	
	if not WindowData.CurrentTarget or not WindowData.CurrentTarget.TargetId or WindowData.CurrentTarget.TargetId == 0 or not WindowGetShowing("TargetWindow") or not IsMobile(WindowData.CurrentTarget.TargetId) then
		return
	end
	
	for i = 1, #TargetWindow.Buttons do
		if DoesWindowNameExist(TargetWindow.Buttons[i]) then
			DestroyWindow(TargetWindow.Buttons[i])
		end
	end
	TargetWindow.Buttons  = {}

	local menuItems = TargetWindow.GetActionsList(WindowData.CurrentTarget.TargetId)
	local dock = "TargetWindow"

	

	for i = 1, #menuItems do
		local iconId =10000000 +  menuItems[i].returnCode
		local name, x, y = GetIconData(iconId)
		if not name or name == "" then
			continue
		end
		
		local newWidth, newHeight = UOGetTextureSize("icon"..iconId)
		local scale = 0.9

		local slot = "TargetWindow" .. iconId .. "Button"
		CreateWindowFromTemplate(slot, "TargetWindowBigButtonTemplate", "Root")
		if #TargetWindow.Buttons <= 0 then
			WindowAddAnchor(slot, "bottomleft", dock, "topleft", 35, 0)
		else
			WindowAddAnchor(slot, "topright", TargetWindow.Buttons[#TargetWindow.Buttons], "topleft", 5, 0)
		end
		table.insert(TargetWindow.Buttons, slot)
		ButtonSetDisabledFlag(slot, false)
		WindowSetShowing(slot.. "Disabled", false)
		
		DynamicImageSetTextureDimensions(slot .. "Icon", newWidth*scale, newHeight*scale)
		WindowSetDimensions(slot.. "Icon", newWidth*scale, newHeight*scale)
		DynamicImageSetTexture(slot .. "Icon", name, x, y )
		DynamicImageSetTextureScale(slot .. "Icon", scale)
		WindowSetId(slot, menuItems[i].returnCode)
		local tscale = WindowGetScale("TargetWindow")
		WindowSetScale(slot, tscale - (tscale / 4))
	end
	TargetWindow.RefreshButtons()
end

function TargetWindow.UpdateObject()
	for i = 1, #TargetWindow.Buttons do
		if DoesWindowNameExist(TargetWindow.Buttons[i]) then
			DestroyWindow(TargetWindow.Buttons[i])
		end
	end
	TargetWindow.Buttons  = {}
	if( (TargetWindow.HasTarget == false) or
		(TargetWindow.HasTarget == true and WindowData.CurrentTarget.TargetId ~= TargetWindow.TargetId) ) then
		TargetWindow.UnregisterPreviousTargetData()
		
		--Update the local targetType to Object type
		TargetWindow.TargetType = TargetWindow.ObjectType
		WindowSetShowing("TargetWindow",true)
		TargetWindow.TargetId = WindowData.CurrentTarget.TargetId
		
		RegisterWindowData(WindowData.ObjectInfo.Type,WindowData.CurrentTarget.TargetId)
		
		StatusBarSetCurrentValue( "TargetWindowHealthBar", 0 )
		itemData = WindowData.ObjectInfo[WindowData.CurrentTarget.TargetId]
		if itemData then
			LabelSetText("TargetWindowName", itemData.name)

			NameColor.UpdateLabelNameColor("TargetWindowName", NameColor.Notoriety.NONE)
		end
	end
end

--Corpse will show the portrait of the mobile, but use the item properites for the name
function TargetWindow.UpdateCorpse()
	for i = 1, #TargetWindow.Buttons do
		if DoesWindowNameExist(TargetWindow.Buttons[i]) then
			DestroyWindow(TargetWindow.Buttons[i])
		end
	end
	TargetWindow.Buttons  = {}
	if( (TargetWindow.HasTarget == false) or
		(TargetWindow.HasTarget == true and WindowData.CurrentTarget.TargetId ~= TargetWindow.TargetId) ) then
		TargetWindow.UnregisterPreviousTargetData()
		
		--Update the local targetType to Object type
		TargetWindow.TargetType = TargetWindow.CorpseType
		WindowSetShowing("TargetWindow",true)
		TargetWindow.TargetId = WindowData.CurrentTarget.TargetId
		
		RegisterWindowData(WindowData.ObjectInfo.Type,WindowData.CurrentTarget.TargetId)
		itemData = WindowData.ObjectInfo[WindowData.CurrentTarget.TargetId]
		
		StatusBarSetCurrentValue( "TargetWindowHealthBar", 0 )
		LabelSetText("TargetWindowName", itemData.name)
		
		NameColor.UpdateLabelNameColor("TargetWindowName", NameColor.Notoriety.NONE)
	end
end

function TargetWindow.UpdateTarget()
	--Check to see if the target is a mobile or object first, if it is a mobile then show the portrait of the mobile
	--otherwise show the object texture
	if(WindowData.CurrentTarget.TargetType == TargetWindow.MobileType) then
		TargetWindow.UpdateMobile()
	else
		if(WindowData.CurrentTarget.TargetType == TargetWindow.ObjectType) then
			TargetWindow.UpdateObject()
		else
			if(WindowData.CurrentTarget.TargetType == TargetWindow.CorpseType) then
				TargetWindow.UpdateCorpse()
			else
				TargetWindow.ClearPreviousTarget()
			end
		end
	end 
	-- End of registering for the mobileType

	TargetWindow.HasTarget = WindowData.CurrentTarget.HasTarget	
	MobileHealthBar.HandleBackGround(WindowData.CurrentTarget.TargetId)
end

function TargetWindow.MobileStatusUpdate()
    TargetWindow.UpdateStatus(WindowData.UpdateInstanceId)
end

function TargetWindow.UpdateStatus(targetId)	
	if( targetId == WindowData.CurrentTarget.TargetId ) then
		local mobileData = Interface.GetMobileData(targetId, true)
		if not mobileData then
			return
		end
		StatusBarSetCurrentValue( "TargetWindowHealthBar", mobileData.CurrentHealth )	
		StatusBarSetMaximumValue( "TargetWindowHealthBar", mobileData.MaxHealth )			
		if( mobileData.IsDead ) then
		    LabelSetText("TargetWindowHits", StringToWString("Health: 0%"))
		else
			HotbarSystem.CurrentTargLife = 100
			if(TargetWindow.TargetType == TargetWindow.MobileType and IsHealthBarEnabled(targetId) and IsMobile(targetId)) then
				
				local data = WindowData.MobileName[targetId]
				if not data then
					UnregisterWindowData(WindowData.MobileName.Type, targetId)
					RegisterWindowData(WindowData.MobileName.Type, targetId)
				end
				if ( data ~= nil ) then
					if (data.Notoriety+1 < 8) then
						local curr = mobileData.CurrentHealth 
						local max = mobileData.MaxHealth 
						local perc = (curr/max)*100
						if (tostring(perc) == "-1.#IND") then
							perc = 0
							if Interface.TimeSinceLogin >= TargetWindow.RegisterTime[WindowData.CurrentTarget.TargetId] + 0.2 then								
								UnregisterWindowData(WindowData.MobileStatus.Type, WindowData.CurrentTarget.TargetId)
								TargetWindow.RegisterTime[WindowData.CurrentTarget.TargetId] = Interface.TimeSinceLogin
								return
							end
						end
						HotbarSystem.CurrentTargLife = perc
						perc = math.floor(perc)
						local gb = math.floor(2.55 * perc)
						LabelSetTextColor("TargetWindowHits", 255, gb, gb)
						LabelSetText("TargetWindowHits", StringToWString("Health: " .. tostring(perc) .. "%"))
					else
						LabelSetText("TargetWindowHits", L">>" .. wstring.upper(GetStringFromTid(3000509)) .. L"<<")
						
						LabelSetTextColor("TargetWindowHits", 255, 255, 0)
					end	
				end
			end
		end
	end
end

function TargetWindow.HandleUpdateNameEvent()
    TargetWindow.UpdateName(WindowData.UpdateInstanceId)
end

function TargetWindow.UpdateName(targetId)	
	if(targetId ~= nil and targetId == WindowData.CurrentTarget.TargetId ) then
		LabelSetText("TargetWindowName", WindowData.MobileName[WindowData.CurrentTarget.TargetId].MobName)
		
		local noto = WindowData.MobileName[WindowData.CurrentTarget.TargetId].Notoriety+1
		if (targetId == Interface.CurrentHonor) then
			noto = {r=163, g=73, b=164}
			LabelSetTextColor("TargetWindowName", noto.r, noto.g, noto.b)
		else
			NameColor.UpdateLabelNameColor("TargetWindowName", WindowData.MobileName[WindowData.CurrentTarget.TargetId].Notoriety+1)
		end
	end
end

function TargetWindow.HandleTintHealthBarEvent()
    TargetWindow.TintHealthBar(WindowData.UpdateInstanceId)
end

function TargetWindow.TintHealthBar(mobileId)
	if( mobileId == WindowData.CurrentTarget.TargetId ) then
		local windowTintName = "TargetWindowHealthBar"
		--Colors the health bar to the correct color
		HealthBarColor.UpdateHealthBarColor(windowTintName, WindowData.HealthBarColor[mobileId].VisualStateId)
	end
end

function TargetWindow.UpdateObjectInfo()
	if( WindowData.UpdateInstanceId == WindowData.CurrentTarget.TargetId ) then
		itemData = WindowData.ObjectInfo[WindowData.CurrentTarget.TargetId]
		LabelSetText("TargetWindowName", itemData.name)
	end	
end

--When players double clice on the target window, send a request object use packet
function TargetWindow.OnItemDblClicked()
	if IsMobile(TargetWindow.TargetId) then
		local mobileId = TargetWindow.TargetId
		if  IsBanker( mobileId ) then
			ContextMenu.RequestContextAction(mobileId, ContextMenu.DefaultValues.OpenBankbox)
		elseif IsVendor( mobileId ) then
			ContextMenu.RequestContextAction(mobileId, ContextMenu.DefaultValues.VendorBuy)
		elseif IsOldQuestGiver( mobileId ) then
			ContextMenu.RequestContextAction(mobileId, ContextMenu.DefaultValues.NPCTalk)
		else
			UserActionUseItem(mobileId,false)
		end
	else
		UserActionUseItem(TargetWindow.TargetId,false)
	end
end

function TargetWindow.OnRClick()
	RequestContextMenu(TargetWindow.TargetId)
end

function TargetWindow.OnLClick()
	if( SystemData.DragItem.DragType == SystemData.DragItem.TYPE_ITEM ) then
	    DragSlotDropObjectToObject(WindowData.CurrentTarget.TargetId)
	else
		--Let the targeting manager handle single left click on the target
		HandleSingleLeftClkTarget(WindowData.CurrentTarget.TargetId)
	end
end

function TargetWindow.OnMouseOver()
	local itemData =
	{
		windowName = "TargetWindow",
		itemId = WindowData.CurrentTarget.TargetId,
		itemType = WindowData.ItemProperties.TYPE_ITEM,
	}					
	ItemProperties.SetActiveItem(itemData)	
end

function TargetWindow.OnMouseOverEnd()
	ItemProperties.ClearMouseOverItem()
end

function TargetWindow.ButtonsUse()
	local wind = string.gsub(SystemData.ActiveWindow.name, "Label", "")
	wind = string.gsub(wind, "Icon", "")
	if ButtonGetDisabledFlag(wind) then
		return
	end

	ContextMenu.RequestContextAction(TargetWindow.TargetId, WindowGetId(wind))
end

function TargetWindow.OnMoveStart()
	if ( not TargetWindow.Locked ) then
		WindowSetMoving("TargetWindow", true)
		SnapUtils.StartWindowSnap("TargetWindow")
	end
end

function TargetWindow.Lock()
	TargetWindow.Locked = not TargetWindow.Locked 
	Interface.SaveBoolean( "TargetWindowLocked", TargetWindow.Locked  )
	
	local this = "TargetWindow"
	local texture = "UO_Core"
	if ( TargetWindow.Locked  ) then		
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

function TargetWindow.LockTooltip()
	if ( TargetWindow.Locked ) then
		Tooltips.CreateTextOnlyTooltip(SystemData.ActiveWindow.name,GetStringFromTid(1154903))
	else
		Tooltips.CreateTextOnlyTooltip(SystemData.ActiveWindow.name, GetStringFromTid(1154904))
	end
	
	Tooltips.Finalize()
	Tooltips.AnchorTooltip( Tooltips.ANCHOR_WINDOW_TOP )
end