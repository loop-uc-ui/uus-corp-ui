----------------------------------------------------------------
-- Global Variables
----------------------------------------------------------------

ContainerWindow = {}
ContainerWindow.OpenContainers = {}
ContainerWindow.RegisteredItems = {}
ContainerWindow.ViewModes = {}

ContainerWindow.DEFAULT_START_POSITION = { x=100,y=100 }
ContainerWindow.MAX_VALUES = { x=1280, y=1024 }
ContainerWindow.POSITION_OFFSET = 30
ContainerWindow.TimePassedSincePickUp = 0
ContainerWindow.CanPickUp = true

ContainerWindow.TID_GRID_MODE = 1079439
ContainerWindow.TID_FREEFORM_MODE = 1079440
ContainerWindow.TID_LIST_MODE = 1079441

ContainerWindow.ScrollbarWidth = 12

ContainerWindow.Grid = {}
ContainerWindow.Grid.PaddingTop = 50
ContainerWindow.Grid.PaddingLeft = 12
ContainerWindow.Grid.PaddingBottom = 15
ContainerWindow.Grid.PaddingRight = 26
ContainerWindow.Grid.SocketSize = 57
ContainerWindow.Grid.MinWidth = 320
ContainerWindow.Grid.NumSockets = {}

ContainerWindow.List = {}
ContainerWindow.List.PaddingTop = 50
ContainerWindow.List.PaddingLeft = 0
ContainerWindow.List.PaddingBottom = 15
ContainerWindow.List.PaddingRight = 14
ContainerWindow.List.LabelPaddingRight = ContainerWindow.ScrollbarWidth + ContainerWindow.List.PaddingRight + 5
ContainerWindow.List.ItemHeight = 60
ContainerWindow.List.MinWidth = 320

ContainerWindow.MAX_INVENTORY_SLOTS = 125
ContainerWindow.MAX_BANK_SLOTS = 175

ContainerWindow.CHESS_GUMP = 2330
ContainerWindow.BACKGAMMON_GUMP = 2350
ContainerWindow.PLAGUE_BEAST_GUMP = 10851

-- used for windows the player doesn't own
ContainerWindow.Cascade = {}
ContainerWindow.Cascade.Movement = { x=0, y=0 }

ContainerWindow.PlayerBackpack = 0
ContainerWindow.PlayerBank = 0

ContainerWindow.IgnoreItems = {}
ContainerWindow.OpenedCorpse = 0

ContainerWindow.DeltaRefresh = 0
ContainerWindow.delta = 0

ContainerWindow.Locked = false

ContainerWindow.LastUsesDelta = {}
ContainerWindow.CurrentUses = {}
ContainerWindow.ItemContainerMap = {}
ContainerWindow.ShortUsesDelta = 0

ContainerWindow.TODO = {}

ContainerWindow.EnableAutoIgnoreCorpses = true

ContainerWindow.RefreshRate = 0.1

ContainerWindow.MaxSlotsPerGrid = ContainerWindow.MAX_INVENTORY_SLOTS-- max number of slots allowed for the grid mode, any amount greater than this one will turn the container to list view.

ContainerWindow.PickupWaitTime = 1
ContainerWindow.LootAll = {}

ContainerWindow.SUEDE_BACKPACK = 30558
ContainerWindow.POLAR_BEAR_BACKPACK = 30560
ContainerWindow.GHOUL_SKIN_BACKPACK = 30562

----------------------------------------------------------------
-- ContainerWindow Functions
----------------------------------------------------------------

-- Helper function
function ContainerWindow.ReleaseRegisteredObjects(id)
	if( ContainerWindow.RegisteredItems[id] ~= nil ) then
		for i, _ in pairs(ContainerWindow.RegisteredItems[id]) do
			UnregisterWindowData(WindowData.ObjectInfo.Type, i)
		end
	end
	ContainerWindow.RegisteredItems[id] = {}
end
function ContainerWindow.ReleaseRegisteredObjectsByID(id, containerID)
	if( ContainerWindow.RegisteredItems[containerID] ~= nil and id ~= nil) then
		UnregisterWindowData(WindowData.ObjectInfo.Type, id)
		ContainerWindow.RegisteredItems[containerID][id] = nil	
	end	
end

-- sets legacy container art
function ContainerWindow.SetLegacyContainer( gumpID, windowID )
	this = SystemData.ActiveWindow.name

	if( gumpID == nil or gumpID == 0 ) then
        --Debug.Print("ContainerWindow.SetLegacyContainer: gumpID is nil!")       
        return
    end
	
	-- hide unwanted container elements
	WindowSetShowing( this.."Chrome", false )
	WindowSetShowing( this.."Title", false )
	if (DoesWindowNameExist(this.."Background")) then
		WindowSetShowing( this.."Background", false )
	end
	WindowSetScale(this,InterfaceCore.scale)   

	local texture = gumpID
	local xSize, ySize
	local scale = SystemData.FreeformInventory.Scale
	texture, xSize, ySize = RequestGumpArt( texture )
	local textureSize = xSize
	if (textureSize < ySize) then
		textureSize = ySize
	end
	
	local yAnchor = 0
	if (gumpID == ContainerWindow.CHESS_GUMP) then
		yAnchor = 20
	end
	
	-- show legacy container art
	WindowSetDimensions( this, xSize * scale, ySize * scale )
	WindowSetShowing( this.."LegacyContainerArt", true )
	WindowAddAnchor( this.."LegacyContainerArt", "topleft", this, "topleft", 0, yAnchor )
	WindowSetDimensions( this.."LegacyContainerArt", xSize * scale, ySize * scale )
	DynamicImageSetTexture( this.."LegacyContainerArt", texture, 0, 0 )
	DynamicImageSetTextureScale( this.."LegacyContainerArt", scale )
	
	DynamicImageSetTextureDimensions(this.."FreeformView", textureSize * scale, textureSize * scale)
	WindowSetDimensions(this.."FreeformView", textureSize * scale, textureSize * scale)
	DynamicImageSetTexture(this.."FreeformView", "freeformcontainer_texture"..windowID, 0, 0)
	DynamicImageSetTextureScale(this.."FreeformView", InterfaceCore.scale * scale)
	requestedContainerArt = requestedContainerArt or {}
	requestedContainerArt = texture
end

-- OnInitialize Handler
function ContainerWindow.Initialize()
	local id = SystemData.DynamicWindowId	
	this = "ContainerWindow_" .. id

	local legacyContainersMode = SystemData.Settings.Interface.LegacyContainers
	if id == Interface.TrapBoxID then
		WindowSetShowing(this, false)
	end
	if (id == ContainerWindow.PlayerBackpack) then
		Interface.BackpackOpen  = true
		Interface.SaveBoolean( "BackpackOpen", Interface.BackpackOpen  )
	end
	ContainerWindow.GetContentDelta[id] = 0
	WindowSetId(this, id)	
	Interface.DestroyWindowOnClose[this] = true
	ContainerWindow.OpenContainers[id] = {open = true, cascading = false, slotsWide = 0, slotsHigh = 0, dirty=0, windowHeight = 0, windowWidth = 0, forceListView = 0}	

	WindowRegisterEventHandler(this, WindowData.ContainerWindow.Event, "ContainerWindow.MiniModelUpdate")
	WindowRegisterEventHandler(this, WindowData.ObjectInfo.Event, "ContainerWindow.HandleUpdateObjectEvent")

	-- Scanned containers maybe already registered
	if WindowData.ContainerWindow[id] then
		UnregisterWindowData(WindowData.ContainerWindow.Type, id)		
	end
	
	RegisterWindowData(WindowData.ContainerWindow.Type, id)	
	RegisterWindowData(WindowData.PlayerEquipmentSlot.Type, EquipmentData.EQPOS_BACKPACK)		
	
	local gumpID, typeName = ContainersInfo.GetGump(id, WindowData.ContainerWindow[id].gumpNum)	

	if(legacyContainersMode)then
		ContainerWindow.SetLegacyContainer( gumpID, id )
	end

	----Debug.PrintToDebugConsole( "legacyContainersMode = "..tostring( legacyContainersMode ) )
	----Debug.PrintToDebugConsole( "container id = "..gumpID )
	----Debug.PrintToDebugConsole( "container id = "..WindowData.ContainerWindow[id].gumpNum )
	
	if (typeName == "corpse" or typeName == "bones") then
		WindowData.ContainerWindow[id].isCorpse = true 
	else 
		WindowData.ContainerWindow[id].isCorpse = false
	end	
	
	-- determine the container's view mode
	if (legacyContainersMode or gumpID == ContainerWindow.CHESS_GUMP or gumpID == ContainerWindow.BACKGAMMON_GUMP 
			or gumpID == ContainerWindow.PLAGUE_BEAST_GUMP ) then
        ContainerWindow.ViewModes[id] = "Freeform"	
		
	elseif WindowData.ContainerWindow[id].isCorpse then
		ContainerWindow.ViewModes[id] = SystemData.Settings.Interface.defaultCorpseMode
		if ( ContainerWindow.OpenedCorpse ~= 0 and ContainerWindow.EnableAutoIgnoreCorpses) then
			local count = table.getn(ContainerWindow.IgnoreItems)
			local found = false
			for i=1, count do
				if ( ContainerWindow.IgnoreItems[i] and ContainerWindow.IgnoreItems[i].id == ContainerWindow.OpenedCorpse) then
					ObjectHandle.DestroyObjectWindow(ContainerWindow.IgnoreItems[i].id) 
					ContainerWindow.OpenedCorpse = 0
					found = true
					break
				end
    		end
    		if ( not found ) then
    			local data =  { id = ContainerWindow.OpenedCorpse, decayTime = Interface.Clock.Timestamp + 1800}
    			table.insert(ContainerWindow.IgnoreItems, data)
    			ObjectHandleWindow.ForceIgnore = ContainerWindow.OpenedCorpse
				ContainerWindow.OpenedCorpse = 0
    		end
		end
		
	elseif IsInPlayerBackPack(id) then
		-- iterate through the shared vector looking for our container id
		for i, windowId in ipairs(SystemData.Settings.Interface.ContainerViewModes.Ids) do
			if windowId == id then -- we found the preserved viewmode
				ContainerWindow.ViewModes[id] = SystemData.Settings.Interface.ContainerViewModes.ViewModes[i]
				break
			end
		end
		
		-- if the id wasn't found or if the container's viewmode was manually changed to "Freeform" with legacy containers 
		-- turned off, use the default setting
		if not ContainerWindow.ViewModes[id] or ContainerWindow.ViewModes[id] == "Freeform" then
			ContainerWindow.ViewModes[id] = SystemData.Settings.Interface.defaultContainerMode
			
			-- insert the new container setting into the shared vector
			local newContainerIndex = table.getn(SystemData.Settings.Interface.ContainerViewModes.ViewModes) + 1
			SystemData.Settings.Interface.ContainerViewModes.Ids[newContainerIndex] = id
			SystemData.Settings.Interface.ContainerViewModes.ViewModes[newContainerIndex] = ContainerWindow.ViewModes[id]
		end
		
	else
		-- use the default container mode				
		ContainerWindow.ViewModes[id] = SystemData.Settings.Interface.defaultContainerMode
	end
	-- done getting view mode
	
	
	if (ContainerWindow.ViewModes[id] == "Freeform") then
		if not(legacyContainersMode)then
			ContainerWindow.SetLegacyContainer( gumpID, id )
		end
		WindowSetShowing( this.."ViewButton", false )
		WindowSetShowing( this.."ResizeButton", false )
		WindowSetShowing( this.."LootAll", false )
	else
		WindowSetShowing( this.."ViewButton", true )
	end
	
	WindowData.ContainerWindow[id].numCreatedSlots = 0
	WindowData.ContainerWindow[id].maxSlots = SystemData.ActiveContainer.NumSlots	
	
	-- if this is the players backpack then update the paperdoll backpack icon
	if (WindowData.PlayerEquipmentSlot[EquipmentData.EQPOS_BACKPACK]) then
		if( id == ContainerWindow.PlayerBackpack ) then
			ContainerWindow.SetInventoryButtonPressed(true)
			WindowSetShowing( this.."LootAll", false )
		end
	end
	
	ContainerWindow.Grid.PaddingTop = 50
	ContainerWindow.Grid.PaddingLeft = 12
	ContainerWindow.Grid.PaddingBottom = 15
	ContainerWindow.Grid.PaddingRight = 26
	ContainerWindow.Grid.SocketSize = 57
	ContainerWindow.List.PaddingTop = 50
	ContainerWindow.List.PaddingLeft = 0
	ContainerWindow.List.PaddingBottom = 15
	ContainerWindow.List.PaddingRight = 14
	ContainerWindow.List.LabelPaddingRight = ContainerWindow.ScrollbarWidth + ContainerWindow.List.PaddingRight + 5

	local texture = "UO_Core"
	if ( ContainerWindow.Locked ) then		
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

	WindowSetShowing(this.."Lock", false)
	WindowSetShowing(this.."Organize", false)
	WindowSetShowing(this.."Restock", false)	
	WindowSetShowing(this.."Search", false)			
	WindowSetShowing(this.."LootAll", false)
	
	if (ContainerWindow.ViewModes[id] ~= "Freeform" ) then
		WindowSetScale(this, SystemData.Settings.Interface.customUiScale * 0.80)
		ContainerWindow.Grid.PaddingTop = 50
		ContainerWindow.Grid.PaddingLeft = 12
		ContainerWindow.Grid.PaddingBottom = 15
		ContainerWindow.Grid.PaddingRight = 26
		ContainerWindow.Grid.SocketSize = 57
		ContainerWindow.Grid.MinWidth = 320

		ContainerWindow.List.PaddingTop = 50
		ContainerWindow.List.PaddingLeft = 0
		ContainerWindow.List.PaddingBottom = 15
		ContainerWindow.List.PaddingRight = 14
		ContainerWindow.List.LabelPaddingRight = ContainerWindow.ScrollbarWidth + ContainerWindow.List.PaddingRight + 5
		ContainerWindow.List.ItemHeight = 60
		ContainerWindow.List.MinWidth = 320

		if (ContainerWindow.PlayerBackpack == id ) then
			WindowClearAnchors(this.."Lock")
			WindowSetShowing(this.."Lock", true)
			WindowAddAnchor( this.."Lock", "topright", this, "topright", -45, -3)
			WindowSetMovable(this,not ContainerWindow.Locked )
		end
		WindowClearAnchors(this.."Organize")
		WindowAddAnchor( this.."Organize", "topleft", this, "topleft", 10, -2)
		WindowClearAnchors(this.."Restock")
		WindowAddAnchor( this.."Restock", "topright", this.."Organize", "topright", 40, 0)
		WindowSetShowing(this.."Organize", true)
		WindowSetShowing(this.."Restock", true)
	else
		if (ContainerWindow.PlayerBackpack == id ) then
			WindowClearAnchors(this.."Lock")
			WindowSetShowing(this.."Lock", true)
			WindowSetLayer(this.."Lock", Window.Layers.OVERLAY	)
			WindowAddAnchor( this.."Lock", "top", this.."LegacyContainerArt", "center", 0, 30)
			WindowSetMovable(this,not ContainerWindow.Locked )	
		end
	end
	
	-- if this container belongs to the player then use the saved position
	if IsInPlayerBackPack(id) then
		WindowUtils.RestoreWindowPosition(this, true)
		
		-- if the window position can't be restored, try to place this container near its parent container
		if not WindowUtils.CanRestorePosition(this) then			
			local parentContainerId = GetParentContainer(id)			
			WindowClearAnchors(this)
			if parentContainerId ~= 0 then
				-- offset this container from the parent
				local x, y = WindowGetScreenPosition("ContainerWindow_"..parentContainerId)	
				x = math.floor((x + ContainerWindow.POSITION_OFFSET) / InterfaceCore.scale + 0.5)
				y = math.floor((y + ContainerWindow.POSITION_OFFSET) / InterfaceCore.scale + 0.5)
				WindowAddAnchor(this, "topleft", "Root", "topleft", x, y)	
			else
				WindowAddAnchor(this, "topleft", "Root", "topleft", 200, 200)	
			end		
		end
		
		-- if this is the players backpack then update the paperdoll backpack icon
		
		if( id == ContainerWindow.PlayerBackpack ) then
			ContainerWindow.SetInventoryButtonPressed(true)
		end
		
	-- else tile them like the old client
	else
		WindowUtils.RestoreWindowPosition(this)		
		if not WindowUtils.CanRestorePosition(this) then			
			-- if window position couldn't be restored, cascade the containers from the top left of the screen
			local x, y;
			
			local topCascadingId = ContainerWindow.GetTopOfCascade()
			if not topCascadingId then
				x = ContainerWindow.DEFAULT_START_POSITION.x
				y = ContainerWindow.DEFAULT_START_POSITION.y
			else
				x, y = WindowGetScreenPosition("ContainerWindow_"..topCascadingId)
				x = x + ContainerWindow.POSITION_OFFSET
				y = y + ContainerWindow.POSITION_OFFSET
			end
			
			x = math.floor(x / InterfaceCore.scale + 0.5)
			y = math.floor(y / InterfaceCore.scale + 0.5)
			WindowClearAnchors(this)
			WindowAddAnchor(this, "topleft", "Root", "topleft", x, y)				
			ContainerWindow.AddToCascade(id)		
		end
	end
	
	ContainerWindow.LegacyGridDock(this)
	ContainerWindow.UpdateContents(id,true)		
	-- Add Container ID to TODO List because all items are not loaded yet
	-- This will be done multiple times so we are sure the uses are correctly updated as soon as possible.
	-- Only delay when loading containers from xml
	local tdTwo = {func = function() ContainerWindow.LegacyGridDock(this) end, time = Interface.TimeSinceLogin + 1}
	table.insert(ContainerWindow.TODO, tdTwo)
		
	tdTwo = {func = function() ContainerWindow.UpdateUses(id) end, time = Interface.TimeSinceLogin + 1}
	table.insert(ContainerWindow.TODO, tdTwo)
	
	
	if (Interface.TrapBoxID ~= 0 and Interface.TrapBoxID == id) then
		WindowClearAnchors(this)
		WindowAddAnchor(this, "topleft", "Root", "topleft", -400, -400)	
		UO_DefaultWindow.CloseDialog()
    end
	
	if Interface.BackpackFirstPositioning and id == ContainerWindow.PlayerBackpack then
		WindowClearAnchors(this)
		local x, y= WindowGetOffsetFromParent(this)
		WindowClearAnchors(this)
		WindowSetOffsetFromParent(this, x,y)
	end
	
	WindowUtils.LoadScale( this )
end

function ContainerWindow.Shutdown()
	local checkContainerArt = tonumber( requestedContainerArt )
	if checkContainerArt then
		ReleaseGumpArt( checkContainerArt )
	end

	local id = WindowGetId(WindowUtils.GetActiveDialog())
	this = "ContainerWindow_"..id
			
	-- if the container is in the cascade, don't save its position
	if ContainerWindow.IsCascading(id) then		
		ContainerWindow.RemoveFromCascade(id)
	elseif id ~= Interface.TrapBoxID then		
		WindowUtils.SaveWindowPosition(this)
	end
	
	if ContainerWindow.waitItems == id then
		ContainerWindow.waitItems = 0
	end
	
	if ContainerWindow.waitGump == id then
		ContainerWindow.waitGump = 0
	end
	
	if ContainerWindow.waitLegacy == id then
		ContainerWindow.waitLegacy = 0
	end
	
	if IsInPlayerBackPack(id) then
		
		-- iterate through the shared vector looking for our container id
		for i, windowId in ipairs(SystemData.Settings.Interface.ContainerViewModes.Ids) do
			if windowId == id then
				SystemData.Settings.Interface.ContainerViewModes.ViewModes[i] = ContainerWindow.ViewModes[id]
				break
			end
		end
		
		if( id == ContainerWindow.PlayerBackpack ) then
			ContainerWindow.SetInventoryButtonPressed(false)
		end 
	end
	
	ContainerWindow.ReleaseRegisteredObjects(id)
	
	ContainerWindow.ViewModes[id] = nil
	ContainerWindow.OpenContainers[id] = nil
	
	ContainerWindow.GetContentDelta[id] = nil
	ContainerWindow.CurrentUses[id] = nil
	ContainerWindow.LastUsesDelta[id] = nil
	
	UnregisterWindowData(WindowData.ContainerWindow.Type, id)
	UnregisterWindowData(WindowData.PlayerEquipmentSlot.Type, EquipmentData.EQPOS_BACKPACK)
	
	if( ItemProperties.GetCurrentWindow() == this ) then
		ItemProperties.ClearMouseOverItem()
	end
	
	GumpManagerOnCloseContainer(id)
end

function ContainerWindow.LegacyGridDock(this)
	if not DoesWindowNameExist(this) then
		return
	end
	local id = WindowGetId(this)
	if id == Interface.TrapBoxID then
		return
	end

	if not id or not WindowData.ContainerWindow[id] then		
		return
	end	

	if(ContainerWindow.ViewModes[id] == "Freeform")then		
		return
	end

	local data = WindowData.ContainerWindow[id]	
	local gumpID = ContainersInfo.GetGump(id,WindowData.ContainerWindow[id].gumpNum) -- WindowData.ContainerWindow[id].gumpNum
	
	WindowSetShowing(this, true)
	if(WindowData.PlayerEquipmentSlot[EquipmentData.EQPOS_BANK] and id == WindowData.PlayerEquipmentSlot[EquipmentData.EQPOS_BANK].objectId)then
		ContainerWindow.PlayerBank = id		
	end
	local windowName = "ContainerWindow_"..id
	local listViewName = windowName.."ListView"
	local maxOffset

	if (ContainerWindow.ViewModes[id] == "List") then
		local scrollchildName = listViewName.."ScrollChild"
		local windowWidth, windowHeight = WindowGetDimensions(windowName)
		local newListHeight = windowHeight - (ContainerWindow.List.PaddingTop + ContainerWindow.List.PaddingBottom)
		local newListWidth = windowWidth - (ContainerWindow.List.PaddingRight + ContainerWindow.List.PaddingLeft)
		local h = 60 * data.numItems

		WindowSetDimensions(listViewName, newListWidth, newListHeight)
		WindowSetDimensions(scrollchildName, newListWidth, h)
		ScrollWindowUpdateScrollRect(listViewName)

		maxOffset = VerticalScrollbarGetMaxScrollPosition(listViewName.."Scrollbar")
		local listOffset = ScrollWindowGetOffset(listViewName)
		if DoesPlayerHaveItem(id) or id == ContainerWindow.PlayerBank then
			listOffset = Interface.LoadNumber("ScrollList" .. id, listOffset)
		elseif( listOffset > maxOffset ) then
			listOffset = maxOffset
		end
		ScrollWindowSetOffset(listViewName,listOffset)

	else
		ContainerWindow.UpdateGridViewSockets(id)
	end

	if (ContainerWindow.PlayerBackpack ~= id and gumpID ~= 1422) then
		WindowClearAnchors(this.."Restock")
		WindowAddAnchor( this.."Restock", "topleft", this.."ViewButton", "topleft", -35, -5)
		WindowClearAnchors(this.."Organize")
		WindowAddAnchor( this.."Organize", "topleft", this.."Restock", "topright", -2, 0)
		WindowClearAnchors(this.."LootAll")
		WindowAddAnchor( this.."LootAll", "topleft", this.."Restock", "topright", 0, 0)
		WindowSetShowing(this.."Organize", true)
		WindowSetShowing(this.."Restock", true)
		WindowSetShowing(this.."Search", true)
		WindowSetShowing(this.."LootAll", true)
		WindowClearAnchors(this.."Search")
		WindowAddAnchor( this.."Search", "topleft", this, "topleft", 5, -5)
		WindowClearAnchors(this.."LootAll")
		WindowAddAnchor( this.."LootAll", "topright", this.."Search", "topleft", 5, 0)
	elseif (gumpID ~= 1422) then
		WindowSetShowing(this.."LootAll", false)
		WindowSetShowing(this.."Search", true)
		WindowClearAnchors(this.."Search")
		WindowAddAnchor( this.."Search", "topright", this.."Restock", "topleft", 7, 0)
		WindowClearAnchors(this.."LootAll")
		WindowAddAnchor( this.."LootAll", "topleft", this.."Restock", "topright", 0, 0)
	end
end

function ContainerWindow.SearchItem()
	ContainerSearch.Container = WindowGetId(WindowUtils.GetActiveDialog())
	ContainerSearch.Toggle()	
end

function ContainerWindow.SearchAllTooltip()

	Tooltips.CreateTextOnlyTooltip(SystemData.ActiveWindow.name,  GetStringFromTid(1154791))
	Tooltips.Finalize()
	Tooltips.AnchorTooltip( Tooltips.ANCHOR_WINDOW_TOP )
end

function ContainerWindow.LootAllBtn()
	local oldOrganizeParent = ContainerWindow.OrganizeParent
	ContainerWindow.OrganizeParent = WindowGetId(WindowUtils.GetActiveDialog())

	if(oldOrganizeParent ~= nil and oldOrganizeParent ~= ContainerWindow.OrganizeParent)then
		ContainerWindow.LootAll[oldOrganizeParent] = nil
	end

	if(ContainerWindow.LootAll[ContainerWindow.OrganizeParent] == nil)then
		ContainerWindow.LootAll[ContainerWindow.OrganizeParent] = ContainerWindow.OrganizeParent
	else
		ContainerWindow.LootAll[ContainerWindow.OrganizeParent] = nil
	end	
end

function ContainerWindow.LootAllTooltip()
	local windowID = WindowGetId(WindowUtils.GetActiveDialog())
	if (ContainerWindow.LootAll[windowID] == nil) then
		Tooltips.CreateTextOnlyTooltip(SystemData.ActiveWindow.name,  GetStringFromTid(1154783))
	else
		Tooltips.CreateTextOnlyTooltip(SystemData.ActiveWindow.name,  GetStringFromTid(1154788))
	end
	Tooltips.Finalize()
	Tooltips.AnchorTooltip( Tooltips.ANCHOR_WINDOW_TOP )
end


function ContainerWindow.LockTooltip()
	
	if ( ContainerWindow.Locked ) then
		Tooltips.CreateTextOnlyTooltip(SystemData.ActiveWindow.name, GetStringFromTid(1154784))
	else
		Tooltips.CreateTextOnlyTooltip(SystemData.ActiveWindow.name,  GetStringFromTid(1154785))
	end
	Tooltips.Finalize()
	Tooltips.AnchorTooltip( Tooltips.ANCHOR_WINDOW_TOP )
end

function ContainerWindow.OrganizerContext()
	if ( not ContainerWindow.Organize) then
		for i=1, Organizer.Organizers do
			local name = ReplaceTokens(GetStringFromTid(1155441), {towstring( i ) } )
			if (Organizer.Organizers_Desc[i] ~= L"") then
				name = Organizer.Organizers_Desc[i]
			end
			ContextMenu.CreateLuaContextMenuItemWithString(name ,0,i,2,Organizer.ActiveOrganizer == i)
		end
		ContextMenu.ActivateLuaContextMenu(ContainerWindow.ContextMenuCallback)
	end
end

function ContainerWindow.ContextMenuCallback(returnCode, _)
	Organizer.ActiveOrganizer = returnCode
	Interface.SaveNumber( "OrganizerActiveOrganizer" , Organizer.ActiveOrganizer )
end

function ContainerWindow.Organizes()
	
	ContainerWindow.OrganizeBag = nil
	ContainerWindow.OrganizeParent = nil
	if ( not ContainerWindow.Organize) then
		ContainerWindow.OrganizeParent = WindowGetId(WindowUtils.GetActiveDialog())
		if (Organizer.Organizers_Cont[Organizer.ActiveOrganizer] == 0) then
			RequestTargetInfo()
			WindowUtils.SendOverheadText(GetStringFromTid(1154773), 1152, true)
			WindowRegisterEventHandler("Root", SystemData.Events.TARGET_SEND_ID_CLIENT, "ContainerWindow.OrganizeTargetInfoReceived")
		else
			ContainerWindow.OrganizeBag = Organizer.Organizers_Cont[Organizer.ActiveOrganizer]
			ContainerWindow.Organize = true
			return
		end
	end
	
	ContainerWindow.Organize = false
end

function ContainerWindow.OrganizeTargetInfoReceived()
	ContainerWindow.OrganizeBag = SystemData.RequestInfo.ObjectId
	if (ContainerWindow.OrganizeBag ~= nil  and ContainerWindow.OrganizeBag ~= 0 ) then
		ContainerWindow.Organize = true
	end
	WindowUnregisterEventHandler("Root", SystemData.Events.TARGET_SEND_ID_CLIENT)
	
end

function ContainerWindow.OrganizeTooltip()
	if (not ContainerWindow.Organize) then
		local name = L" Organizer " .. Organizer.ActiveOrganizer
		if (Organizer.Organizers_Desc[Organizer.ActiveOrganizer] ~= L"") then
			name = L" " .. Organizer.Organizers_Desc[Organizer.ActiveOrganizer]
		end
		Tooltips.CreateTextOnlyTooltip(SystemData.ActiveWindow.name,  ReplaceTokens(GetStringFromTid(1154789), {name}))
	else
		Tooltips.CreateTextOnlyTooltip(SystemData.ActiveWindow.name,  GetStringFromTid(1154786))
	end
	
	Tooltips.Finalize()
	Tooltips.AnchorTooltip( Tooltips.ANCHOR_WINDOW_TOP )
end

function ContainerWindow.RestockContext()
	if ( not ContainerWindow.Restock) then
		for i=1, Organizer.Restocks do
			local name = ReplaceTokens(GetStringFromTid(1155443), {towstring( i ) } ) 
			if (Organizer.Restocks_Desc[i] ~= L"") then
				name = Organizer.Restocks_Desc[i]
			end
			ContextMenu.CreateLuaContextMenuItemWithString(name,0,i,2,Organizer.ActiveRestock == i)
		end
		ContextMenu.ActivateLuaContextMenu(ContainerWindow.RestockContextMenuCallback)
	end
end

function ContainerWindow.RestockContextMenuCallback(returnCode, _)
	Organizer.ActiveRestock = returnCode
	Interface.SaveNumber( "OrganizerActiveRestock" , Organizer.ActiveRestock )
end

function ContainerWindow.RestockTooltip()
	if (not ContainerWindow.Restock) then
		local name = ReplaceTokens(GetStringFromTid(1155444), {towstring( Organizer.ActiveRestock ) } ) 
		if (Organizer.Restocks_Desc[Organizer.ActiveRestock] ~= L"") then
			name = Organizer.Restocks_Desc[Organizer.ActiveRestock]
		end
		Tooltips.CreateTextOnlyTooltip(SystemData.ActiveWindow.name,  GetStringFromTid(1155427) .. L"\n".. ReplaceTokens(GetStringFromTid(1155265), { name }))
	else
		Tooltips.CreateTextOnlyTooltip(SystemData.ActiveWindow.name,  GetStringFromTid(1154787))
	end
	
	Tooltips.Finalize()
	Tooltips.AnchorTooltip( Tooltips.ANCHOR_WINDOW_TOP )
end

function ContainerWindow.Restocks()
	
	ContainerWindow.OrganizeBag = nil
	ContainerWindow.OrganizeParent = nil
	if ( not ContainerWindow.Restock) then
		ContainerWindow.OrganizeParent = WindowGetId(WindowUtils.GetActiveDialog())
		if (Organizer.Restocks_Cont[Organizer.ActiveRestock] == 0) then
			RequestTargetInfo()
			WindowUtils.SendOverheadText(GetStringFromTid(1154773), 1152, true)
			WindowRegisterEventHandler("Root", SystemData.Events.TARGET_SEND_ID_CLIENT, "ContainerWindow.RestockTargetInfoReceived")
		else
			ContainerWindow.OrganizeBag = Organizer.Restocks_Cont[Organizer.ActiveRestock]
			ContainerWindow.CurrentAmountArray = {}
			for i=1,  Organizer.Restocks_Items[Organizer.ActiveRestock] do
				local itemL = Organizer.Restock[Organizer.ActiveRestock][i]
				if not ContainerWindow.CurrentAmountArray[itemL.type] then
					ContainerWindow.CurrentAmountArray[itemL.type] = {}
				end
				if not ContainerWindow.CurrentAmountArray[itemL.type][itemL.hue] then
					ContainerWindow.CurrentAmountArray[itemL.type][itemL.hue] = 0
				end
				ContainerWindow.CurrentAmountArray[itemL.type][itemL.hue] = 0
			end
			
			RegisterWindowData(WindowData.ContainerWindow.Type, ContainerWindow.OrganizeBag)
			if WindowData.ContainerWindow[ContainerWindow.OrganizeBag] then
				local numItems = WindowData.ContainerWindow[ContainerWindow.OrganizeBag].numItems
				for i = 1, numItems  do
					local item = WindowData.ContainerWindow[ContainerWindow.OrganizeBag].ContainedItems[i]
					local itemData = WindowData.ObjectInfo[item.objectId]
					for tp, h in pairs(ContainerWindow.CurrentAmountArray) do
						if (tp == itemData.objectType and h[itemData.hueId]) then
							ContainerWindow.CurrentAmountArray[itemData.objectType][itemData.hueId] =ContainerWindow.CurrentAmountArray[itemData.objectType][itemData.hueId] + itemData.quantity							
						end
					end
				end
			else
				WindowUtils.SendOverheadText(GetStringFromTid(1154790), 33, true)
				ContainerWindow.OrganizeBag = nil
				return
			end

			ContainerWindow.Restock = true
			return
		end
	end
	
	ContainerWindow.Restock = false
end

function ContainerWindow.RestockTargetInfoReceived()

	ContainerWindow.OrganizeBag = SystemData.RequestInfo.ObjectId
	if (ContainerWindow.OrganizeBag ~= nil and ContainerWindow.OrganizeBag ~= 0) then
		ContainerWindow.CurrentAmountArray = {}
		for i=1,  Organizer.Restocks_Items[Organizer.ActiveRestock] do
			local itemL = Organizer.Restock[Organizer.ActiveRestock][i]
			if not ContainerWindow.CurrentAmountArray[itemL.type] then
				ContainerWindow.CurrentAmountArray[itemL.type] = {}
			end
			if not ContainerWindow.CurrentAmountArray[itemL.type][itemL.hue] then
				ContainerWindow.CurrentAmountArray[itemL.type][itemL.hue] = 0
			end
			ContainerWindow.CurrentAmountArray[itemL.type][itemL.hue] = 0
		end
		
		if WindowData.ContainerWindow[ContainerWindow.OrganizeBag] then
			local numItems = WindowData.ContainerWindow[ContainerWindow.OrganizeBag].numItems
			for i = 1, numItems  do
				local item = WindowData.ContainerWindow[ContainerWindow.OrganizeBag].ContainedItems[i]
				local itemData = WindowData.ObjectInfo[item.objectId]
				for tp, h in pairs(ContainerWindow.CurrentAmountArray) do
					if (tp == itemData.objectType and h[itemData.hueId]) then
						ContainerWindow.CurrentAmountArray[itemData.objectType][itemData.hueId] =ContainerWindow.CurrentAmountArray[itemData.objectType][itemData.hueId] + itemData.quantity
					end
				end
			end
		else
			WindowUnregisterEventHandler("Root", SystemData.Events.TARGET_SEND_ID_CLIENT)
			WindowUtils.SendOverheadText(GetStringFromTid(1155445), 33, true)
			ContainerWindow.OrganizeBag = nil
			return
		end
		ContainerWindow.Restock = true
	end
	WindowUnregisterEventHandler("Root", SystemData.Events.TARGET_SEND_ID_CLIENT)
	
end

function ContainerWindow.Lock()
	local dialog = WindowUtils.GetActiveDialog()
	ContainerWindow.Locked = not ContainerWindow.Locked 
	Interface.SaveBoolean( "LockedBackpack", ContainerWindow.Locked  )
	WindowSetMovable(dialog,not ContainerWindow.Locked )
	local this = WindowUtils.GetActiveDialog()
	local texture = "UO_Core"
	if ( ContainerWindow.Locked ) then		
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

function ContainerWindow.OnSetMoving(isMoving)
	local id = WindowGetId(WindowUtils.GetActiveDialog())
	
	if ContainerWindow.IsCascading(id) then			
		local windowName = "ContainerWindow_"..id
		local x, y = WindowGetScreenPosition(windowName)
		if isMoving then
			ContainerWindow.Cascade.Movement.x = x
			ContainerWindow.Cascade.Movement.y = y
		else			
			if ContainerWindow.Cascade.Movement.x ~= x and ContainerWindow.Cascade.Movement.y ~= y then
				ContainerWindow.RemoveFromCascade(id)
			end
		end	
	end
end

function ContainerWindow.SetInventoryButtonPressed(pressed)
	local my_paperdoll = "PaperdollWindow"..WindowData.PlayerStatus.PlayerId
	local my_paperdoll_backpackicon = "PaperdollWindow"..WindowData.PlayerStatus.PlayerId.."ToggleInventory"
	if DoesWindowNameExist(my_paperdoll) and WindowGetShowing(my_paperdoll) then
		ButtonSetPressedFlag( my_paperdoll_backpackicon, pressed)
	end	
end

function ContainerWindow.HideAllContents(parent, numItems)
	if not DoesWindowNameExist(parent) then
		return
	end
	local id = WindowGetId(parent)
	local data = WindowData.ContainerWindow[id]
	local maxSlots = 125
	if data then
		maxSlots = data.maxSlots
	end
	for i=1,maxSlots do
		if DoesWindowNameExist(parent.."GridViewSocket"..i.."Icon") then
			DynamicImageSetTexture(parent.."GridViewSocket"..i.."Icon", "", 0, 0);
			if DoesWindowNameExist(parent.."GridViewSocket"..i.."IconMulti") then
				DynamicImageSetTexture( parent.."GridViewSocket"..i.."IconMulti", "", 0, 0 )
			end
			LabelSetText(parent.."GridViewSocket"..i.."Quantity", L"")
		end
		if i <= numItems then
			if DoesWindowNameExist(parent.."ListViewScrollChildItem"..i) then
				LabelSetText(parent.."ListViewScrollChildItem"..i.."Name", L"" )
				DynamicImageSetTexture(parent.."ListViewScrollChildItem"..i.."Icon", "", 0, 0);
				WindowSetShowing(parent.."ListViewScrollChildItem"..i, false)
			end
		end
	end
end

function ContainerWindow.CreateListViewSlots(dialog, low, high)
	local parent = dialog.."ListViewScrollChild"
	for i=low, high do
		slotName = parent.."Item"..i
		CreateWindowFromTemplate(slotName, "ContainerItemTemplate", parent)
		WindowSetId(slotName,i)
		WindowSetId(slotName.."Icon", i)
        
		if i == 1 then
			WindowAddAnchor(slotName, "topleft", parent, "topleft", 0, 0)
            WindowAddAnchor(slotName, "topright", dialog, "topright", -ContainerWindow.List.LabelPaddingRight, 0)
		else
			WindowAddAnchor(slotName, "bottomleft", parent.."Item"..i-1, "topleft", 0, 0)
            WindowAddAnchor(slotName, "bottomright", dialog, "topright", -ContainerWindow.List.LabelPaddingRight, 0)
		end
	end
end

function ContainerWindow.MiniModelUpdate()
	local id = WindowData.UpdateInstanceId
	if id == Interface.TrapBoxID then
		return
	end

	if (ContainerWindow.OpenContainers[id] and ContainerWindow.OpenContainers[id].inUpdate) then		
		return
	end
	if( id == WindowGetId(SystemData.ActiveWindow.name) ) then		
		ContainerWindow.OpenContainers[id].dirty = 1		
	end	
end

function ContainerWindow.BackpackItemsCheck()		
	if (Interface.BackPackItems)then
		
		local serverId = WindowData.SkillsCSV[16].ServerId
		local discoSkillLevel = WindowData.SkillDynamicData[serverId].RealSkillValue / 10
		
		serverId = WindowData.SkillsCSV[41].ServerId
		local peaceSkillLevel = WindowData.SkillDynamicData[serverId].RealSkillValue / 10
		
		serverId = WindowData.SkillsCSV[43].ServerId
		local provoSkillLevel = WindowData.SkillDynamicData[serverId].RealSkillValue / 10
		
		local data = WindowData.ContainerWindow[ContainerWindow.PlayerBackpack]
		if data then			
			for i = 1, #Interface.BackPackItems do
				if not WindowData.ObjectInfo[Interface.BackPackItems[i]] then					
					RegisterWindowData(WindowData.ObjectInfo.Type, Interface.BackPackItems[i])
				end
				local item =  WindowData.ObjectInfo[Interface.BackPackItems[i]]
				if (item) then					
					if (item.objectType == 12629 and item.hueId == 0) then
						local prop = ItemProperties.GetObjectPropertiesParamsForTid( Interface.BackPackItems[i], 1060485, "Backpack check - Arcane focus parsing" ) -- strength bonus ~1_val~
						if prop then
							Interface.ArcaneFocusLevel = tonumber(prop[1])
						end
					elseif ((item.objectType == 8794 or item.objectType == 8795) and item.hueId == 0) then						
						local prop = ItemProperties.GetObjectPropertiesParamsForTid( Interface.BackPackItems[i], 1060485, "Backpack check - Arcane focus parsing" ) -- strength bonus ~1_val~
						if prop then								
							Interface.ArcaneFocusLevel = tonumber(prop[1])
						end				
						if discoSkillLevel >= 90 or peaceSkillLevel >= 90 or provoSkillLevel >= 90 then
							Interface.BardMastery = true
						else
							Interface.BardMastery = false
						end
					end
				end
			end
		end
	end
end

function ContainerWindow.UpdateContents(id, _)
		
	this = "ContainerWindow_"..id

	if id == Interface.TrapBoxID then
		return
	end
	if(not DoesWindowNameExist(this)) then
		return
	end
		
	local list_view_this = this.."ListView"        
	local grid_view_this = this.."GridView"
	local freeform_view_this = this.."FreeformView"
	local data = WindowData.ContainerWindow[id]
	
	if not data then
		return
	end
	
	ContainerWindow.OpenContainers[id].inUpdate = true
	
	-- store the scrollbar offset so we can restore it when we are done
	local listOffset
	local gridOffset
	
	-- Create any contents slots we need
	local numItems = data.numItems
	local numCreatedSlots = data.numCreatedSlots or 1

	if numItems > numCreatedSlots then				
		ContainerWindow.CreateListViewSlots(this, numCreatedSlots+1, numItems)
		data.numCreatedSlots = numItems
	end	
	
	local isNotBankBox = true
	if(WindowData.PlayerEquipmentSlot[EquipmentData.EQPOS_BANK] and id == WindowData.PlayerEquipmentSlot[EquipmentData.EQPOS_BANK].objectId)then
		isNotBankBox = false		
	end
	
	if ContainerWindow.ViewModes[id] ~= "Freeform" then
			if numItems and isNotBankBox == true and numItems > ContainerWindow.MAX_INVENTORY_SLOTS then			
				ContainerWindow.ViewModes[id] = "List"
				WindowSetShowing(this.. "ViewButton", false)
				ContainerWindow.OpenContainers[id].forceListView = 1
			else		
				WindowSetShowing(this.. "ViewButton", true)
				ContainerWindow.OpenContainers[id].forceListView = 0
			end	
	
			if ContainerWindow.OpenContainers[id].forceListView == 0 then		
				if not data.numGridSockets then			
					ContainerWindow.CreateGridViewSockets(this, 1, data.maxSlots)
					data.numGridSockets = data.maxSlots;
				end		
			end
	end	
	-- Turn off all contents to start
	ContainerWindow.HideAllContents(this, numCreatedSlots)
	if ContainerWindow.ViewModes[id] == "List" then
		WindowSetShowing(list_view_this , true)
		WindowSetShowing(grid_view_this, false)
		WindowSetShowing(freeform_view_this, false)			
	elseif ContainerWindow.ViewModes[id] == "Grid" then
		WindowSetShowing(list_view_this, false)
		WindowSetShowing(grid_view_this, true)
		WindowSetShowing(freeform_view_this, false)			
	elseif ContainerWindow.ViewModes[id] == "Freeform" then
		WindowSetShowing(list_view_this, false)
		WindowSetShowing(grid_view_this, false)
		WindowSetShowing(freeform_view_this, true)	
	end	

	LabelSetText(this.."Title", data.containerName)
	if (data and data.containerName and data.containerName ~= L"" and data.containerName ~= "") then
		WindowUtils.FitTextToLabel(this.."Title", data.containerName)
	end
	
	--ContainerWindow.ReleaseRegisteredObjects(id)
	if(not ContainerWindow.RegisteredItems[id])then
		ContainerWindow.RegisteredItems[id] = {}
	end
	
	if id == ContainerWindow.PlayerBackpack then
		Interface.BackPackItems = nil
		Interface.BackPackItems = ContainerWindow.ScanQuantities(id, true)
		ContainerWindow.BackpackItemsCheck()
	end
		
	if( ContainerWindow.ViewModes[id] ~= "Freeform" ) then
		local scl = WindowGetScale(this)
		for i = 1, numItems do
			item = data.ContainedItems[i]
			ContainerWindow.RegisteredItems[id][item.objectId] = true			
			if(not WindowData.ObjectInfo[item.objectId])then					
				RegisterWindowData(WindowData.ObjectInfo.Type, item.objectId)
			end
			-- perform the initial update of this object
			ContainerWindow.UpdateObject(this,item.objectId)
			
			if	item.name == GetStringFromTid(1062824) or	-- Your Bank Box
				item.name == GetStringFromTid(1062825) or	-- Your Stabled Pets
				item.name == GetStringFromTid(1062826) or	-- Your Worn Equipment
				item.name == GetStringFromTid(1062827) or	-- Your Backpack
				item.name == GetStringFromTid(1062905)		-- Your Controlled Pets
			then 
				data.containerName = L"Transfer Crate"
				WindowUtils.FitTextToLabel(this.."Title", data.containerName)
			end			
			WindowSetScale(list_view_this.."ScrollChildItem"..i, scl)
		end
		local savedOffset = 0
		if (ContainerWindow.ViewModes[id] == "List") then
			for i = 1, numItems do
				if ( DoesWindowNameExist(list_view_this.."ScrollChildItem"..i) and LabelGetText(list_view_this.."ScrollChildItem"..i.."Name" ) == "") then
					WindowSetShowing(list_view_this.."ScrollChildItem"..i, false)
				else
					WindowSetShowing(list_view_this.."ScrollChildItem"..i,true)
				end
			end
			-- Update the scroll windows
			ScrollWindowUpdateScrollRect( list_view_this )   	
			local maxOffset = VerticalScrollbarGetMaxScrollPosition(list_view_this.."Scrollbar")
			savedOffset = Interface.LoadNumber("ScrollList" .. id, 0)
			listOffset = savedOffset
			if( listOffset > maxOffset ) then
		   		listOffset = maxOffset
			end
			ScrollWindowSetOffset(list_view_this,listOffset)						
		else
			maxOffset = VerticalScrollbarGetMaxScrollPosition(grid_view_this.."Scrollbar")
			savedOffset = Interface.LoadNumber("ScrollGrid" .. id, 0)
			gridOffset = savedOffset		
			if( gridOffset > maxOffset ) then
		   		gridOffset = maxOffset
			end
			ScrollWindowSetOffset(grid_view_this, gridOffset)						
		end	
	end
	
	for w, dat in pairs (TradeWindow.TradeInfo) do
		TradeWindow.UpdateContents(dat.containerId, w, true)
		TradeWindow.UpdateContents(dat.containerId2, w, true)
	end

	ContainerWindow.OpenContainers[id].dirty = 0
	ContainerWindow.OpenContainers[id].inUpdate = false
	ContainerWindow.OpenContainers[id].LastUpdate = ContainerWindow.DeltaRefresh + ContainerWindow.RefreshRate	
end

ContainerWindow.GetContentDelta = {}

function ContainerWindow.GetContent(contId)
	local rtn = L""
	local _, qta, wgt, val, token
	wgt = 0
	qta = 0
	
	local props = ItemProperties.GetObjectPropertiesArray( contId, "container items weight scan" )

	if props  then
		local params = ItemProperties.BuildParamsArray( props )			
		for j = 1, #props.PropertiesTids do			
			if qta == 0 and ItemPropertiesInfo.QuantityTid[props.PropertiesTids[j]] then
				token = ItemPropertiesInfo.QuantityTid[props.PropertiesTids[j]]
				val = tostring(params[props.PropertiesTids[j]][token])				
				qta = qta + tonumber(val)
														
			end
			if wgt == 0 and ItemPropertiesInfo.WeightONLYTid[props.PropertiesTids[j]] then
				token = ItemPropertiesInfo.WeightONLYTid[props.PropertiesTids[j]]
				val = tostring(params[props.PropertiesTids[j]][token])			
				wgt = wgt + tonumber(val)				
			end			
		end
	end

	if wgt ~= 0 then
		local tidParams = ItemProperties.GetObjectPropertiesParamsForTid( contId, 1073841, "container content params" )
		if tidParams then
			rtn = ReplaceTokens(GetStringFromTid(1073841), {towstring(qta), towstring(tidParams[2]), WindowUtils.AddCommasToNumber(wgt)})   -- Contents: ~1_COUNT~/~2_MAXCOUNT~ items, ~3_WEIGHT~ stones
		else
			rtn = ReplaceTokens(GetStringFromTid(1073841), {towstring(qta), towstring(125), WindowUtils.AddCommasToNumber(wgt)})   -- Contents: ~1_COUNT~/~2_MAXCOUNT~ items, ~3_WEIGHT~ stones
		end
	end

	if rtn and rtn ~= L"" and wstring.find(rtn, L":") then
		return rtn
	end

	return nil
end

function ContainerWindow.ScanSubCont(id, allItems, itemsOnly)
	local removeOnComplete = false
	if not WindowData.ContainerWindow[id] then		
		RegisterWindowData(WindowData.ContainerWindow.Type, id)
		removeOnComplete = true		
	end
	
	local qta = 0
	local wgt = 0
	if not WindowData.ContainerWindow[id] and not itemsOnly then
		local props = ItemProperties.GetObjectPropertiesArray( id, "container items weight scan" )
		if props  then
			local params = ItemProperties.BuildParamsArray( props )			
			for j = 1, #props.PropertiesTids do				
				if ItemPropertiesInfo.WeightONLYTid[props.PropertiesTids[j]] then					
					local token = ItemPropertiesInfo.WeightONLYTid[props.PropertiesTids[j]]
					local val = tostring(params[props.PropertiesTids[j]][token])					
					wgt = wgt + tonumber(val)					
				end				
			end
		end
		return allItems, qta, wgt
	elseif WindowData.ContainerWindow[id] then		
		local numItems = WindowData.ContainerWindow[id].numItems
		qta = numItems
		if not itemsOnly then		
			local props = ItemProperties.GetObjectPropertiesArray( id, "sub-containers items weight scan" )
			if props  then
				local params = ItemProperties.BuildParamsArray( props )
				for j = 1, #props.PropertiesTids do
					if ItemPropertiesInfo.WeightONLYTid[props.PropertiesTids[j]] then
						local token = ItemPropertiesInfo.WeightONLYTid[props.PropertiesTids[j]]
						local val = tostring(params[props.PropertiesTids[j]][token])
						wgt = wgt + tonumber(val)
						break					
					end
				end
			end
		end		
		for i = 1, numItems do
			local item = WindowData.ContainerWindow[id].ContainedItems[i]
			allItems = ContainerSearch.ScanSubCont(item.objectId, allItems, itemsOnly)
			table.insert(allItems,item.objectId )
		end		
	end

	if(ContainerWindow.OpenContainers[id] == nil and removeOnComplete)then		
		UnregisterWindowData(WindowData.ContainerWindow.Type, id)
	end	
	return allItems, qta, wgt
end

function ContainerWindow.ScanQuantities(backpackId, itemsOnly)
	local AllItems = {}
	local qta = 0 
	local wgt = 0
	if not WindowData.ContainerWindow[backpackId] then
		RegisterWindowData(WindowData.ContainerWindow.Type, backpackId)
	end
	if not WindowData.ContainerWindow[backpackId] then		
		return
	end	
	local numItems = WindowData.ContainerWindow[backpackId].numItems
	qta = numItems	
	for i = 1, numItems do
		local item = WindowData.ContainerWindow[backpackId].ContainedItems[i]
		AllItems, qt, wg = ContainerWindow.ScanSubCont(item.objectId, AllItems, itemsOnly)
		table.insert(AllItems,item.objectId )
		qta = qta + qt
		wgt = wgt + wg
	end	
	return AllItems, qta, wgt
end

function ContainerWindow.HandleUpdateObjectEvent()
    ContainerWindow.UpdateObject(SystemData.ActiveWindow.name,WindowData.UpdateInstanceId)    
end

function ContainerWindow.UpdateObject(windowName,updateId)
	if not DoesWindowNameExist(windowName) then		
		return
	end
	
	if not WindowData.ObjectInfo[updateId] then		
		RegisterWindowData(WindowData.ObjectInfo.Type, updateId)		
	end
	if( WindowData.ObjectInfo[updateId] ~= nil ) then
	    local containerId = WindowData.ObjectInfo[updateId].containerId
	    local viewMode = ContainerWindow.ViewModes[containerId]	        	
	    -- if this object is in my container
	    if( containerId == WindowGetId(windowName) ) then
		    -- find the slot index
		    containedItems = WindowData.ContainerWindow[containerId].ContainedItems
		    numItems = WindowData.ContainerWindow[containerId].numItems
		    listIndex = 0
		    for i=1, numItems do
			    if( containedItems[i].objectId == updateId ) then
				    listIndex = i
				    gridIndex = (containedItems[i].gridIndex)
				    break
			    end
		    end
		    item = WindowData.ObjectInfo[updateId]
		    if(viewMode == "List")then
					-- Name
					ElementName = windowName.."ListViewScrollChildItem"..listIndex.."Name"
					local scl = WindowGetScale(windowName)
					if (DoesWindowNameExist(ElementName) and ContainerWindow.ViewModes[WindowGetId(windowName)] ~= "Freeform") then
						WindowSetScale(ElementName, scl)
					end

					local name =  Shopkeeper.stripFirstNumber(item.name)

					local summBall
					if wstring.find(wstring.lower(GetStringFromTid(1054131)), L":") then
						summBall = wstring.sub(wstring.lower(GetStringFromTid(1054131)), 1, wstring.find(wstring.lower(GetStringFromTid(1054131)), L":") - 1)
					end

					if summBall and (name and type(name) ~= "string" and type(summBall) ~= "wstring") then
						if wstring.find(wstring.lower(name), summBall) then
							name = summBall
						end
					end

					if name and name ~= "" and item.quantity > 1 then
						local commaQ = WindowUtils.AddCommasToNumber(item.quantity)
						if commaQ then
							name = WindowUtils.AddCommasToNumber(item.quantity) .. L" " .. name
						end
					end

					if (name and name ~= "" and wstring.lower(name) == wstring.lower(GetStringFromTid(1041361))) then -- a bank check			    	
						local prop = ItemProperties.GetObjectProperties( updateId, 4, "Container Window - Update Object - Bank Check" )
						if(DoesWindowNameExist(ElementName)) then
							LabelSetText(ElementName, FormatProperly(name .. L"\n   " .. prop))
						end
					elseif(DoesWindowNameExist(ElementName) and name and name ~= "") then
						LabelSetText(ElementName, FormatProperly(name) )
					end

					if (name and name ~= "" and wstring.lower(name) == wstring.lower(GetStringFromTid(1078604))) then -- scroll of alacrity
						local prop = ItemProperties.GetObjectPropertiesTidParams( updateId, 4, "Container Window - Update Object - Scroll of alacrity" )
						local skill = tostring(wstring.gsub(prop[1], L"#", L""))
						skill = tonumber(skill)
						if(skill ~= nil)then
							prop = GetStringFromTid(1149921) .. L" " .. GetStringFromTid(skill)
							if(DoesWindowNameExist(ElementName)) then
								LabelSetText(ElementName, FormatProperly(name .. L"\n   " .. prop))
							end				
						end
					end

					if (name and name ~= "" and wstring.lower(name) == wstring.lower(GetStringFromTid(1094934))) then -- scroll of transcendence
						local prop = ItemProperties.GetObjectPropertiesTidParams( updateId, 4, "Container Window - Update Object - scroll of transcendence" )
						local skill = tostring(wstring.gsub(prop[1], L"#", L""))
						skill = tonumber(skill)
						if(skill ~= nil)then					
							prop = GetStringFromTid(1149921) .. L" " .. GetStringFromTid(skill)
							if(DoesWindowNameExist(ElementName)) then
								LabelSetText(ElementName, FormatProperly(name .. L"\n   " .. prop))
							end				
						end
					end

					ItemProperties.GetCharges(updateId)
					local uses = ContainerWindow.GetUses(updateId, containerId)				
					if( uses ~= nil and DoesWindowNameExist(ElementName)) then
						LabelSetText(ElementName, FormatProperly(name .. L"\n   " .. uses[1]))
					end

					WindowSetShowing(ElementName, true)
					-- Icon
					elementIcon = windowName.."ListViewScrollChildItem"..listIndex.."Icon"
					if( item.iconName ~= "" ) then
						if ( Interface.TrapBoxID == 0 and Interface.oldTrapBoxID == updateId) then
							Interface.oldTrapBoxID = 0
						end
						if ( Interface.LootBoxID == 0 and Interface.oldLootBoxID == updateId) then
							Interface.oldLootBoxID = 0
						end
						item.id = updateId
					    EquipmentData.UpdateItemIcon(elementIcon, item)
						
					    parent = WindowGetParent(elementIcon)
					    WindowClearAnchors(elementIcon)
					    WindowAddAnchor(elementIcon, "topleft", parent, "topleft", 15+((45-item.newWidth)/2), 15+((45-item.newHeight)/2))
						
					    WindowSetShowing(elementIcon, true)
					else
					    WindowSetShowing(elementIcon, false)
					end
		    end

		    if( item.iconName ~= "" ) then
				elementIcon = windowName.."GridViewSocket"..gridIndex.."Icon"
				if DoesWindowNameExist(elementIcon .. "Multi") then
					DynamicImageSetTexture( elementIcon .. "Multi", "", 0, 0 )
					WindowSetShowing(elementIcon .. "Multi", false)
				end
				if DoesWindowNameExist(elementIcon) then
					item.id = updateId
					EquipmentData.UpdateItemIcon(elementIcon, item)	
					if item.quantity > 1 and item.objectType ~= 3821 and item.objectType ~= 3824 then
						if DoesWindowNameExist(elementIcon .. "Multi") then
							EquipmentData.UpdateItemIcon(elementIcon .. "Multi", item)
							WindowSetShowing(elementIcon .. "Multi", true)	
						end
					end
					local gridViewItemLabel = windowName.."GridViewSocket"..gridIndex.."Quantity"
					LabelSetText(gridViewItemLabel, L"")
										
					if( item.quantity ~= nil and item.quantity > 1 ) then 
						LabelSetText(gridViewItemLabel, Knumber(item.quantity))
					else
						ItemProperties.GetCharges(updateId)
						local uses = ContainerWindow.GetUses(updateId, containerId)
						if( uses ~=nil) then
							LabelSetText(gridViewItemLabel, Knumber(uses[2]))
						end
					end
				end
			end
	    end
	end
end


function ContainerWindow.UpdateUses(id)	
	ContainerWindow.CurrentUses[id] = {}	
	if (WindowData.ContainerWindow[id]) then
		local numItems = WindowData.ContainerWindow[id].numItems		
		for i = 1, numItems  do
			local item = WindowData.ContainerWindow[id].ContainedItems[i]
			local objectId = item.objectId
			ItemProperties.GetCharges(objectId)				
		end		
	end
end

function ContainerWindow.UpdateUsesByID(objectId)		
	ItemProperties.GetCharges(objectId)
	local containerID = GetParentContainer(objectId)
	if( containerID ~= 0)then
		ContainerWindow.UpdateObject("ContainerWindow_"..containerID, objectId)
	end
end

function ContainerWindow.GetUses(objectId, contId)	
	if ContainerWindow.CurrentUses[contId] ~= nil then		
		return ContainerWindow.CurrentUses[contId][objectId]
	end
	return nil
end

function ContainerWindow.ToggleView()
	local id = WindowGetId(WindowUtils.GetActiveDialog())
	
	if( WindowData.ContainerWindow[id] and WindowData.ContainerWindow[id].isSnooped == false ) then
        if (ContainerWindow.ViewModes[id] == "List") then
		    ContainerWindow.ViewModes[id] = "Grid"
		    ContainerWindow.UpdateGridViewSockets(id)
        elseif( ContainerWindow.ViewModes[id] == "Grid" ) then
    	    ContainerWindow.ViewModes[id] = "List"    	    
			ContainerWindow.UpdateListViewSockets(id)
	    end	    
        ContainerWindow.UpdateContents(id,true)
    end
    
    local playerBackpack = WindowData.PlayerEquipmentSlot[EquipmentData.EQPOS_BACKPACK].objectId
	if( id == playerBackpack ) then
		SystemData.Settings.Interface.inventoryMode = ContainerWindow.ViewModes[id]
	elseif( WindowData.ContainerWindow[id] and WindowData.ContainerWindow[id].isCorpse == true ) then
		SystemData.Settings.Interface.defaultCorpseMode = ContainerWindow.ViewModes[id]
	else
		SystemData.Settings.Interface.defaultContainerMode = ContainerWindow.ViewModes[id]
	end

	SettingsWindow.UpdateSettings()
end

function ContainerWindow.GetSlotNumFromGridIndex(containerId, gridIndex)
    local slotNum

	if( ContainerWindow.ViewModes[containerId] == "Grid" ) then

		if( WindowData.ContainerWindow[containerId].ContainedItems ) then
            for index, item in ipairs(WindowData.ContainerWindow[containerId].ContainedItems) do                
	            if( item.gridIndex == gridIndex ) then
		            slotNum = index
		            break
	            end
            end
        end
    else
        slotNum = gridIndex
    end
    
    return slotNum
end

function ContainerWindow.OnItemClicked(flags)
	local containerId = WindowGetId(WindowUtils.GetActiveDialog())
	local slotNum = WindowGetId(SystemData.ActiveWindow.name)
	
	slotNum = ContainerWindow.GetSlotNumFromGridIndex(containerId, slotNum)

    if( slotNum ~= nil ) then
	    if( WindowData.Cursor ~= nil and WindowData.Cursor.target == true ) then
			local objectId = WindowData.ContainerWindow[containerId].ContainedItems[slotNum].objectId
			HandleSingleLeftClkTarget(objectId)
	    elseif( SystemData.DragItem.DragType == SystemData.DragItem.TYPE_NONE ) then
			local objectId = WindowData.ContainerWindow[containerId].ContainedItems[slotNum].objectId
			local itemData = WindowData.ObjectInfo[objectId]
			if flags == SystemData.ButtonFlags.CONTROL and DoesPlayerHaveItem(objectId) then
				if ItemsInfo.Reagents[itemData.objectType] then
					local id = itemData.objectType
					local lblid = QuickStats.GetId()
					local label = "QuickStat_" .. lblid
					local l = QuickStats.DoesLabelExist(id, true)
					if l > 0 and DoesWindowNameExist("QuickStat_" .. l) then
						label = "QuickStat_" .. l
					else
						local lab = {objectType=id, minQuantity=20, frame=true, icon=true, name=true, cap=true, locked=false, BGColor={r=0,g=0,b=0}, frameColor={r=255,g=255,b=255}, valueTextColor={r=255,g=255,b=255}, nameTextColor={r=243,g=227,b=49}}
						table.insert(QuickStats.Labels, lblid, lab)
						
						CreateWindowFromTemplate(label, "QuickStatTemplate", "Root")
						WindowSetId(label, lblid)
						WindowUtils.openWindows[label] = true
						QuickStats.UpdateLabel(label)
						QuickStats.Save(label)
						SnapUtils.SnappableWindows[label] = true
					end
					local scaleFactor = 1/InterfaceCore.scale	
					
					local propWindowWidth = 380
					local propWindowHeight = 30
					
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
					
					WindowSetOffsetFromParent(label, propWindowX * scaleFactor, propWindowY * scaleFactor)
					QuickStats.InMovement[label] = true
					WindowSetMoving(label, true)
					SnapUtils.StartWindowSnap(label)
				else
					local blockBar = HotbarSystem.GetNextHotbarId()
					Interface.SaveBoolean("Hotbar" .. blockBar .. "_IsBlockbar", true)
					HotbarSystem.SpawnNewHotbar()
					
					HotbarSystem.SetActionOnHotbar(SystemData.UserAction.TYPE_USE_ITEM, objectId, itemData.iconId, blockBar,  1)

					
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
				end
			else
				DragSlotSetObjectMouseClickData(objectId, SystemData.DragSource.SOURCETYPE_CONTAINER)
				ContainerWindow.ReleaseRegisteredObjectsByID(objectId, containerId)								 
				ContainerWindow.GetContentDelta[containerId] = 0								
			end
			
	    end
	end
end

function ContainerWindow.OnItemRelease()	
	if( SystemData.DragItem.DragType == SystemData.DragItem.TYPE_ITEM ) then
	    local containerId = WindowGetId(WindowUtils.GetActiveDialog())
		local gridIndex = WindowGetId(SystemData.ActiveWindow.name)
		local slotNum = ContainerWindow.GetSlotNumFromGridIndex(containerId, gridIndex)
		local slot

		if( WindowData.ContainerWindow[containerId].ContainedItems ~= nil and slotNum ~= nil) then
            slot = WindowData.ContainerWindow[containerId].ContainedItems[slotNum]
        end

		SystemData.ActiveContainer.SlotsWide = ContainerWindow.OpenContainers[containerId].slotsWide
		SystemData.ActiveContainer.SlotsHigh = ContainerWindow.OpenContainers[containerId].slotsHigh
        
        --Debug.Print("OnItemRelease: "..tostring(slot))
		--This happens when you drop an item onto an empty grid socket
		
		if (not slot) then
			if(gridIndex > ContainerWindow.MAX_BANK_SLOTS)then
				gridIndex = 0
			end			
            DragSlotDropObjectToContainer(containerId,gridIndex)
            local td = {func = function() ContainerWindow.GetContentDelta[containerId] = 0 ContainerWindow.UpdateContents(containerId)	 end, time = Interface.TimeSinceLogin + 2}
			table.insert(ContainerWindow.TODO, td)
			return
		end
		
		local clickedObjId = slot.objectId
		if (clickedObjId ~= Interface.TrapBoxID) then
			if ContainerWindow.ViewModes[containerId] == "Grid" then
				DragSlotDropObjectToObjectAtIndex(clickedObjId,gridIndex)
			else
				DragSlotDropObjectToObjectAtIndex(clickedObjId,0)
			end
		end
		local td = {func = function() ContainerWindow.UpdateUsesByID(SystemData.DragItem.itemId) end, time = Interface.TimeSinceLogin + 2}
		table.insert(ContainerWindow.TODO, td)        				
		ContainerWindow.GetContentDelta[containerId] = 0		        
	end
end

function ContainerWindow.OnContainerRelease()	
	if( SystemData.DragItem.DragType == SystemData.DragItem.TYPE_ITEM ) then
		local containerId = WindowGetId(WindowUtils.GetActiveDialog())
		DragSlotDropObjectToContainer(containerId,0)
		ContainerWindow.LegacyGridDock(WindowUtils.GetActiveDialog())
		ContainerWindow.GetContentDelta[containerId] = 0		
		ContainerWindow.UpdateContents(containerId)
	end
end

function ContainerWindow.OnItemDblClicked()	
	local containerId = WindowGetId(WindowUtils.GetActiveDialog())
	local slotNum = WindowGetId(SystemData.ActiveWindow.name)
		
	slotNum = ContainerWindow.GetSlotNumFromGridIndex(containerId, slotNum)
	if( slotNum ~= nil ) then
	    local objectId = WindowData.ContainerWindow[containerId].ContainedItems[slotNum].objectId
	    
	    if Interface.UnpackTransferCrate then	    				
			RegisterWindowData(WindowData.ObjectInfo.Type, objectId)			
			local itemData = WindowData.ObjectInfo[objectId]
			if	itemData.name == GetStringFromTid(1062824) or	-- Your Bank Box
				itemData.name == GetStringFromTid(1062825) or	-- Your Stabled Pets
				itemData.name == GetStringFromTid(1062826) or	-- Your Worn Equipment
				itemData.name == GetStringFromTid(1062827) or	-- Your Backpack
				itemData.name == GetStringFromTid(1062905)		-- Your Controlled Pets
				
			then 
				ContainerWindow.UnpackTransferCrate(objectId)
			else
				UserActionUseItem(objectId,false)
			end
			UnregisterWindowData(WindowData.ObjectInfo.Type, objectId)
	    else
			UserActionUseItem(objectId,false)
		end
	end
end


function ContainerWindow.UnpackTransferCrate(objectId)
	ContextMenu.RequestContextAction(objectId, ContextMenu.DefaultValues.UnpackTransferCrate )
end

function ContainerWindow.OnItemRButtonUp()
	
end

function ContainerWindow.ItemMouseOver()
	local this = SystemData.ActiveWindow.name
	local index = WindowGetId(this)
	local dialog = WindowUtils.GetActiveDialog()
	local containerId = WindowGetId(dialog)
	local containedItems = WindowData.ContainerWindow[containerId].ContainedItems
    local slotNum = ContainerWindow.GetSlotNumFromGridIndex(containerId, index)
    
    if( slotNum ~= nil and containedItems and containedItems[slotNum] ~= nil ) then
	    objectId = containedItems[slotNum].objectId
    	
	    if objectId then
		    local itemData = { windowName = dialog,
						       itemId = objectId,
		    			       itemType = WindowData.ItemProperties.TYPE_ITEM,
		    			       detail = ItemProperties.DETAIL_LONG }
		    ItemProperties.SetActiveItem(itemData)
	    end
	end
end

function ContainerWindow.OnItemGet(flags)
	local index = WindowGetId(SystemData.ActiveWindow.name)
	local containerId = WindowGetId(WindowUtils.GetActiveDialog())
	local slotNum = ContainerWindow.GetSlotNumFromGridIndex(containerId, index)
	
	if (slotNum ~= nil) then
		local objectId = WindowData.ContainerWindow[containerId].ContainedItems[slotNum].objectId
	
		if (objectId ~= nil or objectId ~= 0) then
			if flags == SystemData.ButtonFlags.CONTROL and  WindowData.ObjectInfo[objectId].quantity > 1 then
				ContainerWindow.DragOne = true
				ContainerWindow.HoldShiftBackup = SystemData.Settings.GameOptions.holdShiftToUnstack
				SystemData.Settings.GameOptions.holdShiftToUnstack = false
				UserSettingsChanged()
				DragSlotSetObjectMouseClickData(objectId, SystemData.DragSource.SOURCETYPE_CONTAINER)
				ContainerWindow.GetContentDelta[containerId] = 0 
				ContainerWindow.ReleaseRegisteredObjectsByID(objectId, containerId)								 
				ContainerWindow.UpdateContents(containerId)	
				return
			end
				
			-- If player is trying to get objects from a container that is not from the players backpack have it dropped
			-- into the players backpack
			if(WindowData.ContainerWindow[containerId].isCorpse == true) then
				if( ContainerWindow.CanPickUp == true) then
					local itemData = WindowData.ObjectInfo[objectId]
					if (Interface.LootBoxID == 0 or itemData.objectType == 3821) then
						DragSlotAutoPickupObject(objectId)
					else
						MoveItemToContainer(objectId,itemData.quantity, Interface.LootBoxID)
					end
					 ContainerWindow.GetContentDelta[containerId] = 0
					 ContainerWindow.ReleaseRegisteredObjectsByID(objectId, containerId)					 
					 ContainerWindow.UpdateContents(containerId)	
					ContainerWindow.TimePassedSincePickUp = 0
					ContainerWindow.CanPickUp = false
				else
					PrintTidToChatWindow(1045157,1)
				end
			else
				RequestContextMenu(objectId)
			end
		end
	end
end

local moveObjects = {}
ContainerWindow.lastLooted = 0

function ContainerWindow.UpdatePickupTimer(timePassed)

	if(ContainerWindow.CanPickUp == false) then
		ContainerWindow.TimePassedSincePickUp = ContainerWindow.TimePassedSincePickUp + timePassed
		if(ContainerWindow.TimePassedSincePickUp >= ContainerWindow.PickupWaitTime) then
			ContainerWindow.CanPickUp = true	
		end
	end
	ContainerWindow.DeltaRefresh = ContainerWindow.DeltaRefresh + timePassed

	for i = 1, #ContainerWindow.TODO do
		if ContainerWindow.TODO[i] and not ContainerWindow.TODO[i].time then
			ContainerWindow.TODO[i] = nil
		end
		if ContainerWindow.TODO[i] and Interface.TimeSinceLogin >= ContainerWindow.TODO[i].time then
			ContainerWindow.TODO[i] = nil
		end
	end		

	if (ContainerWindow.DragOne) then
		if (DoesWindowNameExist("GenericQuantityWindow")) then
			ContainerWindow.DragOne = false
			DragSlotQuantityRequestResult(1)
			SystemData.Settings.GameOptions.holdShiftToUnstack = ContainerWindow.HoldShiftBackup
			ContainerWindow.HoldShiftBackup = nil
			UserSettingsChanged()
		end	
	end
	
	if ContainerWindow.Organize and ContainerWindow.OrganizeParent then
		if not moveObjects or #moveObjects == 0 then
			moveObjects = {}
			local numItems = WindowData.ContainerWindow[ContainerWindow.OrganizeParent].numItems
			for i = 1, numItems  do
				local item = WindowData.ContainerWindow[ContainerWindow.OrganizeParent].ContainedItems[i]
				RegisterWindowData(WindowData.ObjectInfo.Type, item.objectId)
				local itemData = WindowData.ObjectInfo[item.objectId]
				if (itemData) then
					if (Organizer.Organizer[Organizer.ActiveOrganizer]) then
						for j=1,  Organizer.Organizers_Items[Organizer.ActiveOrganizer] do
							local itemL = Organizer.Organizer[Organizer.ActiveOrganizer][j]
							if (itemL.type > 0 and itemL.type == itemData.objectType and itemL.hue == itemData.hueId) then
								table.insert(moveObjects,item.objectId)
								break
							elseif(itemL.id > 0  and itemL.id == item.objectId) then
								table.insert(moveObjects,item.objectId)
								break
							end
						end
					end	
				end
				UnregisterWindowData(WindowData.ObjectInfo.Type, item.objectId)
			end
		end
		
		if moveObjects and #moveObjects > 0 and ContainerWindow.CanPickUp then		
			local OrganizeBag = ContainerWindow.OrganizeBag
			if not OrganizeBag or OrganizeBag == 0 then
				OrganizeBag = ContainerWindow.PlayerBackpack
			end			
			local key = moveObjects[1]
			RegisterWindowData(WindowData.ObjectInfo.Type, key)
			local itemData = WindowData.ObjectInfo[key]
			if itemData and itemData.containerId == ContainerWindow.OrganizeParent then
				ContainerWindow.TimePassedSincePickUp = 0
				ContainerWindow.CanPickUp = false
				ObjectHandleWindow.lastItem = key
				
				MoveItemToContainer(key,itemData.quantity, OrganizeBag)

				table.remove(moveObjects, 1)
				if #moveObjects == 0 then
					moveObjects = {}
					local numItems = WindowData.ContainerWindow[ContainerWindow.OrganizeParent].numItems
					for i = 1, numItems  do
						local item = WindowData.ContainerWindow[ContainerWindow.OrganizeParent].ContainedItems[i]
						RegisterWindowData(WindowData.ObjectInfo.Type, item.objectId)
						itemData = WindowData.ObjectInfo[item.objectId]
						if (itemData) then
							if (Organizer.Organizer[Organizer.ActiveOrganizer]) then
								for j=1,  Organizer.Organizers_Items[Organizer.ActiveOrganizer] do
									local itemL = Organizer.Organizer[Organizer.ActiveOrganizer][j]
									if (itemL.type > 0 and itemL.type == itemData.objectType and itemL.hue == itemData.hueId) then
										table.insert(moveObjects,item.objectId)
										break
									elseif(itemL.id > 0  and itemL.id == item.objectId) then
										table.insert(moveObjects,item.objectId)
										break
									end
								end
							end	
						end
						UnregisterWindowData(WindowData.ObjectInfo.Type, item.objectId)
					end
					if #moveObjects == 0 then
						ContainerWindow.Organize = false
						if Organizer.Organizers_CloseCont[Organizer.ActiveOrganizer] then
							if DoesWindowNameExist( "ContainerWindow_" .. ContainerWindow.OrganizeParent ) then
								DestroyWindow("ContainerWindow_" .. ContainerWindow.OrganizeParent)
							end
						end
					end
				end
			else
				table.remove(moveObjects, 1)
				if #moveObjects == 0 then
					moveObjects = {}
					local numItems = WindowData.ContainerWindow[ContainerWindow.OrganizeParent].numItems
					for i = 1, numItems  do
						local item = WindowData.ContainerWindow[ContainerWindow.OrganizeParent].ContainedItems[i]
						RegisterWindowData(WindowData.ObjectInfo.Type, item.objectId)
						itemData = WindowData.ObjectInfo[item.objectId]
						if (itemData) then
							if (Organizer.Organizer[Organizer.ActiveOrganizer]) then
								for j=1,  Organizer.Organizers_Items[Organizer.ActiveOrganizer] do
									local itemL = Organizer.Organizer[Organizer.ActiveOrganizer][j]
									if (itemL.type > 0 and itemL.type == itemData.objectType and itemL.hue == itemData.hueId) then
										table.insert(moveObjects,item.objectId)
										break
									elseif(itemL.id > 0  and itemL.id == item.objectId) then
										table.insert(moveObjects,item.objectId)
										break
									end
								end
							end	
						end
						UnregisterWindowData(WindowData.ObjectInfo.Type, item.objectId)
					end
					if #moveObjects == 0 then
						ContainerWindow.Organize = false
						if Organizer.Organizers_CloseCont[Organizer.ActiveOrganizer] then
							if DoesWindowNameExist( "ContainerWindow_" .. ContainerWindow.OrganizeParent ) then
								DestroyWindow("ContainerWindow_" .. ContainerWindow.OrganizeParent)
							end
						end
					end
				end
			end
		end
	end
	
	
	if ContainerWindow.Restock and ContainerWindow.CanPickUp then		
		local OrganizeBag = ContainerWindow.OrganizeBag
		if not OrganizeBag or OrganizeBag == 0 then
			OrganizeBag = ContainerWindow.PlayerBackpack
		end

		local numItems = WindowData.ContainerWindow[ContainerWindow.OrganizeParent].numItems
		for i = 1, numItems  do
			local item = WindowData.ContainerWindow[ContainerWindow.OrganizeParent].ContainedItems[i]
			RegisterWindowData(WindowData.ObjectInfo.Type, item.objectId)
			local itemData = WindowData.ObjectInfo[item.objectId]			
						
			if (itemData) then
				if (Organizer.Restock[Organizer.ActiveRestock]) then
					for j=1,  Organizer.Restocks_Items[Organizer.ActiveRestock] do
						local itemL = Organizer.Restock[Organizer.ActiveRestock][j]
						if (itemL.type > 0 and itemL.type == itemData.objectType and itemL.hue == itemData.hueId and ContainerWindow.CurrentAmountArray[itemL.type][itemL.hue] < itemL.qta) then
							
							if itemData.quantity < itemL.qta then
								DragAmount = itemData.quantity 
							else
								DragAmount = itemL.qta - ContainerWindow.CurrentAmountArray[itemL.type][itemL.hue]
							end
							
							if (DragAmount > 0) then
								MoveItemToContainer(item.objectId,DragAmount, OrganizeBag)
								ContainerWindow.CurrentAmountArray[itemL.type][itemL.hue] = ContainerWindow.CurrentAmountArray[itemL.type][itemL.hue] + DragAmount
								ContainerWindow.TimePassedSincePickUp = 0
								ContainerWindow.CanPickUp = false	
								return
							end
						end
					end	
				end
			end
			UnregisterWindowData(WindowData.ObjectInfo.Type, item.objectId)
		end
		ContainerWindow.Restock = false
	end
	
	
	if ContainerWindow.OrganizeParent and ContainerWindow.LootAll[ContainerWindow.OrganizeParent] and ContainerWindow.CanPickUp then

		if not moveObjects or #moveObjects == 0 then
			moveObjects = {}
			local numItems = WindowData.ContainerWindow[ContainerWindow.OrganizeParent].numItems
			for i = 1, numItems  do
				local item = WindowData.ContainerWindow[ContainerWindow.OrganizeParent].ContainedItems[i]
				local itemData = WindowData.ObjectInfo[item.objectId]
				if (itemData) then
					table.insert(moveObjects,item.objectId)
				end
			end
			if(#moveObjects == 0)then
				ContainerWindow.LootAll[ContainerWindow.OrganizeParent] = nil
			end
		end
		
		if moveObjects and #moveObjects > 0 and ContainerWindow.CanPickUp then
		
			local OrganizeBag = Interface.LootBoxID
			if not OrganizeBag or OrganizeBag == 0 then
				OrganizeBag = ContainerWindow.PlayerBackpack
			end
			
			local key = moveObjects[1]
			local itemData = WindowData.ObjectInfo[key]

			if itemData and itemData.containerId == ContainerWindow.OrganizeParent then
				ContainerWindow.TimePassedSincePickUp = 0
				ContainerWindow.CanPickUp = false
				ObjectHandleWindow.lastItem = key
				
				MoveItemToContainer(key,itemData.quantity, OrganizeBag)

				table.remove(moveObjects, 1)
				if #moveObjects == 0 then
					moveObjects = {}
					local numItems = WindowData.ContainerWindow[ContainerWindow.OrganizeParent].numItems
					for i = 1, numItems  do
						local item = WindowData.ContainerWindow[ContainerWindow.OrganizeParent].ContainedItems[i]
						itemData = WindowData.ObjectInfo[item.objectId]
						if (itemData) then
							table.insert(moveObjects,item.objectId)
						end
					end
					if #moveObjects == 0 then
						ContainerWindow.LootAll[ContainerWindow.OrganizeParent] = nil
					end
				end
			else
				table.remove(moveObjects, 1)
				if #moveObjects == 0 then
					moveObjects = {}
					local numItems = WindowData.ContainerWindow[ContainerWindow.OrganizeParent].numItems
					for i = 1, numItems  do
						local item = WindowData.ContainerWindow[ContainerWindow.OrganizeParent].ContainedItems[i]
						itemData = WindowData.ObjectInfo[item.objectId]
						if (itemData) then
							table.insert(moveObjects,item.objectId)
						end
					end
					if #moveObjects == 0 then
						ContainerWindow.LootAll[ContainerWindow.OrganizeParent] = nil
					end
				end
			end	
		end
	end

	for id, _ in pairs(ContainerWindow.OpenContainers) do
		if ContainerWindow.OpenContainers[id] ~= nil	then
			local isDirty = ContainerWindow.OpenContainers[id].dirty						
			if(isDirty == 1 and ContainerWindow.OpenContainers[id].LastUpdate and ContainerWindow.OpenContainers[id].LastUpdate < ContainerWindow.DeltaRefresh)then				
				ContainerWindow.UpdateContents(id)
				if (ContainerSearch.Container == id) then		
					ContainerSearch.UpdateList()
				end			
			end
		end
	end

end




function ContainerWindow.ViewButtonMouseOver()
	local messageText = L""
	local containerId = WindowGetId(WindowUtils.GetActiveDialog())
	
	if (ContainerWindow.ViewModes[containerId] == "Grid" ) then
        messageText = GetStringFromTid(ContainerWindow.TID_LIST_MODE)
	elseif (ContainerWindow.ViewModes[containerId] == "List" ) then
        messageText = GetStringFromTid(ContainerWindow.TID_GRID_MODE)
    end
    
	local itemData = { windowName = SystemData.ActiveWindow.name,
						itemId = containerId,
						itemType = WindowData.ItemProperties.TYPE_WSTRINGDATA,
						binding = L"",
						detail = nil,
						title =	messageText,
						body = L""}

	ItemProperties.SetActiveItem(itemData)
end


function ContainerWindow.OnResizeBegin()	
	local id = WindowGetId(WindowUtils.GetActiveDialog())
	local minHeight
	local minWidth

	if (ContainerWindow.ViewModes[id] == "List") then
		minWidth = ContainerWindow.List.MinWidth
		minHeight = minWidth
	else -- "Grid"
		minWidth = ContainerWindow.Grid.MinWidth
		minHeight = minWidth
	end
	
    WindowUtils.BeginResize( WindowUtils.GetActiveDialog(), "topleft", minWidth, minHeight, false, ContainerWindow.OnResizeEnd)
end

function ContainerWindow.OnResizeEnd()	
	local windowName = WindowUtils.resizeWindow
	local id = WindowGetId(windowName)

	ContainerWindow.LegacyGridDock(windowName)	

    ContainerWindow.UpdateContents(id) 
end

function ContainerWindow.UpdateListViewSockets(id)	
	--Debug.Print("ContainerWindow.UpdateListViewSockets("..id..")")
	
	local windowName = "ContainerWindow_"..id
	if not DoesWindowNameExist(windowName) then
		return
	end	
	ContainerWindow.LegacyGridDock(windowName)	
end

function ContainerWindow.UpdateGridViewSockets(id)
	--Debug.Print("UpdateGridViewSockets")
	if not DoesWindowNameExist("ContainerWindow_" .. id) then
		return
	end

	local data = WindowData.ContainerWindow[id]
	
	local windowName = "ContainerWindow_"..id
	local gridViewName = windowName.."GridView"
	local scrollViewChildName = gridViewName.."ScrollChild"
	
	-- determine the grid dimensions based on window width and height
	local windowWidth, windowHeight = WindowGetDimensions(windowName)
	local GRID_WIDTH = math.floor((windowWidth - (ContainerWindow.Grid.PaddingLeft + ContainerWindow.Grid.PaddingRight)) / ContainerWindow.Grid.SocketSize + 0.5)	
	local GRID_HEIGHT = math.floor((windowHeight - (ContainerWindow.Grid.PaddingTop + ContainerWindow.Grid.PaddingBottom)) / ContainerWindow.Grid.SocketSize + 0.5)	
	local numSockets = GRID_WIDTH * GRID_HEIGHT
	local isNotBankBox = true
	if(WindowData.PlayerEquipmentSlot[EquipmentData.EQPOS_BANK] and id == WindowData.PlayerEquipmentSlot[EquipmentData.EQPOS_BANK].objectId)then
		isNotBankBox = false
	end
	if(isNotBankBox and numSockets > ContainerWindow.MAX_INVENTORY_SLOTS) then
		numSockets = ContainerWindow.MAX_INVENTORY_SLOTS
	end

	local allSocketsVisible = numSockets >= data.maxSlots
	
	-- if numSockets is less than 125, we need additional rows to provide at least 125 sockets.
	if not allSocketsVisible then
		GRID_HEIGHT = math.ceil(data.maxSlots / GRID_WIDTH)
		numSockets = GRID_WIDTH * GRID_HEIGHT
		if(isNotBankBox and numSockets > ContainerWindow.MAX_INVENTORY_SLOTS) then
			numSockets = ContainerWindow.MAX_INVENTORY_SLOTS
		end
	end
	
	if not data.numGridSockets then		
		ContainerWindow.CreateGridViewSockets(windowName, 1, numSockets)
	else
		-- create additional padding sockets if needed or destroy extra ones from the last resize
		if data.numGridSockets > numSockets then
			ContainerWindow.DestroyGridViewSockets(windowName, numSockets + 1, data.numGridSockets)
		elseif data.numGridSockets < numSockets then			
			ContainerWindow.CreateGridViewSockets(windowName, data.numGridSockets + 1, numSockets)
		end
	end

	local scl = WindowGetScale(windowName)
	data.numGridSockets = numSockets
	
	-- position and anchor the sockets
	for i = 1, data.numGridSockets do
		local socketName = windowName.."GridViewSocket"..i 
		if(DoesWindowNameExist(socketName)) then
			WindowClearAnchors(socketName)		
		end		
		WindowSetScale(socketName, scl)
		if i == 1 then
			WindowAddAnchor(socketName, "topleft", scrollViewChildName, "topleft", 0, 0)
		elseif (i % GRID_WIDTH) == 1 then
			WindowAddAnchor(socketName, "bottomleft", windowName.."GridViewSocket"..i-GRID_WIDTH, "topleft", 0, 1)
		else
			WindowAddAnchor(socketName, "topright", windowName.."GridViewSocket"..i-1, "topleft", 1, 0)
		end
		if DoesWindowNameExist(socketName .. "IconMulti") then
			WindowSetShowing(socketName .. "IconMulti", false)
		end
		WindowSetShowing(socketName, true)	
	end

	-- dimensions for the entire grid view with GRID_WIDTH x GRID_HEIGHT dimensions
	local newGridWidth = GRID_WIDTH * ContainerWindow.Grid.SocketSize + ContainerWindow.Grid.PaddingLeft
	local newGridHeight = GRID_HEIGHT * ContainerWindow.Grid.SocketSize + ContainerWindow.Grid.PaddingTop
	
	-- fit the window width to the grid width
	local newWindowWidth = newGridWidth + ContainerWindow.Grid.PaddingRight
	local newWindowHeight = windowHeight
	
	-- if we can see every slot in the container, snap the window height to the grid and hide the void created 
	-- by the missing scrollbar
	if allSocketsVisible then
		newWindowHeight = newGridHeight + ContainerWindow.Grid.PaddingBottom
		newWindowWidth = newWindowWidth - ContainerWindow.ScrollbarWidth
	else
		newWindowHeight = windowHeight
		newGridHeight = windowHeight - (ContainerWindow.Grid.PaddingBottom + ContainerWindow.Grid.PaddingTop)
	end
	WindowSetDimensions(windowName, newWindowWidth, newWindowHeight)
	WindowSetDimensions(gridViewName, newGridWidth, newGridHeight)	

	if ContainerWindow.OpenContainers[id] then
		ContainerWindow.OpenContainers[id].slotsWide = GRID_WIDTH
		ContainerWindow.OpenContainers[id].slotsHigh = GRID_HEIGHT		
		local staticGridWidth = math.floor((windowWidth - (ContainerWindow.Grid.PaddingLeft + ContainerWindow.Grid.PaddingRight)) / ContainerWindow.Grid.SocketSize + 0.5)
		local staticGridHeight = math.ceil(data.maxSlots / staticGridWidth)
		ContainerWindow.OpenContainers[id].windowWidth = staticGridWidth * ContainerWindow.Grid.SocketSize + ContainerWindow.Grid.PaddingLeft
		ContainerWindow.OpenContainers[id].windowHeight = staticGridHeight * ContainerWindow.Grid.SocketSize + ContainerWindow.Grid.PaddingTop		
		WindowSetDimensions(scrollViewChildName, ContainerWindow.OpenContainers[id].windowWidth, ContainerWindow.OpenContainers[id].windowHeight)
	end	
	
	WindowSetShowing(gridViewName, true)	
	ScrollWindowUpdateScrollRect(gridViewName)
	ContainerWindow.UpdateGridItemSlots(id)
end

function ContainerWindow.CreateGridViewSockets(dialog, lower, upper)
	--Debug.Print("ContainerWindow.CreateGridViewSockets")
	local id = WindowGetId(dialog)
	local data = WindowData.ContainerWindow[id]
	
	if not data then
		return
	end
	
	if not lower then
		lower = 1
	end
	
	if not upper then
		upper = data.maxSlots
		if upper > ContainerWindow.MaxSlotsPerGrid then
			upper = ContainerWindow.MaxSlotsPerGrid
		end
	end	
	--Debug.Print("ContainerWindow.CreateGridViewSockets("..dialog..") lower = "..lower.." upper = "..upper)
	
	local parent = dialog.."GridViewScrollChild"
	
	local color = false
	
	for i = lower, upper do
		local socketName = dialog.."GridViewSocket"..i 
		local socketTemplate

		if i > data.maxSlots then
			socketTemplate = "GridViewSocketBaseTemplate"
		else
			if (not UserContainerSettings.brightContainers()) then
				socketTemplate = "GridViewSocketTemplate"
			else
				socketTemplate = "ColoredGridViewSocketTemplate"
			end
		end
		
		-- use the transparent grid background for legacy container views
		local legacyContainersMode = SystemData.Settings.Interface.LegacyContainers
		if( legacyContainersMode == true ) then
		    socketTemplate = "GridViewSocketLegacyTemplate"
		end
		if DoesWindowNameExist(socketName) then
			DestroyWindow(socketName)
		end
		CreateWindowFromTemplate(socketName, socketTemplate, parent)
		
		if (not UserContainerSettings.gridContainer()) then
			ButtonSetTexture(socketName, Button.ButtonState.NORMAL, "", 0, 0)
			ButtonSetTexture(socketName, Button.ButtonState.HIGHLIGHTED, "", 0, 0)
			ButtonSetTexture(socketName, Button.ButtonState.DISABLED, "", 0, 0)
			ButtonSetTexture(socketName, Button.ButtonState.PRESSED, "", 0, 0)
			ButtonSetTexture(socketName, Button.ButtonState.PRESSED_HIGHLIGHTED, "", 0, 0)
		end
		local gridColor = UserContainerSettings.gridColor()
		WindowSetTintColor(socketName, gridColor.r, gridColor.g, gridColor.b)

		if (color and UserContainerSettings.alternateGrid()) then
			local altColor = UserContainerSettings.alternateColor()
			WindowSetTintColor(socketName, altColor.r, altColor.g, altColor.b)
		end
		color = not color
		
		WindowSetId(socketName, i)
		WindowSetShowing(socketName, false)
		
		if i > data.maxSlots then
			WindowSetAlpha(socketName, 0.5)
			WindowSetTintColor(socketName, 10, 10, 10)
		end
	end		
end

function ContainerWindow.DestroyGridViewSockets(dialog, lower, upper)
	local id = WindowGetId(dialog)
	local data = WindowData.ContainerWindow[id]
	
	if not lower then
		lower = 1
	end
	
	if not upper then
    upper = data.maxSlots
	end

	for i = lower, upper do
		local socketName = dialog.."GridViewSocket"..i 
		if DoesWindowNameExist(socketName) then
			DestroyWindow(socketName)
		end
	end
end

function ContainerWindow.GetTopOfCascade()
	local cascadeSize = table.getn(ContainerWindow.Cascade)
	if cascadeSize > 0 then
		-- loop from n to 1 , removing windows with cascading == false and returning the first
		-- with cascading == true
		for i = cascadeSize, 1, -1 do
			local windowId = ContainerWindow.Cascade[i]
			if ContainerWindow.IsCascading(windowId) then
				return windowId
			else
				ContainerWindow.Cascade[i] = nil
			end
		end
	end
	
	return nil;
end

function ContainerWindow.IsCascading(windowId)
	if ContainerWindow.OpenContainers[windowId] then
		return ContainerWindow.OpenContainers[windowId].cascading
	else
		return false
	end
end

function ContainerWindow.AddToCascade(windowId)
	if ContainerWindow.OpenContainers[windowId] then
		local cascadeSize = table.getn(ContainerWindow.Cascade) + 1
		ContainerWindow.Cascade[cascadeSize] = windowId
		ContainerWindow.OpenContainers[windowId].cascading = true
	end
end

function ContainerWindow.RemoveFromCascade(windowId)
	-- since this is called often. the ContainerWindow.Cascade array is resized in GetTopOfCascade
	if ContainerWindow.OpenContainers[windowId] then
		ContainerWindow.OpenContainers[windowId].cascading = false
	end
end

function ContainerWindow.Scrolling(pos)	
	--Debug.Print("ContainerWindow.Scrolling: "..pos)
	local id = WindowGetId(WindowUtils.GetActiveDialog())
	this = "ContainerWindow_"..id		
	
	local listViewName = this.."ListView"
	local gridViewName = this.."GridView"

	if WindowGetShowing(listViewName) then
		if VerticalScrollbarGetMaxScrollPosition(listViewName.."Scrollbar") > 0 then
			Interface.SaveNumber("ScrollList" .. id, pos)
		end
	elseif WindowGetShowing(gridViewName) then
		Interface.SaveNumber("ScrollGrid" .. id, pos)
		ContainerWindow.UpdateGridItemSlots(id,pos)
	end		
	ContainerWindow.scrolled =  nil		
end

function ContainerWindow.UpdateGridItemSlots(id, scrollpos)
	--Debug.Print("ContainerWindow.UpdateGridItemSlots")			
	this = "ContainerWindow_"..id	
	local gridViewName = this.."GridView"
	local data = WindowData.ContainerWindow[id]
	local scrollViewChildName = gridViewName.."ScrollChild"
	local _,parentY = WindowGetScreenPosition(scrollViewChildName)
	
	-- Fixing scrollbar
	local scrollOffset
	if scrollpos == nil then
		scrollOffset = ScrollWindowGetOffset(gridViewName)
	else
		scrollOffset = scrollpos	
	end
	local socketName 	
	local _, windowHeight = WindowGetDimensions(this)
	local GRID_HEIGHT = math.floor((windowHeight - (ContainerWindow.Grid.PaddingTop + ContainerWindow.Grid.PaddingBottom)) / 40.5) 

	local totalHidden = 0
	local totalSeen = 0
	local sockSizeMod1= 40.5
	local sockSizeMod2= 60.5 	
	local beginningRowsToHide =  math.floor(math.floor(scrollOffset) / (sockSizeMod1 - 0.5))
	for i = 1, data.numGridSockets do
		socketName = this.."GridViewSocket"..i 
		if(DoesWindowNameExist(socketName)) then
			local _,elementY = WindowGetScreenPosition(socketName)
			local temp = parentY + (beginningRowsToHide * sockSizeMod1) - 10			
			local temp2 = temp + (GRID_HEIGHT * sockSizeMod2) +1
			if (elementY < temp) then
				--Debug.Print("Hidden :("..i.." temp: "..temp..")")
				WindowSetShowing(socketName, false)
				totalHidden = totalHidden + 1
			elseif(elementY > temp2) then
				--Debug.Print("Hidden :("..i.." temp2: "..temp2..")")
				WindowSetShowing(socketName, false)
				totalHidden = totalHidden + 1
			else					
				WindowSetShowing(socketName, true)
				totalSeen = totalSeen + 1
			end			
		end
	end	
	--Debug.Print("totalHidden :("..totalHidden.." totalSeen: "..totalSeen..")")	
end