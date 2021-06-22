----------------------------------------------------------------
-- Global Variables
----------------------------------------------------------------

Hotbar = {}

----------------------------------------------------------------
-- Local Variables
----------------------------------------------------------------

Hotbar.NUM_BUTTONS = 12

Hotbar.CurrentUseSlot = 0
Hotbar.CurrentUseHotbar = 0

Hotbar.DarkItemLabel = { r=245,g=229,b=0 }
Hotbar.LightItemLabel = { r=0,g=0,b=0 }

Hotbar.RecordingKey = false
Hotbar.RecordingSlot = 0
Hotbar.RecordingHotbar = 0

Hotbar.HANDLE_OFFSET = 20
Hotbar.BUTTON_SIZE = 50

Hotbar.TID_BINDING_CONFLICT_TITLE = 1079169
Hotbar.TID_BINDING_CONFLICT_BODY = 1079170
Hotbar.TID_BINDING_CONFLICT_QUESTION = 1094839
Hotbar.TID_YES = 1049717
Hotbar.TID_NO = 1049718

Hotbar.TID_TARGET = 1079927 -- "Target:"
Hotbar.TID_BINDING = 1079928 -- "Binding:"

Hotbar.TID_HOTBAR = 1079167 -- "Hotbar"
Hotbar.TID_SLOT = 1079168 -- "Slot"

----------------------------------------------------------------
-- MainMenuWindow Functions
----------------------------------------------------------------

function Hotbar.SetHotbarItem(hotbarId, slot)
	local itemIndex = slot
	local element = "Hotbar"..hotbarId.."Button"..slot	
	local hasItem = HotbarHasItem(hotbarId, itemIndex)
	
	--Debug.Print("Hotbar.SetHotbarItem: "..tostring(slot).." itemIndex: "..tostring(itemIndex).." hasItem: "..tostring(hasItem))
	
	-- bail out if this item doesnt exist in c++
	if( hasItem == false ) then
		return
	end
	
	HotbarSystem.RegisterAction(element, hotbarId, itemIndex, 0)
end

function Hotbar.ClearHotbarItem(hotbarId, slot, bUnregister)
	--Debug.PrintToDebugConsole(L"Hotbar::ClearHotbarSlot Slot: "..slot)
	
	local itemIndex = slot
	local element = "Hotbar"..hotbarId.."Button"..slot
	
	HotbarSystem.ClearActionIcon(element, hotbarId, itemIndex, 0, bUnregister)
end

function Hotbar.ReloadHotbar(hotbarId)
	--Debug.Print("Hotbar.ReloadHotbar")
	
	for slot = 1, Hotbar.NUM_BUTTONS do	
		Hotbar.SetHotbarItem(hotbarId,slot)
	end
	
	local hotbar = "Hotbar"..hotbarId
	WindowUtils.LoadScale( hotbar )
	local x, y = WindowGetOffsetFromParent(hotbar)
	WindowClearAnchors(hotbar)
	WindowSetOffsetFromParent(hotbar, x, y)
	local closed = Interface.LoadBoolean( hotbar.. "Closed",false )

	if (closed) then
		Hotbar.Shrink(hotbar, true)
	end
	
	text = Interface.LoadWString( "Hotbar"..hotbarId .. "CustomText", L"" )
		
	LabelSetText("Hotbar"..hotbarId .. "NameH", text)
	LabelSetText("Hotbar"..hotbarId .. "NameV", text)
	LabelSetText("Hotbar"..hotbarId .. "NameVrev", text)
	LabelSetText("Hotbar"..hotbarId .. "NameHrev", text)
	
	local width, height = WindowGetDimensions(hotbar)
	
	if (not Interface.LoadBoolean( "Hotbar"..hotbarId .. "ReverseText", false ) ) then
		WindowSetShowing("Hotbar"..hotbarId .. "NameVrev", false)
		WindowSetShowing("Hotbar"..hotbarId .. "NameHrev", false)
		if (width < height) then
			WindowSetShowing("Hotbar"..hotbarId .. "NameV", false)
			WindowSetShowing("Hotbar"..hotbarId .. "NameH", true)
		else
			WindowSetShowing("Hotbar"..hotbarId .. "NameV", true)
			WindowSetShowing("Hotbar"..hotbarId .. "NameH", false)
		end
	else
		WindowSetShowing("Hotbar"..hotbarId .. "NameV", false)
		WindowSetShowing("Hotbar"..hotbarId .. "NameH", false)
		if (width < height) then
			WindowSetShowing("Hotbar"..hotbarId .. "NameVrev", false)
			WindowSetShowing("Hotbar"..hotbarId .. "NameHrev", true)
		else
			WindowSetShowing("Hotbar"..hotbarId .. "NameVrev", true)
			WindowSetShowing("Hotbar"..hotbarId .. "NameHrev", false)
		end
	end
	
	width = Interface.LoadNumber( hotbar .. "SizeW", width )
	height = Interface.LoadNumber( hotbar .. "SizeH", height )
	color = Interface.LoadColor(hotbar .. "HandleColor",{r=153,g=153,b=153})
	WindowSetTintColor(hotbar .. "HorizHandle", color.r, color.g, color.b)
	WindowSetTintColor(hotbar .. "VertHandle", color.r, color.g, color.b)
	
	LabelSetTextColor(hotbar .. "NameH", color.r, color.g, color.b)
	LabelSetTextColor(hotbar .. "NameV", color.r, color.g, color.b)
	LabelSetTextColor(hotbar .. "NameVrev", color.r, color.g, color.b)
	LabelSetTextColor(hotbar .. "NameHrev", color.r, color.g, color.b)

	if (Interface.LoadBoolean( hotbar .. "LeftToRight", false )) then
		
		if (width > height) then
			
			ButtonSetTexture(hotbar .. "MinimizeButtonH", InterfaceCore.ButtonStates.STATE_NORMAL, "ExtractRight", 0, 0)
			ButtonSetTexture(hotbar .. "MinimizeButtonH", InterfaceCore.ButtonStates.STATE_NORMAL_HIGHLITE, "ExtractRight", 24 , 0)
			ButtonSetTexture(hotbar .. "MinimizeButtonH", InterfaceCore.ButtonStates.STATE_PRESSED, "ExtractLeft", 24 , 0)
			ButtonSetTexture(hotbar .. "MinimizeButtonH", InterfaceCore.ButtonStates.STATE_PRESSED_HIGHLITE, "ExtractRight", 24 , 0)
				
			ButtonSetTexture(hotbar .. "MaximizeButtonH", InterfaceCore.ButtonStates.STATE_NORMAL, "ExtractLeft", 24, 0)
			ButtonSetTexture(hotbar .. "MaximizeButtonH", InterfaceCore.ButtonStates.STATE_NORMAL_HIGHLITE, "ExtractLeft", 0 , 0)
			ButtonSetTexture(hotbar .. "MaximizeButtonH", InterfaceCore.ButtonStates.STATE_PRESSED, "ExtractLeft", 0 , 0)
			ButtonSetTexture(hotbar .. "MaximizeButtonH", InterfaceCore.ButtonStates.STATE_PRESSED_HIGHLITE, "ExtractLeft", 0 , 0)
			
			
			WindowClearAnchors(hotbar .. "Lock")
			WindowAddAnchor(hotbar .. "Lock","bottomleft","Hotbar"..hotbarId.."HorizHandle","bottomleft",2,-2)
		else
			ButtonSetTexture(hotbar .. "MinimizeButtonV", InterfaceCore.ButtonStates.STATE_NORMAL, "updown", 50, 1)
			ButtonSetTexture(hotbar .. "MinimizeButtonV", InterfaceCore.ButtonStates.STATE_NORMAL_HIGHLITE, "updown", 76 , 0)
			ButtonSetTexture(hotbar .. "MinimizeButtonV", InterfaceCore.ButtonStates.STATE_PRESSED, "updown", 76 , 0)
			ButtonSetTexture(hotbar .. "MinimizeButtonV", InterfaceCore.ButtonStates.STATE_PRESSED_HIGHLITE, "updown", 76 , 0)
				
			ButtonSetTexture(hotbar .. "MaximizeButtonV", InterfaceCore.ButtonStates.STATE_NORMAL, "updown", 27, 0)
			ButtonSetTexture(hotbar .. "MaximizeButtonV", InterfaceCore.ButtonStates.STATE_NORMAL_HIGHLITE, "updown", 3 , 2)
			ButtonSetTexture(hotbar .. "MaximizeButtonV", InterfaceCore.ButtonStates.STATE_PRESSED, "updown", 3 , 2)
			ButtonSetTexture(hotbar .. "MaximizeButtonV", InterfaceCore.ButtonStates.STATE_PRESSED_HIGHLITE, "updown", 3 , 2)

			WindowClearAnchors(hotbar .. "Lock")
			WindowAddAnchor(hotbar .. "Lock","topleft","Hotbar"..hotbarId.."VertHandle","topleft",0,0)
		end
	else
		if (width > height) then
			
			ButtonSetTexture(hotbar .. "MaximizeButtonH", InterfaceCore.ButtonStates.STATE_NORMAL, "ExtractRight", 0, 0)
			ButtonSetTexture(hotbar .. "MaximizeButtonH", InterfaceCore.ButtonStates.STATE_NORMAL_HIGHLITE, "ExtractRight", 24 , 0)
			ButtonSetTexture(hotbar .. "MaximizeButtonH", InterfaceCore.ButtonStates.STATE_PRESSED, "ExtractLeft", 24 , 0)
			ButtonSetTexture(hotbar .. "MaximizeButtonH", InterfaceCore.ButtonStates.STATE_PRESSED_HIGHLITE, "ExtractRight", 24 , 0)
				
			ButtonSetTexture(hotbar .. "MinimizeButtonH", InterfaceCore.ButtonStates.STATE_NORMAL, "ExtractLeft", 24, 0)
			ButtonSetTexture(hotbar .. "MinimizeButtonH", InterfaceCore.ButtonStates.STATE_NORMAL_HIGHLITE, "ExtractLeft", 0 , 0)
			ButtonSetTexture(hotbar .. "MinimizeButtonH", InterfaceCore.ButtonStates.STATE_PRESSED, "ExtractLeft", 0 , 0)
			ButtonSetTexture(hotbar .. "MinimizeButtonH", InterfaceCore.ButtonStates.STATE_PRESSED_HIGHLITE, "ExtractLeft", 0 , 0)
			
			WindowClearAnchors(hotbar .. "Lock")
			WindowAddAnchor(hotbar .. "Lock","bottomleft","Hotbar"..hotbarId.."HorizHandle","bottomleft",2,-2)
		else
			ButtonSetTexture(hotbar .. "MaximizeButtonV", InterfaceCore.ButtonStates.STATE_NORMAL, "updown", 50, 1)
			ButtonSetTexture(hotbar .. "MaximizeButtonV", InterfaceCore.ButtonStates.STATE_NORMAL_HIGHLITE, "updown", 76 , 0)
			ButtonSetTexture(hotbar .. "MaximizeButtonV", InterfaceCore.ButtonStates.STATE_PRESSED, "updown", 76 , 0)
			ButtonSetTexture(hotbar .. "MaximizeButtonV", InterfaceCore.ButtonStates.STATE_PRESSED_HIGHLITE, "updown", 76 , 0)
				
			ButtonSetTexture(hotbar .. "MinimizeButtonV", InterfaceCore.ButtonStates.STATE_NORMAL, "updown", 27, 0)
			ButtonSetTexture(hotbar .. "MinimizeButtonV", InterfaceCore.ButtonStates.STATE_NORMAL_HIGHLITE, "updown", 3 , 2)
			ButtonSetTexture(hotbar .. "MinimizeButtonV", InterfaceCore.ButtonStates.STATE_PRESSED, "updown", 3 , 2)
			ButtonSetTexture(hotbar .. "MinimizeButtonV", InterfaceCore.ButtonStates.STATE_PRESSED_HIGHLITE, "updown", 3 , 2)
			
			WindowClearAnchors(hotbar .. "Lock")
			WindowAddAnchor(hotbar .. "Lock","topleft","Hotbar"..hotbarId.."VertHandle","topleft",0,0)
			
			
		end
	end
	
	Hotbar.OnResizeEnd(hotbar)
	
	local texture = "UO_Core"
	if ( not Interface.LoadBoolean( hotbar .. "LockWithHandle", false )  ) then
		ButtonSetTexture(hotbar.."Lock", InterfaceCore.ButtonStates.STATE_NORMAL, texture, 69,341)
		ButtonSetTexture(hotbar.."Lock",InterfaceCore.ButtonStates.STATE_NORMAL_HIGHLITE, texture, 92,341)
		ButtonSetTexture(hotbar.."Lock", InterfaceCore.ButtonStates.STATE_PRESSED, texture, 92,341)
		ButtonSetTexture(hotbar.."Lock", InterfaceCore.ButtonStates.STATE_PRESSED_HIGHLITE, texture, 92,341)
	else
		ButtonSetTexture(hotbar.."Lock", InterfaceCore.ButtonStates.STATE_NORMAL, texture, 117,341)
		ButtonSetTexture(hotbar.."Lock",InterfaceCore.ButtonStates.STATE_NORMAL_HIGHLITE, texture, 142,341)
		ButtonSetTexture(hotbar.."Lock", InterfaceCore.ButtonStates.STATE_PRESSED, texture, 142,341)
		ButtonSetTexture(hotbar.."Lock", InterfaceCore.ButtonStates.STATE_PRESSED_HIGHLITE, texture, 142,341)	
	end
	
	Hotbar.HideBar(hotbar)
end

function Hotbar.SetLocked(hotbarId, locked)
	--Debug.Print("Hotbar.SetLocked: Hotbar"..hotbarId.." is "..(locked and "LOCKED" or "UNLOCKED"))
	
	local curWindow = "Hotbar"..hotbarId
	
	SystemData.Hotbar[hotbarId].Locked = locked	
	Hotbar.OnResizeEnd(curWindow)
end

function Hotbar.UseSlot(hotbarId, slot)
	local itemIndex = slot
		
	if( HotbarHasItem(hotbarId, itemIndex) ) then
		HotbarExecuteItem(hotbarId, itemIndex)
		--Debug.Print(HotbarSystem.RegisteredObjects["Hotbar"..hotbarId.."Button"..itemIndex])
	end
end

-- OnInitialize Handler
function Hotbar.Initialize()
	this = SystemData.ActiveWindow.name
	local hotbarId = SystemData.DynamicWindowId
	
	SnapUtils.SnappableWindows[this] = true
	
	WindowSetId(this,hotbarId)
	
	WindowRegisterEventHandler( this, SystemData.Events.INTERFACE_KEY_RECORDED, "Hotbar.KeyRecorded" )
	WindowRegisterEventHandler( this, SystemData.Events.INTERFACE_KEY_CANCEL_RECORD, "Hotbar.KeyCancelRecord" )
	
	-- hotbars positions and sizes are tracked
	WindowUtils.RestoreWindowPosition(this,true)	
	Hotbar.SetLocked(hotbarId, SystemData.Hotbar[hotbarId].Locked)
	
	-- set the hotbar labels based on the hotkey
	-- and initialize the slots
	for slot = 1, Hotbar.NUM_BUTTONS do
	   local element = this.."Button"..slot
	   local key = SystemData.Hotbar[hotbarId].BindingDisplayStrings[slot]
	   local key2 = SystemData.Hotbar[hotbarId].Bindings[slot]
	   HotbarSystem.UpdateBinding(element,key, key2)
	   
	   Hotbar.ClearHotbarItem(hotbarId,slot,false)
	end	
	
	Hotbar.ReloadHotbar(hotbarId)
end

-- OnShutdown Handler
function Hotbar.Shutdown()
	--Debug.Print("Hotbar.Shutdown")
	
	this = SystemData.ActiveWindow.name
	hotbarId = WindowGetId(this)
	
	SnapUtils.SnappableWindows[this] = nil
	
	for slot = 1, Hotbar.NUM_BUTTONS do
		Hotbar.ClearHotbarItem(hotbarId,slot,true)
	end
	
	if( ItemProperties.GetCurrentWindow() == "Hotbar"..hotbarId ) then
		ItemProperties.ClearMouseOverItem()
	end
	
	-- save the position of dynamic bars
	WindowUtils.SaveWindowPosition(this)
end

Hotbar.InMovement = {}

function Hotbar.FindHotbarMovingBlock(CurWindow)
	local anchorPositions = SnapUtils.ComputeAnchorScreenPositions(CurWindow)
	for windowName,_ in pairs(SnapUtils.SnappableWindows) do
		if( windowName ~= CurWindow and string.find(windowName, "Hotbar") and not Hotbar.InMovement[windowName] and not WindowGetMoving(windowName) ) then          
			local comparePositions = SnapUtils.ComputeAnchorScreenPositions(windowName)            
            
			for _, snapPair in ipairs( SnapUtils.SNAP_PAIRS )
			do
				local dist = SnapUtils.GetAnchorDistance( anchorPositions, snapPair[1], comparePositions, snapPair[2] )
               
				-- If the distance between the anchors is within the snap threshold, save the value
				if( (dist <= 5) and (dist < 6) and WindowGetShowing(windowName) )
				then
					
					WindowSetMoving(windowName, true)
					Hotbar.InMovement[windowName] = true
					Hotbar.FindHotbarMovingBlock(windowName)
				end
		   end
		end
	end
end

function Hotbar.FindHotbarShrinkBlock(CurWindow)
	local anchorPositions = SnapUtils.ComputeAnchorScreenPositions(CurWindow)
	for windowName,_ in pairs(SnapUtils.SnappableWindows) do
		if( windowName ~= CurWindow and string.find(windowName, "Hotbar") and not Interface.LoadBoolean( windowName.. "Closed",false ) ) then          
			local comparePositions = SnapUtils.ComputeAnchorScreenPositions(windowName)            
            
			for _, snapPair in ipairs( SnapUtils.SNAP_PAIRS ) do
				local dist = SnapUtils.GetAnchorDistance( anchorPositions, snapPair[1], comparePositions, snapPair[2] )
               
				-- If the distance between the anchors is within the snap threshold, save the value
				if( (dist <= 5) and (dist < 6) and WindowGetShowing(windowName) )
				then
					Hotbar.Shrink(windowName)
					Hotbar.FindHotbarShrinkBlock(windowName)
				end
		   end
		end
	end
end

function Hotbar.FindHotbarEnlargeBlock(CurWindow)
	local anchorPositions = SnapUtils.ComputeAnchorScreenPositions(CurWindow)
	for windowName,_ in pairs(SnapUtils.SnappableWindows) do
		if( windowName ~= CurWindow and string.find(windowName, "Hotbar") and Interface.LoadBoolean( windowName.. "Closed",false ) ) then          
			local comparePositions = SnapUtils.ComputeAnchorScreenPositions(windowName)            
            
			for _, snapPair in ipairs( SnapUtils.SNAP_PAIRS ) do
				local dist = SnapUtils.GetAnchorDistance( anchorPositions, snapPair[1], comparePositions, snapPair[2] )
               
				-- If the distance between the anchors is within the snap threshold, save the value
				if( (dist <= 5) and (dist < 6) and WindowGetShowing(windowName) )
				then
					Hotbar.Enlarge(windowName)
					Hotbar.FindHotbarEnlargeBlock(windowName)
				end
		   end
		end
	end
end

function Hotbar.FindHotbarGroup(CurWindow, group)
	if not group then
		group = {}
	end
	local count = 0
	local anchorPositions = SnapUtils.ComputeAnchorScreenPositions(CurWindow)
	for windowName,_ in pairs(SnapUtils.SnappableWindows) do
		if( windowName ~= CurWindow and string.find(windowName, "Hotbar") and not group[windowName] ) then          
			local comparePositions = SnapUtils.ComputeAnchorScreenPositions(windowName)            
            
			for _, snapPair in ipairs( SnapUtils.SNAP_PAIRS ) do
				local dist = SnapUtils.GetAnchorDistance( anchorPositions, snapPair[1], comparePositions, snapPair[2] )
               
				-- If the distance between the anchors is within the snap threshold, save the value
				if( (dist <= 5) and (dist < 6) and WindowGetShowing(windowName) ) then
					group[windowName] = true
					group = Hotbar.FindHotbarGroup(windowName, group)
					
				end
		   end
		end
	end
	for _, _ in pairs(group) do
		count = count + 1
	end
	return group, count
end

-- OnLButtonDown Handler
function Hotbar.ItemLButtonDown(flags)
	local slot = WindowGetId(SystemData.ActiveWindow.name)
	local hotbarId = WindowGetId(WindowUtils.GetActiveDialog())
	
	--Debug.PrintToDebugConsole(L"Hotbar::OnLButtonDown(): Slot "..slot)
	if flags == SystemData.ButtonFlags.CONTROL then
		WindowSetMoving("Hotbar"..hotbarId, true)
		SnapUtils.StartWindowSnap( "Hotbar"..hotbarId )
		return
	end
	if flags == SystemData.ButtonFlags.SHIFT and not WindowGetMoving("Hotbar"..hotbarId) then
		Hotbar.FindHotbarMovingBlock("Hotbar"..hotbarId)
		WindowSetMoving("Hotbar"..hotbarId, true)
		return
	end
	local itemIndex = slot
		
	if( WindowData.Cursor ~= nil and WindowData.Cursor.target == true and hotbarId ~= 0 )
	then		
		if ( UserActionGetType( hotbarId, slot, 0 ) == SystemData.UserAction.TYPE_USE_ITEM ) then
			local objID = UserActionGetId(hotbarId, slot, 0)
			if objID
			and objID ~= 0 
			and (not DoesWindowNameExist("Hotbar"..hotbarId.."Button"..slot.."Disabled" ) or not WindowGetShowing("Hotbar"..hotbarId.."Button"..slot.."Disabled" ))
			then
				HandleSingleLeftClkTarget(objID)
				Hotbar.CurrentUseHotbar = nil
				Hotbar.CurrentUseSlot = nil
			end
		elseif( UserActionGetType( hotbarId, slot, 0 ) == SystemData.UserAction.TYPE_USE_OBJECTTYPE )
		then
			local specID = UserActionGetId(hotbarId, slot, 0)
			if specID 
			and specID ~= 0 
			then
				local objID = UserActionGetNextObjectId(specID)
				if objID 
				and objID ~= 0 
				and (not DoesWindowNameExist("Hotbar"..hotbarId.."Button"..slot.."Disabled" ) or not WindowGetShowing("Hotbar"..hotbarId.."Button"..slot.."Disabled" ))
				then
					HandleSingleLeftClkTarget(objID)
					Hotbar.CurrentUseHotbar = nil
					Hotbar.CurrentUseSlot = nil
				end
			end
		else
			if HotbarHasItem(hotbarId, itemIndex)
			and (not DoesWindowNameExist("Hotbar"..hotbarId.."Button"..slot.."Disabled" ) or not WindowGetShowing("Hotbar"..hotbarId.."Button"..slot.."Disabled" ))
			then
				Hotbar.CurrentUseHotbar = hotbarId
				Hotbar.CurrentUseSlot = slot
			end
		end
	else
		if HotbarHasItem(hotbarId, itemIndex) then
			if not SystemData.Hotbar[hotbarId].Locked then
				DragSlotSetExistingActionMouseClickData(hotbarId,slot,0)
			end

		    if (not DoesWindowNameExist("Hotbar"..hotbarId.."Button"..slot.."Disabled" ) or not WindowGetShowing("Hotbar"..hotbarId.."Button"..slot.."Disabled" )) then
				Hotbar.CurrentUseHotbar = hotbarId
				Hotbar.CurrentUseSlot = slot
			end
		end
	end
end

-- OnLButtonUP Handler
function Hotbar.ItemLButtonUp(flags)
	local hotbarId = WindowGetId(WindowUtils.GetActiveDialog())
	local slot = WindowGetId(SystemData.ActiveWindow.name)
	
	if WindowGetMoving("Hotbar"..hotbarId) then
		WindowSetMoving("Hotbar"..hotbarId, false)
		return
	end
	for windowName,_ in pairs(Hotbar.InMovement) do
		WindowSetMoving(windowName, false)
		Hotbar.InMovement[windowName] = nil
	end
	Hotbar.InMovement = {}
	if flags == SystemData.ButtonFlags.CONTROL then
		return
	end

	
	--Debug.PrintToDebugConsole(L"Hotbar::OnLButtonUp(): Slot = "..StringToWString(tostring(slot)))
	--Debug.PrintToDebugConsole(L"Hotbar::OnLButtonUp(): SystemData.DragItem.DragType =  "..StringToWString(tostring(SystemData.DragItem.DragType)))
	
	if( SystemData.DragItem.DragType ~= SystemData.DragItem.TYPE_NONE ) then
		local actionId = UserActionGetId(hotbarId,slot,0)

		if( SystemData.DragItem.DragType == SystemData.DragItem.TYPE_ITEM and actionId == 5015) then
			DragSlotDropObjectToObject(WindowData.PlayerStatus.PlayerId)
		else
			local dropSuccess = DragSlotDropAction(hotbarId,slot,0)
		    
			if( dropSuccess ) then
				-- clear existing hotbar icon
		        
				Hotbar.ClearHotbarItem(hotbarId,slot,true)	   
				
				local element = "Hotbar"..hotbarId.."Button"..slot				
				LabelSetText(element.."BandageTime", L"")

				-- get the new action type for this item
				local actionType = UserActionGetType(hotbarId,slot,0)

		        actionId = UserActionGetId(hotbarId,slot,0)
				
				-- open action window if applicable
				local slotWindow = "Hotbar"..hotbarId.."Button"..slot

			    
				-- update hotbar item in ui
				Hotbar.SetHotbarItem(hotbarId,slot)
		        
		        
		        local notarget = false
				local type = UserActionGetType(hotbarId, slot, 0)
				if (type == SystemData.UserAction.TYPE_SPELL and SpellsInfo) then
					for _, value in pairs(SpellsInfo.SpellsData) do
						if value.id == actionId then
							notarget = value.notarget
							break
						end
					end
				end
			    if notarget then
					UserActionSetTargetType(hotbarId,slot,0,SystemData.Hotbar.TargetType.TARGETTYPE_CURSOR)
				end
			    
			    if ActionsWindow.isAction(type) then
					if ActionsWindow.CustomEdit(actionId) then
						if (actionId == 5207) then
							Actions.ActionEditRequest = {ActionId = actionId, HotbarId = hotbarId, ItemIndex = slot, SubIndex = 0}
							Actions.TargetType()
						elseif (actionId >= 5500 and actionId < 5600) then
							Actions.ActionEditRequest = {ActionId = actionId, HotbarId = hotbarId, ItemIndex = slot, SubIndex = 0}
							Actions.TargetPetball()
						elseif (actionId >= 5600 and actionId < 5700) or (actionId >= 5800 and actionId < 5900) or actionId == 5156 or actionId == 5736 then
							Actions.ActionEditRequest = {ActionId = actionId, HotbarId = hotbarId, ItemIndex = slot, SubIndex = 0}
							Actions.TargetMount()
						else
							local speechText = ActionsWindow.ActionData[actionId].callback
							UserActionSpeechSetText(hotbarId, slot, 0, speechText)	
						end
					else
						ActionEditWindow.OpenEditWindow(actionType,slotWindow,hotbarId,slot,0)
					end
				end
			end
		end
	elseif( slot == Hotbar.CurrentUseSlot and hotbarId == Hotbar.CurrentUseHotbar ) then
		Hotbar.UseSlot(hotbarId, slot)
	end
end

function Hotbar.ContextMenuCallback(returnCode,param)
	if( string.find(returnCode, "minitxt") ) then
		
		local custom = string.gsub(returnCode, "minitxt", "")
		custom = tonumber(custom)
		local element = "Hotbar"..param.HotbarId.."Button"..param.ItemIndex
		Interface.SaveNumber( element .. "Custom", custom )
		HotbarSystem.UpdateTargetTypeIndicator(element,param.HotbarId,param.ItemIndex,0)
		return
	elseif( string.find(returnCode, "familiar") ) then
		local num = string.gsub(returnCode, "familiar", "")
		Interface.ForceFamiliar = tonumber(num)
		Interface.SaveNumber( "ForceFamiliar", Interface.ForceFamiliar )
		return
	elseif( string.find(returnCode, "enchant") ) then
		local num = string.gsub(returnCode, "enchant", "")
		Interface.ForceEnchant = tonumber(num)
		Interface.SaveNumber( "ForceEnchant", Interface.ForceEnchant )
		return
	elseif( string.find(returnCode, "animalForm") ) then
		local num = string.gsub(returnCode, "animalForm", "")
		Interface.ForceAnimal = tonumber(num)
		Interface.SaveNumber( "ForceAnimal", Interface.ForceAnimal )
		return
	elseif( string.find(returnCode, "spellTrigger") ) then
		local num = string.gsub(returnCode, "spellTrigger", "")
		Interface.ForceSpellTrigger = tonumber(num)
		Interface.SaveNumber( "ForceSpellTrigger", Interface.ForceSpellTrigger )
		return
	elseif( string.find(returnCode, "polymorph") ) then
		local num = string.gsub(returnCode, "polymorph", "")
		Interface.ForcePolymorph = tonumber(num)
		Interface.SaveNumber( "ForcePolymorph", Interface.ForcePolymorph )
		return
	elseif( param ~= nil ) then
		local bHandled = HotbarSystem.ContextMenuCallback(returnCode,param) 
		if( string.find(returnCode,"org") ) then
			local id = string.gsub(returnCode, "org", "")
			Organizer.ActiveOrganizer = tonumber(id)
			Interface.SaveNumber( "OrganizerActiveOrganizer" , Organizer.ActiveOrganizer )
			return
		end
		if( string.find(returnCode,"undr") ) then
			local id = string.gsub(returnCode, "undr", "")
			Organizer.ActiveUndress = tonumber(id)
			Interface.SaveNumber( "OrganizerActiveUndress" , Organizer.ActiveUndress )
			return
		end
		-- if it wasnt handled then check for hotbar specific options
		if( bHandled == false ) then	
			if( returnCode == HotbarSystem.ContextReturnCodes.CLEAR_ITEM ) then
				HotbarSystem.ClearActionIcon(param.SlotWindow, param.HotbarId, param.ItemIndex, param.SubIndex, true)
				HotbarClearItem(param.HotbarId,param.ItemIndex)
			elseif( returnCode == HotbarSystem.ContextReturnCodes.ASSIGN_KEY ) then
				WindowClearAnchors("AssignHotkeyInfo")
				WindowAddAnchor("AssignHotkeyInfo","topright","Hotbar"..param.HotbarId.."Button"..param.Slot,"bottomleft",0,-6)
				WindowSetShowing("AssignHotkeyInfo",true)
			
				Hotbar.RecordingSlot = param.Slot
				Hotbar.RecordingHotbar = param.HotbarId
				Hotbar.RecordingKey = true
				BroadcastEvent( SystemData.Events.INTERFACE_RECORD_KEY )
			elseif( returnCode == HotbarSystem.ContextReturnCodes.NEW_HOTBAR ) then
				Hotbar.CreateNew()
			elseif( returnCode == HotbarSystem.ContextReturnCodes.DESTROY_HOTBAR ) then
                local okayButton = { textTid=UO_StandardDialog.TID_OKAY, callback=function() HotbarSystem.DestroyHotbar(param.HotbarId) end }
                local cancelButton = { textTid=UO_StandardDialog.TID_CANCEL }
				local DestroyConfirmWindow = 
				{
				    windowName = "Hotbar"..param.HotbarId,
					titleTid = HotbarSystem.TID_DESTROY_HOTBAR,
					bodyTid = HotbarSystem.TID_DESTROY_CONFIRM,
					buttons = { okayButton, cancelButton }
				}
					
				UO_StandardDialog.CreateDialog(DestroyConfirmWindow)
			elseif( returnCode == "DestroyGroup" ) then
                local okayButton = { textTid=UO_StandardDialog.TID_OKAY, callback=function() HotbarSystem.DestroyHotbarGroup("Hotbar"..param.HotbarId) end }
                local cancelButton = { textTid=UO_StandardDialog.TID_CANCEL }
				local DestroyConfirmWindow = 
				{
				    windowName = "Hotbar"..param.HotbarId,
					titleTid = HotbarSystem.TID_DESTROY_HOTBAR,
					body = GetStringFromTid(1155387),
					buttons = { okayButton, cancelButton }
				}
					
				UO_StandardDialog.CreateDialog(DestroyConfirmWindow)
			elseif( returnCode == HotbarSystem.ContextReturnCodes.LOCK_HOTBAR) then
				Hotbar.SetLocked(param.HotbarId, not SystemData.Hotbar[param.HotbarId].Locked)
			elseif( returnCode == "fade" ) then
				Interface.SaveBoolean( "Hotbar"..param.HotbarId.. "Fade",true )
				Hotbar.HideBar("Hotbar"..param.HotbarId)
			elseif( returnCode == "unfade" ) then
				Interface.SaveBoolean( "Hotbar"..param.HotbarId.. "Fade",false )
				Hotbar.ShowBar("Hotbar"..param.HotbarId)
			end	
		end						 
	end
end

function Hotbar.ItemRButtonUp()
	local hotbarId = WindowGetId(WindowUtils.GetActiveDialog())
	local slot = WindowGetId(SystemData.ActiveWindow.name)
	local param = {Slot=slot,HotbarId=hotbarId, ItemIndex=slot}	
	
	--Debug.Print("Hotbar.ItemRButtonUp hotbarId: "..hotbarId.." slot: " .. slot)
	
	if not Interface.LoadBoolean("Hotbar" .. hotbarId .. "_IsBlockbar", false) then
		if SystemData.Hotbar[hotbarId].Locked then
			ContextMenu.CreateLuaContextMenuItem(HotbarSystem.TID_UNLOCK_HOTBAR,0,HotbarSystem.ContextReturnCodes.LOCK_HOTBAR,param)
		else
			ContextMenu.CreateLuaContextMenuItem(HotbarSystem.TID_LOCK_HOTBAR,0,HotbarSystem.ContextReturnCodes.LOCK_HOTBAR,param)
		end
		
		ContextMenu.CreateLuaContextMenuItem(HotbarSystem.TID_NEW_HOTBAR,0,HotbarSystem.ContextReturnCodes.NEW_HOTBAR,param)
	end
	
	local fade = Interface.LoadBoolean( "Hotbar"..hotbarId .. "Fade",false )
	if( fade) then
		ContextMenu.CreateLuaContextMenuItemWithString(GetStringFromTid(1155402),0,"unfade", param,false)
	else
		ContextMenu.CreateLuaContextMenuItemWithString(GetStringFromTid(1155403),0,"fade", param,false)
	end
	
	if( hotbarId ~= HotbarSystem.STATIC_HOTBAR_ID and hotbarId ~= Interface.MenuBar) then
		ContextMenu.CreateLuaContextMenuItem(HotbarSystem.TID_DESTROY_HOTBAR,0,HotbarSystem.ContextReturnCodes.DESTROY_HOTBAR,param)
		local _, cnt = Hotbar.FindHotbarGroup("Hotbar" .. hotbarId)
		if cnt > 0 then
			ContextMenu.CreateLuaContextMenuItemWithString(GetStringFromTid(1155386),0,"DestroyGroup",param, false)
		end
	end
	
	ContextMenu.CreateLuaContextMenuItem(HotbarSystem.TID_ASSIGN_HOTKEY,0,HotbarSystem.ContextReturnCodes.ASSIGN_KEY,param)
	
	local itemIndex = slot
	
	if( HotbarHasItem(hotbarId,itemIndex) == true ) then
		local slotWindow = "Hotbar"..hotbarId.."Button"..slot
		HotbarSystem.CreateUserActionContextMenuOptions(hotbarId, itemIndex, 0, slotWindow)
	end


	local element = "Hotbar"..hotbarId.."Button"..slot
	local subMenu = {}
	local custom = Interface.LoadNumber( element .. "Custom", 1 )
	
	for i = 1, table.getn( MiniTexturePack.Overlays )do
		local press = false
		press =custom == i
		item = { str = MiniTexturePack.Overlays[i].name,flags=0,returnCode="minitxt" .. i,param=param,pressed=press,false }
		table.insert(subMenu, item)
	end
	ContextMenu.CreateLuaContextMenuItemWithString(GetStringFromTid(1155279),0,0,"null",false,subMenu)

	
	ContextMenu.ActivateLuaContextMenu(Hotbar.ContextMenuCallback)
end

-- OnMouseOver Handler
function Hotbar.ItemMouseOver()
	local this = SystemData.ActiveWindow.name
	local hotbarId = WindowGetId(WindowUtils.GetActiveDialog())
	local slot = WindowGetId(this)
	local itemIndex = slot
	local actionId = UserActionGetId(hotbarId,itemIndex,0)
	Hotbar.ShowBar("Hotbar" .. hotbarId)
	local actionType = SystemData.UserAction.TYPE_NONE
	-- default id to the slot so it shows the item properties when there is only a binding
	local itemId = slot
	
	local bindingText = L""
	if( SystemData.Hotbar[hotbarId] ~= nil) then
		bindingText = bindingText..SystemData.Hotbar[hotbarId].Bindings[slot]
		if bindingText ~= L"" then
			bindingText = GetStringFromTid(Hotbar.TID_BINDING)..L" "..bindingText -- "Binding:"..L" "..<KEY>
		end
	end
	
	if( HotbarHasItem(hotbarId,itemIndex) == true ) then
	    actionType = UserActionGetType(hotbarId,itemIndex,0)
		actionId = UserActionGetId(hotbarId,itemIndex,0)
		if( actionId ~= 0 ) then
			itemId = actionId
		end
		
		-- if its a macro reference, we need to dereference it
		if( actionType == SystemData.UserAction.TYPE_MACRO_REFERENCE ) then
			local macroId = UserActionGetId(hotbarId,itemIndex,0)
			local macroIndex = MacroSystemGetMacroIndexById(macroId)
			actionType = SystemData.UserAction.TYPE_MACRO
			hotbarId = SystemData.MacroSystem.STATIC_MACRO_ID -- - 1000 -- ???
			itemIndex = macroIndex
		end
	end

	if( actionType == SystemData.UserAction.TYPE_SKILL ) then
		bindingText = SkillsWindow.FormatSkillValue(WindowData.SkillDynamicData[itemId].RealSkillValue)..L"%\n"..bindingText -- Tack on the formatted skill level.
		
		-- NOTE: Need to fix this. Id 0 is also a null check, so no tooltip for Alchemy
		itemId = itemId + 1
	end	
	
	if(actionType == SystemData.UserAction.TYPE_PLAYER_STATS) then
		bindingText = L""		
	end	
				
	local type = actionType
	local idC = itemId

	local notarget = false
	if (type == SystemData.UserAction.TYPE_SPELL and SpellsInfo) then
		for _, value in pairs(SpellsInfo.SpellsData) do
			if value.id == idC then
				notarget = value.notarget
				break
			end
		end
	end
	
	local _, _, _, _, _, _, _, _, manacost  = GetAbilityData(idC)
	local lmcMana
	if manacost and WindowData.PlayerStatus then
		lmcMana = math.floor(manacost - (manacost * (tonumber(WindowData.PlayerStatus["LowerManaCost"]) / 100)))
	end
	if BuffDebuff.BuffWindowId[1104] then -- Mana Phase
		lmcMana = 0
	end
	if type == SystemData.UserAction.TYPE_SKILL and idC ~= 9 then
		noSelf=true
	end
	
	if type == SystemData.UserAction.TYPE_SKILL and (idC ~= 46 or idC ~= 32 or idC ~= 56 or idC ~= 38 or idC ~= 21 or idC ~= 47) then -- meditation, spirit speak, imbuing, tracking, hiding, stealth
		notarget=true
	end

	local targetText = L""
	if ( ( UserActionHasTargetType(hotbarId,itemIndex,0) ) and ( SystemData.Settings.GameOptions.legacyTargeting == false ) and not notarget ) then
		local targetType = UserActionGetTargetType(hotbarId,itemIndex,0)
		targetText = GetStringFromTid(Hotbar.TID_TARGET) -- "Target:"
		if targetType == 1 then -- Current
			targetText = targetText..L" "..GetStringFromTid(HotbarSystem.TID_CURRENT)
		elseif targetType == 2 then -- Cursor
			targetText = targetText..L" "..GetStringFromTid(HotbarSystem.TID_CURSOR)
		elseif targetType == 3 then -- Self
			targetText = targetText..L" "..GetStringFromTid(HotbarSystem.TID_SELF)
		elseif targetType == 4 then -- Object Id
			targetText = targetText..L" "..GetStringFromTid(HotbarSystem.TID_OBJECT_ID)
		else
			targetText = L"" -- Bad case; forget about it.
		end
	end
		
	if (actionId and ((actionId > 5000 and actionId < 20000) or (actionId == 53 or actionId == 54 or actionId == 50)) and 
	(actionType ~= SystemData.UserAction.TYPE_SKILL and actionType ~= SystemData.UserAction.TYPE_SPELL  and actionType ~= SystemData.UserAction.TYPE_USE_ITEM and actionType ~= SystemData.UserAction.TYPE_WEAPON_ABILITY)
	) then
		
		local actionData = ActionsWindow.ActionData[actionId]
		if not actionData then
			return
		end
		local name = L""
		if (actionData.nameTid) then
			name = GetStringFromTid(actionData.nameTid)
		else
			name = actionData.nameString
		end
		
		local desc = L""
		if (not actionData.detailTid) then
			desc = actionData.detailString
		else
			desc = GetStringFromTid(actionData.detailTid)
		end
		if type == SystemData.UserAction.TYPE_SKILL and lmcMana and WindowData.PlayerStatus and tonumber(WindowData.PlayerStatus["CurrentMana"]) < lmcMana then
			desc = desc .. "\n" .. GetStringFromTid(502625)
		end
		
		local itemData
		if (actionId == 5011) then
			local backpackId = WindowData.PlayerEquipmentSlot[EquipmentData.EQPOS_BACKPACK].objectId
	
			if backpackId ~= 0 then
				itemData = {
					windowName = "Hotbar"..hotbarId,
					itemLoc = {hotbarId=hotbarId, itemIndex=itemIndex},
					itemId = backpackId,
					itemType = WindowData.ItemProperties.TYPE_ITEM,
					binding = bindingText, -- As defined above
				}
				ItemProperties.SetActiveItem(itemData)
			end
		else
			if (actionId == 5732) then
				name = ReplaceTokens(GetStringFromTid(1155442), {towstring( Organizer.ActiveOrganizer ) } )
				if (Organizer.Organizers_Desc[Organizer.ActiveOrganizer] ~= L"") then
					name = Organizer.Organizers_Desc[Organizer.ActiveOrganizer]
				end
				desc = desc .. L"\n\n" .. ReplaceTokens(GetStringFromTid(1154934), {name})
			end
			itemData =
			{
				windowName = "Hotbar"..hotbarId,
				itemId = actionId,
				detail = ItemProperties.DETAIL_LONG,
				itemLoc = {hotbarId=hotbarId, itemIndex=itemIndex},
				itemType = WindowData.ItemProperties.TYPE_WSTRINGDATA,
				binding = bindingText, -- As defined above
				title =	name,
				body = desc
				
			}	
		end		
		ItemProperties.SetActiveItem(itemData)	
	else
		
		
		local qtaLbl = "Hotbar".. hotbarId .. "Button" ..slot .."Quantity"
		local qta
		if (DoesWindowNameExist(qtaLbl)) then
			qta = LabelGetText(qtaLbl)
		end

		local detailType = ItemProperties.DETAIL_SHORT
		if(SystemData.Settings.Interface.showTooltips) then
			detailType = ItemProperties.DETAIL_LONG
		end
		local itemType = WindowData.ItemProperties.TYPE_ACTION
		if( type == SystemData.UserAction.TYPE_USE_ITEM )  then
			itemType = WindowData.ItemProperties.TYPE_ITEM
	    end
	    local itemData
		local id = itemId
		if (type == SystemData.UserAction.TYPE_USE_OBJECTTYPE) then
			id = UserActionGetNextObjectId(itemId)
		end
		if(DoesPlayerHaveItem(id)) then
			itemData = { windowName = "Hotbar"..hotbarId,
							itemId = id,
							itemType = WindowData.ItemProperties.TYPE_ITEM,
							detail = ItemProperties.DETAIL_LONG,
							itemLoc = {hotbarId=hotbarId, itemIndex=itemIndex},
							binding = bindingText, -- As defined above
							myTarget = targetText, }
		else
			if DoesWindowNameExist("Hotbar"..hotbarId.."Button"..slot.."Disabled" ) and WindowGetShowing("Hotbar"..hotbarId.."Button"..slot.."Disabled" ) == true then
				local abilityId = id
				local r,g,b = WindowGetTintColor("Hotbar"..hotbarId.."Button"..slot.."Disabled")				
				
				if actionType == SystemData.UserAction.TYPE_WEAPON_ABILITY then					
					abilityId = EquipmentData.GetWeaponAbilityId(id) + CharacterAbilities.WEAPONABILITY_OFFSET
				end

				local _, _, tid, desctid, _, _, _, minskill, mCost = GetAbilityData(abilityId)

				local name = GetStringFromTid(tid)
				local desc = L""
				
				if(detailType ~= ItemProperties.DETAIL_SHORT) then
					desc = GetStringFromTid(desctid) .. L"\n"
				end	
				
				if not minskill or minskill == 0 then
					minskill = SpellsInfo.GetMinSkill(abilityId)
					if not minskill then
						minskill = 0
					end
				end
				
				if r == 0 and g == 0 and b == 255 then
					if actionType == SystemData.UserAction.TYPE_WEAPON_ABILITY then
						local mana = AbilitiesInfo.GetManaCost(abilityId)
						if BuffDebuff.BuffWindowId[1104] then -- Mana Phase
							mana = 0
						end
						desc = desc .. L"\n" .. ReplaceTokens(GetStringFromTid(1060181), { towstring(mana) } ) .. L"\n"
					elseif actionType == SystemData.UserAction.TYPE_SPELL then
						
						lmcMana = math.floor(mCost - (mCost * (tonumber(WindowData.PlayerStatus["LowerManaCost"]) / 100)))
						if BuffDebuff.BuffWindowId[1104] then -- Mana Phase
							lmcMana = 0
						end
						desc = desc .. L"\n" .. ReplaceTokens(GetStringFromTid(1060181), { towstring(lmcMana) } ) .. L"\n"
					end
				else
					local mhandId = WindowData.Paperdoll[WindowData.PlayerStatus.PlayerId][4].slotId
					local lance = false
					if mhandId ~= 0 then
						if not WindowData.ObjectInfo[mhandId] then
							RegisterWindowData(WindowData.ObjectInfo.Type, mhandId)
						end
						if WindowData.ObjectInfo[mhandId] then
							local objType = WindowData.ObjectInfo[mhandId].objectType
							if objType == 18634 or objType == 18635 or objType == 9920 or objType == 9930 then
								lance = true
							end
						end
					end
					
					if (actionType == SystemData.UserAction.TYPE_WEAPON_ABILITY and EquipmentData.GetWeaponAbilityId(id) == 22 ) and not (BuffDebuff.BuffWindowId[1054] or IsRiding()) then
						desc = desc .. L"\n" .. GetStringFromTid(1070770) .. L"\n"
					elseif (actionType == SystemData.UserAction.TYPE_WEAPON_ABILITY and EquipmentData.GetWeaponAbilityId(id) == 6 ) and (BuffDebuff.BuffWindowId[1054] or IsRiding()) and not lance then
						desc = desc .. L"\n" .. GetStringFromTid(1061283) .. L"\n"
					elseif (abilityId == 56 or abilityId == 106 or abilityId == 107 or abilityId == 116 or abilityId == 609 or abilityId == 613 or abilityId == 685 or abilityId == 508 ) and BuffDebuff.BuffWindowId[1054] then
						desc = desc .. L"\n" .. GetStringFromTid(1113415) .. L"\n"
					elseif abilityId == 604 and BuffDebuff.Timers[1021] and actionType == SystemData.UserAction.TYPE_SPELL then
						desc = desc .. L"\n" .. GetStringFromTid(1005417) .. L"\n"
					elseif abilityId == 613 and BuffDebuff.Timers[1024] and actionType == SystemData.UserAction.TYPE_SPELL then
						desc = desc .. L"\n" .. GetStringFromTid(1005417) .. L"\n"
					elseif abilityId == 681 and BuffDebuff.Timers[1091] and actionType == SystemData.UserAction.TYPE_SPELL then
						desc = desc .. L"\n" .. GetStringFromTid(501775) .. L"\n"
					elseif (actionType == SystemData.UserAction.TYPE_WEAPON_ABILITY or actionType == SystemData.UserAction.TYPE_SPELL) and IsPlayerDead() then
						desc = desc .. L"\n" .. GetStringFromTid(1060169) .. L"\n"
					elseif (actionType == SystemData.UserAction.TYPE_WEAPON_ABILITY or actionType == SystemData.UserAction.TYPE_SPELL) and Interface.CurrentSpell.casting then	
						desc = desc .. L"\n" .. GetStringFromTid(502165) .. L"\n"
					elseif (actionType == SystemData.UserAction.TYPE_SPELL) and (HotbarSystem.StunTime > 0 or BuffDebuff.Timers[1037]) then	
						desc = desc .. L"\n" .. GetStringFromTid(502646) .. L"\n"
					elseif (actionType == SystemData.UserAction.TYPE_WEAPON_ABILITY) and (HotbarSystem.StunTime > 0 or BuffDebuff.Timers[1037]) then	
						desc = desc .. L"\n" .. GetStringFromTid(1060170) .. L"\n"
					elseif actionType == SystemData.UserAction.TYPE_WEAPON_ABILITY then
						 if not AbilitiesInfo.CanUse(abilityId) then
							desc = desc .. L"\n" .. GetStringFromTid(1049536) .. L"\n"
						 end
					elseif actionType == SystemData.UserAction.TYPE_SPELL then
						local serverId = WindowData.SkillsCSV[SpellsInfo.GetSkillID(abilityId)].ServerId
						local SkillLevel = WindowData.SkillDynamicData[serverId].TempSkillValue / 10
						local targetType = UserActionGetTargetType(hotbarId,itemIndex,1)

						-- TODO: paralyze check 1037
						if Interface.SpellRecovery > 0 then
							desc = desc .. L"\n" .. GetStringFromTid(502644) .. L"\n"
						elseif SkillLevel < minskill then
							desc = desc .. L"\n" .. GetStringFromTid(1049536) .. L"\n"
						elseif targetType and targetType == SystemData.Hotbar.TargetType.TARGETTYPE_CURRENT then
							desc = desc .. L"\n" .. GetStringFromTid(500643) .. L"\n"
						end
					end
				end
						
				itemData = { windowName = "Hotbar"..hotbarId,
						itemId = itemId,
						detail = detailType,
						itemType = itemType,
						actionType = actionType,
						itemLoc = {hotbarId=hotbarId, itemIndex=itemIndex},
						itemType = WindowData.ItemProperties.TYPE_WSTRINGDATA,
						binding = bindingText, -- As defined above
						title =	name,
						body = desc
					}								
			else				
				itemData = { windowName = "Hotbar"..hotbarId,
							itemId = itemId,
							itemType = itemType,
							actionType = actionType,
							detail = detailType,
							itemLoc = {hotbarId=hotbarId, itemIndex=itemIndex},
							binding = bindingText, -- As defined above
							myTarget = targetText, }
			end
			
		end

		if (DoesWindowNameExist("Hotbar"..hotbarId.."Button"..slot.."Disabled" )) then
			if(not DoesWindowNameExist("Hotbar"..hotbarId.."Button"..slot.."Disabled" ) or not WindowGetShowing("Hotbar"..hotbarId.."Button"..slot.."Disabled" ) or itemType ~= WindowData.ItemProperties.TYPE_ITEM) then
				ItemProperties.SetActiveItem(itemData)
			end
		else			
			ItemProperties.SetActiveItem(itemData)
		end
	end
	
end

function Hotbar.KeyRecorded()
	if( Hotbar.RecordingKey == true ) then
		Hotbar.RecordingKey = false
		WindowSetShowing("AssignHotkeyInfo",false)
		
		if( SystemData.BindingConflictType ~= SystemData.BindType.BINDTYPE_NONE )then
			body = GetStringFromTid( Hotbar.TID_BINDING_CONFLICT_BODY )..L"\n\n"..HotbarSystem.GetKeyName(SystemData.BindingConflictHotbarId, SystemData.BindingConflictItemIndex, SystemData.BindingConflictType)..L"\n\n"..GetStringFromTid( Hotbar.TID_BINDING_CONFLICT_QUESTION )
			
			local yesButton = { textTid = Hotbar.TID_YES,
								callback =	function()
											HotbarSystem.ReplaceKey(
												SystemData.BindingConflictHotbarId, SystemData.BindingConflictItemIndex, SystemData.BindingConflictType,
												Hotbar.RecordingHotbar, Hotbar.RecordingSlot, SystemData.BindType.BINDTYPE_HOTBAR,
												SystemData.RecordedKey, SystemData.RecordedKeySmallDisplay)
											end
							  }
			local noButton = { textTid = Hotbar.TID_NO }
			local windowData = 
			{
				windowName = "Hotbar", 
				titleTid = Hotbar.TID_BINDING_CONFLICT_TITLE, 
				body = body, 
				buttons = { yesButton, noButton }
			}
			UO_StandardDialog.CreateDialog( windowData )
	    else
            SystemData.Hotbar[Hotbar.RecordingHotbar].Bindings[Hotbar.RecordingSlot] = SystemData.RecordedKey
	        SystemData.Hotbar[Hotbar.RecordingHotbar].BindingDisplayStrings[Hotbar.RecordingSlot] = SystemData.RecordedKeySmallDisplay
        		
	        HotbarUpdateBinding(Hotbar.RecordingHotbar,Hotbar.RecordingSlot,SystemData.RecordedKey)
	        local element = "Hotbar"..Hotbar.RecordingHotbar.."Button"..Hotbar.RecordingSlot
	        HotbarSystem.UpdateBinding(element,SystemData.RecordedKeySmallDisplay,SystemData.RecordedKey)
		end
	end
end

function Hotbar.KeyCancelRecord()
	if( Hotbar.RecordingKey == true ) then
		Hotbar.RecordingKey = false
		WindowSetShowing("AssignHotkeyInfo",false)
	end
end

function Hotbar.OnResizeBegin()
	this = WindowUtils.GetActiveDialog()
	local hotbarId = WindowGetId(this)
	if not SystemData.Hotbar[hotbarId].Locked then
		local width, height = WindowGetDimensions(this)
		local widthMin = 70
		local heightMin = 70
		if (width >= height) then
			heightMin = 50
		else
			widthMin = 50
		end
		WindowUtils.BeginResize( this, "topleft", widthMin, heightMin, false, Hotbar.OnResizeEnd)
	end
end

function Hotbar.OnResizeEnd(curWindow)
	local closed = Interface.LoadBoolean( curWindow.. "Closed",false )
	if (closed) then
		return
	end
	local width, height = WindowGetDimensions(curWindow)
	
	--Debug.Print("Hotbar.OnResizeEnd: "..curWindow.." width: "..width..", height: "..height)
	
	local hotbarId = WindowGetId(curWindow)
	local locked = SystemData.Hotbar[hotbarId].Locked
	
	-- used to compensate for larger hotbar window size caused by a visible handle
	local handleOffset = locked and 0 or Hotbar.HANDLE_OFFSET
	
	if( width > height ) then
		-- show the correct handle if not locked
		WindowSetShowing(curWindow.."HorizHandle", not locked)
		WindowSetShowing(curWindow.."VertHandle", false)
		
		WindowSetShowing("Hotbar" .. hotbarId .. "MaximizeButtonV" , false)
		WindowSetShowing("Hotbar" .. hotbarId .. "MaximizeButtonH" , false)
		WindowSetShowing("Hotbar" .. hotbarId .. "MinimizeButtonV" , false)
		WindowSetShowing("Hotbar" .. hotbarId .. "MinimizeButtonH" , true)
			
		-- anchor the first button to the handle if not locked (otherwise anchors the button to the hotbar's top left)
		WindowClearAnchors(curWindow.."Button"..1)

		if locked then
			WindowAddAnchor(curWindow.."Button"..1,"topleft",curWindow,"topleft",0,0)
		else
			WindowAddAnchor(curWindow.."Button"..1,"topright",curWindow.."HorizHandle","topleft",0,0)
		end
		
		-- anchor the rest of the buttons to the previous one
		-- and hide the ones that are outside the window
		for slot=2, Hotbar.NUM_BUTTONS do
			local button = curWindow.."Button"..slot
			if( (slot * Hotbar.BUTTON_SIZE) > (width + handleOffset) ) then
				WindowSetShowing(button, false)
			else
				local relativeTo = curWindow.."Button"..(slot-1)
				WindowClearAnchors(button)
				WindowAddAnchor(button,"topright",relativeTo,"topleft",0,0)			
				WindowSetShowing(button, true)
			end
		end
	
		local numVisibleButtons = math.min(math.floor((width+handleOffset)/Hotbar.BUTTON_SIZE),Hotbar.NUM_BUTTONS)
		local newHeight = Hotbar.BUTTON_SIZE
		local newWidth = math.min((numVisibleButtons * Hotbar.BUTTON_SIZE) + handleOffset, (Hotbar.BUTTON_SIZE * Hotbar.NUM_BUTTONS) + handleOffset)
		WindowSetDimensions(curWindow,newWidth,newHeight)
		
		WindowClearAnchors(curWindow .. "Lock")
		WindowAddAnchor(curWindow .. "Lock","bottomleft","Hotbar"..hotbarId.."HorizHandle","bottomleft",2,-2)
	else
		-- show the correct handle if not locked
		WindowSetShowing(curWindow.."HorizHandle",false)
		WindowSetShowing(curWindow.."VertHandle", not locked)
		
		WindowSetShowing("Hotbar" .. hotbarId .. "MaximizeButtonV" , false)
		WindowSetShowing("Hotbar" .. hotbarId .. "MaximizeButtonH" , false)
		WindowSetShowing("Hotbar" .. hotbarId .. "MinimizeButtonH" , false)
		WindowSetShowing("Hotbar" .. hotbarId .. "MinimizeButtonV" , true)
		
		-- anchor the first button to the handle if not locked
		WindowClearAnchors(curWindow.."Button"..1)
		if locked then
			WindowAddAnchor(curWindow.."Button"..1,"topright",curWindow,"topright",0,0)
		else
			WindowAddAnchor(curWindow.."Button"..1,"bottomright",curWindow.."VertHandle","topright",0,0)
		end
		
		-- anchor the rest of the buttons to the previous one
		-- and hide the ones that are outside the window
		for slot=2, Hotbar.NUM_BUTTONS do
			local button = curWindow.."Button"..slot
			if( (slot * Hotbar.BUTTON_SIZE) > (height + handleOffset) ) then
				WindowSetShowing(button, false)
			else
				local relativeTo = curWindow.."Button"..(slot-1)
				WindowClearAnchors(button)
				WindowAddAnchor(button,"bottomleft",relativeTo,"topleft",0,0)			
				WindowSetShowing(button, true)
			end
		end

		local numVisibleButtons = math.floor((height+handleOffset)/Hotbar.BUTTON_SIZE)
		local newHeight = math.min((numVisibleButtons * Hotbar.BUTTON_SIZE) + handleOffset, (Hotbar.BUTTON_SIZE * Hotbar.NUM_BUTTONS) + handleOffset)
		local newWidth = Hotbar.BUTTON_SIZE
		WindowSetDimensions(curWindow,newWidth,newHeight)		
		
		
		WindowClearAnchors(curWindow .. "Lock")
		WindowAddAnchor(curWindow .. "Lock","topleft","Hotbar"..hotbarId.."VertHandle","topleft",0,0)
	end
	
	if locked then
		WindowSetShowing("Hotbar" .. hotbarId .. "MaximizeButtonV" , false)
		WindowSetShowing("Hotbar" .. hotbarId .. "MaximizeButtonH" , false)
		WindowSetShowing("Hotbar" .. hotbarId .. "MinimizeButtonV" , false)
		WindowSetShowing("Hotbar" .. hotbarId .. "MinimizeButtonH" , false)
	end
	
	if (not Interface.LoadBoolean( curWindow .. "ReverseText", false ) ) then
		WindowSetShowing(curWindow .. "NameVrev", false)
		WindowSetShowing(curWindow .. "NameHrev", false)
		if (width < height) then
			WindowSetShowing(curWindow .. "NameV", false)
			WindowSetShowing(curWindow .. "NameH", true)
		else
			WindowSetShowing(curWindow .. "NameV", true)
			WindowSetShowing(curWindow .. "NameH", false)
		end
	else
		WindowSetShowing(curWindow .. "NameV", false)
		WindowSetShowing(curWindow .. "NameH", false)
		if (width < height) then
			WindowSetShowing(curWindow .. "NameVrev", false)
			WindowSetShowing(curWindow .. "NameHrev", true)
		else
			WindowSetShowing(curWindow .. "NameVrev", true)
			WindowSetShowing(curWindow .. "NameHrev", false)
		end
	end	
end

function Hotbar.OnHandleLButDown(flags, _, _)
	local hotbarId = WindowGetId(WindowUtils.GetActiveDialog())
	local hotbarWindow = WindowGetParent(SystemData.ActiveWindow.name)

	if not SystemData.Hotbar[hotbarId].Locked and not Interface.LoadBoolean( hotbarWindow .. "LockWithHandle", false ) then

		if flags == SystemData.ButtonFlags.SHIFT and not WindowGetMoving(hotbarWindow) then
			Hotbar.FindHotbarMovingBlock(hotbarWindow)
			WindowSetMoving(hotbarWindow, true)
		else
			
			SnapUtils.StartWindowSnap( hotbarWindow )
		end
	end
end

function Hotbar.OnHandleLButUp(_, _, _)
	local hotbarWindow = WindowGetParent(SystemData.ActiveWindow.name)
	
	if WindowGetMoving(hotbarWindow) then
		WindowSetMoving(hotbarWindow, false)
		return
	end
	for windowName,_ in pairs(Hotbar.InMovement) do
		WindowSetMoving(windowName, false)
		Hotbar.InMovement[windowName] = nil
	end
end


function Hotbar.ShrinkTooltip()
	local windowname = WindowUtils.GetActiveDialog()
	local closed = Interface.LoadBoolean( windowname.. "Closed",false )
	if (closed) then
		Tooltips.CreateTextOnlyTooltip(SystemData.ActiveWindow.name, GetStringFromTid(1155233))
	else
		Tooltips.CreateTextOnlyTooltip(SystemData.ActiveWindow.name, GetStringFromTid(1155234))
	end
	
	Tooltips.Finalize()
	Tooltips.AnchorTooltip( Tooltips.ANCHOR_WINDOW_TOP )
	
	local hotbarId = WindowGetId(WindowUtils.GetActiveDialog())
	Hotbar.ShowBar("Hotbar" .. hotbarId)
end

function Hotbar.ShowBar(windowName)
	WindowStopAlphaAnimation(windowName)
	local alpha = Interface.LoadNumber( windowName.."ALP", -5 )
	if (alpha ~= nil and alpha ~= -5) then
		WindowSetAlpha(windowName, alpha)
	else
		WindowSetAlpha(windowName, 1)
	end
end

function Hotbar.ItemMouseOverEnd()
	Hotbar.HideBar(WindowGetParent(SystemData.ActiveWindow.name))
	ItemProperties.ClearMouseOverItem()
end

function Hotbar.HandleMouseOver()
	local hotbarId = WindowGetId(WindowUtils.GetActiveDialog())
	Hotbar.ShowBar("Hotbar" .. hotbarId)
end

function Hotbar.HideBar(windowName)
	if Interface.LoadBoolean( windowName.. "Fade",false ) then
		local alpha = Interface.LoadNumber( windowName.."ALP", -5 )
		if (alpha == nil or alpha == -5) then
			alpha = 1
		end
		WindowStartAlphaAnimation(windowName, Window.AnimationType.SINGLE_NO_RESET, alpha, 0.01, 2, false, 1, 1 )
	end
end

function Hotbar.LockTooltip()
	local windowname = WindowUtils.GetActiveDialog()

	if ( Interface.LoadBoolean( windowname .. "LockWithHandle", false )  ) then
		Tooltips.CreateTextOnlyTooltip(SystemData.ActiveWindow.name, GetStringFromTid(1111696))
	else
		Tooltips.CreateTextOnlyTooltip(SystemData.ActiveWindow.name, GetStringFromTid(1111697))
	end
	
	Tooltips.Finalize()
	Tooltips.AnchorTooltip( Tooltips.ANCHOR_WINDOW_TOP )
end

function Hotbar.Lock()
	local windowname = WindowUtils.GetActiveDialog()
		
	local texture = "UO_Core"
	if ( not Interface.LoadBoolean( windowname .. "LockWithHandle", false )  ) then
		Interface.SaveBoolean( windowname .. "LockWithHandle", true )
		SystemData.Hotbar[WindowGetId(windowname)].Locked = false
		ButtonSetTexture(windowname.."Lock", InterfaceCore.ButtonStates.STATE_NORMAL, texture, 69,341)
		ButtonSetTexture(windowname.."Lock",InterfaceCore.ButtonStates.STATE_NORMAL_HIGHLITE, texture, 92,341)
		ButtonSetTexture(windowname.."Lock", InterfaceCore.ButtonStates.STATE_PRESSED, texture, 92,341)
		ButtonSetTexture(windowname.."Lock", InterfaceCore.ButtonStates.STATE_PRESSED_HIGHLITE, texture, 92,341)
	else
		Interface.SaveBoolean( windowname .. "LockWithHandle", false )
		ButtonSetTexture(windowname.."Lock", InterfaceCore.ButtonStates.STATE_NORMAL, texture, 117,341)
		ButtonSetTexture(windowname.."Lock",InterfaceCore.ButtonStates.STATE_NORMAL_HIGHLITE, texture, 142,341)
		ButtonSetTexture(windowname.."Lock", InterfaceCore.ButtonStates.STATE_PRESSED, texture, 142,341)
		ButtonSetTexture(windowname.."Lock", InterfaceCore.ButtonStates.STATE_PRESSED_HIGHLITE, texture, 142,341)		
	end			
end

function Hotbar.SpecialLock()
	local windowname = WindowUtils.GetActiveDialog()
	
	local width = Interface.LoadNumber( windowname .. "SizeW", 50 )
	local height = Interface.LoadNumber( windowname .. "SizeH", 50 )
	
	local w,h = WindowGetDimensions(windowname)
	if w > width then
		width = w
	end
	if h > height then
		height = h
	end
	
	if (not Interface.LoadBoolean( windowname .. "LeftToRight", false ) ) then
		if (width > height) then
			ContextMenu.CreateLuaContextMenuItemWithString(GetStringFromTid(1154845),0,"closeR",{wind=windowname, side =GetStringFromTid(1155245)} ,false)
		else
			ContextMenu.CreateLuaContextMenuItemWithString(GetStringFromTid(1155236),0,"closeR",{wind=windowname, side =GetStringFromTid(1155246)},false)
		end
	else
		if (width > height) then
			ContextMenu.CreateLuaContextMenuItemWithString(GetStringFromTid(1154846),0,"closeL",{wind=windowname, side =GetStringFromTid(1155247)},false)
		else
			ContextMenu.CreateLuaContextMenuItemWithString(GetStringFromTid(1155238),0,"closeL",{wind=windowname, side =GetStringFromTid(1155248)},false)
		end
	end
	
	
	
	ContextMenu.CreateLuaContextMenuItemWithString(GetStringFromTid(1155239),0,"HandleColor",{wind=windowname, side =L"HandleColor"} ,false)
	
	ContextMenu.CreateLuaContextMenuItemWithString(GetStringFromTid(1155240),0,"Reverse",{wind=windowname} ,Interface.LoadBoolean( windowname .. "ReverseText", false ))
	
	ContextMenu.CreateLuaContextMenuItemWithString(GetStringFromTid(1155241),0,"SetText",{wind=windowname} ,false)
	
	ContextMenu.ActivateLuaContextMenu(Hotbar.ContextMenuCallbackLock)
end

function Hotbar.ContextMenuCallbackLock( returnCode, param )
	local windowname = param.wind

	if ( returnCode=="lock" ) then
		Interface.SaveBoolean( windowname .. "LockWithHandle", true )
		ChatWindow.Print(GetStringFromTid(1155242))
	elseif ( returnCode=="unlock" ) then
		Interface.SaveBoolean( windowname .. "LockWithHandle", false )
		ChatWindow.Print(GetStringFromTid(1155243))
	elseif ( returnCode=="closeR" ) then
		Interface.SaveBoolean( windowname .. "LeftToRight", true )
		ChatWindow.Print(ReplaceTokens(GetStringFromTid(1155244), { param.side }))
		if (param.side == GetStringFromTid(1155245)) then

			ButtonSetTexture(windowname .. "MinimizeButtonH", InterfaceCore.ButtonStates.STATE_NORMAL, "ExtractRight", 0, 0)
			ButtonSetTexture(windowname .. "MinimizeButtonH", InterfaceCore.ButtonStates.STATE_NORMAL_HIGHLITE, "ExtractRight", 24 , 0)
			ButtonSetTexture(windowname .. "MinimizeButtonH", InterfaceCore.ButtonStates.STATE_PRESSED, "ExtractLeft", 24 , 0)
			ButtonSetTexture(windowname .. "MinimizeButtonH", InterfaceCore.ButtonStates.STATE_PRESSED_HIGHLITE, "ExtractRight", 24 , 0)
				
			ButtonSetTexture(windowname .. "MaximizeButtonH", InterfaceCore.ButtonStates.STATE_NORMAL, "ExtractLeft", 24, 0)
			ButtonSetTexture(windowname .. "MaximizeButtonH", InterfaceCore.ButtonStates.STATE_NORMAL_HIGHLITE, "ExtractLeft", 0 , 0)
			ButtonSetTexture(windowname .. "MaximizeButtonH", InterfaceCore.ButtonStates.STATE_PRESSED, "ExtractLeft", 0 , 0)
			ButtonSetTexture(windowname .. "MaximizeButtonH", InterfaceCore.ButtonStates.STATE_PRESSED_HIGHLITE, "ExtractLeft", 0 , 0)
		else
			ButtonSetTexture(windowname .. "MinimizeButtonV", InterfaceCore.ButtonStates.STATE_NORMAL, "updown", 50, 1)
			ButtonSetTexture(windowname .. "MinimizeButtonV", InterfaceCore.ButtonStates.STATE_NORMAL_HIGHLITE, "updown", 76 , 0)
			ButtonSetTexture(windowname .. "MinimizeButtonV", InterfaceCore.ButtonStates.STATE_PRESSED, "updown", 76 , 0)
			ButtonSetTexture(windowname .. "MinimizeButtonV", InterfaceCore.ButtonStates.STATE_PRESSED_HIGHLITE, "updown", 76 , 0)
				
			ButtonSetTexture(windowname .. "MaximizeButtonV", InterfaceCore.ButtonStates.STATE_NORMAL, "updown", 27, 0)
			ButtonSetTexture(windowname .. "MaximizeButtonV", InterfaceCore.ButtonStates.STATE_NORMAL_HIGHLITE, "updown", 3 , 2)
			ButtonSetTexture(windowname .. "MaximizeButtonV", InterfaceCore.ButtonStates.STATE_PRESSED, "updown", 3 , 2)
			ButtonSetTexture(windowname .. "MaximizeButtonV", InterfaceCore.ButtonStates.STATE_PRESSED_HIGHLITE, "updown", 3 , 2)
		end
	elseif ( returnCode=="closeL" ) then
		Interface.SaveBoolean( windowname .. "LeftToRight", false )
		ChatWindow.Print(ReplaceTokens(GetStringFromTid(1155244), { param.side }))
		if (param.side == GetStringFromTid(1155247)) then
			ButtonSetTexture(windowname .. "MaximizeButtonH", InterfaceCore.ButtonStates.STATE_NORMAL, "ExtractRight", 0, 0)
			ButtonSetTexture(windowname .. "MaximizeButtonH", InterfaceCore.ButtonStates.STATE_NORMAL_HIGHLITE, "ExtractRight", 24 , 0)
			ButtonSetTexture(windowname .. "MaximizeButtonH", InterfaceCore.ButtonStates.STATE_PRESSED, "ExtractLeft", 24 , 0)
			ButtonSetTexture(windowname .. "MaximizeButtonH", InterfaceCore.ButtonStates.STATE_PRESSED_HIGHLITE, "ExtractRight", 24 , 0)
				
			ButtonSetTexture(windowname .. "MinimizeButtonH", InterfaceCore.ButtonStates.STATE_NORMAL, "ExtractLeft", 24, 0)
			ButtonSetTexture(windowname .. "MinimizeButtonH", InterfaceCore.ButtonStates.STATE_NORMAL_HIGHLITE, "ExtractLeft", 0 , 0)
			ButtonSetTexture(windowname .. "MinimizeButtonH", InterfaceCore.ButtonStates.STATE_PRESSED, "ExtractLeft", 0 , 0)
			ButtonSetTexture(windowname .. "MinimizeButtonH", InterfaceCore.ButtonStates.STATE_PRESSED_HIGHLITE, "ExtractLeft", 0 , 0)
		else
			ButtonSetTexture(windowname .. "MaximizeButtonV", InterfaceCore.ButtonStates.STATE_NORMAL, "updown", 50, 1)
			ButtonSetTexture(windowname .. "MaximizeButtonV", InterfaceCore.ButtonStates.STATE_NORMAL_HIGHLITE, "updown", 76 , 0)
			ButtonSetTexture(windowname .. "MaximizeButtonV", InterfaceCore.ButtonStates.STATE_PRESSED, "updown", 76 , 0)
			ButtonSetTexture(windowname .. "MaximizeButtonV", InterfaceCore.ButtonStates.STATE_PRESSED_HIGHLITE, "updown", 76 , 0)
				
			ButtonSetTexture(windowname .. "MinimizeButtonV", InterfaceCore.ButtonStates.STATE_NORMAL, "updown", 27, 0)
			ButtonSetTexture(windowname .. "MinimizeButtonV", InterfaceCore.ButtonStates.STATE_NORMAL_HIGHLITE, "updown", 3 , 2)
			ButtonSetTexture(windowname .. "MinimizeButtonV", InterfaceCore.ButtonStates.STATE_PRESSED, "updown", 3 , 2)
			ButtonSetTexture(windowname .. "MinimizeButtonV", InterfaceCore.ButtonStates.STATE_PRESSED_HIGHLITE, "updown", 3 , 2)
		end
	elseif ( returnCode=="Reverse" ) then
		local stat = not Interface.LoadBoolean( windowname .. "ReverseText", false )
		Interface.SaveBoolean( windowname .. "ReverseText", stat )
		local width, height = WindowGetDimensions(windowname)
		if (not stat ) then
			WindowSetShowing(windowname .. "NameVrev", false)
			WindowSetShowing(windowname .. "NameHrev", false)
			if (width < height) then
				WindowSetShowing(windowname .. "NameV", false)
				WindowSetShowing(windowname .. "NameH", true)
			else
				WindowSetShowing(windowname .. "NameV", true)
				WindowSetShowing(windowname .. "NameH", false)
			end
		else
			WindowSetShowing(windowname .. "NameV", false)
			WindowSetShowing(windowname .. "NameH", false)
			if (width < height) then
				WindowSetShowing(windowname .. "NameVrev", false)
				WindowSetShowing(windowname .. "NameHrev", true)
			else
				WindowSetShowing(windowname .. "NameVrev", true)
				WindowSetShowing(windowname .. "NameHrev", false)
			end
		end
	elseif ( returnCode=="SetText" ) then
		local rdata = {title=GetStringFromTid(1077826), subtitle=GetStringFromTid(1155249), callfunction=Hotbar.SetText, id=windowname}
		RenameWindow.Create(rdata)
	elseif ( returnCode=="HandleColor" ) then	
		Hotbar.PickColor(param.side, windowname)
	end	
end

function Hotbar.CreateNew(_, _)
	HotbarSystem.SpawnNewHotbar(_, 12)
end

function Hotbar.SetText(windowname, text)
	Interface.SaveWString( windowname .. "CustomText", text )
	LabelSetText(windowname .. "NameH", text)
	LabelSetText(windowname .. "NameV", text)
	LabelSetText(windowname .. "NameVrev", text)
	LabelSetText(windowname .. "NameHrev", text)
end

function Hotbar.PickColor(_, windowname)
	Hotbar.CurrentChangeColorWindow = windowname
	local defaultColors = {
		0, --HUE_NONE 
		34, --HUE_RED
		53, --HUE_YELLOW
		63, --HUE_GREEN
		89, --HUE_BLUE
		119, --HUE_PURPLE
		144, --HUE_ORANGE
		368, --HUE_GREEN_2
		946, --HUE_GREY
		}
		local hueTable = {}
		for idx, hue in pairs(defaultColors) do
			for i=0,8 do
				hueTable[(idx-1)*10+i+1] = hue+i
			end
		end
		CreateWindowFromTemplate( "ColorPicker", "ColorPickerWindowTemplate", "Root" )
		WindowSetLayer( "ColorPicker", Window.Layers.SECONDARY	)
		ColorPickerWindow.SetNumColorsPerRow(9)
		ColorPickerWindow.SetSwatchSize(30)
		ColorPickerWindow.SetWindowPadding(4,4)
		ColorPickerWindow.SetFrameEnabled(true)
		ColorPickerWindow.SetCloseButtonEnabled(true)
		ColorPickerWindow.SetColorTable(hueTable,"ColorPicker")
		ColorPickerWindow.DrawColorTable("ColorPicker")
		ColorPickerWindow.SetAfterColorSelectionFunction(Hotbar.ColorPicked)
		WindowAddAnchor( "ColorPicker", "center", "Root", "center", 0, 0)
		ColorPickerWindow.SetFrameEnabled(false)
		WindowSetShowing( "ColorPicker", true )
		ColorPickerWindow.SelectColor("ColorPicker", 1)
end

function Hotbar.ColorPicked()
		local huePicked = ColorPickerWindow.colorSelected["ColorPicker"]
		local color = {}
		color.r, color.g, color.b = HueRGBAValue(huePicked)
		Interface.SaveColor(Hotbar.CurrentChangeColorWindow .. "HandleColor",color)
		WindowSetTintColor(Hotbar.CurrentChangeColorWindow .. "HorizHandle", color.r, color.g, color.b)
		WindowSetTintColor(Hotbar.CurrentChangeColorWindow .. "VertHandle", color.r, color.g, color.b)
		LabelSetTextColor(Hotbar.CurrentChangeColorWindow .. "NameH", color.r, color.g, color.b)
		LabelSetTextColor(Hotbar.CurrentChangeColorWindow .. "NameV", color.r, color.g, color.b)
		LabelSetTextColor(Hotbar.CurrentChangeColorWindow .. "NameVrev", color.r, color.g, color.b)
		LabelSetTextColor(Hotbar.CurrentChangeColorWindow .. "NameHrev", color.r, color.g, color.b)
		DestroyWindow("ColorPicker")
end

function Hotbar.ShrinkBDown(flags)
	local windowName = WindowUtils.GetActiveDialog()
	if not Interface.LoadBoolean( windowName.. "Closed",false ) then
		Hotbar.Shrink(windowName)
		if flags == SystemData.ButtonFlags.SHIFT then
			Hotbar.FindHotbarShrinkBlock(windowName)
		end
	else
		Hotbar.Enlarge(windowName)
		if flags == SystemData.ButtonFlags.SHIFT then
			Hotbar.FindHotbarEnlargeBlock(windowName)
		end
	end
end

function Hotbar.Shrink(hotbar)
	local windowname = hotbar
	
	local text = string.find(windowname, "Hotbar")
	if (not text) then
		return
	end
	--local currentButton = windowname .. "MinimizeButtonH"--SystemData.ActiveWindow.name
	local width, height = WindowGetDimensions(windowname)

	Interface.SaveNumber( windowname .. "SizeW", width )
	Interface.SaveNumber( windowname .. "SizeH", height )
	local x, y = WindowGetOffsetFromParent(windowname)

	Interface.SaveBoolean( windowname.. "Closed",true )
	
	WindowSetShowing(windowname .. "HorizHandle" , false)
	WindowSetShowing(windowname .. "VertHandle" , false)
	WindowSetShowing(windowname .. "MinimizeButtonH" , false)
	WindowSetShowing(windowname .. "MaximizeButtonH" , false)
	WindowSetShowing(windowname .. "MinimizeButtonV" , false)
	WindowSetShowing(windowname .. "MaximizeButtonV" , false)
	
		
	if (not Interface.LoadBoolean( windowname .. "ReverseText", false ) ) then
		WindowSetShowing(windowname .. "NameVrev", false)
		WindowSetShowing(windowname .. "NameHrev", false)
		if (width > height) then
			WindowSetShowing(windowname .. "NameV", false)
			WindowSetShowing(windowname .. "NameH", true)
		else
			WindowSetShowing(windowname .. "NameV", true)
			WindowSetShowing(windowname .. "NameH", false)
		end
	else
		WindowSetShowing(windowname .. "NameV", false)
		WindowSetShowing(windowname .. "NameH", false)
		if (width > height) then
			WindowSetShowing(windowname .. "NameVrev", false)
			WindowSetShowing(windowname .. "NameHrev", true)
		else
			WindowSetShowing(windowname .. "NameVrev", true)
			WindowSetShowing(windowname .. "NameHrev", false)
		end
	end

	if (width > height) then
		
		WindowSetDimensions(windowname, 20, 50)
		WindowSetShowing(windowname .. "HorizHandle" , true)
		WindowSetShowing(windowname .. "MaximizeButtonH" , true)
		if (Interface.LoadBoolean( windowname .. "LeftToRight", false ) and Interface.TimeSinceLogin > 0.5 ) then
			if (WindowGetAnchorCount(windowname) > 0) then
				WindowClearAnchors(windowname)
			end
			WindowSetOffsetFromParent(windowname, (x + (width - 20)), y)
		end
		
	else
		WindowSetDimensions(windowname, 50, 20)
		WindowSetShowing(windowname .. "VertHandle" , true)
		WindowSetShowing(windowname .. "MaximizeButtonV" , true)
		if (Interface.LoadBoolean( windowname .. "LeftToRight", false ) and Interface.TimeSinceLogin > 0.5 ) then
			if (WindowGetAnchorCount(windowname) > 0) then
				WindowClearAnchors(windowname)
			end
			WindowSetOffsetFromParent(windowname, x, (y + (height - 20)))
		end
		
	end
	
	for slot=1, Hotbar.NUM_BUTTONS do
		local button = windowname.."Button"..slot
		WindowSetShowing(button, false)
	end
	button = windowname.."ResizeButton"
	WindowSetShowing(button, false)
	
end

function Hotbar.Enlarge(hotbar)
	local windowname = hotbar
	
	local text = string.find(windowname, "Hotbar")
	if (not text) then
		return
	end
	local currentButton = SystemData.ActiveWindow.name
	
	local width = Interface.LoadNumber( windowname .. "SizeW", 50 )
	local height = Interface.LoadNumber( windowname .. "SizeH", 50 )
	local x, y = WindowGetOffsetFromParent(windowname)
	Interface.SaveBoolean( windowname.. "Closed",false )
	WindowSetDimensions(windowname, width, height)
	
	if (not Interface.LoadBoolean( windowname .. "ReverseText", false ) ) then
		WindowSetShowing(windowname .. "NameVrev", false)
		WindowSetShowing(windowname .. "NameHrev", false)
		if (width < height) then
			WindowSetShowing(windowname .. "NameV", false)
			WindowSetShowing(windowname .. "NameH", true)
		else
			WindowSetShowing(windowname .. "NameV", true)
			WindowSetShowing(windowname .. "NameH", false)
		end
	else
		WindowSetShowing(windowname .. "NameV", false)
		WindowSetShowing(windowname .. "NameH", false)
		if (width < height) then
			WindowSetShowing(windowname .. "NameVrev", false)
			WindowSetShowing(windowname .. "NameHrev", true)
		else
			WindowSetShowing(windowname .. "NameVrev", true)
			WindowSetShowing(windowname .. "NameHrev", false)
		end
	end
		
	if (width > height) then
		WindowSetShowing(windowname.. "MinimizeButtonH" , true)

		if (currentButton) then
			WindowSetShowing(currentButton , false)
		else
			currentButton = windowname .. "MinimizeButtonH"
			WindowSetShowing(currentButton , false)
		end
		if (Interface.LoadBoolean( windowname .. "LeftToRight", false ) and Interface.TimeSinceLogin > 0.5 ) then
			if (WindowGetAnchorCount(windowname) > 0) then
				WindowClearAnchors(windowname)
			end
			WindowSetOffsetFromParent(windowname, (x - (width -20)), y)
				
		end
	else
		WindowSetShowing(windowname .. "MinimizeButtonV" , true)
		if (currentButton) then
			WindowSetShowing(currentButton , false)
		else
			currentButton = windowname .. "MinimizeButtonV"
			WindowSetShowing(currentButton , false)
		end
		
		if (Interface.LoadBoolean( windowname .. "LeftToRight", false ) and Interface.TimeSinceLogin > 0.5 ) then
			if (WindowGetAnchorCount(windowname) > 0) then
				WindowClearAnchors(windowname)
			end
			WindowSetOffsetFromParent(windowname, x, (y - (height - 20)))
		end
	end
	local button = windowname.."Button"..1
	WindowSetShowing(button, true)
	
	button = windowname.."ResizeButton"	
	WindowSetShowing(button, true)
	
	Hotbar.OnResizeEnd(windowname)	
end

function Hotbar.IsShrunken(hotbarId)
	local windowname = "Hotbar"..hotbarId	
	if not (DoesWindowNameExist(windowname)) then		
		return true
	end

	local alpha = WindowGetAlpha(windowname)
	if(alpha <= 0.5)then		
		return true
	end

	local resizeButton = windowname.."ResizeButton"
	if not (DoesWindowNameExist(resizeButton)) then		
		return false
	end

	if WindowGetShowing(resizeButton) == true then			
		return false		
	end

	return true
end

function Hotbar.OnHandleLButtonDown(_, _, _)
	local hotbarId = WindowGetId(WindowUtils.GetActiveDialog())
	if not SystemData.Hotbar[hotbarId].Locked and not Interface.LoadBoolean( "Hotbar" .. hotbarId .. "LockWithHandle", false ) then
		hotbarWindow = WindowGetParent(SystemData.ActiveWindow.name)
		SnapUtils.StartWindowSnap( hotbarWindow )
	end
end

function Hotbar.ShowBar(windowName)
	WindowStopAlphaAnimation(windowName)
	local alpha = Interface.LoadNumber( windowName.."ALP", -5 )
	if (alpha ~= nil and alpha ~= -5) then
		WindowSetAlpha(windowName, alpha)
	else
		WindowSetAlpha(windowName, 1)
	end
end

function Hotbar.HideBar(windowName)
	if Interface.LoadBoolean( windowName.. "Fade",false ) then
		local alpha = Interface.LoadNumber( windowName.."ALP", -5 )
		if (alpha == nil or alpha == -5) then
			alpha = 1
		end
		WindowStartAlphaAnimation(windowName, Window.AnimationType.SINGLE_NO_RESET, alpha, 0.01, 2, false, 1, 1 )
	end
end