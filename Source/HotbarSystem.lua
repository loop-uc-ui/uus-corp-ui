----------------------------------------------------------------
-- Global Variables
----------------------------------------------------------------

HotbarSystem = {}

----------------------------------------------------------------
-- Local Variables
----------------------------------------------------------------
HotbarSystem.RegisteredSpellIcons = {}

HotbarSystem.CurRequestInfoItem = nil

HotbarSystem.HighlightSpellIconInput = {}
HotbarSystem.HighlightSpellIconInput.highlightSpellID = 0
HotbarSystem.HighlightSpellIconInput.highlightSpellEnabled = 0

HotbarSystem.ContextReturnCodes = {}
HotbarSystem.ContextReturnCodes.CLEAR_ITEM = 1
HotbarSystem.ContextReturnCodes.ASSIGN_KEY = 2
HotbarSystem.ContextReturnCodes.NEW_HOTBAR = 3
HotbarSystem.ContextReturnCodes.DESTROY_HOTBAR = 4
HotbarSystem.ContextReturnCodes.TARGET_SELF = 5
HotbarSystem.ContextReturnCodes.TARGET_CURRENT = 6
HotbarSystem.ContextReturnCodes.TARGET_CURSOR = 7
HotbarSystem.ContextReturnCodes.TARGET_OBJECT_ID = 8
HotbarSystem.ContextReturnCodes.EDIT_ITEM = 9
HotbarSystem.ContextReturnCodes.ENABLE_REPEAT = 10
HotbarSystem.ContextReturnCodes.DISABLE_REPEAT = 11
HotbarSystem.ContextReturnCodes.LOCK_HOTBAR = 12

HotbarSystem.TID_CLEAR_ITEM = 1077858
HotbarSystem.TID_ASSIGN_HOTKEY = 1078019
HotbarSystem.TID_NEW_HOTBAR = 1078020
HotbarSystem.TID_DESTROY_HOTBAR = 1078026
HotbarSystem.TID_DESTROY_CONFIRM = 1078027
HotbarSystem.TID_CURSOR = 1078071
HotbarSystem.TID_SELF = 1078072
HotbarSystem.TID_CURRENT = 1078073
HotbarSystem.TID_OBJECT_ID = 1094772
HotbarSystem.TID_TARGET = 1078074
HotbarSystem.TID_EDIT_ITEM = 1078196
HotbarSystem.TID_ENABLE_REPEAT = 1079431 -- "Enable Repeating"
HotbarSystem.TID_DISABLE_REPEAT = 1079433 -- "Disable Repeating"
HotbarSystem.TID_LOCK_HOTBAR = 1115431
HotbarSystem.TID_UNLOCK_HOTBAR = 1115432

HotbarSystem.Spells = {} 
HotbarSystem.Skills = {} 
HotbarSystem.Specials = {}
HotbarSystem.Virtues = {}
HotbarSystem.SpecialActions = {}
HotbarSystem.Delta = 0

----------------------------------------------------------------
-- MainMenuWindow Functions
----------------------------------------------------------------

HotbarSystem.STATIC_HOTBAR_ID = 1
HotbarSystem.MAX_HOTBAR_ID = 5000

HotbarSystem.TID_ASSIGN_HOTKEY_DESC = 1078096
HotbarSystem.TID_REQUEST_TARGET_ID_DESC = 1094788

-- TEMP VARIABLES
HotbarSystem.OffsetX = 945
HotbarSystem.OffsetY = 910
HotbarSystem.OffsetIncrement = -60

HotbarSystem.ReflectionCooldown = 0
HotbarSystem.EtherealVoyageCooldown = 0
HotbarSystem.AttunementCooldown = 0
HotbarSystem.EvasionCooldown = 0
HotbarSystem.StunTime = 0
HotbarSystem.GrapeDelayTime = 0
HotbarSystem.AppleDelayTime = 0
HotbarSystem.HealPotDelayTime = 0
HotbarSystem.BandageDelayTime = 0 -- Starts off at 0 since no bandages have been used yet

HotbarSystem.SkillDelayTimeMax = 0
HotbarSystem.SkillDelayTime = 0


HotbarSystem.RegisteredGenericObjectType = {}
HotbarSystem.RegisteredObjects = {}
HotbarSystem.ReferencedTextures = {}
HotbarSystem.ObjectSlots = {}
HotbarSystem.ObjectSlotsSize = {}
HotbarSystem.MacroReferenceSlots = {}
HotbarSystem.PlayerStatsElements = {}

HotbarSystem.DarkItemLabel = { r=245,g=229,b=0 }
HotbarSystem.LightItemLabel = { r=255,g=255,b=255 }

HotbarSystem.Plain = { r=255,g=255,b=255 }

HotbarSystem.Control = { r=255,g=0,b=0 }
HotbarSystem.Alt = { r=0,g=255,b=0 }
HotbarSystem.Shift = { r=0,g=92,b=232 }

HotbarSystem.ControlAlt = { r=255,g=255,b=0 }
HotbarSystem.AltShift = { r=0,g=255,b=255 }
HotbarSystem.ControlShift = { r=255,g=0,b=255 }

HotbarSystem.ControlAltShift = { r=179,g=106,b=227 }

HotbarSystem.CountdownTimer = { r=255,g=0,b=0 }

HotbarSystem.WARNINGLEVEL = 10

HotbarSystem.TalismanTimers = {}

HotbarSystem.TargetTypeTintColors = {
    [SystemData.Hotbar.TargetType.TARGETTYPE_NONE] = { 159,177,189 },
    [SystemData.Hotbar.TargetType.TARGETTYPE_SELF] = { 0,138,255 },
    [SystemData.Hotbar.TargetType.TARGETTYPE_CURRENT] = { 255,0,0 },
    [SystemData.Hotbar.TargetType.TARGETTYPE_CURSOR] = { 91,204,91 },
    [SystemData.Hotbar.TargetType.TARGETTYPE_OBJECT_ID] = { 200,200,200 }
}

function HotbarSystem.Initialize()
	-- setup the assign key description window
	CreateWindow("AssignHotkeyInfo",false)
	LabelSetText("AssignHotkeyInfoText",GetStringFromTid(HotbarSystem.TID_ASSIGN_HOTKEY_DESC))
	local x, y = LabelGetTextDimensions( "AssignHotkeyInfoText" )
	WindowSetDimensions("AssignHotkeyInfo",x+16,y+16)
	
	-- setup the "Request Target ID" description window
	CreateWindow("RequestTargetIdInfo",false)
	LabelSetText("RequestTargetIdInfoText",GetStringFromTid(HotbarSystem.TID_REQUEST_TARGET_ID_DESC))
	x, y = LabelGetTextDimensions( "RequestTargetIdInfoText" )
	WindowSetDimensions("RequestTargetIdInfo",x+16,y+16)
		
	-- create a hotbar for each id in the list
	for _, hotbarId in pairs(SystemData.Hotbar.HotbarIds) do
		HotbarSystem.SpawnNewHotbar(hotbarId)
	end
	
	--Used to show the stats when players drag their stats into the hotbar
	RegisterWindowData(WindowData.PlayerStatus.Type, 0)
	WindowRegisterEventHandler( "Root", WindowData.PlayerStatus.Event, "HotbarSystem.UpdatePlayerStat")
	
	WindowRegisterEventHandler( "Root", WindowData.ObjectInfo.Event, "HotbarSystem.UpdateItemSlot")	
	WindowRegisterEventHandler( "Root", SystemData.Events.MACRO_CHANGED, "HotbarSystem.UpdateMacroReferenceSlot")
	WindowRegisterEventHandler( "Root", SystemData.Events.HOTBAR_HIGHLIGHT_SPELL_ICON, "HotbarSystem.HighlightSpellIcon")
	WindowRegisterEventHandler( "Root", SystemData.Events.HOTBAR_UNHIGHLIGHT_SPELL_ICON, "HotbarSystem.UnhighlightSpellIcon")
	WindowRegisterEventHandler( "Root", WindowData.ObjectTypeQuantity.Event, "HotbarSystem.UpdateQuantity")
	--WindowRegisterEventHandler( "Root", SystemData.Events.OBJECT_DELAY_TIME, "HotbarSystem.UpdateDelayTime")
	WindowRegisterEventHandler( "Root", SystemData.Events.UPDATE_ACTION_ITEM, "HotbarSystem.HandleUpdateActionItem")
end

function HotbarSystem.Shutdown()
	UnregisterWindowData(WindowData.PlayerStatus.Type, 0)
end

function HotbarSystem.DestroyHotbar(hotbarId)
	for i=1,12 do
		local element = "Hotbar" .. hotbarId.."Button"..i
		HotbarSystem.UnbindKey(hotbarId, i, SystemData.BindType.BINDTYPE_HOTBAR)
		Interface.DeleteSetting( element .. "Custom" )
	end
	Interface.DeleteSetting( "Hotbar" .. hotbarId .. "_IsBlockbar" )
	Interface.DeleteSetting( "Hotbar" .. hotbarId .."SC" )
	Interface.DeleteSetting( "Hotbar" .. hotbarId .."ALP")
	Interface.DeleteSetting( "Hotbar" .. hotbarId .."NameVrev")
	Interface.DeleteSetting( "Hotbar" .. hotbarId .."NameHrev")
	Interface.DeleteSetting( "Hotbar" .. hotbarId .."NameH")
	Interface.DeleteSetting( "Hotbar" .. hotbarId .."NameV")
	Interface.DeleteSetting( "Hotbar" .. hotbarId .."SizeW")
	Interface.DeleteSetting( "Hotbar" .. hotbarId .."SizeH")
	Interface.DeleteSetting( "Hotbar" .. hotbarId .."HandleColor")
	Interface.DeleteSetting( "Hotbar" .. hotbarId .."LeftToRight")
	Interface.DeleteSetting( "Hotbar" .. hotbarId .."LockWithHandle")
	Interface.DeleteSetting( "Hotbar" .. hotbarId .."Closed")
	Interface.DeleteSetting( "Hotbar" .. hotbarId .."Fade")
	Interface.DeleteSetting( "Hotbar" .. hotbarId .."ReverseText")
	
	HotbarUnregister(hotbarId)

	DestroyWindow("Hotbar"..hotbarId)
	-- We dont want to keep track of window positions for hotbars that are permanently destroyed
	WindowUtils.ClearWindowPosition("Hotbar"..hotbarId)
end

function HotbarSystem.DestroyHotbarGroup(windowName)
	local grp, _ = Hotbar.FindHotbarGroup(windowName)
	
	for hbar, _ in pairs(grp) do
		HotbarSystem.DestroyHotbar(WindowGetId(hbar))
	end
end

function HotbarSystem.SpawnNewHotbar(hotbarId, slots)
	-- If the hotbarId is passed in, this thing is already registered in code (from loading UserSettings)
	local setPosition = false
	if( hotbarId == nil ) then
		hotbarId = HotbarSystem.GetNextHotbarId()
		HotbarRegisterNew(hotbarId)
		setPosition = true
		
		-- new hotbars default to unlocked
		SystemData.Hotbar[hotbarId].Locked = false
	end
	
	--Debug.Print("HotbarSystem.SpawnNewHotbar: "..hotbarId)
	
	SystemData.DynamicWindowId = hotbarId
	CreateWindowFromTemplate("Hotbar"..hotbarId, "Hotbar", "Root")
	
	-- dynamic hotbars need to have their position generated when created for the first time
	if( setPosition == true ) then
		if Interface.LoadBoolean("Hotbar" .. hotbarId .. "_IsBlockbar", false) then
			WindowSetDimensions("Hotbar" .. hotbarId, Hotbar.BUTTON_SIZE, Hotbar.BUTTON_SIZE)
			Hotbar.OnResizeEnd("Hotbar" .. hotbarId)
			Hotbar.SetLocked(hotbarId, true)
		elseif( hotbarId ~= HotbarSystem.STATIC_HOTBAR_ID ) then
			WindowClearAnchors("Hotbar"..hotbarId)
			WindowAddAnchor("Hotbar"..hotbarId, "topleft", "Root", "topleft", HotbarSystem.OffsetX, HotbarSystem.OffsetY)
			HotbarSystem.OffsetY = HotbarSystem.OffsetY + HotbarSystem.OffsetIncrement	
			-- when we get to the top, start over at the bottom
			if( HotbarSystem.OffsetY < 0 ) then
			    HotbarSystem.OffsetY = 910
			end
		end
	end
	if slots and tonumber(slots) then
		WindowSetDimensions("Hotbar" .. hotbarId, Hotbar.BUTTON_SIZE * slots, Hotbar.BUTTON_SIZE)
		Hotbar.OnResizeEnd("Hotbar" .. hotbarId)
	end
	return hotbarId
end

function HotbarSystem.GetNextHotbarId()
	-- find the next available id
	local newHotbarId = 2
	
	while newHotbarId ~= HotbarSystem.MAX_HOTBAR_ID do
		local found = false
		for _, hotbarId in pairs(SystemData.Hotbar.HotbarIds) do
			if( hotbarId == newHotbarId ) then
				found = true
			end
		end
		
		if( found ~= true ) then
			break
		end
		
		newHotbarId = newHotbarId + 1
	end
	
	return newHotbarId
end

function HotbarSystem.RegisterAction(element, hotbarId, itemIndex, subIndex)
	local type = UserActionGetType(hotbarId, itemIndex, subIndex)
	local id = UserActionGetId(hotbarId, itemIndex, subIndex)
	local iconId = UserActionGetIconId(hotbarId, itemIndex, subIndex)
	local disabled = not UserActionIsTargetModeCompat(hotbarId, itemIndex, subIndex)
	
    if( type == SystemData.UserAction.TYPE_USE_ITEM or
	    type == SystemData.UserAction.TYPE_USE_OBJECTTYPE) or id == 5011 then    
		if( HotbarSystem.ObjectSlots[id] == nil ) then
			HotbarSystem.ObjectSlots[id] = {}
			HotbarSystem.ObjectSlotsSize[id] = 0
		end
		HotbarSystem.ObjectSlotsSize[id] = HotbarSystem.ObjectSlotsSize[id] + 1
		HotbarSystem.ObjectSlots[id][element] = {type=type,iconId=iconId}
    elseif( type == SystemData.UserAction.TYPE_MACRO_REFERENCE ) then
		if(	HotbarSystem.MacroReferenceSlots[id] == nil ) then
			HotbarSystem.MacroReferenceSlots[id] = {}
		end
		HotbarSystem.MacroReferenceSlots[id][element] = {hotbarId=hotbarId, itemIndex=itemIndex, subIndex=subIndex}
		
		local macroId = UserActionGetId(hotbarId,itemIndex,0)
		local macroIndex = MacroSystemGetMacroIndexById(macroId)
		disabled = not UserActionIsTargetModeCompat(SystemData.MacroSystem.STATIC_MACRO_ID, macroIndex, 0)
	elseif( type == SystemData.UserAction.TYPE_PLAYER_STATS ) then
		HotbarSystem.PlayerStatsElements[element] = id
	end
	
	HotbarSystem.UpdateActionButton(element, type, id, iconId, disabled )
	HotbarSystem.UpdateTargetTypeIndicator(element,hotbarId,itemIndex,subIndex)
end

function HotbarSystem.UpdateActionButton(element, type, id, iconId, disabled )
	local bDisabled = disabled

	local elementIcon = element.."SquareIcon"
	local elementHotkey = element.."Hotkey"
	local elementOverlay = element.."Overlay"
	
	local custom = Interface.LoadNumber( element .. "Custom", 1 )

	ButtonSetTexture(elementOverlay, InterfaceCore.ButtonStates.STATE_NORMAL,			MiniTexturePack.Overlays[custom].texture, 0, 0)
	ButtonSetTexture(elementOverlay,InterfaceCore.ButtonStates.STATE_NORMAL_HIGHLITE,	MiniTexturePack.Overlays[custom].texture, 0, 0)
	ButtonSetTexture(elementOverlay, InterfaceCore.ButtonStates.STATE_PRESSED,			MiniTexturePack.Overlays[custom].texture, 0, 0)
	ButtonSetTexture(elementOverlay, InterfaceCore.ButtonStates.STATE_PRESSED_HIGHLITE, MiniTexturePack.Overlays[custom].texture, 0, 0)

	
	--Debug.Print("UpdateActionButton: element: "..tostring(element).." actionType: "..tostring(actionType).." actionId: "..tostring(actionId).." iconId: "..tostring(iconId).." isActive: "..tostring(isActive))
	WindowSetShowing(element.."Alert",false)
	-- use item is a crazy special case so handle that first
	if( type == SystemData.UserAction.TYPE_USE_ITEM or
	    type == SystemData.UserAction.TYPE_USE_OBJECTTYPE) then

        local item
		local playerHasItem = false
        local itemHasCharges
		--Debug.Print("Step 1: "..tostring(type))
        if( type == SystemData.UserAction.TYPE_USE_ITEM ) then
		    -- register for this object if its not already registered
		    if( HotbarSystem.RegisteredObjects[element] == nil or not WindowData.ObjectInfo[id]) then
			    RegisterWindowData(WindowData.ObjectInfo.Type, id)
			    HotbarSystem.RegisteredObjects[element] = id		
		    end		    
	        item = WindowData.ObjectInfo[id]
	        playerHasItem = DoesPlayerHaveItem(id)	        	        		    
		    if playerHasItem and item ~= nil and item.quantity == 1 then
				local uses = ItemProperties.GetCharges(id)
				if uses ~= nil then
					itemHasCharges = Knumber(uses[2])
				end
		    end
		elseif( type == SystemData.UserAction.TYPE_USE_OBJECTTYPE ) then
	        -- register for this object if its not already registered
	        if( HotbarSystem.RegisteredGenericObjectType[element] == nil or not WindowData.ObjectTypeQuantity[id] ) then
	        --Debug.Print("REGISTER for OBJECTYPE "..id)
		        RegisterWindowData(WindowData.ObjectTypeQuantity.Type, id)
		        HotbarSystem.RegisteredGenericObjectType[element] = id
	        end	
			
		    item = WindowData.ObjectTypeQuantity[id]
		    playerHasItem = (item~= nil and item.quantity >= 1) 		    
		end
	
		--Debug.Print("Step 2: "..tostring(playerHasItem))
		if( playerHasItem ) then
			--Debug.Print("Step 3: "..tostring(item.name))	
			if( item.quantity ~= nil) then
				--Debug.Print("Step 4: "..tostring(item.quantity))
				if( item.name ~= nil and item.quantity >= 1) then
					--Debug.Print("Step 4: UpdateItemIcon")
                    EquipmentData.UpdateItemIcon(elementIcon, item)
			    end			    
			    LabelSetText(element.."Quantity",L"")
			    if item.quantity < 20 and Interface.LoadBoolean( element .. "EnableAlert", false ) then
					local alpha = 1.5 - (item.quantity / 20)
					WindowSetShowing(element.."Alert",true)
					WindowSetAlpha(element.."Alert", alpha)
				end
				local labelString
			    if (item.quantity > 1) then					
					if (item.quantity >= 1000) then
						local q = item.quantity / 1000
						q = math.floor(q)
						labelString = StringToWString(tostring(q).."K")	
					else
						labelString = StringToWString(tostring(item.quantity))	
					end
					LabelSetText(element.."Quantity",labelString)
				elseif itemHasCharges ~= nil then					
					if (tonumber(itemHasCharges) >= 1000) then
						local q = itemHasCharges / 1000
						q = math.floor(q)
						labelString = StringToWString(tostring(q).."K")	
					else
						labelString = StringToWString(tostring(itemHasCharges))	
					end						
					LabelSetText(element.."Quantity",labelString)
				end
		    end
			
			LabelSetTextColor(elementHotkey,HotbarSystem.DarkItemLabel.r,HotbarSystem.DarkItemLabel.g,HotbarSystem.DarkItemLabel.b)
		-- If its not in your pack anymore just use the icon and disable it
		elseif( iconId ~= 0 and iconId ~= nil ) then
			name, x, y, scale, newWidth, newHeight = RequestTileArt(iconId,50,50)
			DynamicImageSetTextureDimensions(elementIcon, newWidth, newHeight)
			WindowSetDimensions(elementIcon, newWidth, newHeight)
			DynamicImageSetTexture(elementIcon, name, x, y )
			DynamicImageSetTextureScale(elementIcon, scale)
			
			LabelSetTextColor(elementHotkey,HotbarSystem.DarkItemLabel.r,HotbarSystem.DarkItemLabel.g,HotbarSystem.DarkItemLabel.b)
			
			HotbarSystem.ReferencedTextures[element] = iconId	
			
			bDisabled = true
		end
		DynamicImageSetTexture( elementIcon .."BG", MiniTexturePack.DB[MiniTexturePack.Current].texture .. "Icon", 0, 0 )
		WindowSetShowing(elementIcon .."BG", true)
	elseif (type == SystemData.UserAction.TYPE_WEAPON_ABILITY) then
		EquipmentData.RegisterWeaponAbilitySlot(element,id)
		LabelSetTextColor(elementHotkey,HotbarSystem.LightItemLabel.r,HotbarSystem.LightItemLabel.g,HotbarSystem.LightItemLabel.b)
		if( HotbarSystem.Specials[id] == nil ) then
				HotbarSystem.Specials[id] = {}
		end
		HotbarSystem.Specials[id][element] = element
		DynamicImageSetTexture( elementIcon .."BG", MiniTexturePack.DB[MiniTexturePack.Current].texture .. "Icon", 0, 0 )
		WindowSetShowing(elementIcon .."BG", true)
	else
		HotbarSystem.SetHotbarIcon(element, iconId)
		HotbarSystem.RegisterSpellIcon(element,id)
	end
	
	if type == SystemData.UserAction.TYPE_SPELL then
		
		if( HotbarSystem.Spells[id] == nil ) then
				HotbarSystem.Spells[id] = {}
		end
		HotbarSystem.Spells[id][element] = element
	end
	
	if type == SystemData.UserAction.TYPE_SKILL then
		
		if( HotbarSystem.Skills[id] == nil ) then
				HotbarSystem.Skills[id] = {}
		end
		HotbarSystem.Skills[id][element] = element
	end

	if ActionsWindow.isAction(type) then
		id = ActionsWindow.GetIdByType(type)
	end
	
	if (id == 86 and type == SystemData.UserAction.TYPE_BANDAGE_SELF) or (id == 87 and type == SystemData.UserAction.TYPE_BANDAGE_SELECTED_TARGET) then
		if( HotbarSystem.SpecialActions[id] == nil ) then
				HotbarSystem.SpecialActions[id] = {}
		end
		HotbarSystem.SpecialActions[id][element] = element
	end
	
	if id == 5117 then
		if( HotbarSystem.SpecialActions[id] == nil ) then
				HotbarSystem.SpecialActions[id] = {}
		end
		HotbarSystem.SpecialActions[id][element] = element
	end
	
	if id == 5118 then
		if( HotbarSystem.SpecialActions[id] == nil ) then
				HotbarSystem.SpecialActions[id] = {}
		end
		HotbarSystem.SpecialActions[id][element] = element
	end
	
	if id == 3 and type == SystemData.UserAction.TYPE_TOGGLE_WAR_MODE then
		if( HotbarSystem.SpecialActions[id] == nil ) then
				HotbarSystem.SpecialActions[id] = {}
		end
		HotbarSystem.SpecialActions[id][element] = element
	end
	
	if id == 83 and type == SystemData.UserAction.TYPE_TOGGLE_ALWAYS_RUN then
		if( HotbarSystem.SpecialActions[id] == nil ) then
				HotbarSystem.SpecialActions[id] = {}
		end
		HotbarSystem.SpecialActions[id][element] = element
	end
	
	if( bDisabled == true ) then
		WindowSetShowing(element.."Disabled",true)
		WindowSetShowing(element.."Alert",false)
		ButtonSetDisabledFlag(element,true)
	else	
		WindowSetShowing(element.."Disabled",false)
		ButtonSetDisabledFlag(element,false)
	end
	
	--Need to update label here in case iconId changes
	if (type == SystemData.UserAction.TYPE_PLAYER_STATS) then
		HotbarSystem.UpdatePlayerStatLabel(element, id)
	end
	WindowSetScale(elementIcon, InterfaceCore.scale)
end

function HotbarSystem.UpdateTargetTypeIndicator(element,hotbarId,itemIndex,subIndex)
    --Debug.Print("UpdateTargetTypeIndicator: "..tostring(element)..", "..tostring(hotbarId)..", "..tostring(itemIndex)..", "..tostring(subIndex))
	local type = UserActionGetType(hotbarId, itemIndex, subIndex)
	local idC = UserActionGetId(hotbarId, itemIndex, subIndex)
	local notarget = false
	if (type == SystemData.UserAction.TYPE_SPELL and SpellsInfo) then
		for _, value in pairs(SpellsInfo.SpellsData) do
			if value.id == idC then
				notarget = value.notarget
				break
			end
		end
	end
	
	if type == SystemData.UserAction.TYPE_SKILL and (idC == 46 or idC== 32 or idC== 56 or idC== 38 or idC== 21 or idC== 47) then -- meditation, spirit speak, imbuing, tracking, hiding, stealth
		notarget=true
	end
	local elementOverlay = element.."Overlay"
	
	local custom = Interface.LoadNumber( element .. "Custom", 1 )

	ButtonSetTexture(elementOverlay, InterfaceCore.ButtonStates.STATE_NORMAL,			MiniTexturePack.Overlays[custom].texture, 0, 0)
	ButtonSetTexture(elementOverlay,InterfaceCore.ButtonStates.STATE_NORMAL_HIGHLITE,	MiniTexturePack.Overlays[custom].texture, 0, 0)
	ButtonSetTexture(elementOverlay, InterfaceCore.ButtonStates.STATE_PRESSED,			MiniTexturePack.Overlays[custom].texture, 0, 0)
	ButtonSetTexture(elementOverlay, InterfaceCore.ButtonStates.STATE_PRESSED_HIGHLITE, MiniTexturePack.Overlays[custom].texture, 0, 0)


	if( UserActionHasTargetType(hotbarId,itemIndex,subIndex) and SystemData.Settings.GameOptions.legacyTargeting == false and not notarget ) then
	    local targetType = UserActionGetTargetType(hotbarId,itemIndex,subIndex)
	    local tintColor = HotbarSystem.TargetTypeTintColors[targetType]
	    WindowSetTintColor(elementOverlay,0,0,0)
	    WindowSetTintColor(elementOverlay,tintColor[1],tintColor[2],tintColor[3])
	else
		local tintColor = HotbarSystem.TargetTypeTintColors[SystemData.Hotbar.TargetType.TARGETTYPE_NONE]
		WindowSetTintColor(elementOverlay,0,0,0)
	    WindowSetTintColor(elementOverlay,tintColor[1],tintColor[2],tintColor[3])
	end

end

function HotbarSystem.ClearActionIcon(element, hotbarId, itemIndex, subIndex, bUnregister)
	local elementIcon = element.."SquareIcon"
	local elementHotkey = element.."Hotkey"
	
	local id = UserActionGetId(hotbarId, itemIndex, subIndex)

	if HotbarSystem.Spells and HotbarSystem.Spells[id] and HotbarSystem.Spells[id][element] then
		HotbarSystem.Spells[id][element] = nil
	elseif HotbarSystem.Skills and HotbarSystem.Skills[id] and HotbarSystem.Skills[id][element] then
		
		HotbarSystem.Skills[id][element] = nil
	elseif HotbarSystem.Specials and HotbarSystem.Specials[id] and HotbarSystem.Specials[id][element] then
		
		HotbarSystem.Specials[id][element] = nil
	elseif HotbarSystem.Virtues and HotbarSystem.Virtues[id] and HotbarSystem.Virtues[id][element] then
		
		HotbarSystem.Virtues[id][element] = nil
	elseif HotbarSystem.SpecialActions and HotbarSystem.SpecialActions[id] and HotbarSystem.SpecialActions[id][element] then
		
		HotbarSystem.SpecialActions[id][element] = nil
	end
	
	if ( DoesWindowNameExist(element.."Cooldown")) then
		LabelSetText(element.."BandageTime", L"")
		DestroyWindow(element.."Cooldown")
		WindowSetShowing(element .. "Hotkey", true)
		WindowSetShowing(element.."Disabled",false)
		ButtonSetDisabledFlag(element,false)
		WindowSetLayer(element.."Disabled",Window.Layers.OVERLAY)
	end
	
	--Debug.Print("HotbarSystem.ClearActionIcon: "..tostring(element).." hotbarId: "..tostring(hotbarId).." itemIndex: "..tostring(itemIndex).." subIndex: "..tostring(subIndex))
	
	DynamicImageSetTextureDimensions(elementIcon, 50, 50)
	WindowSetDimensions(elementIcon, 50, 50)
	DynamicImageSetTexture(elementIcon, "", 0, 0 )
	DynamicImageSetTextureScale(elementIcon, 0.78 )	
	WindowSetTintColor(elementIcon,255,255,255)
	WindowSetAlpha(elementIcon,1.0)
	
    WindowSetShowing(elementIcon .."BG", false)
    LabelSetText(element.."Quantity",L"")
		
	LabelSetTextColor(elementHotkey,HotbarSystem.DarkItemLabel.r,HotbarSystem.DarkItemLabel.g,HotbarSystem.DarkItemLabel.b)
	
	WindowSetShowing(element.."Disabled",false)
	WindowSetShowing(element.."Alert",false)
	ButtonSetDisabledFlag(element,false)
	
	local tintColor = HotbarSystem.TargetTypeTintColors[SystemData.Hotbar.TargetType.TARGETTYPE_NONE]
	WindowSetTintColor(element.."Overlay",tintColor[1],tintColor[2],tintColor[3])
	
	--Clear the label text when the players stats icon is cleared
	LabelSetText(element.."Stats", L"")
	LabelSetText(element.."StatsTop", L"")
	LabelSetText(element.."StatsBottom",L"")
	HotbarSystem.PlayerStatsElements[element] = nil

	
	if( bUnregister == true ) then
		-- clear the weapon ability (this does nothing if its not a weapon ability)
		EquipmentData.UnregisterWeaponAbilitySlot(element)
		-- clear the spell registration (this does nothing if it is not a spell
		HotbarSystem.UnregisterSpellIcon(element)
		
		-- unregister the object info for this slot if necesary
		if( HotbarSystem.RegisteredObjects[element] ~= nil ) then
			local itemId = HotbarSystem.RegisteredObjects[element]
			--Debug.Print("UNREGISTERING HOTBAR OBJECT: "..tostring(hotbarId)..", "..tostring(itemIndex).." itemId: "..tostring(itemId))
			HotbarSystem.ObjectSlots[itemId][element] = nil
			if( HotbarSystem.ObjectSlots[itemId] ~= nil) then
				if( HotbarSystem.ObjectSlotsSize[itemId] == 1 ) then
					HotbarSystem.ObjectSlots[itemId] = nil
				end
				HotbarSystem.ObjectSlotsSize[itemId] = HotbarSystem.ObjectSlotsSize[itemId] - 1
			end			
			
			UnregisterWindowData(WindowData.ObjectInfo.Type,HotbarSystem.RegisteredObjects[element])
			HotbarSystem.RegisteredObjects[element] = nil
		end
		
		-- unregister the generic object type info for this slot if necesary
		if( HotbarSystem.RegisteredGenericObjectType[element] ~= nil) then
			local itemId = HotbarSystem.RegisteredGenericObjectType[element]
			--Debug.Print("UNREGISTERING HOTBAR OBJECT: "..tostring(hotbarId)..", "..tostring(itemIndex).." itemId: "..tostring(itemId).." element "..element)
			
			HotbarSystem.UpdateQuantityForOneSlot(element)
			HotbarSystem.ObjectSlots[itemId][element] = nil
			if( HotbarSystem.ObjectSlots[itemId] ~= nil) then
				if (HotbarSystem.ObjectSlotsSize[itemId] == 1 ) then
					HotbarSystem.ObjectSlots[itemId] = nil
				end
				HotbarSystem.ObjectSlotsSize[itemId] = HotbarSystem.ObjectSlotsSize[itemId] - 1
			end

			UnregisterWindowData(WindowData.ObjectTypeQuantity.Type,HotbarSystem.RegisteredGenericObjectType[element])
			HotbarSystem.RegisteredGenericObjectType[element] = nil
		end

		WindowSetShowing(element.."Disabled",false)
		ButtonSetDisabledFlag(element,false)
		
		if( HotbarSystem.ReferencedTextures[element] ~= nil ) then
			ReleaseTileArt(HotbarSystem.ReferencedTextures[element])
			HotbarSystem.ReferencedTextures[element] = nil
		end
	end
end

function HotbarSystem.UpdateItemSlot()
	local id = WindowData.UpdateInstanceId
	
	if( HotbarSystem.ObjectSlots[id] ~= nil ) then
		-- if the player has this item then enable it
		if( DoesPlayerHaveItem(id) ) then
			for element, itemLoc in pairs(HotbarSystem.ObjectSlots[id]) do
				if not itemLoc.hotbarId then
					if ActionEditWindow.CurEditItem then
						itemLoc.hotbarId = ActionEditWindow.CurEditItem.hotbarId
						itemLoc.itemIndex = ActionEditWindow.CurEditItem.itemIndex
						itemLoc.subIndex = WindowGetId(element)
					else
						local fnd = string.find(element , "Button")
						if (fnd ~= nil ) then
							itemLoc.hotbarId = tonumber(string.sub(element,7, fnd - 1))
							itemLoc.itemIndex = tonumber(string.sub(element, fnd + 6 ))	
							itemLoc.subIndex = 0
						end	
					end
				end
				WindowSetShowing(element.."Disabled",false)
				ButtonSetDisabledFlag(element,false)
					
				local item = WindowData.ObjectInfo[id]				
				-- also update the image if it isnt set yet
				local elementIcon = element.."SquareIcon"
				-- always update the hue
				DynamicImageSetCustomShader(elementIcon, "UOSpriteUIShader", {item.hueId, item.objectType})
				WindowSetTintColor(elementIcon,item.hue.r,item.hue.g,item.hue.b)
				WindowSetAlpha(elementIcon,item.hue.a/255)	
									
				if( UserActionGetIconId(itemLoc.hotbarId,itemLoc.itemIndex,itemLoc.subIndex) == 0 ) then
                    EquipmentData.UpdateItemIcon(elementIcon, item)
				end	

				if (item.quantity > 1) then					
					if (item.quantity >= 1000) then
						local q = item.quantity / 1000
						q = math.floor(q)
						labelString = StringToWString(tostring(q).."K")	
					else
						labelString = StringToWString(tostring(item.quantity))	
					end
					LabelSetText(element.."Quantity",labelString)
				else
					local itemHasCharges
					local uses = ItemProperties.GetCharges(id)
					if uses ~= nil then
						itemHasCharges = Knumber(uses[2])
						local labelString
						if (tonumber(itemHasCharges) >= 1000) then
							local q = itemHasCharges / 1000
							q = math.floor(q)
							labelString = StringToWString(tostring(q).."K")
						else
							labelString = StringToWString(tostring(itemHasCharges))
						end
						LabelSetText(element.."Quantity",labelString)
					end
			    end	    	
		    end		    
		-- if this item has left the players backpack then disable it
		else
			for element, _ in pairs(HotbarSystem.ObjectSlots[id]) do
				WindowSetShowing(element.."Disabled",true)
				WindowSetShowing(element.."Alert",false)
				ButtonSetDisabledFlag(element,true)
			end
		end
	end
end

function HotbarSystem.SetHotbarIcon(element, iconId)
	local elementIcon = element.."SquareIcon"
	local elementOverlay = element.."Overlay"
	
	local custom = Interface.LoadNumber( element .. "Custom", 1 )

	ButtonSetTexture(elementOverlay, InterfaceCore.ButtonStates.STATE_NORMAL,			MiniTexturePack.Overlays[custom].texture, 0, 0)
	ButtonSetTexture(elementOverlay,InterfaceCore.ButtonStates.STATE_NORMAL_HIGHLITE,	MiniTexturePack.Overlays[custom].texture, 0, 0)
	ButtonSetTexture(elementOverlay, InterfaceCore.ButtonStates.STATE_PRESSED,			MiniTexturePack.Overlays[custom].texture, 0, 0)
	ButtonSetTexture(elementOverlay, InterfaceCore.ButtonStates.STATE_PRESSED_HIGHLITE, MiniTexturePack.Overlays[custom].texture, 0, 0)
	
	if( iconId ~= nil ) then
		WindowSetShowing(elementIcon .."BG", true)
		local texture, x, y = GetIconData( iconId )
		DynamicImageSetTextureDimensions(elementIcon, 50, 50)
		WindowSetDimensions(elementIcon, 50, 50)
		DynamicImageSetTexture( elementIcon, texture, x, y )		
		DynamicImageSetTextureScale(elementIcon, 0.78 )
		
		DynamicImageSetTexture( elementIcon .."BG", MiniTexturePack.DB[MiniTexturePack.Current].texture .. "Icon", 0, 0 )
		LabelSetTextColor(element.."StatsTop", MiniTexturePack.DB[MiniTexturePack.Current].StatLabelColor.r, MiniTexturePack.DB[MiniTexturePack.Current].StatLabelColor.g, MiniTexturePack.DB[MiniTexturePack.Current].StatLabelColor.b)
		LabelSetTextColor(element.."StatsBottom", MiniTexturePack.DB[MiniTexturePack.Current].StatLabelColor.r, MiniTexturePack.DB[MiniTexturePack.Current].StatLabelColor.g, MiniTexturePack.DB[MiniTexturePack.Current].StatLabelColor.b)
		LabelSetTextColor(element.."Stats", MiniTexturePack.DB[MiniTexturePack.Current].StatLabelColor.r, MiniTexturePack.DB[MiniTexturePack.Current].StatLabelColor.g, MiniTexturePack.DB[MiniTexturePack.Current].StatLabelColor.b)
	end
end

function HotbarSystem.UpdatePlayerStatLabel(element, id)
	local statsName = WStringToString(WindowData.PlayerStatsDataCSV[id].name)

	if( WindowData.PlayerStatsDataCSV[id].hasDivider  == true) then
		local curVal = statsName

		local topValue = WindowData.PlayerStatus[curVal]
		local bottomValue = WindowData.PlayerStatus["Max"..statsName]
		if( (statsName == "Health") or (statsName == "Stamina") or (statsName == "Mana") ) then
			curVal = "Current"..statsName
			topValue = WindowData.PlayerStatus[curVal]
			if( topValue <= HotbarSystem.WARNINGLEVEL ) then
				HotbarSystem.SetHotbarIcon(element, WindowData.PlayerStatsDataCSV[id].warningIconId)
			else
				HotbarSystem.SetHotbarIcon(element, WindowData.PlayerStatsDataCSV[id].iconId)
			end	
		end
		
		if( (statsName == "Weight") ) then
			if (topValue >= (bottomValue - HotbarSystem.WARNINGLEVEL) ) then
				HotbarSystem.SetHotbarIcon(element, WindowData.PlayerStatsDataCSV[id].warningIconId)	
			else
				HotbarSystem.SetHotbarIcon(element, WindowData.PlayerStatsDataCSV[id].iconId)
			end
		end
		
		LabelSetText(element.."StatsTop", StringToWString(tostring(topValue))  )
		LabelSetText(element.."StatsBottom", StringToWString(tostring(bottomValue)) )
	else
		local labelString = StringToWString(tostring(WindowData.PlayerStatus[statsName]))
		local cap = WindowData.PlayerStatus["Max"..statsName]
		if cap then
			cap = StringToWString(tostring(cap))
		end
		if(statsName == "Damage") then
			labelString = StringToWString(tostring(WindowData.PlayerStatus[statsName]).."-"..tostring(WindowData.PlayerStatus["Max"..statsName])) 
			cap = nil
		end

		if(statsName == "TithingPoints" or statsName == "Gold")then 
			LabelSetText(element.."Stats", Knumber(WindowData.PlayerStatus[statsName])	 )
		elseif (CharacterSheet.Caps[statsName]) then
			cap = CharacterSheet.Caps[statsName] + CharacterSheet.CapsBonus[statsName]
			LabelSetText(element.."StatsTop", labelString  )
			LabelSetText(element.."StatsBottom", StringToWString(tostring(cap)) )		
		elseif cap  then
			LabelSetText(element.."StatsTop", labelString  )
			LabelSetText(element.."StatsBottom", cap )	
		else
			LabelSetText(element.."Stats", labelString )
		end
	end
end

--Update the players stats on the hotbar when the player stats updates
function HotbarSystem.UpdatePlayerStat()
	for element, id in pairs (HotbarSystem.PlayerStatsElements) do
		HotbarSystem.UpdatePlayerStatLabel(element, id)
	end
end

function HotbarSystem.UpdateQuantityForOneSlot(element)
	LabelSetText(element.."Quantity",L"")
end

function HotbarSystem.UpdateCooldownSlot(element, cooldownTimer, alphaMod, cooldownLabel)
	if( cooldownTimer <= 0 ) then
		--Debug.Print("UpdateCooldownSlot: "..tostring(0))
		LabelSetText(element.."BandageTime", L"")
		if ( DoesWindowNameExist(element.."Cooldown")) then
			DestroyWindow(element.."Cooldown")
			WindowSetShowing(element .. "Hotkey", true)
			WindowSetShowing(element.."Disabled",false)						
			WindowSetLayer(element.."Disabled",Window.Layers.OVERLAY)
		end
	else
		--Debug.Print("UpdateCooldownSlot: "..tostring(cooldownTimer))
		if(cooldownLabel ~= nil)then
			LabelSetText(element.."BandageTime", cooldownLabel)
		else
			LabelSetText(element.."BandageTime", math.ceil(cooldownTimer)..L"s")
		end
		LabelSetTextColor(element.."BandageTime",HotbarSystem.CountdownTimer.r,HotbarSystem.CountdownTimer.g,HotbarSystem.CountdownTimer.b)
		if (not DoesWindowNameExist(element .. "Cooldown")) then
			CreateWindowFromTemplate(element .. "Cooldown", "CooldownEffect", element)
			AnimatedImageStartAnimation(element .. "Cooldown", 2,false,false,0)
			AnimatedImageSetPlaySpeed(element .. "Cooldown", math.max(1, math.floor(Cooldown.Frames/cooldownTimer)))
			WindowSetAlpha(element .. "Cooldown", 0.65)
			WindowSetShowing(element .. "Hotkey", false)
			WindowSetShowing(element.."Disabled",true)						
			WindowClearAnchors(element.."BandageTime")
			WindowAddAnchor(element.."BandageTime", "topleft", element, "topleft", 0, 15)
			WindowSetLayer(element.."BandageTime", Window.Layers.OVERLAY)
			WindowSetLayer(element.."Disabled", Window.Layers.SECONDARY)			
		else
			local alpha = ((cooldownTimer * alphaMod) / 100) / 10
			if alpha > 0.8 then
				alpha = 0.8
			elseif alpha < 0.3 then
				alpha = 0.3
			end
			WindowSetAlpha(element .. "Cooldown", alpha)
		end
	end
end

HotbarSystem.OldQTA = 0
HotbarSystem.QTA = 0
function HotbarSystem.UpdateQuantity()
	local id = WindowData.UpdateInstanceId
	local quantity = 0	
	if( HotbarSystem.ObjectSlots[id] ~= nil ) then
		local item = WindowData.ObjectTypeQuantity[id]		
		if( item ~= nil ) then
			quantity = item.quantity
		end
		local objectType, hue = UserActionUseObjectTypeGetObjectTypeHue(id)
		for element, _ in pairs(HotbarSystem.ObjectSlots[id]) do
			local elementIcon = element.."SquareIcon"
			local oldQuantity = tonumber(LabelGetText(element.."Quantity"))
			local realId = UserActionGetNextObjectId(id)
			if (oldQuantity > 0 ) then
				HotbarSystem.OldQTA = oldQuantity
			end
			if (quantity > 0 ) then
				HotbarSystem.QTA = quantity
			end
			if Interface.LastItem == realId and HotbarSystem.OldQTA ~= HotbarSystem.QTA and HotbarSystem.OldQTA ~= 0 then
				if objectType == 3852 then
					HotbarSystem.HealPotDelayTime = 10					
				elseif objectType == 12247 and hue == 1154 then
					HotbarSystem.GrapeDelayTime = 120
				end
			end
			if(item ~= nil and quantity > 0) then
				if (not DoesWindowNameExist(element .. "Cooldown")) then
					WindowSetShowing(element.."Disabled",false)
					ButtonSetDisabledFlag(element,false)
				end
				
                EquipmentData.UpdateItemIcon(elementIcon, item)
			    
			    if quantity < 20 and Interface.LoadBoolean( element .. "EnableAlert", false ) then
					local alpha = 1.5 - (quantity / 20)
					WindowSetShowing(element.."Alert",true)
					WindowSetAlpha(element.."Alert", alpha)
				else
					WindowSetShowing(element.."Alert",false)
				end
			    
				LabelSetText(element.."Quantity",L"")
				if (quantity > 1) then
		
					local labelString
					if (quantity >= 1000) then
						local q = quantity / 1000
						q = math.floor(q)
						labelString = StringToWString(tostring(q).."K")	
					else
						labelString = StringToWString(tostring(quantity))	
					end
					LabelSetText(element.."Quantity",labelString)	
				end
			else
				WindowSetShowing(element.."Disabled",true)
				WindowSetShowing(element.."Alert",false)
				ButtonSetDisabledFlag(element,true)
				LabelSetText(element.."Quantity",L"")
			end
			
		end
	end
end

function HotbarSystem.HandleUpdateActionItem()
	--Debug.Print("OOO: " .. tostring(SystemData.UpdateActionItem.hotbarId)..", "..tostring(SystemData.UpdateActionItem.itemIndex))
	if( SystemData.UpdateActionItem.hotbarId == SystemData.MacroSystem.STATIC_MACRO_ID ) then
		MacroEditWindow.UpdateMacroActionList("ActionEditMacro", SystemData.UpdateActionItem.hotbarId, SystemData.UpdateActionItem.itemIndex)
	else
		Hotbar.ClearHotbarItem(SystemData.UpdateActionItem.hotbarId,SystemData.UpdateActionItem.itemIndex,true)
		Hotbar.SetHotbarItem(SystemData.UpdateActionItem.hotbarId,SystemData.UpdateActionItem.itemIndex)
	end
end

function HotbarSystem.Update(timePassed)	
	for id, _ in pairs(HotbarSystem.SpecialActions) do
		for key, curElement in pairs(HotbarSystem.SpecialActions[id]) do
			local patt = key
			local fnd = string.find(patt , "Button")
			if (key and fnd ~= nil ) then
				local hotbarId = tonumber(string.sub(patt,7, fnd - 1))
				local itemIndex = tonumber(string.sub(patt, fnd + 6 ))
				if not Hotbar.IsShrunken(hotbarId) then
					if not DoesWindowNameExist(WindowGetParent(key)) then
						HotbarSystem.SpecialActions[id] = nil
					else
						local aId = UserActionGetId(hotbarId,itemIndex,0)
						if aId then
							if( HotbarSystem.SpecialActions[id] == nil ) then
								HotbarSystem.SpecialActions[id] = {}
							end
							local bDisabled = false
							if id == 3 then --TYPE_TOGGLE_WAR_MODE
								WindowSetShowing(curElement.."Alert",WindowData.PlayerStatus.InWarMode)
							end
							if id == 83 then --TYPE_TOGGLE_ALWAYS_RUN
								WindowSetShowing(curElement.."Alert",SystemData.Settings.GameOptions.alwaysRun)
							end

							if id == 86 or id == 87 then --TYPE_BANDAGE_SELF & TYPE_BANDAGE_SELECTED_TARGET
								HotbarSystem.UpdateCooldownSlot(curElement, HotbarSystem.BandageDelayTime)
							end
							if ( DoesWindowNameExist(curElement.."Cooldown") ) then
								WindowSetShowing(curElement .. "Hotkey", false)
								WindowSetShowing(curElement.."Disabled",true)
							elseif bDisabled then
								WindowSetShowing(curElement.."Disabled",bDisabled)
								ButtonSetDisabledFlag(curElement,bDisabled)
							end
						else
							HotbarSystem.SpecialActions[id][key] = nil
						end
					end
				end
			end
		end
	end
	
	for id, _ in pairs (HotbarSystem.ObjectSlots) do
		for curElement, _ in pairs(HotbarSystem.ObjectSlots[id]) do
			local patt = curElement
			local fnd = string.find(patt , "Button")
			if (curElement and fnd ~= nil ) then
				local hotbarId = tonumber(string.sub(patt,7, fnd - 1))				
				if not Hotbar.IsShrunken(hotbarId) then
					local item  = WindowData.ObjectInfo[id]
					if curElement and DoesWindowNameExist(WindowGetParent(curElement)) then
						local objectType, hue = UserActionUseObjectTypeGetObjectTypeHue(id)
						if ( item ~= nil ) then
							hue = item.hueId
						end
						if(objectType == 3617 or objectType == 3817) then -- BANDAGES
							if( HotbarSystem.ObjectSlots[id] == nil ) then
								HotbarSystem.ObjectSlots[id] = {}
							end
							HotbarSystem.UpdateCooldownSlot(curElement, HotbarSystem.BandageDelayTime, 7)
						elseif(objectType == 3852) then -- HEALING POTION
							if( HotbarSystem.ObjectSlots[id] == nil ) then
								HotbarSystem.ObjectSlots[id] = {}
							end
							HotbarSystem.UpdateCooldownSlot(curElement, HotbarSystem.HealPotDelayTime, 10)
						elseif(objectType == 12248 and hue == 1160) then -- ENCHANTED APPLE
							if( HotbarSystem.ObjectSlots[id] == nil ) then
								HotbarSystem.ObjectSlots[id] = {}
							end
							HotbarSystem.UpdateCooldownSlot(curElement, HotbarSystem.AppleDelayTime, 30)
						elseif(objectType == 12247 and hue == 1154) then -- GRAPES OF WRATH
							if( HotbarSystem.ObjectSlots[id] == nil ) then
								HotbarSystem.ObjectSlots[id] = {}
							end
							HotbarSystem.UpdateCooldownSlot(curElement, HotbarSystem.GrapeDelayTime, 120)
						elseif(objectType == 12120 or objectType == 12121 or objectType == 12122 or objectType == 12123 or objectType == 4246) then -- TALISMANS
							if( HotbarSystem.ObjectSlots[id] == nil ) then
								HotbarSystem.ObjectSlots[id] = {}
							end
							local time

							local chargeTime

							local props = ItemProperties.GetObjectPropertiesArray( UserActionGetNextObjectId(id), "container items weight scan" )
							if props  then
								local params = ItemProperties.BuildParamsArray( props )

								for j = 1, #props.PropertiesTids do
									if ItemPropertiesInfo.LifeSpanTid[props.PropertiesTids[j]] then
										local token = ItemPropertiesInfo.LifeSpanTid[props.PropertiesTids[j]]
										local val = tostring(params[props.PropertiesTids[j]][token])

										chargeTime = tonumber(val)
										break
									end
								end
							end
							time = chargeTime
							if time then
								time = time - timePassed
								HotbarSystem.TalismanTimers[curElement] = time
								if time <= 0 then
									HotbarSystem.TalismanTimers[curElement] = nil
									time = nil
								end
							end

							if( not time or time == 0 ) then
								HotbarSystem.UpdateCooldownSlot(curElement, 0)
							else
								local timer
								local min = math.floor(time/60)
								if min > 60 then
									local prefix = ""
									if ((min / 60) - math.floor(min / 60) > 0) then
										prefix = ">"
									end
									local h = math.floor(min / 60)
									timer = StringToWString(prefix .. tostring(h) .. "h")
								elseif min > 0 then
									local prefix = ""
									if (time - (min * 60) > 0) then
										prefix = ">"
									end
									timer = StringToWString(prefix .. tostring(min)	.. "m")
								else
									timer = StringToWString(tostring( math.floor(time))	.. "s")
								end
								HotbarSystem.UpdateCooldownSlot(curElement, time, 1800, timer)
							end
						end
					else
						HotbarSystem.ObjectSlots[id] = nil
					end
				end
			end
		end
	end
	
	for id, _ in pairs(HotbarSystem.Skills) do
		for element, _ in pairs(HotbarSystem.Skills[id]) do
			local patt = element
			local fnd = string.find(patt , "Button")
			if (element and fnd ~= nil ) then
				local hotbarId = tonumber(string.sub(patt,7, fnd - 1))
				if not Hotbar.IsShrunken(hotbarId)then
					if DoesWindowNameExist(WindowGetParent(element)) then
						if( HotbarSystem.Skills[id] == nil ) then
							HotbarSystem.Skills[id] = {}
						end
						WindowSetShowing(element.."Disabled",false)
						WindowSetShowing(element.."Alert",false)
						HotbarSystem.UpdateCooldownSlot(element, HotbarSystem.SkillDelayTime, HotbarSystem.SkillDelayTimeMax)
					else
						HotbarSystem.Skills[id] = nil
					end
				end
			end
		end
	end
	
	for id, _ in pairs(HotbarSystem.Spells) do
		for element, _ in pairs(HotbarSystem.Spells[id]) do
			local patt = element
			local fnd = string.find(patt , "Button")
			if (element and fnd ~= nil ) then
				local hotbarId = tonumber(string.sub(patt,7, fnd - 1))
				local itemIndex = tonumber(string.sub(patt, fnd + 6 ))
				if not Hotbar.IsShrunken(hotbarId)then
					if DoesWindowNameExist(WindowGetParent(element)) then
						if( HotbarSystem.Spells[id] == nil ) then
							HotbarSystem.Spells[id] = {}
						end

						local type = UserActionGetType(hotbarId, itemIndex, 1)
						local idC = UserActionGetId(hotbarId, itemIndex, 1)
						WindowSetTintColor(element.."Disabled", 255,255,255)

						if ( not HotbarHasItem(hotbarId, itemIndex) or id ~= idC or type ~= SystemData.UserAction.TYPE_SPELL ) then
							HotbarSystem.Spells[id][element] = nil
							WindowSetShowing(element.."Disabled",false)
						else
							local distance = -1
							for _, value in pairs(SpellsInfo.SpellsData) do
								if value.id== id then
									distance = value.distance
									break
								end
							end

							local infoSkillId = SpellsInfo.GetSkillID(id)
							if(infoSkillId == nil)then
								return
							end

							if(id == 403) then -- EVASION
								if( HotbarSystem.ObjectSlots[id] == nil ) then
									HotbarSystem.ObjectSlots[id] = {}
								end
								HotbarSystem.UpdateCooldownSlot(element, HotbarSystem.EvasionCooldown, 16)
							elseif(id == 604) then -- ATTUNEMENT
								if( HotbarSystem.ObjectSlots[id] == nil ) then
									HotbarSystem.ObjectSlots[id] = {}
								end
								HotbarSystem.UpdateCooldownSlot(element, HotbarSystem.AttunementCooldown, 120)
							elseif(id == 613) then -- ETHEREAL VOYAGE
								if( HotbarSystem.ObjectSlots[id] == nil ) then
									HotbarSystem.ObjectSlots[id] = {}
								end
								HotbarSystem.UpdateCooldownSlot(element, HotbarSystem.EtherealVoyageCooldown, 300)
							elseif(id == 36) then -- MAGIC REFLECTION
								if( HotbarSystem.ObjectSlots[id] == nil ) then
									HotbarSystem.ObjectSlots[id] = {}
								end
								HotbarSystem.UpdateCooldownSlot(element, HotbarSystem.ReflectionCooldown, 30)
							end

							if (id == 56 or id == 106 or id == 107 or id == 116 or id == 609 or id == 613 or id == 685 or id == 508 ) and BuffDebuff.BuffWindowId[1054] then -- FLYING RESTRICTIONS
								WindowSetShowing(element.."Disabled",true)
								WindowSetShowing(element.."Alert",false)
							elseif id == 604 and BuffDebuff.Timers[1021] then -- ATTUNE_WEAPON
								WindowSetShowing(element.."Disabled",true)
								WindowSetShowing(element.."Alert",false)
							elseif id == 613 and BuffDebuff.Timers[1024] then -- ETHEREAL_VOYAGE
								WindowSetShowing(element.."Disabled",true)
								WindowSetShowing(element.."Alert",false)
							elseif id == 681 and BuffDebuff.Timers[1091] then -- ENCHANT
								WindowSetShowing(element.."Disabled",true)
								WindowSetShowing(element.."Alert",false)
							elseif Interface.CurrentSpell.casting then
								WindowSetShowing(element.."Disabled",true)
								WindowSetShowing(element.."Alert",false)
							elseif (distance and distance >= 0) and WindowData.CurrentTarget.TargetId then
								local targetType = UserActionGetTargetType(hotbarId,itemIndex,1)
								if targetType and targetType == SystemData.Hotbar.TargetType.TARGETTYPE_CURRENT then
									bDisabled= GetDistanceFromPlayer(WindowData.CurrentTarget.TargetId) > distance and not DoesPlayerHaveItem(WindowData.CurrentTarget.TargetId)
								elseif targetType and targetType == SystemData.Hotbar.TargetType.TARGETTYPE_OBJECT_ID then
									local targ = UserActionGetTargetId(hotbarId,itemIndex,1)
									bDisabled= GetDistanceFromPlayer(targ) > distance and not DoesPlayerHaveItem(targ)
								else
									bDisabled = false
								end
								if( bDisabled == true ) then
									WindowSetShowing(element.."Disabled",true)
									WindowSetShowing(element.."Alert",false)
								else
									WindowSetShowing(element.."Disabled",false)
								end
							elseif not DoesWindowNameExist(element.."Cooldown") then
								WindowSetShowing(element.."Disabled",false)
								ButtonSetDisabledFlag(element,false)
							end
						end
					else
						HotbarSystem.Spells[id] = nil
					end
				end
			end
		end
	end
	
	for id, _ in pairs(HotbarSystem.Specials) do
		for element, _ in pairs(HotbarSystem.Specials[id]) do
			local patt = element
			local fnd = string.find(patt , "Button")
			if (element and fnd ~= nil ) then
				local hotbarId = tonumber(string.sub(patt,7, fnd - 1))
				local itemIndex = tonumber(string.sub(patt, fnd + 6 ))
				if not Hotbar.IsShrunken(hotbarId) then
					if DoesWindowNameExist(WindowGetParent(element)) then
						if( HotbarSystem.Specials[id] == nil ) then
							HotbarSystem.Specials[id] = {}
						end

						local type = UserActionGetType(hotbarId, itemIndex, 1)
						local idC = UserActionGetId(hotbarId, itemIndex, 1)
						WindowSetTintColor(element.."Disabled", 255,255,255)
						if ( not HotbarHasItem(hotbarId, itemIndex) or id ~= idC or type ~= SystemData.UserAction.TYPE_WEAPON_ABILITY ) then
							HotbarSystem.Specials[id][element] = nil
							WindowSetShowing(element.."Disabled",false)
							ButtonSetDisabledFlag(element,false)
						else
							local mhandId  = 0
							if WindowData.Paperdoll[WindowData.PlayerStatus.PlayerId] then
								mhandId = WindowData.Paperdoll[WindowData.PlayerStatus.PlayerId][4].slotId
							end
							local lance = false
							if mhandId ~= 0 then

								RegisterWindowData(WindowData.ObjectInfo.Type, mhandId)
								local objType = WindowData.ObjectInfo[mhandId].objectType
								if objType == 18634 or objType == 18635 or objType == 9920 or objType == 9930 then
									lance = true
								end
								UnregisterWindowData(WindowData.ObjectInfo.Type, mhandId)
							end
							if (EquipmentData.GetWeaponAbilityId(id) == 22 ) and not (BuffDebuff.BuffWindowId[1054] or IsRiding()) then
								WindowSetShowing(element.."Disabled",true)
								WindowSetShowing(element.."Alert",false)
							elseif (EquipmentData.GetWeaponAbilityId(id) == 6 ) and (BuffDebuff.BuffWindowId[1054] or IsRiding()) and not lance then
								WindowSetShowing(element.."Disabled",true)
								WindowSetShowing(element.."Alert",false)
							elseif IsPlayerDead() then
								WindowSetShowing(element.."Disabled",true)
								WindowSetShowing(element.."Alert",false)
							elseif Interface.CurrentSpell.casting then
								WindowSetShowing(element.."Disabled",true)
								WindowSetShowing(element.."Alert",false)
							else
								WindowSetShowing(element.."Disabled",false)
								ButtonSetDisabledFlag(element,false)
							end
						end
					else
						HotbarSystem.Specials[id] = nil
					end
				end
			end
		end
	end
end

function HotbarSystem.UpdateMacroReferenceSlot(macroIndex)
	local id = WindowData.UpdateInstanceId
	if(macroIndex ~= nil) then
		id = macroIndex
	end
	
	if( HotbarSystem.MacroReferenceSlots[id] ~= nil ) then
		macroIndex = MacroSystemGetMacroIndexById(id)
		
		for element, itemLoc in pairs(HotbarSystem.MacroReferenceSlots[id]) do
			-- if macroIndex is 0 then the macro was deleted
			if( macroIndex == 0 ) then
				HotbarSystem.ClearActionIcon(element, itemLoc.hotbarId, itemLoc.itemIndex, itemLoc.subIndex, true)
				-- right now macro references can only exist in the hotbar
				HotbarClearItem(itemLoc.hotbarId,itemLoc.itemIndex)
			-- else the icon might have changed so reset it
			else
				HotbarSystem.RegisterAction(element, itemLoc.hotbarId, itemLoc.itemIndex, itemLoc.subIndex)
			end
		end
	end
end

function HotbarSystem.CreateUserActionContextMenuOptions(hotbarId, itemIndex, subIndex, slotWindow)
	local actionType = UserActionGetType(hotbarId,itemIndex,subIndex)

	--Debug.Print("HotbarSystem.CreateUserActionContextMenuOptions: "..tostring(hotbarId)..", "..tostring(itemIndex)..", "..tostring(subIndex).." actionType: "..tostring(actionType))
	
	local actionId = UserActionGetId(hotbarId,itemIndex,subIndex)
	
	local param = {HotbarId=hotbarId, ItemIndex=itemIndex, SubIndex=subIndex, SlotWindow=slotWindow, ActionType=actionType}
	
	local type = UserActionGetType(hotbarId, itemIndex, subIndex)
	local idC = actionId
	local cursorOnly=false
	local noSelf=false
	local notarget = false
	if (type == SystemData.UserAction.TYPE_SPELL) then
		for _, value in pairs(SpellsInfo.SpellsData) do
			if value.id == idC then
				notarget = value.notarget
				noSelf = value.noSelf
				cursorOnly = value.cursorOnly
				break
			end
		end
	end
	
	if type == SystemData.UserAction.TYPE_SKILL and idC ~= 9 then
		noSelf=true
	end
	
	if type == SystemData.UserAction.TYPE_SKILL and (idC== 46 or idC== 32 or idC== 56 or idC== 38 or idC== 21 or idC== 47) then -- meditation, spirit speak, imbuing, tracking, hiding, stealth
		notarget=true
	end
	--Debug.Print(type)
	if( type == SystemData.UserAction.TYPE_USE_ITEM or type == SystemData.UserAction.TYPE_USE_OBJECTTYPE ) then
		
		if Interface.LoadBoolean( "Hotbar" .. hotbarId .. "Button" .. itemIndex .. "EnableAlert", false ) then
			ContextMenu.CreateLuaContextMenuItemWithString(GetStringFromTid(1155010),0,"toggleAlert", param,false)
			
		else
			ContextMenu.CreateLuaContextMenuItemWithString(GetStringFromTid(1155009),0,"toggleAlert",param, false)
		end
	end
	
	if not Interface.LoadBoolean("Hotbar" .. hotbarId .. "_IsBlockbar", false) then
		ContextMenu.CreateLuaContextMenuItem(HotbarSystem.TID_CLEAR_ITEM,0,HotbarSystem.ContextReturnCodes.CLEAR_ITEM,param)
	end
	
	if( ( UserActionHasTargetType(hotbarId,itemIndex,subIndex) ) and ( SystemData.Settings.GameOptions.legacyTargeting == false ) and (not notarget) ) then
		local targetType = UserActionGetTargetType(hotbarId,itemIndex,subIndex)
		-- determine which target type is pressed (add one to type for 1 based lua array)
		local pressed = { false, false, false, false }
		pressed[targetType+1] = true
		--Debug.Print("TargetType: "..targetType)
		local subMenu = {
			{ tid = HotbarSystem.TID_SELF,flags=0,returnCode=HotbarSystem.ContextReturnCodes.TARGET_SELF,param=param,pressed=pressed[1+SystemData.Hotbar.TargetType.TARGETTYPE_SELF] },
			{ tid = HotbarSystem.TID_CURSOR,flags=0,returnCode=HotbarSystem.ContextReturnCodes.TARGET_CURSOR,param=param,pressed=pressed[1+SystemData.Hotbar.TargetType.TARGETTYPE_CURSOR] },
			{ tid = HotbarSystem.TID_OBJECT_ID,flags=0,returnCode=HotbarSystem.ContextReturnCodes.TARGET_OBJECT_ID,param=param,pressed=pressed[1+SystemData.Hotbar.TargetType.TARGETTYPE_OBJECT_ID] },
			{ tid = HotbarSystem.TID_CURRENT,flags=0,returnCode=HotbarSystem.ContextReturnCodes.TARGET_CURRENT,param=param,pressed=pressed[1+SystemData.Hotbar.TargetType.TARGETTYPE_CURRENT] } }

		
		if (cursorOnly) then
			subMenu = {
			{ tid = HotbarSystem.TID_CURSOR,flags=0,returnCode=HotbarSystem.ContextReturnCodes.TARGET_CURSOR,param=param,pressed=pressed[1+SystemData.Hotbar.TargetType.TARGETTYPE_CURSOR] } }
			
		elseif (noSelf) then
			subMenu = {
			{ tid = HotbarSystem.TID_CURSOR,flags=0,returnCode=HotbarSystem.ContextReturnCodes.TARGET_CURSOR,param=param,pressed=pressed[1+SystemData.Hotbar.TargetType.TARGETTYPE_CURSOR] },
			{ tid = HotbarSystem.TID_OBJECT_ID,flags=0,returnCode=HotbarSystem.ContextReturnCodes.TARGET_OBJECT_ID,param=param,pressed=pressed[1+SystemData.Hotbar.TargetType.TARGETTYPE_OBJECT_ID] },
			{ tid = HotbarSystem.TID_CURRENT,flags=0,returnCode=HotbarSystem.ContextReturnCodes.TARGET_CURRENT,param=param,pressed=pressed[1+SystemData.Hotbar.TargetType.TARGETTYPE_CURRENT] } }

		end
		ContextMenu.CreateLuaContextMenuItem(HotbarSystem.TID_TARGET,0,0,param,false,subMenu) 
	end	
	
	-- if its a macro reference, we need to dereference it for the edit window
	local editParam = {HotbarId=hotbarId, ItemIndex=itemIndex, SubIndex=subIndex, SlotWindow=slotWindow, ActionType=actionType}
	if( actionType == SystemData.UserAction.TYPE_MACRO_REFERENCE ) then
		local macroId = UserActionGetId(hotbarId,itemIndex,0)
		local macroIndex = MacroSystemGetMacroIndexById(macroId)
		editParam.ActionType = SystemData.UserAction.TYPE_MACRO
		editParam.HotbarId = SystemData.MacroSystem.STATIC_MACRO_ID
		editParam.ItemIndex = macroIndex
		if not UserActionMacroGetRepeatEnabled( editParam.HotbarId, editParam.ItemIndex ) then
			ContextMenu.CreateLuaContextMenuItem(HotbarSystem.TID_ENABLE_REPEAT,0,HotbarSystem.ContextReturnCodes.ENABLE_REPEAT,editParam)
		else
			ContextMenu.CreateLuaContextMenuItem(HotbarSystem.TID_DISABLE_REPEAT,0,HotbarSystem.ContextReturnCodes.DISABLE_REPEAT,editParam)
		end
	end		
		
	if type == SystemData.UserAction.TYPE_SPELL  and actionId == 681 then -- enchant
		local press = Interface.ForceEnchant
		local subMenu = {
		{ str = GetStringFromTid(1080133),flags=0,returnCode="enchant0",param=param,pressed=press==0,false }; -- Select Enchant
		{ str = GetStringFromTid(1079702),flags=0,returnCode="enchant1",param=param,pressed=press==1,false }; -- Hit Dispel
		{ str = GetStringFromTid(1079703),flags=0,returnCode="enchant2",param=param,pressed=press==2,false }; -- Hit Fireball
		{ str = GetStringFromTid(1079704),flags=0,returnCode="enchant3",param=param,pressed=press==3,false }; -- Hit Harm
		{ str = GetStringFromTid(1079705),flags=0,returnCode="enchant4",param=param,pressed=press==4,false }; -- Hit Lightning
		{ str = GetStringFromTid(1079706),flags=0,returnCode="enchant5",param=param,pressed=press==5,false }; -- Hit Magic Arrow
		}
		ContextMenu.CreateLuaContextMenuItemWithString(GetStringFromTid(1080133),0,0,"null",false,subMenu)
	end
	
	if type == SystemData.UserAction.TYPE_SPELL  and actionId == 503 then -- animal form
		local press = Interface.ForceAnimal
		if SpellsInfo.AnimalFormSkillRequirements(Interface.ForceAnimal) == 1 then
			press = 0
		end

		local subMenu = {
			{ str = FormatProperly(GetStringFromTid(1078861)),flags=0,returnCode="animalForm0",param=param,pressed=press==0,false }; -- Select
			{ str = FormatProperly(GetStringFromTid(1028485)),flags=SpellsInfo.AnimalFormSkillRequirements(1028485),returnCode="animalForm1028485",param=param,pressed=press==1028485,false }; -- Rabbit
			{ str = FormatProperly(GetStringFromTid(1028483)),flags=SpellsInfo.AnimalFormSkillRequirements(1028483),returnCode="animalForm1028483",param=param,pressed=press==1028483,false }; -- Rat
			{ str = FormatProperly(GetStringFromTid(1075971)),flags=SpellsInfo.AnimalFormSkillRequirements(1075971),returnCode="animalForm1075971",param=param,pressed=press==1075971,false }; -- squirrel
			{ str = FormatProperly(GetStringFromTid(1018280)),flags=SpellsInfo.AnimalFormSkillRequirements(1018280),returnCode="animalForm1018280",param=param,pressed=press==1018280,false }; -- Dog
			{ str = FormatProperly(GetStringFromTid(1018264)),flags=SpellsInfo.AnimalFormSkillRequirements(1018264),returnCode="animalForm1018264",param=param,pressed=press==1018264,false }; -- Cat
			{ str = FormatProperly(GetStringFromTid(1075972)),flags=SpellsInfo.AnimalFormSkillRequirements(1075972),returnCode="animalForm1075972",param=param,pressed=press==1075972,false }; -- ferret
			{ str = FormatProperly(GetStringFromTid(1028496)),flags=SpellsInfo.AnimalFormSkillRequirements(1028496),returnCode="animalForm1028496",param=param,pressed=press==1028496,false }; -- Bullfrog
			{ str = FormatProperly(GetStringFromTid(1018114)),flags=SpellsInfo.AnimalFormSkillRequirements(1018114),returnCode="animalForm1018114",param=param,pressed=press==1018114,false }; -- Giant Serpent
			{ str = FormatProperly(GetStringFromTid(1031670)),flags=SpellsInfo.AnimalFormSkillRequirements(1031670),returnCode="animalForm1031670",param=param,pressed=press==1031670,false }; -- cu sidhe
			{ str = FormatProperly(GetStringFromTid(1028438)),flags=SpellsInfo.AnimalFormSkillRequirements(1028438),returnCode="animalForm1028438",param=param,pressed=press==1028438,false }; -- Llama
			{ str = FormatProperly(GetStringFromTid(1018273)),flags=SpellsInfo.AnimalFormSkillRequirements(1018273),returnCode="animalForm1018273",param=param,pressed=press==1018273,false }; -- Ostard
			{ str = FormatProperly(GetStringFromTid(1030083)),flags=SpellsInfo.AnimalFormSkillRequirements(1030083),returnCode="animalForm1030083",param=param,pressed=press==1030083,false }; -- Bake-Kitsune
			{ str = FormatProperly(GetStringFromTid(1028482)),flags=SpellsInfo.AnimalFormSkillRequirements(1028482),returnCode="animalForm1028482",param=param,pressed=press==1028482,false }; -- Wolf
			{ str = FormatProperly(GetStringFromTid(1075202)),flags=SpellsInfo.AnimalFormSkillRequirements(1075202),returnCode="animalForm1075202",param=param,pressed=press==1075202,false }; -- reptalon
			{ str = FormatProperly(GetStringFromTid(1029632)),flags=SpellsInfo.AnimalFormSkillRequirements(1029632),returnCode="animalForm1029632",param=param,pressed=press==1029632,false }; -- Kirin
			{ str = FormatProperly(GetStringFromTid(1018214)),flags=SpellsInfo.AnimalFormSkillRequirements(1018214),returnCode="animalForm1018214",param=param,pressed=press==1018214,false }; -- Unicorn 
		}
		ContextMenu.CreateLuaContextMenuItemWithString(WindowUtils.translateMarkup(GetStringFromTid(1063394)),0,0,"null",false,subMenu)
	end
	
	if type == SystemData.UserAction.TYPE_SPELL  and actionId == 686 then -- spell trigger
		local press = Interface.ForceSpellTrigger
		local subMenu = {
			{ str = FormatProperly(WindowUtils.translateMarkup(GetStringFromTid(1078861))),flags=0,returnCode="spellTrigger0",param=param,pressed=press==0,false }; -- Select
		}
		
		local tempSubMenu = {}
		for _, tab in pairs(SpellsInfo.SpellsData) do
			if tab.id >= 678 and tab.id <= 700 and tab.spellTrigger then
				
				local _, serverId, tid, _, _, _, _, minskill, _ = GetAbilityData(tab.id)
				local skillId = 37
				local skillIdsec = 26 -- imbuing
				local skillIdthi= 21 -- focus
				
				serverId = WindowData.SkillsCSV[skillId].ServerId
				local mainSkillLevel = WindowData.SkillDynamicData[serverId].TempSkillValue / 10
				local mobileData = Interface.GetMobileData(WindowData.PlayerStatus.PlayerId, true)
				if mobileData and mobileData.Race == PaperdollWindow.HUMAN and mainSkillLevel < 20 then
					mainSkillLevel = 20
				end
				
				serverId = WindowData.SkillsCSV[skillIdsec].ServerId
				local secondSkillLevel = WindowData.SkillDynamicData[serverId].TempSkillValue / 10
				
				local serverIdthi = WindowData.SkillsCSV[skillIdthi].ServerId
				local tempSkillLevel = WindowData.SkillDynamicData[serverIdthi].TempSkillValue / 10
				secondSkillLevel = math.max(tempSkillLevel,secondSkillLevel)
				
				if mobileData and mobileData.Race == PaperdollWindow.HUMAN and secondSkillLevel < 20 then
					secondSkillLevel = 20
				end
				
				local cando = 1
				if minskill <= 20 or (minskill <= mainSkillLevel and minskill <= secondSkillLevel) then
					cando = 0
				end
				local menu = { str = FormatProperly(GetStringFromTid(tid)),flags=cando,param=param,false };
				tempSubMenu[tab.id] = menu
				
			end
		end
		local buttonId = 2
		for _, menu in pairsByKeys(tempSubMenu) do
			menu.returnCode = "spellTrigger".. buttonId
			if press == buttonId and menu.flags == 1 then
				subMenu[1].pressed = true
				press = 0
			end
			menu.pressed=press==buttonId
			table.insert(subMenu, menu)
			buttonId = buttonId + 1
			if buttonId == 12 then
				buttonId = 14
			end
		end
		
		ContextMenu.CreateLuaContextMenuItemWithString(WindowUtils.translateMarkup(GetStringFromTid(1080151)),0,0,"null",false,subMenu)
	end
	
	if type == SystemData.UserAction.TYPE_SPELL  and actionId == 56 then -- polymorph
		local press = Interface.ForcePolymorph

		local subMenu = {
			{ str = FormatProperly(GetStringFromTid(1078861)),flags=0,returnCode="polymorph0",	param=param,pressed=press==0,false }; -- Select
			{ str = FormatProperly(GetStringFromTid(1015236)),flags=0,returnCode="polymorph1",	param=param,pressed=press==1,false }; -- Chicken
			{ str = FormatProperly(GetStringFromTid(1015237)),flags=0,returnCode="polymorph2",	param=param,pressed=press==2,false }; -- Dog
			{ str = FormatProperly(GetStringFromTid(1015238)),flags=0,returnCode="polymorph3",	param=param,pressed=press==3,false }; -- Wolf
			{ str = FormatProperly(GetStringFromTid(1015239)),flags=0,returnCode="polymorph4",	param=param,pressed=press==4,false }; -- Panther
			{ str = FormatProperly(GetStringFromTid(1015240)),flags=0,returnCode="polymorph5",	param=param,pressed=press==5,false }; -- Gorilla
			{ str = FormatProperly(GetStringFromTid(1015241)),flags=0,returnCode="polymorph6",	param=param,pressed=press==6,false }; -- Black Bear
			{ str = FormatProperly(GetStringFromTid(1015242)),flags=0,returnCode="polymorph7",	param=param,pressed=press==7,false }; -- Grizzly Bear
			{ str = FormatProperly(GetStringFromTid(1015243)),flags=0,returnCode="polymorph8",	param=param,pressed=press==8,false }; -- Polar Bear
			{ str = FormatProperly(GetStringFromTid(1015244)),flags=0,returnCode="polymorph9",	param=param,pressed=press==9,false }; -- Human Male
			{ str = FormatProperly(GetStringFromTid(1015254)),flags=0,returnCode="polymorph10",	param=param,pressed=press==10,false }; -- Human Female
			{ str = FormatProperly(GetStringFromTid(1015246)),flags=0,returnCode="polymorph11",	param=param,pressed=press==11,false }; -- Slime
			{ str = FormatProperly(GetStringFromTid(1015247)),flags=0,returnCode="polymorph12",	param=param,pressed=press==12,false }; -- Orc
			{ str = FormatProperly(GetStringFromTid(1015248)),flags=0,returnCode="polymorph13",	param=param,pressed=press==13,false }; -- Lizard Man
			{ str = FormatProperly(GetStringFromTid(1015249)),flags=0,returnCode="polymorph14",	param=param,pressed=press==14,false }; -- Gargoyle
			{ str = FormatProperly(GetStringFromTid(1015250)),flags=0,returnCode="polymorph15",	param=param,pressed=press==15,false }; -- Ogre
			{ str = FormatProperly(GetStringFromTid(1015251)),flags=0,returnCode="polymorph16",	param=param,pressed=press==16,false }; -- Troll
			{ str = FormatProperly(GetStringFromTid(1015252)),flags=0,returnCode="polymorph17",	param=param,pressed=press==17,false }; -- Ettin
			{ str = FormatProperly(GetStringFromTid(1015253)),flags=0,returnCode="polymorph18",	param=param,pressed=press==18,false }; -- Daemon
		}
		ContextMenu.CreateLuaContextMenuItemWithString(WindowUtils.translateMarkup(GetStringFromTid(1015234)),0,0,"null",false,subMenu)
	end
	
	if type == SystemData.UserAction.TYPE_SPELL  and actionId == 112 then -- summon familiar
		local press = Interface.ForceFamiliar
		if SpellsInfo.SumonFamiliarSkillRequirements(Interface.ForceFamiliar) == 1 then
			press = 0
		end
		
		local subMenu = {
		{ str = GetStringFromTid(1078861),flags=0,returnCode="familiar0",param=param,pressed=press==0,false }; -- Select
		{ str = GetStringFromTid(1060146),flags=SpellsInfo.SumonFamiliarSkillRequirements(1),returnCode="familiar1",param=param,pressed=press==1,false }; -- Horde Minion
		{ str = GetStringFromTid(1060142),flags=SpellsInfo.SumonFamiliarSkillRequirements(2),returnCode="familiar2",param=param,pressed=press==2,false }; -- Shadow Wisp
		{ str = GetStringFromTid(1060143),flags=SpellsInfo.SumonFamiliarSkillRequirements(3),returnCode="familiar3",param=param,pressed=press==3,false }; -- Dark Wolf
		{ str = GetStringFromTid(1060145),flags=SpellsInfo.SumonFamiliarSkillRequirements(4),returnCode="familiar4",param=param,pressed=press==4,false }; -- Death Adder
		{ str = GetStringFromTid(1060144),flags=SpellsInfo.SumonFamiliarSkillRequirements(5),returnCode="familiar5",param=param,pressed=press==5,false }; -- Vampire Bat
		}
		ContextMenu.CreateLuaContextMenuItemWithString(GetStringFromTid(1060147),0,0,"null",false,subMenu)
	end
	
	if ActionsWindow.isAction(actionType) then

		local actionData = ActionsWindow.GetActionDataForID(actionId)
		if not actionData then
			actionData = ActionsWindow.GetActionDataForType(editParam.ActionType)
		end
		if( actionData ~= nil  ) then
			
			if actionId < 5000 or not actionData.callback then
				if actionId < 5000 and actionData.editWindow ~= nil then
					ContextMenu.CreateLuaContextMenuItem(HotbarSystem.TID_EDIT_ITEM,0,HotbarSystem.ContextReturnCodes.EDIT_ITEM,editParam)
				else
					ContextMenu.CreateLuaContextMenuItem(HotbarSystem.TID_EDIT_ITEM,0,HotbarSystem.ContextReturnCodes.EDIT_ITEM,editParam)
				end
			else
				if (actionId == 5732) then
					local subMenu = {}
					for i=1, Organizer.Organizers do
						local name = ReplaceTokens(GetStringFromTid(1155442), {towstring( i ) } )
						if (Organizer.Organizers_Desc[i] ~= L"") then
							name = Organizer.Organizers_Desc[i]
						end
						item = { str = name,flags=0,returnCode="org" .. i,param=param,pressed=Organizer.ActiveOrganizer == i,false }
						table.insert(subMenu, item)
					end
					
					ContextMenu.CreateLuaContextMenuItemWithString(GetStringFromTid(1155130),0,0,"null",false,subMenu)
				elseif (actionId == 5733) then
					local subMenu = {}
					for i=1, Organizer.Undresses do
						local name = L"Use Undress " .. i
						if (Organizer.Undresses_Desc[i] ~= L"") then
							name = Organizer.Undresses_Desc[i]
						end
						item = { str = name,flags=0,returnCode="undr" .. i,param=param,pressed=Organizer.ActiveUndress == i,false }
						table.insert(subMenu, item)
					end
					
					ContextMenu.CreateLuaContextMenuItemWithString(GetStringFromTid(1155232),0,0,"null",false,subMenu)
				end
			end
		end
	end
	
end

function HotbarSystem.ContextMenuCallback(returnCode,param)
	local bHandled = true
	
	if( returnCode == HotbarSystem.ContextReturnCodes.TARGET_SELF ) then
		UserActionSetTargetType(param.HotbarId,param.ItemIndex,param.SubIndex,SystemData.Hotbar.TargetType.TARGETTYPE_SELF)
		HotbarSystem.UpdateTargetTypeIndicator(param.SlotWindow,param.HotbarId,param.ItemIndex,param.SubIndex)
	elseif( returnCode == HotbarSystem.ContextReturnCodes.TARGET_CURRENT ) then
		UserActionSetTargetType(param.HotbarId,param.ItemIndex,param.SubIndex,SystemData.Hotbar.TargetType.TARGETTYPE_CURRENT)
		HotbarSystem.UpdateTargetTypeIndicator(param.SlotWindow,param.HotbarId,param.ItemIndex,param.SubIndex)
	elseif( returnCode == HotbarSystem.ContextReturnCodes.TARGET_CURSOR ) then
		UserActionSetTargetType(param.HotbarId,param.ItemIndex,param.SubIndex,SystemData.Hotbar.TargetType.TARGETTYPE_CURSOR)
		HotbarSystem.UpdateTargetTypeIndicator(param.SlotWindow,param.HotbarId,param.ItemIndex,param.SubIndex)
	elseif( returnCode == HotbarSystem.ContextReturnCodes.TARGET_OBJECT_ID ) then
		HotbarSystem.RequestTargetInfo(param.SlotWindow,param.HotbarId,param.ItemIndex,param.SubIndex)
	elseif( returnCode == HotbarSystem.ContextReturnCodes.EDIT_ITEM ) then
		local actionId = UserActionGetId(param.HotbarId,param.ItemIndex,param.SubIndex)
		if (actionId == 5207) then
			Actions.ActionEditRequest = {ActionId = actionId, HotbarId = param.HotbarId, ItemIndex = param.ItemIndex, SubIndex = param.SubIndex}
			Actions.TargetType()
		elseif (actionId >= 5500 and actionId < 5600) then
			Actions.ActionEditRequest = {ActionId = actionId, HotbarId = param.HotbarId, ItemIndex = param.ItemIndex, SubIndex = param.SubIndex}
			Actions.TargetPetball()
		elseif (actionId >= 5600 and actionId < 5700) or (actionId >= 5800 and actionId < 5900) or actionId == 5156 or actionId == 5736 then
			Actions.ActionEditRequest = {ActionId = actionId, HotbarId = param.HotbarId, ItemIndex = param.ItemIndex, SubIndex = param.SubIndex}
			Actions.TargetMount()
		else
			WindowSetShowing("ActionsWindow",true) -- Open the actions window
			ActionEditWindow.OpenEditWindow(param.ActionType,param.SlotWindow,param.HotbarId,param.ItemIndex,param.SubIndex)
		end
	elseif( returnCode == HotbarSystem.ContextReturnCodes.ENABLE_REPEAT ) then
		UserActionMacroSetRepeatEnabled(param.HotbarId,param.ItemIndex,true)
	elseif( returnCode == HotbarSystem.ContextReturnCodes.DISABLE_REPEAT ) then
		UserActionMacroSetRepeatEnabled(param.HotbarId,param.ItemIndex,false)
	elseif ( returnCode == "toggleAlert" ) then
		Interface.SaveBoolean( "Hotbar" .. param.HotbarId .. "Button" .. param.ItemIndex .. "EnableAlert", not Interface.LoadBoolean( "Hotbar" .. param.HotbarId .. "Button" .. param.ItemIndex .. "EnableAlert", false ) )
		if not Interface.LoadBoolean( "Hotbar" .. param.HotbarId .. "Button" .. param.ItemIndex .. "EnableAlert", false ) then
			WindowSetShowing("Hotbar" .. param.HotbarId .. "Button" .. param.ItemIndex.."Alert",false)
		else
			WindowData.UpdateInstanceId = UserActionGetId(param.HotbarId, param.ItemIndex, param.SubIndex)
			HotbarSystem.UpdateQuantity()
		end
	else
		bHandled = false
	end
	
	return bHandled
end

function HotbarSystem.RegisterSpellIcon(iconWindow,spellId)
	HotbarSystem.RegisteredSpellIcons[iconWindow] = spellId	
end

function HotbarSystem.UnregisterSpellIcon(iconWindow)
	HotbarSystem.RegisteredSpellIcons[iconWindow] = nil	
end

function HotbarSystem.HighlightSpellIcon()
	local spellId = SystemData.HotbarSystem.HighlightSpellIconInput.highlightSpellID
	local highlightEnabled = SystemData.HotbarSystem.HighlightSpellIconInput.highlightSpellEnabled
	for iconWindow, id in pairs(HotbarSystem.RegisteredSpellIcons) do
		if( iconWindow ~= nil and id == spellId ) then
			if (highlightEnabled ~= 0) then	
				WindowSetTintColor(iconWindow.."SquareIcon",255,0,0)
			end
		end
	end
end

function HotbarSystem.UnhighlightSpellIcon()
	local spellId = SystemData.HotbarSystem.UnhighlightSpellIconInput.highlightSpellID
	local highlightEnabled = SystemData.HotbarSystem.UnhighlightSpellIconInput.highlightSpellEnabled
	for iconWindow, id in pairs(HotbarSystem.RegisteredSpellIcons) do
		if( iconWindow ~= nil and id == spellId ) then
			if (highlightEnabled == 0) then	
				WindowSetTintColor(iconWindow.."SquareIcon",255,255,255)
			end
		end
	end
end

function HotbarSystem.RequestTargetInfo(windowName, hotbarId, itemIndex, subIndex)
	HotbarSystem.CurRequestInfoItem =
	{
		windowName = windowName,
		hotbarId = hotbarId,
		itemIndex = itemIndex,				
		subIndex = subIndex,
	}

	RequestTargetInfo()
	
	WindowClearAnchors("RequestTargetIdInfo")
	WindowAddAnchor("RequestTargetIdInfo", "topright", windowName, "bottomleft", 0, -6)
	WindowSetShowing("RequestTargetIdInfo", true)
	WindowRegisterEventHandler("RequestTargetIdInfo", SystemData.Events.TARGET_SEND_ID_CLIENT, "HotbarSystem.RequestTargetInfoReceived")
end

function HotbarSystem.RequestTargetInfoReceived()
	local objectId = SystemData.RequestInfo.ObjectId
	
	if (objectId ~= 0 and HotbarSystem.CurRequestInfoItem ~= nil) then
		UserActionSetTargetId(HotbarSystem.CurRequestInfoItem.hotbarId, HotbarSystem.CurRequestInfoItem.itemIndex, HotbarSystem.CurRequestInfoItem.subIndex, objectId)
		UserActionSetTargetType(HotbarSystem.CurRequestInfoItem.hotbarId, HotbarSystem.CurRequestInfoItem.itemIndex, HotbarSystem.CurRequestInfoItem.subIndex, SystemData.Hotbar.TargetType.TARGETTYPE_OBJECT_ID)
		HotbarSystem.UpdateTargetTypeIndicator(HotbarSystem.CurRequestInfoItem.windowName,HotbarSystem.CurRequestInfoItem.hotbarId,HotbarSystem.CurRequestInfoItem.itemIndex,HotbarSystem.CurRequestInfoItem.subIndex)
	end
	
	WindowSetShowing("RequestTargetIdInfo", false)
	WindowUnregisterEventHandler("RequestTargetIdInfo", SystemData.Events.TARGET_SEND_ID_CLIENT)
end

function HotbarSystem.ReplaceKey(oldHotbarId, oldItemIndex, oldType, hotbarId, itemIndex, type, key, shortKey)
	HotbarSystem.UnbindKey(oldHotbarId, oldItemIndex, oldType)
	HotbarSystem.BindKey(hotbarId, itemIndex, type, key, shortKey)
	
	BroadcastEvent( SystemData.Events.KEYBINDINGS_UPDATED )
end

function HotbarSystem.BindKey(hotbarId, itemIndex, type, key, shortKey)
	if(type == SystemData.BindType.BINDTYPE_SETTINGS) then
		UserControlSettings.Keybindings[itemIndex].newValue = key
		SettingsKeyBindingsWindow.UpdateKeyBindings()
		
	elseif(type == SystemData.BindType.BINDTYPE_HOTBAR) then
		SystemData.Hotbar[hotbarId].Bindings[itemIndex] = key
		SystemData.Hotbar[hotbarId].BindingDisplayStrings[itemIndex] = shortKey
		
		HotbarUpdateBinding(hotbarId, itemIndex, key)
		local element = "Hotbar"..hotbarId.."Button"..itemIndex
		HotbarSystem.UpdateBinding(element,key)
		
	elseif(type == SystemData.BindType.BINDTYPE_MACRO) then
		UserActionMacroUpdateBinding(hotbarId, itemIndex, key)
		local MacroLabel = "MacroScrollWindowScrollChildItem"..itemIndex.."Binding"
		if( key ~= L"" ) then
			LabelSetText(MacroLabel, key)
		else
			LabelSetText(MacroLabel, GetStringFromTid(MacroWindow.TID_NO_KEYBINDING))
		end
	end
end

function HotbarSystem.UpdateBinding(element,key, key2)
	if (key ~= nil) then
		local patt = WStringToString(key)
		local texto = string.find(patt , "OEM_102")
		if ( texto ~= nil ) then
			patt = string.gsub(patt, "OEM_102", "<")
		end
		
		texto = string.find(patt , "Delete")
		if ( texto ~= nil ) then
			patt = string.gsub(patt, "Delete", "Del")
		end
		
		texto = string.find(patt , "Num Pad")
		if ( texto ~= nil ) then
			patt = string.gsub(patt, "Num Pad:", "NP")
		end
		
		texto = string.find(patt , "Space")
		if ( texto ~= nil ) then
			patt = string.gsub(patt, "Space", "Spc")
		end
		
		texto = string.find(patt , "BackSpc")
		if ( texto ~= nil ) then
			patt = string.gsub(patt, "BackSpc", "Back")
		end
		
		texto = string.find(patt , "Insert")
		if ( texto ~= nil ) then
			patt = string.gsub(patt, "Insert", "Ins")
		end
		
		texto = string.find(patt , "Page Up")
		if ( texto ~= nil ) then
			patt = string.gsub(patt, "Page Up", "PGUp")
		end
		
		texto = string.find(patt , "Page Dn")
		if ( texto ~= nil ) then
			patt = string.gsub(patt, "Page Dn", "PGDn")
		end

		
		if (string.len(patt) > 4) then
			patt = string.sub(patt, 1, 4)
		end
		key = StringToWString(patt)
	end
	

	-- PLAIN
	LabelSetTextColor(element.."Hotkey",HotbarSystem.Plain.r,HotbarSystem.Plain.g,HotbarSystem.Plain.b)
	
	local patt = L""
	if (key2 ~= nil) then
		patt = key2
	end

	-- CTRL
	local texto = wstring.find(patt , L"Control")
	if ( texto ~= nil ) then
		LabelSetTextColor(element.."Hotkey",HotbarSystem.Control.r,HotbarSystem.Control.g,HotbarSystem.Control.b)
	end
	
	-- ALT
	texto = wstring.find(patt , L"Alt")
	if ( texto ~= nil ) then
		LabelSetTextColor(element.."Hotkey",HotbarSystem.Alt.r,HotbarSystem.Alt.g,HotbarSystem.Alt.b)
	end
	
	-- SHIFT
	texto = wstring.find(patt , L"Shift")
	if ( texto ~= nil ) then
		LabelSetTextColor(element.."Hotkey",HotbarSystem.Shift.r,HotbarSystem.Shift.g,HotbarSystem.Shift.b)
		
	end
	
	-- CTRL + SHIFT
	texto = wstring.find(patt , L"Shift")
	local texto2 = wstring.find(patt , L"Control")
	if ( texto ~= nil and texto2 ~= nil ) then
		LabelSetTextColor(element.."Hotkey",HotbarSystem.ControlShift.r,HotbarSystem.ControlShift.g,HotbarSystem.ControlShift.b)
	end
	
	-- CTRL + ALT
	texto = wstring.find(patt , L"Alt")
	texto2 = wstring.find(patt , L"Control")
	if ( texto ~= nil and texto2 ~= nil ) then
		LabelSetTextColor(element.."Hotkey",HotbarSystem.ControlAlt.r,HotbarSystem.ControlAlt.g,HotbarSystem.ControlAlt.b)
	end
	
	-- ALT + SHIFT
	texto = wstring.find(patt , L"Alt")
	texto2 = wstring.find(patt , L"Shift")
	if ( texto ~= nil and texto2 ~= nil ) then
		LabelSetTextColor(element.."Hotkey",HotbarSystem.AltShift.r,HotbarSystem.AltShift.g,HotbarSystem.AltShift.b)
	end
	
	-- CTRL + ALT + SHIFT
	texto = wstring.find(patt , L"Alt")
	texto2 = wstring.find(patt , L"Shift")
	local texto3 = wstring.find(patt , L"Control")
	if ( texto ~= nil and texto2 ~= nil and texto3 ~= nil ) then
		LabelSetTextColor(element.."Hotkey",HotbarSystem.ControlAltShift.r,HotbarSystem.ControlAltShift.g,HotbarSystem.ControlAltShift.b)
	end
	
	LabelSetText(element.."Hotkey", key)
	WindowClearAnchors(element.."Hotkey")
	WindowAddAnchor(element.."Hotkey", "topleft", element, "topleft", -5, 0)	

	if( key ~= L"" ) then
		WindowSetShowing(element.."HotkeyBackground",true)
	else
		WindowSetShowing(element.."HotkeyBackground",false)
	end
	
	local fnd = string.find(element , "Button")
	local hotbarId = tonumber(string.sub(element,7, fnd - 1))
	local itemIndex = tonumber(string.sub(element, fnd + 6 ))
	
	if not HotbarSystem.BindingsBackup then
		HotbarSystem.BindingsBackup = {}
	end
    if not HotbarSystem.BindingsBackup[hotbarId] then
		HotbarSystem.BindingsBackup[hotbarId] = {}
	end
	HotbarSystem.BindingsBackup[hotbarId][itemIndex] = key2
end

function HotbarSystem.UnbindKey(hotbarId, itemIndex, type)
	if( type == SystemData.BindType.BINDTYPE_SETTINGS ) then
		UserControlSettings.Keybindings[itemIndex].newValue = L""
		SettingsKeyBindingsWindow.UpdateKeyBindings()
		
	elseif( type == SystemData.BindType.BINDTYPE_HOTBAR ) then
		--Debug.Print("Hotbar: " .. hotbarId .. " ID: " .. itemIndex)
		SystemData.Hotbar[hotbarId].Bindings[itemIndex] = L""
		SystemData.Hotbar[hotbarId].BindingDisplayStrings[itemIndex] = L""
		
		HotbarUpdateBinding(hotbarId, itemIndex, L"")
		local element = "Hotbar"..hotbarId.."Button"..itemIndex
		HotbarSystem.UpdateBinding(element,L"", SystemData.Hotbar[hotbarId].Bindings[itemIndex])
		
	elseif( type == SystemData.BindType.BINDTYPE_MACRO ) then
		UserActionMacroUpdateBinding(hotbarId, itemIndex, L"")
		local MacroLabel = "MacroScrollWindowScrollChildItem"..itemIndex.."Binding"
		LabelSetText(MacroLabel, GetStringFromTid(MacroWindow.TID_NO_KEYBINDING))
	end
end

function HotbarSystem.GetKeyName(hotbarId, itemIndex, type)
	if( type == SystemData.BindType.BINDTYPE_SETTINGS ) then
		return GetStringFromTid( UserControlSettings.Keybindings[itemIndex].tid )
	elseif( type == SystemData.BindType.BINDTYPE_HOTBAR ) then
		return GetStringFromTid( Hotbar.TID_HOTBAR )..L" "..hotbarId..L"  "..GetStringFromTid( Hotbar.TID_SLOT )..L" "..itemIndex
	elseif( type == SystemData.BindType.BINDTYPE_MACRO ) then
		return GetStringFromTid( MacroWindow.TID_MACROCOLON )..L"  "..UserActionMacroGetName(SystemData.MacroSystem.STATIC_MACRO_ID, itemIndex)
	end
end

function HotbarSystem.SetActionOnHotbar(actionType, actionId, actionIcon, hotbarNum, buttonNum)
    HotbarCreateNewAction(actionType,actionId,actionIcon,hotbarNum,buttonNum)
    local element = "Hotbar"..hotbarNum.."Button"..buttonNum
    HotbarSystem.RegisterAction(element,hotbarNum,buttonNum,0)
    if ActionsWindow.isAction(actionType) then
		if actionId >= 5000 then
			local speechText = ActionsWindow.ActionData[actionId].callback
			UserActionSpeechSetText(hotbarNum, buttonNum, 0, speechText)	
		end
    end
end