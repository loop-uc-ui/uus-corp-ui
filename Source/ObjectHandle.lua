----------------------------------------------------------------
-- Global Variables
----------------------------------------------------------------

ObjectHandleWindow = {}
ObjectHandle = {}

----------------------------------------------------------------
-- Local Variables
----------------------------------------------------------------


ObjectHandleWindow.Active = false

--If the health bar for it is already open
ObjectHandleWindow.hasWindow = {}
ObjectHandleWindow.ObjectsData ={}
ObjectHandleWindow.ReverseObjectLookUp ={} 

--Default gray color of objects for their object handles
ObjectHandleWindow.grayColor = { r=172, g=172, b=172 }
ObjectHandleWindow.whiteColor = { r= 255, g=255, b= 255 }

ObjectHandleWindow.WindowShiftOffset = 15

ObjectHandleWindow.mouseOverId = 0

--Theses are used for mobiles only for setting the tint color of the object handle window
ObjectHandleWindow.Notoriety = {NONE = 1, INNOCENT = 2, FRIEND = 3, CANATTACK =4, CRIMINAL=5, ENEMY=6, MURDERER=7, INVULNERABLE=8 }
ObjectHandleWindow.TextColors = {}
ObjectHandleWindow.TextColors[ObjectHandleWindow.Notoriety.NONE]    =  { r=64,   g=64,   b=255 } --- BLUE
ObjectHandleWindow.TextColors[ObjectHandleWindow.Notoriety.INNOCENT]   = { r=128,   g=128,   b=255 } --- BLUE
ObjectHandleWindow.TextColors[ObjectHandleWindow.Notoriety.FRIEND]   = { r=0,   g=159,   b=0 } --- GREEN 
ObjectHandleWindow.TextColors[ObjectHandleWindow.Notoriety.CANATTACK]   = { r=64, g=64, b=64 } --- GREY/SYS
ObjectHandleWindow.TextColors[ObjectHandleWindow.Notoriety.CRIMINAL]   = { r=64, g=64, b=64 } --- GREY/SYS
ObjectHandleWindow.TextColors[ObjectHandleWindow.Notoriety.ENEMY]  = { r=255, g=128, b=0   } --- ORANGE
ObjectHandleWindow.TextColors[ObjectHandleWindow.Notoriety.MURDERER]  =  { r=255, g=0  , b=0  } --- RED  
ObjectHandleWindow.TextColors[ObjectHandleWindow.Notoriety.INVULNERABLE]  = { r=251, g=194, b=2   } --- YELLOW 

ObjectHandleWindow.REFRESH_DELAY = 0.1
ObjectHandleWindow.RefreshTimer = 0
ObjectHandleWindow.CurrentFilter = ""

-- CUSTOMIZABLE???
ObjectHandleWindow.ObjectHandleScale = InterfaceCore.scale * 0.8
ObjectHandleWindow.ObjectHandleAlpha = 0.6

----------------------------------------------------------------
-- Functions
----------------------------------------------------------------

function ObjectHandleWindow.Initialize()
	WindowRegisterEventHandler( "Root", SystemData.Events.CREATE_OBJECT_HANDLES, "ObjectHandleWindow.CreateObjectHandles")
	WindowRegisterEventHandler( "Root", SystemData.Events.DESTROY_OBJECT_HANDLES, "ObjectHandleWindow.DestroyObjectHandles")
end

function ObjectHandleWindow.retrieveObjectsData( objectsData )
	if not objectsData then
		--Debug.PrintToDebugConsole( L"ERROR: objectsData does not exist." )
		return false
	end      
				
	objectsData.Names = WindowData.ObjectHandle.Names
	objectsData.ObjectId = WindowData.ObjectHandle.ObjectId
	objectsData.XPos = WindowData.ObjectHandle.XPos
	objectsData.YPos = WindowData.ObjectHandle.YPos
	objectsData.IsMobile = WindowData.ObjectHandle.IsMobile
	objectsData.Notoriety = WindowData.ObjectHandle.Notoriety
	
	return true
end

--Creates all the object handles for all the objects that are on screen
function ObjectHandleWindow.CreateObjectHandles()	
	ObjectHandleWindow.Active = true
	local objectsData = {}
	if( ObjectHandleWindow.retrieveObjectsData(objectsData) ) then
		if (not  ObjectHandleWindow.ObjectsData) then
			return
		end		
		local isItemsOnly = SystemData.Settings.GameOptions.objectHandleFilter == SystemData.Settings.ObjectHandleFilter.eItemsOnlyFilter
		local isLostItemsOnly = SystemData.Settings.GameOptions.objectHandleFilter == SystemData.Settings.ObjectHandleFilter.eLostItemsOnlyFilter
		ObjectHandleWindow.ObjectsData = objectsData
		local numberObjects = table.getn(ObjectHandleWindow.ObjectsData.ObjectId)
		--Debug.Print(numberObjects)
		for i=1, numberObjects do
			local objectId = ObjectHandleWindow.ObjectsData.ObjectId[i]
			if not ObjectHandleWindow.hasWindow[objectId] and ObjectHandleWindow.ObjectsData.Names and not DoesPlayerHaveItem(objectId) then
				local name = ObjectHandleWindow.ObjectsData.Names[i]
				if (ObjectHandleWindow.CurrentFilter ~= "" and name and name ~= "" and name ~= L"") then
					local found = false
					for cf in wstring.gmatch(ObjectHandleWindow.CurrentFilter, L"[^|]+") do
						if (wstring.find(wstring.lower(name), wstring.lower(cf))) then
							found = true
						else
							found = false
						end
					end
					if not found then
						UnregisterWindowData(WindowData.ObjectInfo.Type, objectId)
					end
				end

				local lostItem = false
				if not IsMobile(objectId) then
					local props = ItemProperties.GetObjectProperties(objectId, nil, "Object Handle - check lost item")
					for j = 1, table.getn(props) do
						local tid = wstring.lower(GetStringFromTid(1151520)) --lost item (Return to gain Honesty)
						if wstring.lower(props[j]) == tid then
							lostItem = true
							break
						end
					end
				end
				local ignored = ( objectId == WindowData.PlayerStatus.PlayerId or name == L"") -- or IsObjectIdPet(objectId))

				local count = table.getn(ContainerWindow.IgnoreItems)
				for j = 1, count do
					if ( ContainerWindow.IgnoreItems[j] and ContainerWindow.IgnoreItems[j].id == objectId ) then
						ignored = true
						break
					end
				end

				local removeOnComplete = false
				if not WindowData.ContainerWindow[objectId] then
					RegisterWindowData(WindowData.ContainerWindow.Type, objectId)
					removeOnComplete = true
				end

				if (isItemsOnly and (ObjectHandleWindow.ObjectsData.IsMobile[i] or (WindowData.ContainerWindow[objectId] and WindowData.ContainerWindow[objectId].isCorpse))) then
					ignored = true
				end

				if ContainerWindow.OpenContainers[objectId] == nil and  removeOnComplete then
					UnregisterWindowData(WindowData.ContainerWindow.Type, objectId)
				end

				if (isLostItemsOnly and not lostItem) then
					ignored = true
				end
				if (name == L"Treasure Sand") then
					ignored = true
				end

				if ( ignored == false ) then
					local windowName = "ObjectHandleWindow"..objectId
					local windowTintName = windowName.."Tint"
					local labelName = windowName.."TintName"
					local labelBGName = windowName.."TintNameBG"
					CreateWindowFromTemplate(windowName, "ObjectHandleWindow", "Root")
					WindowSetScale(windowName, ObjectHandleWindow.ObjectHandleScale)
					WindowSetAlpha(windowName, ObjectHandleWindow.ObjectHandleAlpha)
					AttachWindowToWorldObject(objectId, windowName)

					WindowSetId(windowName, objectId)
					ObjectHandleWindow.hasWindow[objectId] = true
					ObjectHandleWindow.ReverseObjectLookUp[objectId] = i
					LabelSetText(labelName, ObjectHandleWindow.ObjectsData.Names[i])
					LabelSetText(labelBGName, ObjectHandleWindow.ObjectsData.Names[i])
					if (SystemData.Settings.Language.type == SystemData.Settings.Language.LANGUAGE_ENU) then
						LabelSetFont(labelBGName,  "UO_GoldButtonText", 12)
					else
						LabelSetFont(labelBGName,  "UO_DefaultText", 12)
					end
					if (SystemData.Settings.Language.type == SystemData.Settings.Language.LANGUAGE_ENU) then
						LabelSetFont(labelName,  "UO_GoldButtonText", 12)
					else
						LabelSetFont(labelName,  "UO_DefaultText", 12)
					end



					--Set the color of the window based off of the notoriety
					if(ObjectHandleWindow.ObjectsData.IsMobile[i]) then
						local hue = ObjectHandleWindow.TextColors[ObjectHandleWindow.ObjectsData.Notoriety[i]+1]
						--Debug.Print("Seting tint color mobile r ="..hue.r.."g = "..hue.g.."b = "..hue.b)
						if (objectId == Interface.CurrentHonor) then
							hue = {r=163, g=73, b=164}
						end
						WindowSetTintColor(windowTintName, hue.r, hue.g, hue.b)
					else
						--Debug.Print("Seting tint color object r ="..ObjectHandleWindow.grayColor.r.."g = "..ObjectHandleWindow.grayColor.g.."b = "..ObjectHandleWindow.grayColor.b)
						if (lostItem) then
							WindowSetTintColor(windowTintName, 146, 245, 153)
						else
							WindowSetTintColor(windowTintName, ObjectHandleWindow.grayColor.r, ObjectHandleWindow.grayColor.g,ObjectHandleWindow.grayColor.b)
						end
					end
				else
					UnregisterWindowData(WindowData.ObjectInfo.Type, objectId)
				end
			end
		end
	end 
end

--Destroys all the object handles on the screen when the user lets go of ctrl+shift
function ObjectHandleWindow.DestroyObjectHandles()
	ObjectHandleWindow.Active = false
	for key, _ in pairs(ObjectHandleWindow.hasWindow) do
		ObjectHandle.DestroyObjectWindow(key) 
	end
	if (ObjectHandleWindow.mouseOverId == key) then
		ObjectHandleWindow.mouseOverId = 0
		ItemProperties.ClearMouseOverItem()
	end
	if WindowData.ObjectHandle then
		WindowData.ObjectHandle.ObjectId = {}
	end
end

--Destroy object handle when player right clicks the window
function ObjectHandleWindow.OnClickClose()
	local objectId = WindowGetId(WindowUtils.GetActiveDialog())
	ObjectHandle.DestroyObjectWindow(objectId) 
	ItemProperties.ClearMouseOverItem()
end

--Used on mobiles, if they have a context menu and they single click the context menu will come up
function ObjectHandleWindow.OnRClick()
	local objectId = WindowGetId(WindowUtils.GetActiveDialog())
	local tableLoc = ObjectHandleWindow.ReverseObjectLookUp[objectId]
	--Request context menu if the object halde they left click is an object
	if( (SystemData.DragItem.DragType == SystemData.DragItem.TYPE_NONE) and ObjectHandleWindow.ObjectsData.IsMobile[tableLoc] and not ObjectHandleWindow.Buy ) then
		RequestContextMenu(objectId)
	end
end

--When player double clicks the object handle window it acts as if they double-clicked the object itself
function ObjectHandleWindow.OnDblClick()
	local objectId = WindowGetId(WindowUtils.GetActiveDialog())
	
	local mobileId = objectId
	if  IsBanker( mobileId ) then
		ContextMenu.RequestContextAction(mobileId, ContextMenu.DefaultValues.OpenBankbox)
	--elseif IsVendor( mobileId ) then
	--ContextMenu.RequestContextAction(mobileId, ContextMenu.DefaultValues.VendorBuy)
	elseif IsOldQuestGiver( mobileId ) then
		ContextMenu.RequestContextAction(mobileId, ContextMenu.DefaultValues.NPCTalk)
	else
		UserActionUseItem(objectId,false)
	end
	
	ContainerWindow.OpenedCorpse = objectId
end

function ObjectHandleWindow.OnItemClicked()
	local objectId = WindowGetId(WindowUtils.GetActiveDialog())
	if(objectId ~= nil)then
		--If player has a targeting cursor up and they target a object handle window
		--send a event telling the client they selected a target
		if( WindowData.Cursor ~= nil and WindowData.Cursor.target == true ) then
			--Let player select there window as there target
			HandleSingleLeftClkTarget(objectId)
			return
		end
		
		local tableLoc = ObjectHandleWindow.ReverseObjectLookUp[objectId]
		--If player is trying to drag the object handle window, have it act as if they are trying to pickup the object
		if( SystemData.DragItem.DragType == SystemData.DragItem.TYPE_NONE) then
			if( (ObjectHandleWindow.ObjectsData.IsMobile[tableLoc] == false ) ) then
				DragSlotSetObjectMouseClickData(objectId, SystemData.DragSource.SOURCETYPE_OBJECT)
			else				
				HealthBarManager.OnBeginDragHealthBar(objectId)
			end
		end
	end
end

function ObjectHandleWindow.OnLButtonUp()
	local mobileId = WindowGetId(WindowUtils.GetActiveDialog())
	if( SystemData.DragItem.DragType == SystemData.DragItem.TYPE_ITEM ) then
		
	    DragSlotDropObjectToObject(mobileId)
	end
	HandleSingleLeftClkTarget(mobileId)
	local tableLoc = ObjectHandleWindow.ReverseObjectLookUp[mobileId]
	--Request context menu if the object halde they left click is an object
	if( (SystemData.DragItem.DragType == SystemData.DragItem.TYPE_NONE) and ObjectHandleWindow.ObjectsData.IsMobile[tableLoc]) then
		RequestContextMenu(mobileId)
	end
end

--Destroy object handle window and reset the data to nil
function ObjectHandle.DestroyObjectWindow(objectId) 
	local windowName = "ObjectHandleWindow"..objectId
	if( ObjectHandleWindow.hasWindow[objectId] == true) then
		DetachWindowFromWorldObject(objectId, windowName)
		DestroyWindow(windowName)
		UnregisterWindowData(WindowData.ObjectInfo.Type, objectId)
		ObjectHandleWindow.hasWindow[objectId] = nil
		ObjectHandleWindow.ReverseObjectLookUp[objectId] = nil
	end
	
	if (ObjectHandleWindow.mouseOverId == objectId) then
		ObjectHandleWindow.mouseOverId = 0
		ItemProperties.ClearMouseOverItem()
	end
end

function ObjectHandleWindow.OnMouseOver()
	
	local objectId = WindowGetId(WindowUtils.GetActiveDialog())
	local itemData =
	{
		windowName = "ObjectHandleWindow",
		itemId = objectId,
		itemType = WindowData.ItemProperties.TYPE_ITEM,
	}					
	ItemProperties.SetActiveItem(itemData)
	ObjectHandleWindow.mouseOverId = objectId
end



function ObjectHandleWindow.CreateSingle(objectId, name, noto, isMobile)
	local windowName = "ObjectHandleWindow"..objectId
	local isItemsOnly = SystemData.Settings.GameOptions.objectHandleFilter == SystemData.Settings.ObjectHandleFilter.eItemOnlyFilter	
	if (isItemsOnly and isMobile) then	
		
		local windowTintName = windowName.."Tint"
		local labelName = windowName.."TintName"
		local labelBGName = windowName.."TintNameBG"
		CreateWindowFromTemplate(windowName, "ObjectHandleWindow", "Root")
		
		AttachWindowToWorldObject(objectId, windowName)
		
		WindowSetId(windowName, objectId)
		ObjectHandleWindow.hasWindow[objectId] = true
		ObjectHandleWindow.ReverseObjectLookUp[objectId] = i
		LabelSetText(labelName, name)
		LabelSetText(labelBGName, name)

		--Set the color of the window based off of the notoriety
		if(ObjectHandleWindow.ObjectsData.IsMobile[i]) then
			local hue = ObjectHandleWindow.TextColors[noto+1]
			--Debug.Print("Seting tint color mobile r ="..hue.r.."g = "..hue.g.."b = "..hue.b)
			WindowSetTintColor(windowTintName, hue.r, hue.g, hue.b)
		else
			--Debug.Print("Seting tint color object r ="..ObjectHandleWindow.grayColor.r.."g = "..ObjectHandleWindow.grayColor.g.."b = "..ObjectHandleWindow.grayColor.b)
			WindowSetTintColor(windowTintName, ObjectHandleWindow.grayColor.r, ObjectHandleWindow.grayColor.g,ObjectHandleWindow.grayColor.b)
			
		end
	else

		local windowTintName = windowName.."Tint"
		local labelName = windowName.."TintName"
		local labelBGName = windowName.."TintNameBG"
		CreateWindowFromTemplate(windowName, "ObjectHandleWindow", "Root")
		
		AttachWindowToWorldObject(objectId, windowName)
		
		WindowSetId(windowName, objectId)
		ObjectHandleWindow.hasWindow[objectId] = true
		ObjectHandleWindow.ReverseObjectLookUp[objectId] = i
		LabelSetText(labelName, name)
		LabelSetText(labelBGName, name)
		
		--Set the color of the window based off of the notoriety
		if(ObjectHandleWindow.ObjectsData.IsMobile[i]) then
			local hue = ObjectHandleWindow.TextColors[noto+1]
			--Debug.Print("Seting tint color mobile r ="..hue.r.."g = "..hue.g.."b = "..hue.b)
			WindowSetTintColor(windowTintName, hue.r, hue.g, hue.b)
		else
			--Debug.Print("Seting tint color object r ="..ObjectHandleWindow.grayColor.r.."g = "..ObjectHandleWindow.grayColor.g.."b = "..ObjectHandleWindow.grayColor.b)
			WindowSetTintColor(windowTintName, ObjectHandleWindow.grayColor.r, ObjectHandleWindow.grayColor.g,ObjectHandleWindow.grayColor.b)
			
		end
	end

end

ObjectHandleWindow.lastItem = 0
ObjectHandleWindow.cooldown = 0

local okObjects = {}

ObjectHandleWindow.ForceIgnore = nil
function ObjectHandleWindow.OnUpdate(_)
	if (ObjectHandleWindow.ForceIgnore) then
		ObjectHandle.DestroyObjectWindow(ObjectHandleWindow.ForceIgnore) 
		ObjectHandleWindow.ForceIgnore = nil
	end
	if(ObjectHandleWindow.RefreshTimer > ObjectHandleWindow.REFRESH_DELAY) then	
		ObjectHandleWindow.RefreshTimer = 0
		for key, _ in pairs(ObjectHandleWindow.hasWindow) do
			if not(IsValidObject(key)) or DoesPlayerHaveItem(key) then
				ObjectHandle.DestroyObjectWindow(key) 
			end
		end
	end	
	
																				 --  ↓ or Organizer.ScavengeAll	-- TODO: SCAVENGE ALL or USE THE FILTER?
	if (not okObjects or #okObjects == 0) and (Organizer.Scavengers_Items[Organizer.ActiveScavenger] > 0) then
		okObjects = {}
		for key, _ in pairs(ObjectHandleWindow.hasWindow) do
			if not IsMobile(key) then
				if (IsValidObject(key) and GetDistanceFromPlayer(key) <=2 ) then
					RegisterWindowData(WindowData.ObjectInfo.Type, key)
					local itemData = WindowData.ObjectInfo[key]

					if (itemData) then
						for j=1,  Organizer.Scavengers_Items[Organizer.ActiveScavenger] do
							itemData = WindowData.ObjectInfo[key]

							if (itemData) then
								local itemL = Organizer.Scavenger[Organizer.ActiveScavenger][j]
								if (itemL.type > 0 and itemL.type == itemData.objectType and itemL.hue == itemData.hueId) then
									table.insert(okObjects, key)
								end
							end
						end
					end
					UnregisterWindowData(WindowData.ObjectInfo.Type, key)
				end
			end
		end
	end

	
	if okObjects and #okObjects > 0 and ContainerWindow.CanPickUp then
	
		local backpackId = WindowData.PlayerEquipmentSlot[EquipmentData.EQPOS_BACKPACK].objectId
		local OrganizeBag = Organizer.Scavengers_Cont[Organizer.ActiveScavenger]
		if not OrganizeBag or OrganizeBag == 0 then
			OrganizeBag = backpackId
		end
		
		local key = okObjects[1]
		RegisterWindowData(WindowData.ObjectInfo.Type, key)
		local itemData = WindowData.ObjectInfo[key]
		if itemData then
			if key ~= ObjectHandleWindow.lastItem and itemData.containerId == 0 then
				ContainerWindow.TimePassedSincePickUp = 0
				ContainerWindow.CanPickUp = false
				ObjectHandleWindow.lastItem = key

				MoveItemToContainer(key,itemData.quantity, OrganizeBag)

				table.remove(okObjects, 1)
				if #okObjects == 0 then
					okObjects = {}
					ObjectHandleWindow.lastItem = 0
				end
			elseif itemData.containerId ~= 0 then
				table.remove(okObjects, 1)
				if #okObjects == 0 then
					okObjects = {}
					ObjectHandleWindow.lastItem = 0
				end
			end
		else
			table.remove(okObjects, 1)
			if #okObjects == 0 then
				okObjects = {}
				ObjectHandleWindow.lastItem = 0
			end
		end
		UnregisterWindowData(WindowData.ObjectInfo.Type, key)
	end
end

function ObjectHandleWindow.OnMouseOverEnd()
	ItemProperties.ClearMouseOverItem()
	ObjectHandleWindow.mouseOverId = 0
end