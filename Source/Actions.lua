
Actions = {}

Actions.WarMode = 0

function Actions.ToggleMainMenu()	
	WindowSetShowing("MainMenuWindow", not WindowGetShowing("MainMenuWindow"))
end

function Actions.ToggleWarMode()
	UserActionToggleWarMode()
    
    if HighlightEffect and HighlightEffect.Buttons and HighlightEffect.Buttons.war ~= "" and WindowData.HighlightEffect.windowToHighlight == HighlightEffect.Buttons.war then
		Interface.NewPlayerWarToggled =	true
		Interface.SaveBoolean( "NewPlayerWarToggled", true ) 
	end
end

function Actions.ToggleInventoryWindow()
	local objectId = WindowData.PlayerEquipmentSlot[EquipmentData.EQPOS_BACKPACK].objectId
	
	if( SystemData.DragItem.DragType == SystemData.DragItem.TYPE_ITEM ) then
	    DragSlotDropObjectToObject(WindowData.PlayerStatus.PlayerId)
	else
		local windowName = "ContainerWindow_"..objectId
		local showing = false
		
		if( DoesWindowNameExist(windowName) ) then
		    showing = WindowGetShowing(windowName)
		end
		
		if (showing == true) then
			DestroyWindow(windowName)
			Interface.BackpackOpen = false
			Interface.SaveBoolean( "BackpackOpen", Interface.BackpackOpen )
		else
			UserActionUseItem(objectId,false)
		end
	end
	
	if HighlightEffect and HighlightEffect.Buttons and HighlightEffect.Buttons.inventory ~= "" and WindowData.HighlightEffect.windowToHighlight == HighlightEffect.Buttons.inventory then
		Interface.NewPlayerInventoryToggled = true
		Interface.SaveBoolean( "NewPlayerInventoryToggled", true ) 
	end
end

function Actions.ToggleMapWindow()
	if (SystemData.Settings.Interface.mapMode ~= MapCommon.MAP_ATLAS)then
		MapWindow.ActivateMap()		
	else
		MapWindow.CloseMap()
	end
		
	if HighlightEffect and HighlightEffect.Buttons and HighlightEffect.Buttons.map ~= "" and WindowData.HighlightEffect.windowToHighlight == HighlightEffect.Buttons.map then
		Interface.NewPlayerMapToggled = true
		Interface.SaveBoolean( "NewPlayerMapToggled", true ) 
	end
end

function Actions.ToggleGuildWindow()
	local gumpID = nil
	local type = nil
    for k, v in pairs(GumpsParsing.ParsedGumps) do
		if v == "GuildMenu" or v == "GuildMenuMyGuild" or v == "GuildMenuDiplomacy" or v == "GuildMenuRoster"  or v == "GuildMenuAdvSearch" or v == "GuildMenuPlayerDetails" or v == "GuildMenuRelationship"  or v == "GuildMenuWar" then
			gumpID = k
			type = v
			break
		end
    end
   
    if not gumpID then
		BroadcastEvent( SystemData.Events.REQUEST_OPEN_GUILD_WINDOW )
	else
		if type == "GuildMenuCreate" then
			GumpsParsing.PressButton(gumpID, 2)
		else
			GenericGumpOnRClicked(WindowGetId(GumpData.Gumps[gumpID].windowName)) 
		end
	end
end

function Actions.ToggleChatWindow()
	if( not DoesWindowExist("ChannelWindow") ) then
		CreateWindow("ChannelWindow", true)
	else
		DestroyWindow("ChannelWindow")
	end
	if( not DoesWindowExist("GChatRoster") ) then
		CreateWindow("GChatRoster", true)
	else
		DestroyWindow("GChatRoster")
	end
end

function Actions.ToggleSkillsWindow()
	SkillsWindow.ToggleSkillsWindow()

	-- if window is active, hilite button on menu bar
	local WindowName = "SkillsWindow"
	showing = WindowGetShowing(WindowName)
end

function Actions.ToggleVirtuesWindow()
    local gumpID = nil
    for k, v in pairs(GumpsParsing.ParsedGumps) do
		if v == "Virtues" then
			gumpID = k
		end
    end

    if not gumpID then
		BroadcastEvent( SystemData.Events.REQUEST_OPEN_VIRTUES_LIST )
	else
		GumpsParsing.PressButton(gumpID, 2)
	end
end

function Actions.ToggleQuestWindow()
    local gumpID = nil
    for k, v in pairs(GumpsParsing.ParsedGumps) do
		if v == "QuestLog" then
			gumpID = k
		end
    end
   
    if not gumpID then
		BroadcastEvent( SystemData.Events.REQUEST_OPEN_QUEST_LOG )
	else
		GumpsParsing.PressButton(gumpID, 1)
	end
end

function Actions.ToggleHelpWindow()
    local gumpID = nil
    for k, v in pairs(GumpsParsing.ParsedGumps) do
		if v == "HelpMenu" then
			gumpID = k
		end
    end
   
    if not gumpID then
		BroadcastEvent( SystemData.Events.REQUEST_OPEN_HELP_MENU )
	else
		GenericGumpOnRClicked(WindowGetId(GumpData.Gumps[gumpID].windowName)) 
	end
end

function Actions.ToggleUOStoreWindow()
    BroadcastEvent( SystemData.Events.UO_STORE_REQUEST)
end

function Actions.TogglePaperdollWindow()
	playerId = WindowData.PlayerStatus.PlayerId
	local windowName = "PaperdollWindow"..playerId

	if(DoesWindowNameExist(windowName)) then
		DestroyWindow(windowName)
		Interface.PaperdollOpen = false
		Interface.SaveBoolean( "PaperdollOpen",Interface.PaperdollOpen )
	else
		UserActionUseItem(playerId,true)	    
	    Interface.PaperdollOpen = true
		Interface.SaveBoolean( "PaperdollOpen",Interface.PaperdollOpen )
	end
	if HighlightEffect and HighlightEffect.Buttons and HighlightEffect.Buttons.paperdoll ~= "" and WindowData.HighlightEffect.windowToHighlight == HighlightEffect.Buttons.paperdoll then
		Interface.NewPlayerPaperdollToggled = true
		Interface.SaveBoolean( "NewPlayerPaperdollToggled", true ) 
	end	
end

function Actions.ToggleFoliage() 
	SystemData.Settings.Resolution.displayFoliage = not SystemData.Settings.Resolution.displayFoliage
	ButtonSetPressedFlag( "SettingsGraphicsShowFoliageButton", SystemData.Settings.Resolution.displayFoliage )
	UserSettingsChanged()
end

function Actions.ToggleSound() 
	SystemData.Settings.Sound.master.enabled = not SystemData.Settings.Sound.master.enabled
	ButtonSetPressedFlag( "MasterVolumeToggleButton", SystemData.Settings.Sound.master.enabled )
	UserSettingsChanged()
end

function Actions.ToggleSoundEffects() 
	SystemData.Settings.Sound.effects.enabled = not SystemData.Settings.Sound.effects.enabled
	ButtonSetPressedFlag( "EffectsVolumeToggleButton", SystemData.Settings.Sound.effects.enabled )
	UserSettingsChanged()
end

function Actions.ToggleMusic() 
	SystemData.Settings.Sound.music.enabled = not SystemData.Settings.Sound.music.enabled
	ButtonSetPressedFlag( "MusicVolumeToggleButton", SystemData.Settings.Sound.music.enabled )
	UserSettingsChanged()
end

function Actions.ToggleFootsteps() 
	SystemData.Settings.Sound.footsteps.enabled = not SystemData.Settings.Sound.footsteps.enabled
	ButtonSetPressedFlag( "PlayFootstepsToggleButton", SystemData.Settings.Sound.footsteps.enabled )
	UserSettingsChanged()
end

function Actions.ToggleCharacterSheet(noloyalty)
	ToggleWindowByName("CharacterSheet", "", nil)
end

function Actions.ToggleCharacterAbilities()	
	ToggleWindowByName("CharacterAbilities", "", nil)
end

function Actions.IgnorePlayer()
	RequestTargetInfo() 
	WindowRegisterEventHandler("Root", SystemData.Events.TARGET_SEND_ID_CLIENT, "Actions.Ignore")
end

function Actions.Ignore()
	local Id = SystemData.RequestInfo.ObjectId
	WindowUnregisterEventHandler("Root", SystemData.Events.TARGET_SEND_ID_CLIENT)
	if(IsMobile(Id)) then
		AddPlayerToIgnoreList(Id,WindowData.MobileName[Id].MobName, SettingsWindow.IGNORE_LIST_ALL)
		ToggleWindowByName( "SettingsWindow", "", nil )
		WindowUtils.SendOverheadText(ReplaceTokens(GetStringFromTid(1155098), {WindowData.MobileName[Id].MobName}), 33, true)
	else
		WindowUtils.SendOverheadText(GetStringFromTid(1154926), 33, true)
	end
end

function Actions.ToggleUserSettings()	
	Interface.ReloadSettings()
	ToggleWindowByName( "SettingsWindow", "", nil )
end

function Actions.ToggleActions()
	ToggleWindowByName( "ActionsWindow", "",nil )
end

function Actions.ToggleMacros()	
	ToggleWindowByName( "MacroWindow", "", nil )
end

function Actions.PrevTarget()
	local max = table.getn(TargetWindow.PreviousTargets)
	if (TargetWindow.TargetId) then
		table.remove(TargetWindow.PreviousTargets, max)
	end
	local previous = Actions.SearchValidPrevTarget()
	if (previous and previous.id ~= TargetWindow.TargetId) then
		HandleSingleLeftClkTarget(previous.id)
	end

end

function Actions.SearchValidPrevTarget()
	local max = table.getn(TargetWindow.PreviousTargets)
	for i = max, 1, -1 do
		if (TargetWindow.PreviousTargets[i] ~= TargetWindow.TargetId and IsMobile(TargetWindow.PreviousTargets[i])) then
			return {id=TargetWindow.PreviousTargets[i], idx=i}
		end
	end
	
end

Actions.nxt = 1
function Actions.NextTarget()
	local final = 0
	for i = Actions.nxt, table.getn(MobilesOnScreen.MobilesSort) do
		if (Actions.TargetAllowed(MobilesOnScreen.MobilesSort[i]) and MobilesOnScreen.MobilesSort[i] ~= TargetWindow.TargetId ) then
			
			HandleSingleLeftClkTarget(MobilesOnScreen.MobilesSort[i])
			if (WindowGetShowing("TargetWindow") and TargetWindow.TargetId == MobilesOnScreen.MobilesSort[i]) then
				final = MobilesOnScreen.MobilesSort[i]
				Actions.nxt = i+1
				if (Actions.nxt > table.getn(MobilesOnScreen.MobilesSort)) then
					Actions.nxt = 1	
				end
				return
			end
		end
	end
	if final ~= 0 then
		TargetWindow.ClearPreviousTarget()
		HandleSingleLeftClkTarget(final)
	end
	Actions.nxt = 1	
end

function Actions.TargetAllowed(mobileId)
	if (mobileId == WindowData.PlayerStatus.PlayerId) then
		return false
	end
	local data = WindowData.MobileName[mobileId]
	if (not data) then
		RegisterWindowData(WindowData.MobileName.Type, mobileId)
		data = WindowData.MobileName[mobileId]
		if (not data) then
			UnregisterWindowData(WindowData.MobileName.Type, mobileId)
			return false
		end
	end
	if (MobilesOnScreen.STRFilter ~= "" ) then -- filter
		local found = false
		for cf in wstring.gmatch(MobilesOnScreen.STRFilter, L"[^|]+") do
			if (wstring.find(wstring.lower(data.MobName), wstring.lower(cf))) then
				found = true
			end
		end
		if (not found ) then
			return false
		end
	end
	local passa = true
	if (not MobilesOnScreen.SavedFilter[9] and MobilesOnScreen.IsFarm(data.MobName))  or wstring.find(data.MobName, L"A Mannequin") then
			passa = false
	end
	if (not MobilesOnScreen.SavedFilter[10] and MobilesOnScreen.IsSummon(data.MobName, mobileId)) then
				passa = false
	end
	if (not MobilesOnScreen.IsPet(mobileId) and MobilesOnScreen.GetVisible()  and IsMobile(mobileId) and passa) then
		if (MobileHealthBar.windowDisabled[mobileId] and MobileHealthBar.windowDisabled[mobileId]== true) then
			UnregisterWindowData(WindowData.MobileName.Type, mobileId)
			return false			
		end
		local noto = data.Notoriety+1
		if (not MobilesOnScreen.SavedFilter[noto]) then
			return false
		end
	end
	if not Actions.IsMobileVisible(mobileId) then
		return false
	end
	return passa
end

function Actions.IsMobileVisible(mobileId)
	local isVisible = GetDistanceFromPlayer(mobileId) < 22
	return isVisible
end

function Actions.NearTarget()

	if (MobilesOnScreen.DistanceSort) then
		TargetWindow.ClearPreviousTarget()
		HandleSingleLeftClkTarget(MobilesOnScreen.DistanceSort[1])	
	else
		local minDist = -1000
		local id = {}
		for i = 1, table.getn(MobilesOnScreen.MobilesSort) do
			if (MobilesOnScreen.IsPet(MobilesOnScreen.MobilesSort[i])) then
				continue
			end
			local allow = Actions.TargetAllowed(MobilesOnScreen.MobilesSort[i])
			if (allow) then
				local dist = GetDistanceFromPlayer(MobilesOnScreen.MobilesSort[i])
				id[dist] = MobilesOnScreen.MobilesSort[i]
			end
		end
		for i, value in pairsByKeys(id) do
			if (TargetWindow.TargetId == id[i]) then
				return
			end
			if (Actions.TargetAllowed(id[i])) then
				HandleSingleLeftClkTarget(id[i])
				if (WindowGetShowing("TargetWindow") and TargetWindow.TargetId == id[i]) then
					return
				end
			end
		end
	end
end

function Actions.InjuredFollower()
	local lowerId = 0
	local lowerHP = -1
	for i, mobileId in pairs(PetWindow.SortedPet) do
		local mobileData = Interface.GetMobileData(mobileId, true)
		if (mobileData and IsHealthBarEnabled(mobileId) and Actions.IsMobileVisible(mobileId)) then
			local curHealth = mobileData.CurrentHealth
			
			if (curHealth < 25) then
				
				if curHealth < lowerHP or lowerHP == -1 then
					lowerHP = curHealth
					lowerId = mobileId
				end
			end
		end
	end
	
	if (lowerId ~= 0) then
		HandleSingleLeftClkTarget(lowerId)
	end
end

function Actions.InjuredParty()
	local lowerId = 0
	local lowerHP = -1

	for i = 1, HealthBarManager.MAX_PARTY_MEMBERS do
		
		if (WindowData.PartyMember[i] and WindowData.PartyMember[i].memberId ~= 0) then
			local mobileId = WindowData.PartyMember[i].memberId
			local mobileData = Interface.GetMobileData(mobileId, true)
			if (mobileId ~= WindowData.PlayerStatus.PlayerId) then
				local curHealth = mobileData.CurrentHealth
				local maxHealth = mobileData.MaxHealth
				
				local perc = math.floor((curHealth/maxHealth)*100)
				if (perc < 100) then
					if (perc < lowerHP or lowerHP == -1) then
						lowerHP = perc
						lowerId = mobileId
					end
				end
			end
		end
	end
	if (lowerId ~= 0) then
		HandleSingleLeftClkTarget(lowerId)
	end
end

function Actions.InjuredMobile()
	local id = {}
	for i = Actions.nxt, table.getn(MobilesOnScreen.MobilesSort) do
		local mobileId = MobilesOnScreen.MobilesSort[i]
		if (Actions.TargetAllowed(mobileId) and not IsPartyMember(mobileId)) then
			local mobileData = Interface.GetMobileData(mobileId, true)
			if mobileData then
				local curHealth = mobileData.CurrentHealth
				if curHealth < 25 then
					id[curHealth] = mobileId
				end
			end
		end
	end

	for i, value in pairsByKeys(id) do
		if (Actions.TargetAllowed(id[i]) ) then
			HandleSingleLeftClkTarget(id[i])
			return
		end
	end

end

function Actions.TargetFirstContainerObject()
	if not TargetWindow.TargetId then
		WindowUtils.SendOverheadText(GetStringFromTid(1154961), 33, true, false)
		return
	end
	local found = false
	for id, value in pairs(ContainerWindow.OpenContainers) do
		if id == TargetWindow.TargetId then
			found = true
		end
	end
	if not found then
		WindowUtils.SendOverheadText(GetStringFromTid(1154962), 33, true, false)
		return
	end
	
	if WindowData.ContainerWindow[TargetWindow.TargetId] and WindowData.ContainerWindow[TargetWindow.TargetId].numItems > 0 then
		HandleSingleLeftClkTarget(WindowData.ContainerWindow[TargetWindow.TargetId].ContainedItems[1].objectId)
	end
end

function Actions.TargetType()
	if (Actions.ActionEditRequest.SubIndex == 0) then
		WindowUtils.SendOverheadText(GetStringFromTid(1154963), 1152, true)
		local slotWindow = "Hotbar"..Actions.ActionEditRequest.HotbarId.."Button"..Actions.ActionEditRequest.ItemIndex
		HotbarSystem.ClearActionIcon(slotWindow, Actions.ActionEditRequest.HotbarId, Actions.ActionEditRequest.ItemIndex, Actions.ActionEditRequest.SubIndex, true)
		HotbarClearItem(Actions.ActionEditRequest.HotbarId,Actions.ActionEditRequest.ItemIndex)
	else
		RequestTargetInfo()
		WindowUtils.SendOverheadText(GetStringFromTid(1154964), 1152, true)
		WindowRegisterEventHandler("Root", SystemData.Events.TARGET_SEND_ID_CLIENT, "Actions.TypeRequestTargetInfoReceived")
	end
end

function Actions.TypeRequestTargetInfoReceived()
	local objectId = SystemData.RequestInfo.ObjectId
	RegisterWindowData(WindowData.ObjectInfo.Type, objectId)
	local itemData = WindowData.ObjectInfo[objectId]

	if (not itemData ) then
		WindowUtils.ChatPrint(GetStringFromTid(1154965), SystemData.ChatLogFilters.SYSTEM )
		if (Actions.ActionEditRequest.SubIndex == 0) then
			local slotWindow = "Hotbar"..Actions.ActionEditRequest.HotbarId.."Button"..Actions.ActionEditRequest.ItemIndex
			HotbarSystem.ClearActionIcon(slotWindow, Actions.ActionEditRequest.HotbarId, Actions.ActionEditRequest.ItemIndex, Actions.ActionEditRequest.SubIndex, true)
			HotbarClearItem(Actions.ActionEditRequest.HotbarId,Actions.ActionEditRequest.ItemIndex)
		else
			UserActionMacroRemoveAction(Actions.ActionEditRequest.HotbarId, Actions.ActionEditRequest.ItemIndex, Actions.ActionEditRequest.SubIndex)
			MacroEditWindow.UpdateMacroActionList("ActionEditMacro", Actions.ActionEditRequest.HotbarId, Actions.ActionEditRequest.ItemIndex)
		end
	else
		local speechText = L"script Actions.TargetByType(" .. itemData.objectType .. L", " .. itemData.hueId .. L")"
		UserActionSpeechSetText(Actions.ActionEditRequest.HotbarId, Actions.ActionEditRequest.ItemIndex, Actions.ActionEditRequest.SubIndex, speechText)	
	end
	WindowUnregisterEventHandler("Root", SystemData.Events.TARGET_SEND_ID_CLIENT)
	Actions.ActionEditRequest = {}

end

function Actions.TargetByType(type, hue)
	Actions.ScanQuantities()
	for obj, value in pairs(Actions.itemQuantities) do
		if obj == type then
			for i = 1, #Actions.itemQuantities[obj] do
				local id  = Actions.itemQuantities[obj][i]
				RegisterWindowData(WindowData.ObjectInfo.Type, id)
				local item = WindowData.ObjectInfo[id]
				if item then
					if item.hueId == hue then
						HandleSingleLeftClkTarget(id)
						return
					end
				end
			end
			
		end
	end
end

function Actions.ScanQuantities()
	if not WindowData.PlayerEquipmentSlot[EquipmentData.EQPOS_BACKPACK] then
		return
	end
	Actions.itemQuantities = {} 
	Actions.AllItems = {} 
	local backpackId = WindowData.PlayerEquipmentSlot[EquipmentData.EQPOS_BACKPACK].objectId
	local removeOnComplete = false	
	if not WindowData.ContainerWindow[backpackId] then
		removeOnComplete = true		
		RegisterWindowData(WindowData.ContainerWindow.Type, backpackId)		
	end
	local numItems = WindowData.ContainerWindow[backpackId].numItems
	for i = 1, numItems do
		local item = WindowData.ContainerWindow[backpackId].ContainedItems[i]
		
		local sub = Actions.ScanSubCont(item.objectId)
		table.insert(Actions.AllItems,item.objectId )
		
		RegisterWindowData(WindowData.ObjectInfo.Type, item.objectId)
		local objectId = item.objectId
		item =  WindowData.ObjectInfo[objectId]
		if not Actions.itemQuantities[item.objectType] then
			Actions.itemQuantities[item.objectType] = { objectId}
		else
			table.insert(Actions.itemQuantities[item.objectType], objectId)
		end		
		UnregisterWindowData(WindowData.ObjectInfo.Type, objectId)
	end
	if(ContainerWindow.OpenContainers[backpackId] == nil and removeOnComplete)then
		UnregisterWindowData(WindowData.ContainerWindow.Type, backpackId)
	end
end

function Actions.ScanSubCont(id)
	local removeOnComplete = false
	if not WindowData.ContainerWindow[id] then
		RegisterWindowData(WindowData.ContainerWindow.Type, id)
		removeOnComplete = true		
	end		
	if not WindowData.ContainerWindow[id] then
		if(ContainerWindow.OpenContainers[id] == nil and removeOnComplete)then
			UnregisterWindowData(WindowData.ContainerWindow.Type, id)
		end		
		return false
	else
		local numItems = WindowData.ContainerWindow[id].numItems
		for i = 1, numItems do
			local item = WindowData.ContainerWindow[id].ContainedItems[i]
					
			local sub = Actions.ScanSubCont(item.objectId)
			table.insert(Actions.AllItems,item.objectId )
			
			RegisterWindowData(WindowData.ObjectInfo.Type, item.objectId)
			local objectId = item.objectId
			item =  WindowData.ObjectInfo[objectId]
			if not Actions.itemQuantities[item.objectType] then
				Actions.itemQuantities[item.objectType] = {objectId}
			else
				table.insert(Actions.itemQuantities[item.objectType], objectId)
			end
			UnregisterWindowData(WindowData.ObjectInfo.Type, objectId)
		end
		if(ContainerWindow.OpenContainers[id] == nil and removeOnComplete)then
			UnregisterWindowData(WindowData.ContainerWindow.Type, id)
		end	
		return true
	end
end

function Actions.TargetDefaultPet(id)
	RequestTargetInfo()
	WindowUtils.SendOverheadText(GetStringFromTid(1154969), 1152, true)
	Actions.DefaultRecordID = id
	WindowRegisterEventHandler("Root", SystemData.Events.TARGET_SEND_ID_CLIENT, "Actions.SetDefaultPet")
end

function Actions.SetDefaultPet()
	local objectId = SystemData.RequestInfo.ObjectId
	WindowUnregisterEventHandler("Root", SystemData.Events.TARGET_SEND_ID_CLIENT)
	
	if (not IsMobile(objectId) ) then
	
		WindowUtils.ChatPrint(GetStringFromTid(500330), SystemData.ChatLogFilters.SYSTEM )
	else
	
		if( MobilesOnScreen.IsPet(objectId)) then
			if (Actions.DefaultRecordID == 1) then	
				Interface.DefaultPet1 = objectId
				Interface.SaveNumber( "DefaultPet1" , Interface.DefaultPet1 )
			elseif (Actions.DefaultRecordID == 2) then	
				Interface.DefaultPet2 =objectId
				Interface.SaveNumber( "DefaultPet2" , Interface.DefaultPet2 )
			elseif (Actions.DefaultRecordID == 3) then	
				Interface.DefaultPet3 =objectId
				Interface.SaveNumber( "DefaultPet3" , Interface.DefaultPet3 )
			elseif (Actions.DefaultRecordID == 4) then	
				Interface.DefaultPet4 =objectId
				Interface.SaveNumber( "DefaultPet4" , Interface.DefaultPet4 )
			elseif (Actions.DefaultRecordID == 5) then	
				Interface.DefaultPet5 =objectId
				Interface.SaveNumber( "DefaultPet5" , Interface.DefaultPet5 )
			end
			WindowUtils.ChatPrint(ReplaceTokens(GetStringFromTid(1154971),{towstring(Actions.DefaultRecordID)} ), SystemData.ChatLogFilters.SYSTEM )
		else
			WindowUtils.ChatPrint(GetStringFromTid(1154970), SystemData.ChatLogFilters.SYSTEM )
	
		end
	end
	
	Actions.DefaultRecordID = 0
end

function Actions.TargetDefaultItem(id)
	RequestTargetInfo()
	WindowUtils.SendOverheadText(GetStringFromTid(1154972), 1152, true)
	Actions.DefaultRecordID = id
	WindowRegisterEventHandler("Root", SystemData.Events.TARGET_SEND_ID_CLIENT, "Actions.SetDefaultItem")
end

function Actions.SetDefaultItem()
	local objectId = SystemData.RequestInfo.ObjectId
	WindowUnregisterEventHandler("Root", SystemData.Events.TARGET_SEND_ID_CLIENT)
		
	if (Actions.DefaultRecordID == 1) then	
		Interface.DefaultObject1 =objectId
		Interface.SaveNumber( "DefaultObject1" , Interface.DefaultObject1 )
	elseif (Actions.DefaultRecordID == 2) then	
		Interface.DefaultObject2 =objectId
		Interface.SaveNumber( "DefaultObject2" , Interface.DefaultObject2 )
	elseif (Actions.DefaultRecordID == 3) then	
		Interface.DefaultObject3 =objectId
		Interface.SaveNumber( "DefaultObject3" , Interface.DefaultObject3 )
	elseif (Actions.DefaultRecordID == 4) then	
		Interface.DefaultObject4 =objectId
		Interface.SaveNumber( "DefaultObject4" , Interface.DefaultObject4 )
	elseif (Actions.DefaultRecordID == 5) then	
		Interface.DefaultObject5 =objectId
		Interface.SaveNumber( "DefaultObject5" , Interface.DefaultObject5 )
	end
	WindowUtils.ChatPrint(ReplaceTokens(GetStringFromTid(1154973),{towstring(Actions.DefaultRecordID)} ), SystemData.ChatLogFilters.SYSTEM )

	Actions.DefaultRecordID = 0
end

function Actions.TargetPetball()
	RequestTargetInfo()
	WindowUtils.SendOverheadText(GetStringFromTid(1155434), 1152, true)
	WindowRegisterEventHandler("Root", SystemData.Events.TARGET_SEND_ID_CLIENT, "Actions.PetballRequestTargetInfoReceived")
end

function Actions.PetballRequestTargetInfoReceived()
	local objectId = SystemData.RequestInfo.ObjectId
	local itemData = WindowData.ObjectInfo[objectId]

	if (not itemData or itemData.objectType ~= 3630 ) then
		WindowUtils.ChatPrint(GetStringFromTid(1154974), SystemData.ChatLogFilters.SYSTEM )
		if (Actions.ActionEditRequest.SubIndex == 0) then
			local slotWindow = "Hotbar"..Actions.ActionEditRequest.HotbarId.."Button"..Actions.ActionEditRequest.ItemIndex
			HotbarSystem.ClearActionIcon(slotWindow, Actions.ActionEditRequest.HotbarId, Actions.ActionEditRequest.ItemIndex, Actions.ActionEditRequest.SubIndex, true)
			HotbarClearItem(Actions.ActionEditRequest.HotbarId,Actions.ActionEditRequest.ItemIndex)
		else
			UserActionMacroRemoveAction(Actions.ActionEditRequest.HotbarId, Actions.ActionEditRequest.ItemIndex, Actions.ActionEditRequest.SubIndex)
			MacroEditWindow.UpdateMacroActionList("ActionEditMacro", Actions.ActionEditRequest.HotbarId, Actions.ActionEditRequest.ItemIndex)
		end
	else
		if( DoesPlayerHaveItem(objectId)) then
			local speechText = L"script HandleSingleLeftClkTarget(" .. objectId .. L")"
			UserActionSpeechSetText(Actions.ActionEditRequest.HotbarId, Actions.ActionEditRequest.ItemIndex, Actions.ActionEditRequest.SubIndex, speechText)
		else
			WindowUtils.ChatPrint(GetStringFromTid(1154975), SystemData.ChatLogFilters.SYSTEM )
			if (Actions.ActionEditRequest.SubIndex == 0) then
				local slotWindow = "Hotbar"..Actions.ActionEditRequest.HotbarId.."Button"..Actions.ActionEditRequest.ItemIndex
				HotbarSystem.ClearActionIcon(slotWindow, Actions.ActionEditRequest.HotbarId, Actions.ActionEditRequest.ItemIndex, Actions.ActionEditRequest.SubIndex, true)
				HotbarClearItem(Actions.ActionEditRequest.HotbarId,Actions.ActionEditRequest.ItemIndex)
			else
				UserActionMacroRemoveAction(Actions.ActionEditRequest.HotbarId, Actions.ActionEditRequest.ItemIndex, Actions.ActionEditRequest.SubIndex)
				MacroEditWindow.UpdateMacroActionList("ActionEditMacro", Actions.ActionEditRequest.HotbarId, Actions.ActionEditRequest.ItemIndex)
			end
		end
	end
	WindowUnregisterEventHandler("Root", SystemData.Events.TARGET_SEND_ID_CLIENT)
	Actions.ActionEditRequest = {}

end

function Actions.TargetMount()
	RequestTargetInfo()
	if (Actions.ActionEditRequest.ActionId >= 5800 and Actions.ActionEditRequest.ActionId < 5900) then
		WindowUtils.SendOverheadText(GetStringFromTid(1155119), 1152, true)
	elseif (Actions.ActionEditRequest.ActionId == 5156) then
		WindowUtils.SendOverheadText(GetStringFromTid(1154977), 1152, true)
	elseif (Actions.ActionEditRequest.ActionId == 5736) then
		WindowUtils.SendOverheadText(GetStringFromTid(1154978), 1152, true)
	elseif (Actions.ActionEditRequest.ActionId ~= 5156 and Actions.ActionEditRequest.ActionId ~= 5098) then
		WindowUtils.SendOverheadText(GetStringFromTid(1154976), 1152, true)
	end
	
	WindowRegisterEventHandler("Root", SystemData.Events.TARGET_SEND_ID_CLIENT, "Actions.MountRequestTargetInfoReceived")
end

function Actions.MountRequestTargetInfoReceived()
	local objectId = SystemData.RequestInfo.ObjectId
		
	if (not IsMobile(objectId) and Actions.ActionEditRequest.ActionId ~= 5156 and not (Actions.ActionEditRequest.ActionId >= 5800 and Actions.ActionEditRequest.ActionId < 5900)) then
		if (Actions.ActionEditRequest.ActionId ~= 5736) then
			WindowUtils.ChatPrint(GetStringFromTid(500330), SystemData.ChatLogFilters.SYSTEM )
		
			if (Actions.ActionEditRequest.SubIndex == 0) then
				local slotWindow = "Hotbar"..Actions.ActionEditRequest.HotbarId.."Button"..Actions.ActionEditRequest.ItemIndex
				HotbarSystem.ClearActionIcon(slotWindow, Actions.ActionEditRequest.HotbarId, Actions.ActionEditRequest.ItemIndex, Actions.ActionEditRequest.SubIndex, true)
				HotbarClearItem(Actions.ActionEditRequest.HotbarId,Actions.ActionEditRequest.ItemIndex)
			else
				UserActionMacroRemoveAction(Actions.ActionEditRequest.HotbarId, Actions.ActionEditRequest.ItemIndex, Actions.ActionEditRequest.SubIndex)
				MacroEditWindow.UpdateMacroActionList("ActionEditMacro", Actions.ActionEditRequest.HotbarId, Actions.ActionEditRequest.ItemIndex)
			end
		else
			local speechText = L"script DragSlotDropObjectToObjectAtIndex(" .. objectId .. L",0)"
			UserActionSpeechSetText(Actions.ActionEditRequest.HotbarId, Actions.ActionEditRequest.ItemIndex, Actions.ActionEditRequest.SubIndex, speechText)
		end
	else
		if( IsMobile(objectId) and Actions.ActionEditRequest.ActionId == 5098) then -- BOAT
			local speechText = L"script DragSlotDropObjectToObject(" .. objectId .. L")"
			UserActionSpeechSetText(Actions.ActionEditRequest.HotbarId, Actions.ActionEditRequest.ItemIndex, Actions.ActionEditRequest.SubIndex, speechText)
		elseif( MobilesOnScreen.IsPet(objectId) or Actions.ActionEditRequest.ActionId == 5156) then -- BOAT WHEEL
			local speechText = L"script HandleSingleLeftClkTarget(" .. objectId .. L")"
			UserActionSpeechSetText(Actions.ActionEditRequest.HotbarId, Actions.ActionEditRequest.ItemIndex, Actions.ActionEditRequest.SubIndex, speechText)
		elseif( MobilesOnScreen.IsPet(objectId)) then
			local speechText = L"script HandleSingleLeftClkTarget(" .. objectId .. L")"
			UserActionSpeechSetText(Actions.ActionEditRequest.HotbarId, Actions.ActionEditRequest.ItemIndex, Actions.ActionEditRequest.SubIndex, speechText)
		elseif (Actions.ActionEditRequest.ActionId >= 5800 and Actions.ActionEditRequest.ActionId < 5900) and DoesPlayerHaveItem(objectId) and objectId ~= 0 then
			local speechText = L"script HandleSingleLeftClkTarget(" .. objectId .. L")"
			UserActionSpeechSetText(Actions.ActionEditRequest.HotbarId, Actions.ActionEditRequest.ItemIndex, Actions.ActionEditRequest.SubIndex, speechText)
		else
			WindowUtils.ChatPrint(GetStringFromTid(1154970), SystemData.ChatLogFilters.SYSTEM )
			if (Actions.ActionEditRequest.SubIndex == 0) then
				local slotWindow = "Hotbar"..Actions.ActionEditRequest.HotbarId.."Button"..Actions.ActionEditRequest.ItemIndex
				HotbarSystem.ClearActionIcon(slotWindow, Actions.ActionEditRequest.HotbarId, Actions.ActionEditRequest.ItemIndex, Actions.ActionEditRequest.SubIndex, true)
				HotbarClearItem(Actions.ActionEditRequest.HotbarId,Actions.ActionEditRequest.ItemIndex)
			else
				UserActionMacroRemoveAction(Actions.ActionEditRequest.HotbarId, Actions.ActionEditRequest.ItemIndex, Actions.ActionEditRequest.SubIndex)
				MacroEditWindow.UpdateMacroActionList("ActionEditMacro", Actions.ActionEditRequest.HotbarId, Actions.ActionEditRequest.ItemIndex)
			end
		end
	end
	WindowUnregisterEventHandler("Root", SystemData.Events.TARGET_SEND_ID_CLIENT)
	Actions.ActionEditRequest = {}
end

function Actions.IgnorePlayer()
	RequestTargetInfo() 
	WindowRegisterEventHandler("Root", SystemData.Events.TARGET_SEND_ID_CLIENT, "Actions.Ignore")
end

function Actions.Ignore()
	local Id = SystemData.RequestInfo.ObjectId
	WindowUnregisterEventHandler("Root", SystemData.Events.TARGET_SEND_ID_CLIENT)
	if(IsMobile(Id)) then
		AddPlayerToIgnoreList(Id,WindowData.MobileName[Id].MobName, SettingsWindow.IGNORE_LIST_ALL)
		ToggleWindowByName( "SettingsWindow", "", nil )
		WindowUtils.ChatPrint(ReplaceTokens(GetStringFromTid(1154927), {WindowData.MobileName[Id].MobName}), SystemData.ChatLogFilters.SYSTEM)
	else
		WindowUtils.ChatPrint(GetStringFromTid(1155099), SystemData.ChatLogFilters.SYSTEM)
	end
end

function Actions.ToggleLegacyContainers()
	SystemData.Settings.Interface.LegacyContainers = not SystemData.Settings.Interface.LegacyContainers
	if(SystemData.Settings.Interface.LegacyContainers) then
		WindowUtils.ChatPrint(GetStringFromTid(1155100), SystemData.ChatLogFilters.SYSTEM )
	else
		WindowUtils.ChatPrint(GetStringFromTid(1155101), SystemData.ChatLogFilters.SYSTEM )
	end
	UserSettingsChanged()   
	ButtonSetPressedFlag( "SettingsLegacyUseLegacyContainersButton", SystemData.Settings.Interface.LegacyContainers )
end

function Actions.IgnoreActionSelf()
	SystemData.Settings.GameOptions.ignoreMouseActionsOnSelf = not SystemData.Settings.GameOptions.ignoreMouseActionsOnSelf
	if ( SystemData.Settings.GameOptions.ignoreMouseActionsOnSelf ) then
		WindowUtils.ChatPrint(GetStringFromTid(1155102), SystemData.ChatLogFilters.SYSTEM)
    else
		WindowUtils.ChatPrint(GetStringFromTid(1155435), SystemData.ChatLogFilters.SYSTEM)
    end
    UserSettingsChanged()
end

function Actions.EnablePVPWarning()
	ContextMenu.RequestContextAction(WindowData.PlayerStatus.PlayerId, ContextMenu.DefaultValues.EnablePVPWarning)
end

function Actions.ReleaseCoownership()
	ContextMenu.RequestContextAction(WindowData.PlayerStatus.PlayerId, ContextMenu.DefaultValues.ReleaseCoOwnership)
end

function Actions.LeaveHouse()
	ContextMenu.RequestContextAction(WindowData.PlayerStatus.PlayerId, ContextMenu.DefaultValues.LeaveHouse)
end

function Actions.QuestConversation()
	ContextMenu.RequestContextAction(WindowData.PlayerStatus.PlayerId, ContextMenu.DefaultValues.QuestConversation)
end

function Actions.ViewQuestLog()
	ContextMenu.RequestContextAction(WindowData.PlayerStatus.PlayerId, ContextMenu.DefaultValues.ViewQuestLog)
end

function Actions.CancelQuest()
	ContextMenu.RequestContextAction(WindowData.PlayerStatus.PlayerId, ContextMenu.DefaultValues.CancelQuest)
end

function Actions.QuestItem()
	ContextMenu.RequestContextAction(WindowData.PlayerStatus.PlayerId, ContextMenu.DefaultValues.QuestItem)
end

function Actions.InsuranceMenu()
	ContextMenu.RequestContextAction(WindowData.PlayerStatus.PlayerId, ContextMenu.DefaultValues.InsuranceMenu)
end

function Actions.ToggleItemInsurance()
	ContextMenu.RequestContextAction(WindowData.PlayerStatus.PlayerId, ContextMenu.DefaultValues.ToggleItemInsurance)
end

function Actions.TitlesMenu()
	ContextMenu.RequestContextAction(WindowData.PlayerStatus.PlayerId, ContextMenu.DefaultValues.TitlesMenu)
end

function Actions.LoyaltyRating()
	ContextMenu.RequestContextAction(WindowData.PlayerStatus.PlayerId, ContextMenu.DefaultValues.LoyaltyRating)
end

function Actions.CancelProtection()
	ContextMenu.RequestContextAction(WindowData.PlayerStatus.PlayerId, ContextMenu.DefaultValues.CancelProtection)
end

function Actions.VoidPool()
	ContextMenu.RequestContextAction(WindowData.PlayerStatus.PlayerId, ContextMenu.DefaultValues.VoidPool)
end

function Actions.ToggleTrades()
	Interface.AllowTrades = not Interface.AllowTrades
	Interface.SaveBoolean( "AllowTrades", Interface.AllowTrades )
	if Interface.AllowTrades then
		ContextMenu.RequestContextAction(WindowData.PlayerStatus.PlayerId, ContextMenu.DefaultValues.AllowTrades)
	else
		ContextMenu.RequestContextAction(WindowData.PlayerStatus.PlayerId, ContextMenu.DefaultValues.RefuseTrades)
	end
end

function Actions.SiegeBlessItem()
	ContextMenu.RequestContextAction(WindowData.PlayerStatus.PlayerId, ContextMenu.DefaultValues.SiegeBless)
end

function Actions.ExportContainerItems()
	RequestTargetInfo()
	WindowUtils.SendOverheadText(GetStringFromTid(1154960), 1152, true)
	WindowRegisterEventHandler("Root", SystemData.Events.TARGET_SEND_ID_CLIENT, "Actions.RequestContItems")	
end

function Actions.RequestContItems()
	local objectId = SystemData.RequestInfo.ObjectId
	WindowUnregisterEventHandler("Root", SystemData.Events.TARGET_SEND_ID_CLIENT)
	if not ContainerWindow.OpenContainers[objectId] then
		WindowUtils.SendOverheadText(GetStringFromTid(1154962), 33, true, false)
		return
	end
	RegisterWindowData(WindowData.ContainerWindow.Type, objectId)				
	local name = tostring(WindowData.ContainerWindow[objectId].containerName)
	
	if not name or name == "" or name == L"" then
		name = objectId
	end
	
	local AllItems = ContainerSearch.ScanQuantities(objectId)
	
	local output = L"\r\n\r\n"
	
	for i = 1, #AllItems  do
		if i > 1 then
			output = output .. L"#####################\r\n\r\n\r\n"
		end
		local props = ItemProperties.GetObjectProperties(AllItems[i], nil, "Actions - Request Container items list")
		if props then
			for i =1, #props do
				if props[i] ~= "" then
					output = output .. props[i] .. L"\r\n"
				end
			end
		end
		
	end
	local clockstring = Interface.Clock.DD .. "-" .. Interface.Clock.MM .. "-" .. Interface.Clock.YYYY .. " " .. Interface.Clock.h .. "-" .. Interface.Clock.m .. "-" .. Interface.Clock.s
	
	TextLogCreate("ContItems", 1) 
	TextLogSetEnabled("ContItems", true)
	TextLogClear("ContItems")
	TextLogSetIncrementalSaving( "ContItems", true, "logs/[" .. clockstring .. "] " .. name .. " Items.txt")
	
	TextLogAddEntry("ContItems", 1, output)
	TextLogDestroy("ContItems")
	WindowUtils.ChatPrint(ReplaceTokens(GetStringFromTid(1155125), {towstring("[" .. clockstring .. "] " .. name .. " Items.txt")}), SystemData.ChatLogFilters.SYSTEM )
end

function Actions.ToggleEnglishNames()
	SystemData.Settings.Language.englishNames = not SystemData.Settings.Language.englishNames

	local needsReload = UserSettingsChanged()
	
	if ( needsReload == true ) then
		InterfaceCore.ReloadUI()
	end
end

function Actions.CloseAllContainers()
	for id, value in pairs(ContainerWindow.OpenContainers) do
		if id ~= WindowData.PlayerEquipmentSlot[EquipmentData.EQPOS_BACKPACK].objectId then
			DestroyWindow("ContainerWindow_"..id)
		end
	end
end

function Actions.CloseAllCorpses()
	for id, value in pairs(ContainerWindow.OpenContainers) do
		local item = WindowData.ObjectInfo[id]
		if (item  ~= nil) then 
			local name = wstring.lower(item.name)
			local texto = wstring.find(name , L"a corpse of ")
			if ( texto ~= nil ) then
				WindowData.ContainerWindow[id].isCorpse = true 
			end
			local texto = wstring.find(name , L" corpse")
			if ( texto ~= nil) then
				WindowData.ContainerWindow[id].isCorpse = true 
			end
			
		end 
		if(WindowData.ContainerWindow[id] and WindowData.ContainerWindow[id].isCorpse) then
			DestroyWindow("ContainerWindow_"..id)
		end
		
	end
end

Actions.MassOrganize = false
function Actions.MassOrganizerStart()
	ContainerWindow.OrganizeBag = nil
	if (Actions.MassOrganize == false) then
		if (Organizer.Organizers_Cont[Organizer.ActiveOrganizer]) then
			ContainerWindow.Organize = false
			ContainerWindow.OrganizeBag = Organizer.Organizers_Cont[Organizer.ActiveOrganizer]
			Actions.MassOrganize = true
		end
	else
		Actions.MassOrganize = false
	end
end

function Actions.MassOrganizer(timePassed)
	
	if (Actions.MassOrganize == true and ContainerWindow.CanPickUp == true and SystemData.DragItem.DragType ~= SystemData.DragItem.TYPE_ITEM) then
		if not Actions.VacuumObjects or #Actions.VacuumObjects == 0 then
			Actions.VacuumObjects = {}
			for id, value in pairs(ContainerWindow.OpenContainers) do
				if (DoesWindowNameExist("ContainerWindow_"..id) and id ~= ContainerWindow.PlayerBackpack and id ~= ContainerWindow.OrganizeBag) then
					local numItems = WindowData.ContainerWindow[id].numItems
					for i = 1, numItems  do
						local item = WindowData.ContainerWindow[id].ContainedItems[i]
						RegisterWindowData(WindowData.ObjectInfo.Type, item.objectId)
						local itemData = WindowData.ObjectInfo[item.objectId]
						if (itemData) then
							if (Organizer.Organizer[Organizer.ActiveOrganizer]) then
								for j=1,  Organizer.Organizers_Items[Organizer.ActiveOrganizer] do
									local itemL = Organizer.Organizer[Organizer.ActiveOrganizer][j]
									if (itemL.type > 0 and itemL.type == itemData.objectType and itemL.hue == itemData.hueId) then
										table.insert(Actions.VacuumObjects,item.objectId)
										break
									elseif(itemL.id > 0  and itemL.id == item.objectId) then
										table.insert(Actions.VacuumObjects,item.objectId)
										break
									end
								end
							end	
						end
						UnregisterWindowData(WindowData.ObjectInfo.Type, item.objectId)
					end
				end
			end
		end
		if Actions.VacuumObjects and #Actions.VacuumObjects > 0 then
	
			local OrganizeBag = ContainerWindow.OrganizeBag
			if not OrganizeBag or OrganizeBag == 0 then
				OrganizeBag = ContainerWindow.PlayerBackpack
			end
			
			local key = Actions.VacuumObjects[1]
			RegisterWindowData(WindowData.ObjectInfo.Type, key)
			local itemData = WindowData.ObjectInfo[key]

			ContainerWindow.TimePassedSincePickUp = 0
			ContainerWindow.CanPickUp = false
			ObjectHandleWindow.lastItem = key
			
			MoveItemToContainer(key, itemData.quantity, OrganizeBag)

			table.remove(Actions.VacuumObjects, 1)
			if #Actions.VacuumObjects == 0 then
				Actions.VacuumObjects = {}
				for id, value in pairs(ContainerWindow.OpenContainers) do
					if (DoesWindowNameExist("ContainerWindow_"..id) and id ~= ContainerWindow.PlayerBackpack and id ~= ContainerWindow.OrganizeBag) then
						local numItems = WindowData.ContainerWindow[id].numItems
						for i = 1, numItems  do
							local item = WindowData.ContainerWindow[id].ContainedItems[i]
							RegisterWindowData(WindowData.ObjectInfo.Type, item.objectId)
							local itemData = WindowData.ObjectInfo[item.objectId]
							if (itemData) then
								if (Organizer.Organizer[Organizer.ActiveOrganizer]) then
									for j=1,  Organizer.Organizers_Items[Organizer.ActiveOrganizer] do
										local itemL = Organizer.Organizer[Organizer.ActiveOrganizer][j]
										if (itemL.type > 0 and itemL.type == itemData.objectType and itemL.hue == itemData.hueId) then
											table.insert(Actions.VacuumObjects,item.objectId)
											break
										elseif(itemL.id > 0  and itemL.id == item.objectId) then
											table.insert(Actions.VacuumObjects,item.objectId)
											break
										end
									end
								end	
							end
							UnregisterWindowData(WindowData.ObjectInfo.Type, item.objectId)
						end
					end
				end
				if #Actions.VacuumObjects == 0 then
					Actions.MassOrganize = false
				end
			end
			
		end
	end
end

Actions.AutoLoadShurikens = false
Actions.BeltMenuRequest = nil
function Actions.LoadShuri()
	local BeltId = WindowData.Paperdoll[WindowData.PlayerStatus.PlayerId][15].slotId
	if (BeltId ~= 0) then
		local props = ItemProperties.GetObjectPropertiesTid( BeltId, 1, "Actions - Auto-load shurikens - belt check" )
		if (ItemPropertiesInfo.NinjaBeltTid[props]) then
			Actions.BeltMenuRequest = BeltId
			Actions.AutoLoadShurikens = true	
		end
	else
		local backpackId = WindowData.PlayerEquipmentSlot[EquipmentData.EQPOS_BACKPACK].objectId
		local numItems = WindowData.ContainerWindow[backpackId].numItems
		for i = 1, numItems  do
			local item = WindowData.ContainerWindow[backpackId].ContainedItems[i]
			RegisterWindowData(WindowData.ObjectInfo.Type, item.objectId)
			
			item = WindowData.ContainerWindow[backpackId].ContainedItems[i]
			local itemdata = WindowData.ObjectInfo[item.objectId]
			
			if (not itemdata) then
				continue
			end
			if (wstring.find(wstring.lower(itemdata.name), wstring.lower(GetStringFromTid(1030128)))) then
				Actions.BeltMenuRequest = item.objectId
				Actions.AutoLoadShurikens = true
				break
			end
			UnregisterWindowData(WindowData.ObjectInfo.Type, item.objectId)
		end
	end
end


Actions.Nextshuri = 0
function Actions.Shuriken( timePassed )
	
	if (Actions.AutoLoadShurikens) then
		Actions.Nextshuri = Actions.Nextshuri + timePassed
		if (Actions.Nextshuri >= 1) then
			local props = ItemProperties.GetObjectPropertiesArray( Actions.BeltMenuRequest, "container items weight scan" )
			if props and ItemPropertiesInfo.NinjaBeltTid[props.PropertiesTids[1]]  then
				local params = ItemProperties.BuildParamsArray( props )
				
				for j = 1, #props.PropertiesTids do
					if ItemPropertiesInfo.ChargesTid[props.PropertiesTids[j]] then
						local token = ItemPropertiesInfo.ChargesTid[props.PropertiesTids[j]]
						local val = tostring(params[props.PropertiesTids[j]][token])
						uses = tonumber(val)
						break
					end
				end
			end 
			
			if tonumber(uses) and tonumber(uses) < 10 then
				if (WindowData.Cursor ~= nil and WindowData.Cursor.target == true) then
					Actions.AutoLoadShuri()
				elseif Actions.AutoLoadShurikens then
					ContextMenu.RequestContextAction(Actions.BeltMenuRequest, ContextMenu.DefaultValues.LoadShuriken)
				end
			else
				if (WindowData.Cursor ~= nil and WindowData.Cursor.target == true) then
					HandleSingleLeftClkTarget(0)
					WindowData.Cursor.target = false
				end	
				Actions.AutoLoadShurikens = false
			end
			Actions.Nextshuri = 0
		end
	end

end

function Actions.AutoLoadShuri()
	local backpackId = WindowData.PlayerEquipmentSlot[EquipmentData.EQPOS_BACKPACK].objectId
	local numItems = WindowData.ContainerWindow[backpackId].numItems
	for i = 1, numItems  do
		local item = WindowData.ContainerWindow[backpackId].ContainedItems[i]
		RegisterWindowData(WindowData.ObjectInfo.Type, item.objectId)
		
		item = WindowData.ContainerWindow[backpackId].ContainedItems[i]
		local itemdata = WindowData.ObjectInfo[item.objectId]
		
		if (not itemdata) then
			continue
		end
		local objType = WindowData.ObjectInfo[item.objectId].objectType
		if (objType == 10156) then
			HandleSingleLeftClkTarget(item.objectId)
			return
		end
		UnregisterWindowData(WindowData.ObjectInfo.Type, item.objectId)
	end
	if (WindowData.Cursor ~= nil and WindowData.Cursor.target == true) then
		HandleSingleLeftClkTarget(0)
		WindowData.Cursor.target = false
	end	
	Actions.AutoLoadShurikens = false
end

function Actions.DressHolding()
	DragSlotDropObjectToPaperdoll(WindowData.PlayerStatus.PlayerId)
end

function Actions.DropHolding()
	local backpackId = WindowData.PlayerEquipmentSlot[EquipmentData.EQPOS_BACKPACK].objectId
	DragSlotDropObjectToObjectAtIndex(backpackId,0)
end

function Actions.ToggleTrapBox()
	if (Interface.TrapBoxID ~= 0 ) then
		Interface.oldTrapBoxID = Interface.TrapBoxID
		Interface.TrapBoxID = 0
		Interface.SaveNumber( "TrapBoxID" , Interface.TrapBoxID )
		ContainerWindow.UpdateContents(WindowData.PlayerEquipmentSlot[EquipmentData.EQPOS_BACKPACK].objectId)
		WindowUtils.ChatPrint(GetStringFromTid(1155144), SystemData.ChatLogFilters.SYSTEM )
		return
	end
    WindowUtils.SendOverheadText(GetStringFromTid(1155145), 1152, true)
	RequestTargetInfo()
	WindowRegisterEventHandler("Root", SystemData.Events.TARGET_SEND_ID_CLIENT, "Actions.TrapboxTargetReceived")
end

function Actions.TrapboxTargetReceived()
	local backpackId = WindowData.PlayerEquipmentSlot[EquipmentData.EQPOS_BACKPACK].objectId
	local objectId = SystemData.RequestInfo.ObjectId
	local itemData = WindowData.ObjectInfo[objectId]
	WindowUnregisterEventHandler("Root", SystemData.Events.TARGET_SEND_ID_CLIENT)
	
	if not IsContainer(objectId) then
		WindowUtils.ChatPrint(GetStringFromTid(1155159), SystemData.ChatLogFilters.SYSTEM )
		return
	end
	
	if ( objectId ~= backpackId and objectId ~= 0 and DoesPlayerHaveItem(objectId)) then
		if (itemData.objectType ~= 2473 and itemData.objectType ~= 3644 and itemData.objectType ~= 3645 and itemData.objectType ~= 3646 and itemData.objectType ~= 3647 and itemData.objectType ~= 3710 ) then
			WindowUtils.ChatPrint(GetStringFromTid(1155146), SystemData.ChatLogFilters.SYSTEM )
		else
			if (IsInPlayerBackPack(objectId) ) then
				Interface.TrapBoxID = objectId
				Interface.SaveNumber( "TrapBoxID" , Interface.TrapBoxID )
				ContainerWindow.UpdateContents(WindowData.PlayerEquipmentSlot[EquipmentData.EQPOS_BACKPACK].objectId)
				WindowUtils.ChatPrint(GetStringFromTid(1155147), SystemData.ChatLogFilters.SYSTEM )
			else
				WindowUtils.ChatPrint(GetStringFromTid(1155148), SystemData.ChatLogFilters.SYSTEM )
			end
		end
	else
		WindowUtils.ChatPrint(GetStringFromTid(1155149), SystemData.ChatLogFilters.SYSTEM )
	end
	
end

function Actions.ToggleLootbag()
	if (Interface.LootBoxID ~= 0 ) then
		Interface.oldLootBoxID = Interface.LootBoxID
		Interface.LootBoxID = 0
		Interface.SaveNumber( "LootBoxID" , Interface.LootBoxID )
		ContainerWindow.UpdateContents(WindowData.PlayerEquipmentSlot[EquipmentData.EQPOS_BACKPACK].objectId)
		WindowUtils.ChatPrint(GetStringFromTid(1155152), SystemData.ChatLogFilters.SYSTEM )
		return	
	end
    WindowUtils.SendOverheadText(GetStringFromTid(1155153), 1152, true)
	RequestTargetInfo()
	WindowRegisterEventHandler("Root", SystemData.Events.TARGET_SEND_ID_CLIENT, "Actions.LootbagTargetReceived")
end

function Actions.LootbagTargetReceived()
	local backpackId = WindowData.PlayerEquipmentSlot[EquipmentData.EQPOS_BACKPACK].objectId
	local objectId = SystemData.RequestInfo.ObjectId
	WindowUnregisterEventHandler("Root", SystemData.Events.TARGET_SEND_ID_CLIENT)
	
	if not IsContainer(objectId) then
		WindowUtils.ChatPrint(GetStringFromTid(1155159), SystemData.ChatLogFilters.SYSTEM )
		return
	end
	
	local itemData = WindowData.ObjectInfo[objectId]
	if ( objectId ~= backpackId and objectId ~= 0 and DoesPlayerHaveItem(objectId)) then
		if (IsInPlayerBackPack(objectId) ) then
			Interface.LootBoxID = objectId
			Interface.SaveNumber( "LootBoxID" , Interface.LootBoxID )
			ContainerWindow.UpdateContents(WindowData.PlayerEquipmentSlot[EquipmentData.EQPOS_BACKPACK].objectId)
			WindowUtils.ChatPrint(GetStringFromTid(1155154), SystemData.ChatLogFilters.SYSTEM )
		else
			WindowUtils.ChatPrint(GetStringFromTid(1155155), SystemData.ChatLogFilters.SYSTEM )
		end
	else
		WindowUtils.ChatPrint(GetStringFromTid(1155156), SystemData.ChatLogFilters.SYSTEM )
	end
end

function Actions.ToggleAlphaMode()
	if ( WindowUtils.ToggleScale ) then
		Actions.ToggleScaleMode()
	end
    WindowUtils.ToggleAlpha = not WindowUtils.ToggleAlpha 
		
    if ( WindowUtils.ToggleAlpha ) then
		WindowUtils.ChatPrint(GetStringFromTid(1155160), SystemData.ChatLogFilters.SYSTEM)
    else
		WindowUtils.ChatPrint(GetStringFromTid(1155161), SystemData.ChatLogFilters.SYSTEM)
    end
	
end

function Actions.ToggleScaleMode()
	if ( WindowUtils.ToggleAlpha ) then
		Actions.ToggleAlphaMode()
	end
    WindowUtils.ToggleScale = not WindowUtils.ToggleScale 
		
    if ( WindowUtils.ToggleScale ) then
		WindowUtils.ChatPrint(GetStringFromTid(1155166), SystemData.ChatLogFilters.SYSTEM)
    else
		WindowUtils.ChatPrint(GetStringFromTid(1155167), SystemData.ChatLogFilters.SYSTEM)
    end

end

function Actions.ObjectHandleContextMenu()
    local filter
    for filter = 1, #UserOptionsSettings.ObjectHandleFilters do
        ContextMenu.CreateLuaContextMenuItem(
				UserOptionsSettings.ObjectHandleFilters[filter].text,
				0,
				filter,
				filter,
				UserOptionsSettings.objectHandleFilter() == UserOptionsSettings.ObjectHandleFilters[filter].id and not ObjectHandleWindow.ItemsOnly and not ObjectHandleWindow.LostItemsOnly
		)
    end    
    ContextMenu.CreateLuaContextMenuItemWithString(L"",0,"nil",2, false)
    
    if (ObjectHandleWindow.CurrentFilter == "") then
		ContextMenu.CreateLuaContextMenuItemWithString(GetStringFromTid(1062476),0,"setfilter",2, false)
    else
		ContextMenu.CreateLuaContextMenuItemWithString(GetStringFromTid(1154850),0,"addfilter",2, false)
		ContextMenu.CreateLuaContextMenuItemWithString(GetStringFromTid(1154849),0,"removefilter",2, false)
    end
    ContextMenu.ActivateLuaContextMenu(Actions.ObjectHandleContextMenuCallback)
end

function Actions.ObjectHandleContextMenuCallback( returnCode, param )
    if( param ~= nil ) then		
		if (returnCode == "setfilter") then
			local rdata = {title=GetStringFromTid(1062476), subtitle=GetStringFromTid(1155172), callfunction=Actions.ObjectHandleSetFilter, id=2}
			RenameWindow.Create(rdata)
		elseif (returnCode == "addfilter") then
			local rdata = {title=GetStringFromTid(1062476), subtitle=GetStringFromTid(1155172), callfunction=Actions.ObjectHandleSetFilter, id=3}
			RenameWindow.Create(rdata)
		elseif (returnCode == "removefilter") then
			ObjectHandleWindow.CurrentFilter = ""
		elseif (returnCode ~= "nil") then			
			SystemData.Settings.GameOptions.objectHandleFilter = returnCode-1
			UserSettingsChanged()
		end
    end
end

function Actions.ObjectHandleSetFilter(j, newval)
	if j == 2 then
		ObjectHandleWindow.CurrentFilter = newval
	elseif j == 3 then
		ObjectHandleWindow.CurrentFilter = ObjectHandleWindow.CurrentFilter .. L"|" .. newval
	end
end

function Actions.GetHealthbar()
	if( SystemData.Settings.GameOptions.legacyTargeting) then
		return
	end
	if (WindowData.CurrentTarget.TargetId == WindowData.PlayerStatus.PlayerId) then
		WindowUtils.ChatPrint(GetStringFromTid(1155175), SystemData.ChatLogFilters.SYSTEM )
		return
	end
	if(WindowData.CurrentTarget.TargetType == TargetWindow.MobileType) then
		MobileHealthBar.CreateHealthBar(TargetWindow.TargetId)
	else
		local item = WindowData.ObjectInfo[TargetWindow.TargetId]
		if (item == nil) then
			WindowUtils.ChatPrint(GetStringFromTid(1155176), SystemData.ChatLogFilters.SYSTEM )
			return
		end
		
	end	
end

function Actions.GetTypeID()
	WindowUtils.SendOverheadText(GetStringFromTid(1154972), 1152, true)
	RequestTargetInfo()
	WindowRegisterEventHandler("Root", SystemData.Events.TARGET_SEND_ID_CLIENT, "Actions.ItemIDRequestTargetInfoReceived")
end

function Actions.ItemIDRequestTargetInfoReceived()
	local objectId = SystemData.RequestInfo.ObjectId
		
	WindowData.CurrentTarget.TargetId = objectId
	WindowUnregisterEventHandler("Root", SystemData.Events.TARGET_SEND_ID_CLIENT)

	if(IsMobile(objectId)) then
		WindowUtils.ChatPrint(GetStringFromTid(1155182), SystemData.ChatLogFilters.SYSTEM )
		return
	elseif(objectId == 0) then
		WindowUtils.ChatPrint(GetStringFromTid(1155183), SystemData.ChatLogFilters.SYSTEM )
		return
	end
	
	RegisterWindowData(WindowData.ObjectInfo.Type, objectId)
	
	local itemData = WindowData.ObjectInfo[objectId]
	local hexnum = WindowUtils.Dec2Hex(itemData.objectType)
	local finalText = ReplaceTokens(GetStringFromTid(1155184), { itemData.objectType .. L" ( 0x" .. StringToWString(hexnum) .. L" )" } )
	local bonsai = L""
	if (itemData.objectType == 10460 or itemData.objectType == 10463) then
		bonsai =  GetStringFromTid(1063338) .. L" " .. GetStringFromTid(1030460) -- common
		
	elseif (itemData.objectType == 10461 or itemData.objectType == 10464) then
		bonsai =  GetStringFromTid(1063339) .. L" " .. GetStringFromTid(1030460) -- uncommon
		
	elseif (itemData.objectType == 10462 or itemData.objectType == 10465) then
		bonsai = GetStringFromTid(1063340) .. L" " .. GetStringFromTid(1030460) -- rare
		
	elseif (itemData.objectType == 10466) then
		bonsai =  GetStringFromTid(1063341) .. L" " .. GetStringFromTid(1030460) -- exceptional
		
	elseif (itemData.objectType == 10467) then
		bonsai =  GetStringFromTid(1063342) .. L" " .. GetStringFromTid(1030460) -- exotic
					
	end
	if bonsai ~= L"" then
		finalText = finalText .. L" - " .. WindowUtils.Decapitalizing(bonsai)
	end
		
		
	WindowUtils.SendOverheadText(finalText , 33, true)
	
end

function Actions.GetHueID()
	WindowUtils.SendOverheadText(GetStringFromTid(1154972), 1152, true)
	RequestTargetInfo()
	WindowRegisterEventHandler("Root", SystemData.Events.TARGET_SEND_ID_CLIENT, "Actions.ColorRequestTargetInfoReceived")
end

function Actions.ColorRequestTargetInfoReceived()
	local objectId = SystemData.RequestInfo.ObjectId

	WindowUnregisterEventHandler("Root", SystemData.Events.TARGET_SEND_ID_CLIENT)

	if(IsMobile(objectId)) then
		WindowUtils.ChatPrint(GetStringFromTid(1155182), SystemData.ChatLogFilters.SYSTEM )
		return
	elseif(objectId == 0) then
		WindowUtils.ChatPrint(GetStringFromTid(1155183), SystemData.ChatLogFilters.SYSTEM )
		return
	end

	RegisterWindowData(WindowData.ObjectInfo.Type, objectId)
	if( objectId ~= 0) then 
		local item = WindowData.ObjectInfo[objectId]
		WindowUtils.SendOverheadText(ReplaceTokens(GetStringFromTid(1155185), { towstring(item.hueId) }) , 33, true)
		local hueR,hueG,hueB = HueRGBAValue(item.hueId)
		WindowUtils.SendOverheadText(L"R:"..hueR..L" G:".. hueG .. L" B:" .. hueB , 33, true)
		
		if (HuesInfo.Data[item.hueId]) then
			WindowUtils.SendOverheadText(ReplaceTokens(GetStringFromTid(1155186), { HuesInfo.Data[item.hueId] }), 33, true)
		end
	end
end

function Actions.IgnoreTargettedItem()
	RequestTargetInfo()
	WindowUtils.SendOverheadText(GetStringFromTid(1155220), 1152, true)
	WindowRegisterEventHandler("Root", SystemData.Events.TARGET_SEND_ID_CLIENT, "Actions.IgnoreItemRequestTargetInfoReceived")
end

function Actions.IgnoreItemRequestTargetInfoReceived()
	local objectId = SystemData.RequestInfo.ObjectId
	local count = table.getn(ContainerWindow.IgnoreItems)
	local found = false
	for i=1, count do
		if ( ContainerWindow.IgnoreItems[i] and ContainerWindow.IgnoreItems[i].id == objectId) then
			found = true
			break
		end

	end
	if ( not found ) then
		local data =  { id = objectId, decayTime = Interface.Clock.Timestamp + 1800}
		table.insert(ContainerWindow.IgnoreItems, data)
		ObjectHandleWindow.ForceIgnore = objectId
	end
	
	WindowUtils.ChatPrint(GetStringFromTid(1155221), SystemData.ChatLogFilters.SYSTEM )
	WindowUnregisterEventHandler("Root", SystemData.Events.TARGET_SEND_ID_CLIENT)
end

function Actions.ClearIgnoreList()
    ContainerWindow.IgnoreItems = {}
    WindowUtils.ChatPrint(GetStringFromTid(1155224), SystemData.ChatLogFilters.SYSTEM)
end

function Actions.ToggleBlockPaperdolls()

	if(Interface.BlockOthersPaperdoll) then
		Interface.BlockOthersPaperdoll = false
		Interface.SaveBoolean( "BlockOthersPaperdoll", Interface.BlockOthersPaperdoll )
		WindowUtils.ChatPrint(GetStringFromTid(1155226), SystemData.ChatLogFilters.SYSTEM)
	else
		Interface.BlockOthersPaperdoll = true
		Interface.SaveBoolean( "BlockOthersPaperdoll", Interface.BlockOthersPaperdoll )
		WindowUtils.ChatPrint(GetStringFromTid(1155227), SystemData.ChatLogFilters.SYSTEM)
	end	
end


function Actions.UndressMe()
	
	Actions.OrganizeBag = nil
	Actions.OrganizeParent = WindowData.PlayerStatus.PlayerId
	if (not PaperdollWindow.Organize) then
		if (Organizer.Undresses_Cont[Organizer.ActiveUndress] == 0) then
			RequestTargetInfo()
			WindowUtils.SendOverheadText(GetStringFromTid(1154773), 1152, true)
			WindowRegisterEventHandler("Root", SystemData.Events.TARGET_SEND_ID_CLIENT, "Actions.UndressTargetInfoReceived")
		else
			Actions.OrganizeBag = Organizer.Undresses_Cont[Organizer.ActiveUndress]
			Actions.Undress = true
			return
		end
	end
	Actions.Undress = false
end

function Actions.UndressTargetInfoReceived()
	Actions.OrganizeBag = SystemData.RequestInfo.ObjectId
	if (Actions.OrganizeBag and Actions.OrganizeBag ~= 0) then
		Actions.Undress = true
	end
	WindowUnregisterEventHandler("Root", SystemData.Events.TARGET_SEND_ID_CLIENT)
	
end

Actions.UndressItems = {}

function Actions.UndressAgent(timePassed)
	local paperdollId = WindowData.PlayerStatus.PlayerId
	if not WindowData.Paperdoll[paperdollId] then
		RegisterWindowData(WindowData.Paperdoll.Type, paperdollId)
	end
	if (Actions.Undress == true and ContainerWindow.CanPickUp == true and SystemData.DragItem.DragType ~= SystemData.DragItem.TYPE_ITEM) then
		if not Actions.UndressItems or #Actions.UndressItems == 0 then
			Actions.UndressItems = {}
			for index = 1, WindowData.Paperdoll[paperdollId].numSlots  do
				if (WindowData.Paperdoll[paperdollId][index].slotId ~= 0) then
					for j=1,  Organizer.Undresses_Items[Organizer.ActiveUndress] do
						local itemL = Organizer.Undress[Organizer.ActiveUndress][j]
						if(itemL.id > 0  and itemL.id == WindowData.Paperdoll[paperdollId][index].slotId) then
							table.insert(Actions.UndressItems,itemL.id)
						end
					end
					
				end
			end
		end
		
		if Actions.UndressItems and #Actions.UndressItems > 0 then
	
			local OrganizeBag = Actions.OrganizeBag
			if not OrganizeBag or OrganizeBag == 0 then
				OrganizeBag = ContainerWindow.PlayerBackpack
			end
			
			local key = Actions.UndressItems[1]

			ContainerWindow.TimePassedSincePickUp = 0
			ContainerWindow.CanPickUp = false
			ObjectHandleWindow.lastItem = key
			
			MoveItemToContainer(key, 1, OrganizeBag)

			table.remove(Actions.UndressItems, 1)
			if #Actions.UndressItems == 0 then
				Actions.UndressItems = {}
				for index = 1, WindowData.Paperdoll[paperdollId].numSlots  do
					if (WindowData.Paperdoll[paperdollId][index].slotId ~= 0) then
						for j=1,  Organizer.Undresses_Items[Organizer.ActiveUndress] do
							local itemL = Organizer.Undress[Organizer.ActiveUndress][j]
							if(itemL.id > 0  and itemL.id == WindowData.Paperdoll[paperdollId][index].slotId) then
								table.insert(Actions.UndressItems,itemL.id)
							end
						end
						
					end
				end
				if #Actions.UndressItems == 0 then
					Actions.Undress = false
				end
			end
			
		end
	end
end


function Actions.ImbueLast()
	if GumpsParsing.ParsedGumps[999059] then
		GumpsParsing.PressButton(999059, 4)
	else
		WindowUtils.ChatPrint(GetStringFromTid(1155370), SystemData.ChatLogFilters.SYSTEM )
	end	
end

function Actions.UnravelItem()
	if GumpsParsing.ParsedGumps[999059] then
		GumpsParsing.PressButton(999059, 5)
	else
		WindowUtils.ChatPrint(GetStringFromTid(1155370), SystemData.ChatLogFilters.SYSTEM )
	end	
end

function Actions.EnhanceItem()
	local gumpID = 460
	if GumpsParsing.ParsedGumps[gumpID] then
		if GumpsParsing.ParsedGumps[gumpID] == "AlchemyMenu" then
			WindowUtils.ChatPrint(GetStringFromTid(1155383), SystemData.ChatLogFilters.SYSTEM )
		elseif GumpsParsing.ParsedGumps[gumpID] == "BlacksmithMenu" then
			GumpsParsing.PressButton(gumpID, 18)
		elseif GumpsParsing.ParsedGumps[gumpID] == "CookingMenu" then
			WindowUtils.ChatPrint(GetStringFromTid(1155383), SystemData.ChatLogFilters.SYSTEM )
		elseif GumpsParsing.ParsedGumps[gumpID] == "CarpentryMenu" then
			GumpsParsing.PressButton(gumpID, 18)
		elseif GumpsParsing.ParsedGumps[gumpID] == "TailoringMenu" then
			GumpsParsing.PressButton(gumpID, 18)
		elseif GumpsParsing.ParsedGumps[gumpID] == "BowcraftMenu" then
			GumpsParsing.PressButton(gumpID, 10)
		elseif GumpsParsing.ParsedGumps[gumpID] == "TinkeringMenu" then
			GumpsParsing.PressButton(gumpID, 16)
		elseif GumpsParsing.ParsedGumps[gumpID] == "CartographyMenu" then
			WindowUtils.ChatPrint(GetStringFromTid(1155382), SystemData.ChatLogFilters.SYSTEM )
		elseif GumpsParsing.ParsedGumps[gumpID] == "InscriptionMenu" then
			WindowUtils.ChatPrint(GetStringFromTid(1155382), SystemData.ChatLogFilters.SYSTEM )
		elseif GumpsParsing.ParsedGumps[gumpID] == "MasonryMenu" then
			GumpsParsing.PressButton(gumpID, 12)
		elseif GumpsParsing.ParsedGumps[gumpID] == "GlassblowingMenu" then
			WindowUtils.ChatPrint(GetStringFromTid(1155382), SystemData.ChatLogFilters.SYSTEM )
		end
	else
		WindowUtils.ChatPrint(GetStringFromTid(1155432), SystemData.ChatLogFilters.SYSTEM )
	end	
end

function Actions.SmeltItem()
	local gumpID = 460
	if GumpsParsing.ParsedGumps[gumpID] then
		if GumpsParsing.ParsedGumps[gumpID] == "BlacksmithMenu" then
			GumpsParsing.PressButton(gumpID, 4)
		else
			WindowUtils.ChatPrint(GetStringFromTid(1155384), SystemData.ChatLogFilters.SYSTEM )
		end
	else
		WindowUtils.ChatPrint(GetStringFromTid(1155432), SystemData.ChatLogFilters.SYSTEM )
	end	
end


function Actions.AlterItem()
	local gumpID = 460
	if GumpsParsing.ParsedGumps[gumpID] then
		if GumpsParsing.ParsedGumps[gumpID] == "AlchemyMenu" then
			WindowUtils.ChatPrint(GetStringFromTid(1155382), SystemData.ChatLogFilters.SYSTEM )
		elseif GumpsParsing.ParsedGumps[gumpID] == "BlacksmithMenu" then
			GumpsParsing.PressButton(gumpID, 6)
		elseif GumpsParsing.ParsedGumps[gumpID] == "CookingMenu" then
			WindowUtils.ChatPrint(GetStringFromTid(1155382), SystemData.ChatLogFilters.SYSTEM )
		elseif GumpsParsing.ParsedGumps[gumpID] == "CarpentryMenu" then
			GumpsParsing.PressButton(gumpID, 5)
		elseif GumpsParsing.ParsedGumps[gumpID] == "TailoringMenu" then
			GumpsParsing.PressButton(gumpID, 5)
		elseif GumpsParsing.ParsedGumps[gumpID] == "BowcraftMenu" then
			WindowUtils.ChatPrint(GetStringFromTid(1155382), SystemData.ChatLogFilters.SYSTEM )
		elseif GumpsParsing.ParsedGumps[gumpID] == "TinkeringMenu" then
			GumpsParsing.PressButton(gumpID, 5)
		elseif GumpsParsing.ParsedGumps[gumpID] == "CartographyMenu" then
			WindowUtils.ChatPrint(GetStringFromTid(1155382), SystemData.ChatLogFilters.SYSTEM )
		elseif GumpsParsing.ParsedGumps[gumpID] == "InscriptionMenu" then
			WindowUtils.ChatPrint(GetStringFromTid(1155382), SystemData.ChatLogFilters.SYSTEM )
		elseif GumpsParsing.ParsedGumps[gumpID] == "MasonryMenu" then
			WindowUtils.ChatPrint(GetStringFromTid(1155382), SystemData.ChatLogFilters.SYSTEM )
		elseif GumpsParsing.ParsedGumps[gumpID] == "GlassblowingMenu" then
			WindowUtils.ChatPrint(GetStringFromTid(1155382), SystemData.ChatLogFilters.SYSTEM )
		end
	else
		WindowUtils.ChatPrint(GetStringFromTid(1155432), SystemData.ChatLogFilters.SYSTEM )
	end	
end

function Actions.MakeLast()
	local gumpID = 460
	if GumpsParsing.ParsedGumps[gumpID] then
		GumpsParsing.PressButton(gumpID, 2)
	else
		WindowUtils.ChatPrint(GetStringFromTid(1155432), SystemData.ChatLogFilters.SYSTEM )
	end	
end

function Actions.RepairItem()
	local gumpID = 460
	if GumpsParsing.ParsedGumps[gumpID] then
		
		if GumpsParsing.ParsedGumps[gumpID] == "AlchemyMenu" then
			WindowUtils.ChatPrint(GetStringFromTid(1155433), SystemData.ChatLogFilters.SYSTEM )
		elseif GumpsParsing.ParsedGumps[gumpID] == "BlacksmithMenu" then
			GumpsParsing.PressButton(gumpID, 5)
		elseif GumpsParsing.ParsedGumps[gumpID] == "CookingMenu" then
			WindowUtils.ChatPrint(GetStringFromTid(1155433), SystemData.ChatLogFilters.SYSTEM )
		elseif GumpsParsing.ParsedGumps[gumpID] == "CarpentryMenu" then
			GumpsParsing.PressButton(gumpID, 4)
		elseif GumpsParsing.ParsedGumps[gumpID] == "TailoringMenu" then
			GumpsParsing.PressButton(gumpID, 4)
		elseif GumpsParsing.ParsedGumps[gumpID] == "BowcraftMenu" then
			GumpsParsing.PressButton(gumpID, 4)
		elseif GumpsParsing.ParsedGumps[gumpID] == "TinkeringMenu" then
			GumpsParsing.PressButton(gumpID, 4)
		elseif GumpsParsing.ParsedGumps[gumpID] == "CartographyMenu" then
			WindowUtils.ChatPrint(GetStringFromTid(1155433), SystemData.ChatLogFilters.SYSTEM )
		elseif GumpsParsing.ParsedGumps[gumpID] == "InscriptionMenu" then
			WindowUtils.ChatPrint(GetStringFromTid(1155433), SystemData.ChatLogFilters.SYSTEM )
		elseif GumpsParsing.ParsedGumps[gumpID] == "MasonryMenu" then
			GumpsParsing.PressButton(gumpID, 4)
		elseif GumpsParsing.ParsedGumps[gumpID] == "GlassblowingMenu" then
			GumpsParsing.PressButton(gumpID, 4)
		end
	else
		WindowUtils.ChatPrint(GetStringFromTid(1155432), SystemData.ChatLogFilters.SYSTEM )
	end	
end


