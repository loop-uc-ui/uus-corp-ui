----------------------------------------------------------------
-- Global Variables
----------------------------------------------------------------

AdvancedBuff = {}

----------------------------------------------------------------
-- Local Variables
----------------------------------------------------------------

AdvancedBuff.WindowNameGood = "AdvancedBuffGood"
AdvancedBuff.WindowNameEvil = "AdvancedBuffEvil"

AdvancedBuff.GoodLocked = false
AdvancedBuff.EvilLocked = false

-- directions:

-- ___|  == 1

-- |___  == 2

-- |
-- |_  == 3

--  |
-- _| == 4

--  ___  
-- |     == 5

-- ___  
--    | == 6

--  _
-- |
-- |  == 7

-- _
--  |
--  |  == 8


AdvancedBuff.GoodDirection = 1
AdvancedBuff.EvilDirection = 2

AdvancedBuff.ReverseOrderGood = {}
AdvancedBuff.ReverseOrderEvil = {}
AdvancedBuff.TableOrderGood = {}
AdvancedBuff.TableOrderEvil = {}

AdvancedBuff.PrevIconsGood = 0
AdvancedBuff.PrevIconsEvil = 0

----------------------------------------------------------------
-- Functions
----------------------------------------------------------------

function AdvancedBuff.Initialize()
	CreateWindowFromTemplate(AdvancedBuff.WindowNameGood, "AdvancedBuff", "Root")
	if (WindowGetAnchorCount(AdvancedBuff.WindowNameGood) > 0) then
		WindowClearAnchors(AdvancedBuff.WindowNameGood)
	end
	WindowSetOffsetFromParent(AdvancedBuff.WindowNameGood, 451 , 125)
    WindowUtils.RestoreWindowPosition(AdvancedBuff.WindowNameGood)  
    WindowUtils.LoadScale( AdvancedBuff.WindowNameGood )	
					
	CreateWindowFromTemplate(AdvancedBuff.WindowNameEvil, "AdvancedBuff", "Root")
	if (WindowGetAnchorCount(AdvancedBuff.WindowNameEvil) > 0) then
		WindowClearAnchors(AdvancedBuff.WindowNameEvil)
	end
	WindowSetOffsetFromParent(AdvancedBuff.WindowNameEvil, 585 , 125)
	WindowUtils.RestoreWindowPosition(AdvancedBuff.WindowNameEvil)
    WindowUtils.LoadScale( AdvancedBuff.WindowNameEvil )
    
    AdvancedBuff.GoodLocked = Interface.LoadBoolean( "AdvancedBuffGoodLocked",AdvancedBuff.GoodLocked )
    AdvancedBuff.EvilLocked = Interface.LoadBoolean( "AdvancedBuffEvilLocked",AdvancedBuff.EvilLocked )
    
    WindowSetMovable(AdvancedBuff.WindowNameGood, AdvancedBuff.GoodLocked)
    WindowSetMovable(AdvancedBuff.WindowNameEvil, AdvancedBuff.EvilLocked)
    
    local texture = "UO_Core"
	if ( AdvancedBuff.GoodLocked  ) then		
		ButtonSetTexture(AdvancedBuff.WindowNameGood.."Lock", InterfaceCore.ButtonStates.STATE_NORMAL, texture, 69,341)
		ButtonSetTexture(AdvancedBuff.WindowNameGood.."Lock",InterfaceCore.ButtonStates.STATE_NORMAL_HIGHLITE, texture, 92,341)
		ButtonSetTexture(AdvancedBuff.WindowNameGood.."Lock", InterfaceCore.ButtonStates.STATE_PRESSED, texture, 92,341)
		ButtonSetTexture(AdvancedBuff.WindowNameGood.."Lock", InterfaceCore.ButtonStates.STATE_PRESSED_HIGHLITE, texture, 92,341)
	else
		ButtonSetTexture(AdvancedBuff.WindowNameGood.."Lock", InterfaceCore.ButtonStates.STATE_NORMAL, texture, 117,341)
		ButtonSetTexture(AdvancedBuff.WindowNameGood.."Lock",InterfaceCore.ButtonStates.STATE_NORMAL_HIGHLITE, texture, 142,341)
		ButtonSetTexture(AdvancedBuff.WindowNameGood.."Lock", InterfaceCore.ButtonStates.STATE_PRESSED, texture, 142,341)
		ButtonSetTexture(AdvancedBuff.WindowNameGood.."Lock", InterfaceCore.ButtonStates.STATE_PRESSED_HIGHLITE, texture, 142,341)		
	end
	
	texture = "UO_Core"
	if ( AdvancedBuff.EvilLocked ) then		
		ButtonSetTexture(AdvancedBuff.WindowNameEvil.."Lock", InterfaceCore.ButtonStates.STATE_NORMAL, texture, 69,341)
		ButtonSetTexture(AdvancedBuff.WindowNameEvil.."Lock",InterfaceCore.ButtonStates.STATE_NORMAL_HIGHLITE, texture, 92,341)
		ButtonSetTexture(AdvancedBuff.WindowNameEvil.."Lock", InterfaceCore.ButtonStates.STATE_PRESSED, texture, 92,341)
		ButtonSetTexture(AdvancedBuff.WindowNameEvil.."Lock", InterfaceCore.ButtonStates.STATE_PRESSED_HIGHLITE, texture, 92,341)
	else
		ButtonSetTexture(AdvancedBuff.WindowNameEvil.."Lock", InterfaceCore.ButtonStates.STATE_NORMAL, texture, 117,341)
		ButtonSetTexture(AdvancedBuff.WindowNameEvil.."Lock",InterfaceCore.ButtonStates.STATE_NORMAL_HIGHLITE, texture, 142,341)
		ButtonSetTexture(AdvancedBuff.WindowNameEvil.."Lock", InterfaceCore.ButtonStates.STATE_PRESSED, texture, 142,341)
		ButtonSetTexture(AdvancedBuff.WindowNameEvil.."Lock", InterfaceCore.ButtonStates.STATE_PRESSED_HIGHLITE, texture, 142,341)		
	end
		
    AdvancedBuff.GoodDirection = Interface.LoadNumber( "AdvancedBuffGoodDirection", AdvancedBuff.GoodDirection )
    AdvancedBuff.EvilDirection = Interface.LoadNumber( "AdvancedBuffEvilDirection", AdvancedBuff.EvilDirection )    
    AdvancedBuff.UpdateDirections()   
end

function AdvancedBuff.Shutdown()
	if (AdvancedBuff.GoodDirection == 1 or AdvancedBuff.GoodDirection == 3) then
		local endIcons = table.getn(AdvancedBuff.TableOrderGood)
		if (endIcons > 0) then
			for i=1, endIcons do
				BuffDebuff.HandleBuffRemoved(AdvancedBuff.TableOrderGood[i])
			end
		end
	end
	
	if (AdvancedBuff.EvilDirection == 4 or AdvancedBuff.EvilDirection == 6) then
		local endIcons = table.getn(AdvancedBuff.TableOrderEvil)
		if (endIcons > 0) then
			for i=1, endIcons do
				BuffDebuff.HandleBuffRemoved(AdvancedBuff.TableOrderEvil[i])
			end
		end
	end
	
    WindowUtils.SaveWindowPosition(AdvancedBuff.WindowNameGood)   
	WindowUtils.SaveWindowPosition(AdvancedBuff.WindowNameEvil)   
end

function AdvancedBuff.UpdateDirections(isRotating)
	-- GOOD
	local goodX, goodY = WindowGetOffsetFromParent(AdvancedBuff.WindowNameGood .. "Context")
	if (AdvancedBuff.GoodDirection == 1) then
		DynamicImageSetTexture(AdvancedBuff.WindowNameGood .. "Image", "AdvancedBuffDockspot", 3, 0 )
		WindowSetDimensions(AdvancedBuff.WindowNameGood, 106,71)
		DynamicImageSetTextureDimensions(AdvancedBuff.WindowNameGood .. "Image", 97, 52)
		WindowSetDimensions(AdvancedBuff.WindowNameGood .. "Image", 97, 52)
		WindowClearAnchors(AdvancedBuff.WindowNameGood .. "Image")
		WindowAddAnchor(AdvancedBuff.WindowNameGood .. "Image","topright", AdvancedBuff.WindowNameGood, "topright", 0, 10)		
		
		WindowClearAnchors(AdvancedBuff.WindowNameGood .. "Context")
		WindowAddAnchor(AdvancedBuff.WindowNameGood .. "Context","bottomright", AdvancedBuff.WindowNameGood, "bottomright", -3, -11)
		WindowSetTintColor(AdvancedBuff.WindowNameGood .. "Image", 170,254,141)
		
		WindowClearAnchors(AdvancedBuff.WindowNameGood .. "Lock")
		WindowAddAnchor(AdvancedBuff.WindowNameGood .. "Lock","topleft", AdvancedBuff.WindowNameGood .. "Context", "topright", -5, -5)
		
	elseif (AdvancedBuff.GoodDirection == 3) then
		DynamicImageSetTexture(AdvancedBuff.WindowNameGood .. "Image", "AdvancedBuffDockspot", 107, 1 )
		WindowSetDimensions(AdvancedBuff.WindowNameGood, 71,106)
		DynamicImageSetTextureDimensions(AdvancedBuff.WindowNameGood .. "Image", 52, 97)
		WindowSetDimensions(AdvancedBuff.WindowNameGood .. "Image", 52, 97)
		WindowClearAnchors(AdvancedBuff.WindowNameGood .. "Image")
		WindowAddAnchor(AdvancedBuff.WindowNameGood .. "Image","bottomleft", AdvancedBuff.WindowNameGood, "bottomleft", 0, 0)
		
		WindowClearAnchors(AdvancedBuff.WindowNameGood .. "Context")
		WindowAddAnchor(AdvancedBuff.WindowNameGood .. "Context","bottomleft", AdvancedBuff.WindowNameGood, "bottomleft", 3, -2)
		WindowSetTintColor(AdvancedBuff.WindowNameGood .. "Image", 170,254,141)
		
		WindowClearAnchors(AdvancedBuff.WindowNameGood .. "Lock")
		WindowAddAnchor(AdvancedBuff.WindowNameGood .. "Lock","topright", AdvancedBuff.WindowNameGood .. "Context", "topleft", 5, -5)
	elseif (AdvancedBuff.GoodDirection == 5) then
		DynamicImageSetTexture(AdvancedBuff.WindowNameGood .. "Image", "AdvancedBuffDockspot", 121, 112 )
		WindowSetDimensions(AdvancedBuff.WindowNameGood, 106,71)
		DynamicImageSetTextureDimensions(AdvancedBuff.WindowNameGood .. "Image", 97, 52)
		WindowSetDimensions(AdvancedBuff.WindowNameGood .. "Image", 97, 52)
		WindowClearAnchors(AdvancedBuff.WindowNameGood .. "Image")
		WindowAddAnchor(AdvancedBuff.WindowNameGood .. "Image","topleft", AdvancedBuff.WindowNameGood, "topleft", 0, 0)
		
		WindowClearAnchors(AdvancedBuff.WindowNameGood .. "Context")
		WindowAddAnchor(AdvancedBuff.WindowNameGood .. "Context","topleft", AdvancedBuff.WindowNameGood, "topleft", 2, 3)
		WindowSetTintColor(AdvancedBuff.WindowNameGood .. "Image", 170,254,141)
		
		WindowClearAnchors(AdvancedBuff.WindowNameGood .. "Lock")
		WindowAddAnchor(AdvancedBuff.WindowNameGood .. "Lock","topright", AdvancedBuff.WindowNameGood .. "Context", "topleft", 5, -5)
	elseif (AdvancedBuff.GoodDirection == 8) then
		DynamicImageSetTexture(AdvancedBuff.WindowNameGood .. "Image", "AdvancedBuffDockspot", 55, 121 )
		WindowSetDimensions(AdvancedBuff.WindowNameGood, 71,106)
		DynamicImageSetTextureDimensions(AdvancedBuff.WindowNameGood .. "Image", 52, 97)
		WindowSetDimensions(AdvancedBuff.WindowNameGood .. "Image", 52, 97)
		WindowClearAnchors(AdvancedBuff.WindowNameGood .. "Image")
		WindowAddAnchor(AdvancedBuff.WindowNameGood .. "Image","topright", AdvancedBuff.WindowNameGood, "topright", 0, 0)
		
		WindowClearAnchors(AdvancedBuff.WindowNameGood .. "Context")
		WindowAddAnchor(AdvancedBuff.WindowNameGood .. "Context","topright", AdvancedBuff.WindowNameGood, "topright", -2, 2)
		WindowSetTintColor(AdvancedBuff.WindowNameGood .. "Image", 170,254,141)
		
		WindowClearAnchors(AdvancedBuff.WindowNameGood .. "Lock")
		WindowAddAnchor(AdvancedBuff.WindowNameGood .. "Lock","topleft", AdvancedBuff.WindowNameGood .. "Context", "topright", -5, -5)
	end
	AdvancedBuff.HandleReAnchorBuffGood(1)
	if isRotating and isRotating == 0 then
		local goodX_new, goodY_new = WindowGetOffsetFromParent(AdvancedBuff.WindowNameGood .. "Context")
		local gx, gy = WindowGetOffsetFromParent(AdvancedBuff.WindowNameGood)
		WindowClearAnchors(AdvancedBuff.WindowNameGood)
		WindowSetOffsetFromParent(AdvancedBuff.WindowNameGood, gx - (goodX_new - goodX), gy - (goodY_new - goodY))
	end
	
	-- EVIL
	local evilX, evilY = WindowGetOffsetFromParent(AdvancedBuff.WindowNameEvil .. "Context")
	if (AdvancedBuff.EvilDirection == 2) then
		DynamicImageSetTexture(AdvancedBuff.WindowNameEvil .. "Image", "AdvancedBuffDockspot", 1, 56 )
		WindowSetDimensions(AdvancedBuff.WindowNameEvil, 106,71)
		DynamicImageSetTextureDimensions(AdvancedBuff.WindowNameEvil .. "Image", 97, 52)
		WindowSetDimensions(AdvancedBuff.WindowNameEvil .. "Image", 97, 52)
		WindowClearAnchors(AdvancedBuff.WindowNameEvil .. "Image")
		WindowAddAnchor(AdvancedBuff.WindowNameEvil .. "Image","topleft", AdvancedBuff.WindowNameEvil, "topleft", 0, 10)
		
		WindowClearAnchors(AdvancedBuff.WindowNameEvil .. "Context")
		WindowAddAnchor(AdvancedBuff.WindowNameEvil .. "Context","bottomleft", AdvancedBuff.WindowNameEvil, "bottomleft", 2, -11)
		WindowSetTintColor(AdvancedBuff.WindowNameEvil .. "Image", 255,149,152)
		
		WindowClearAnchors(AdvancedBuff.WindowNameEvil .. "Lock")
		WindowAddAnchor(AdvancedBuff.WindowNameEvil .. "Lock","topright", AdvancedBuff.WindowNameEvil .. "Context", "topleft", 5, -5)
	elseif (AdvancedBuff.EvilDirection == 4) then
		DynamicImageSetTexture(AdvancedBuff.WindowNameEvil .. "Image", "AdvancedBuffDockspot", 162, 1 )
		WindowSetDimensions(AdvancedBuff.WindowNameEvil, 71,106)
		DynamicImageSetTextureDimensions(AdvancedBuff.WindowNameEvil .. "Image", 52, 97)
		WindowSetDimensions(AdvancedBuff.WindowNameEvil .. "Image", 52, 97)
		WindowClearAnchors(AdvancedBuff.WindowNameEvil .. "Image")
		WindowAddAnchor(AdvancedBuff.WindowNameEvil .. "Image","bottomright", AdvancedBuff.WindowNameEvil, "bottomright", 0, 0)
		
		WindowClearAnchors(AdvancedBuff.WindowNameEvil .. "Context")
		WindowAddAnchor(AdvancedBuff.WindowNameEvil .. "Context","bottomright", AdvancedBuff.WindowNameEvil, "bottomright", -3, -2)
		WindowSetTintColor(AdvancedBuff.WindowNameEvil .. "Image", 255,149,152)
		
		WindowClearAnchors(AdvancedBuff.WindowNameEvil .. "Lock")
		WindowAddAnchor(AdvancedBuff.WindowNameEvil .. "Lock","topleft", AdvancedBuff.WindowNameEvil .. "Context", "topright", -5, -5)
	elseif (AdvancedBuff.EvilDirection == 6) then
		DynamicImageSetTexture(AdvancedBuff.WindowNameEvil .. "Image", "AdvancedBuffDockspot", 116, 166 )
		WindowSetDimensions(AdvancedBuff.WindowNameEvil, 106,71)
		DynamicImageSetTextureDimensions(AdvancedBuff.WindowNameEvil .. "Image", 97, 52)
		WindowSetDimensions(AdvancedBuff.WindowNameEvil .. "Image", 97, 52)
		WindowClearAnchors(AdvancedBuff.WindowNameEvil .. "Image")
		WindowAddAnchor(AdvancedBuff.WindowNameEvil .. "Image","topright", AdvancedBuff.WindowNameEvil, "topright", 0, 0)
		
		WindowClearAnchors(AdvancedBuff.WindowNameEvil .. "Context")
		WindowAddAnchor(AdvancedBuff.WindowNameEvil .. "Context","topright", AdvancedBuff.WindowNameEvil, "topright", -2, 3)
		WindowSetTintColor(AdvancedBuff.WindowNameEvil .. "Image", 255,149,152)
		
		WindowClearAnchors(AdvancedBuff.WindowNameEvil .. "Lock")
		WindowAddAnchor(AdvancedBuff.WindowNameEvil .. "Lock","topleft", AdvancedBuff.WindowNameEvil .. "Context", "topright", -5, -5)
	elseif (AdvancedBuff.EvilDirection == 7) then
		DynamicImageSetTexture(AdvancedBuff.WindowNameEvil .. "Image", "AdvancedBuffDockspot", 0, 121 )
		WindowSetDimensions(AdvancedBuff.WindowNameEvil, 71,106)
		DynamicImageSetTextureDimensions(AdvancedBuff.WindowNameEvil .. "Image", 52, 97)
		WindowSetDimensions(AdvancedBuff.WindowNameEvil .. "Image", 52, 97)
		WindowClearAnchors(AdvancedBuff.WindowNameEvil .. "Image")
		WindowAddAnchor(AdvancedBuff.WindowNameEvil .. "Image","topleft", AdvancedBuff.WindowNameEvil, "topleft", 0, 0)
		
		WindowClearAnchors(AdvancedBuff.WindowNameEvil .. "Context")
		WindowAddAnchor(AdvancedBuff.WindowNameEvil .. "Context","topleft", AdvancedBuff.WindowNameEvil, "topleft", 3, 3)
		WindowSetTintColor(AdvancedBuff.WindowNameEvil .. "Image", 255,149,152)
		
		WindowClearAnchors(AdvancedBuff.WindowNameEvil .. "Lock")
		WindowAddAnchor(AdvancedBuff.WindowNameEvil .. "Lock","topright", AdvancedBuff.WindowNameEvil .. "Context", "topleft", 5, -5)
	end
	AdvancedBuff.HandleReAnchorBuffEvil(1)
	if isRotating and isRotating == 1 then
		local evilX_new, evilY_new = WindowGetOffsetFromParent(AdvancedBuff.WindowNameEvil .. "Context")
		local gx, gy = WindowGetOffsetFromParent(AdvancedBuff.WindowNameEvil)
		WindowClearAnchors(AdvancedBuff.WindowNameEvil)
		WindowSetOffsetFromParent(AdvancedBuff.WindowNameEvil, gx - (evilX_new - evilX), gy - (evilY_new - evilY))
	end
end

function AdvancedBuff.Rotate()
	local windowname = WindowUtils.GetActiveDialog()
	if string.find(windowname, "Good") then
		if (AdvancedBuff.GoodDirection == 1) then
			AdvancedBuff.GoodDirection = 3
		elseif (AdvancedBuff.GoodDirection == 3) then
			AdvancedBuff.GoodDirection = 5
		elseif (AdvancedBuff.GoodDirection == 5) then
			AdvancedBuff.GoodDirection = 8
		elseif (AdvancedBuff.GoodDirection == 8) then
			AdvancedBuff.GoodDirection = 1
		end
		Interface.SaveNumber( "AdvancedBuffGoodDirection", AdvancedBuff.GoodDirection )
		AdvancedBuff.UpdateDirections(0)
	else
		if (AdvancedBuff.EvilDirection == 2) then
			AdvancedBuff.EvilDirection = 7
		elseif (AdvancedBuff.EvilDirection == 7) then
			AdvancedBuff.EvilDirection = 6
		elseif (AdvancedBuff.EvilDirection == 6) then
			AdvancedBuff.EvilDirection = 4
		elseif (AdvancedBuff.EvilDirection == 4) then
			AdvancedBuff.EvilDirection = 2
		end
		Interface.SaveNumber( "AdvancedBuffEvilDirection", AdvancedBuff.EvilDirection )
		AdvancedBuff.UpdateDirections(1)
	end
end

function AdvancedBuff.LockTooltip()
	local windowname = WindowUtils.GetActiveDialog()
	if string.find(windowname, "Good") then
		if ( AdvancedBuff.GoodLocked  ) then
			Tooltips.CreateTextOnlyTooltip(SystemData.ActiveWindow.name, GetStringFromTid(1111696))
		else
			Tooltips.CreateTextOnlyTooltip(SystemData.ActiveWindow.name, GetStringFromTid(1111697))
		end
	else
		
		if ( AdvancedBuff.EvilLocked  ) then
			Tooltips.CreateTextOnlyTooltip(SystemData.ActiveWindow.name, GetStringFromTid(1111696))
		else
			Tooltips.CreateTextOnlyTooltip(SystemData.ActiveWindow.name, GetStringFromTid(1111697))
		end
	end	
	Tooltips.Finalize()
	Tooltips.AnchorTooltip( Tooltips.ANCHOR_WINDOW_TOP )
end

function AdvancedBuff.LockMe()
	local windowname = WindowUtils.GetActiveDialog()
	if string.find(windowname, "Good") then
		AdvancedBuff.GoodLocked = not AdvancedBuff.GoodLocked
		Interface.SaveBoolean( "AdvancedBuffGoodLocked", AdvancedBuff.GoodLocked  )
		WindowSetMovable(AdvancedBuff.WindowNameGood, AdvancedBuff.GoodLocked)
		
		local texture = "UO_Core"
		if ( AdvancedBuff.GoodLocked  ) then		
			ButtonSetTexture(windowname.."Lock", InterfaceCore.ButtonStates.STATE_NORMAL, texture, 69,341)
			ButtonSetTexture(windowname.."Lock",InterfaceCore.ButtonStates.STATE_NORMAL_HIGHLITE, texture, 92,341)
			ButtonSetTexture(windowname.."Lock", InterfaceCore.ButtonStates.STATE_PRESSED, texture, 92,341)
			ButtonSetTexture(windowname.."Lock", InterfaceCore.ButtonStates.STATE_PRESSED_HIGHLITE, texture, 92,341)
		else
			ButtonSetTexture(windowname.."Lock", InterfaceCore.ButtonStates.STATE_NORMAL, texture, 117,341)
			ButtonSetTexture(windowname.."Lock",InterfaceCore.ButtonStates.STATE_NORMAL_HIGHLITE, texture, 142,341)
			ButtonSetTexture(windowname.."Lock", InterfaceCore.ButtonStates.STATE_PRESSED, texture, 142,341)
			ButtonSetTexture(windowname.."Lock", InterfaceCore.ButtonStates.STATE_PRESSED_HIGHLITE, texture, 142,341)		
		end
	else
		AdvancedBuff.EvilLocked = not AdvancedBuff.EvilLocked
		Interface.SaveBoolean( "AdvancedBuffEvilLocked", AdvancedBuff.EvilLocked )
		WindowSetMovable(AdvancedBuff.WindowNameEvil, AdvancedBuff.EvilLocked)
		
		local texture = "UO_Core"
		if ( AdvancedBuff.EvilLocked ) then		
			ButtonSetTexture(windowname.."Lock", InterfaceCore.ButtonStates.STATE_NORMAL, texture, 69,341)
			ButtonSetTexture(windowname.."Lock",InterfaceCore.ButtonStates.STATE_NORMAL_HIGHLITE, texture, 92,341)
			ButtonSetTexture(windowname.."Lock", InterfaceCore.ButtonStates.STATE_PRESSED, texture, 92,341)
			ButtonSetTexture(windowname.."Lock", InterfaceCore.ButtonStates.STATE_PRESSED_HIGHLITE, texture, 92,341)
		else
			ButtonSetTexture(windowname.."Lock", InterfaceCore.ButtonStates.STATE_NORMAL, texture, 117,341)
			ButtonSetTexture(windowname.."Lock",InterfaceCore.ButtonStates.STATE_NORMAL_HIGHLITE, texture, 142,341)
			ButtonSetTexture(windowname.."Lock", InterfaceCore.ButtonStates.STATE_PRESSED, texture, 142,341)
			ButtonSetTexture(windowname.."Lock", InterfaceCore.ButtonStates.STATE_PRESSED_HIGHLITE, texture, 142,341)		
		end
	end

end

function AdvancedBuff.ContextToolsTooltip()
	Tooltips.CreateTextOnlyTooltip(SystemData.ActiveWindow.name, GetStringFromTid(1151586))	
	Tooltips.Finalize()
	Tooltips.AnchorTooltip( Tooltips.ANCHOR_WINDOW_TOP )
end

function AdvancedBuff.OnLButtonDown()
	if (SystemData.ActiveWindow.name == AdvancedBuff.WindowNameGood) then
		if (not AdvancedBuff.GoodLocked ) then			
			WindowSetMoving(AdvancedBuff.WindowNameGood,true)
		else
			WindowSetMoving(AdvancedBuff.WindowNameGood,false)
		end
	elseif (SystemData.ActiveWindow.name == AdvancedBuff.WindowNameEvil) then
		if (not AdvancedBuff.EvilLocked ) then			
			WindowSetMoving(AdvancedBuff.WindowNameEvil,true)
		else
			WindowSetMoving(AdvancedBuff.WindowNameEvil,false)
		end
	end
end

function AdvancedBuff.HandleReAnchorBuffGood(position)
	local endIcons = table.getn(AdvancedBuff.TableOrderGood)
	if (endIcons > 0) then
		if (AdvancedBuff.GoodDirection == 1) then
			for i=position, endIcons do
				iconName = "BuffDebuffIcon"..AdvancedBuff.TableOrderGood[i]
				WindowClearAnchors(iconName)
				AdvancedBuff.ReverseOrderGood[AdvancedBuff.TableOrderGood[i]] = i
				if i == 1 then					
					WindowAddAnchor(iconName, "topright", AdvancedBuff.WindowNameGood, "topright", -20, 5)
				else
					WindowAddAnchor(iconName, "topleft", "BuffDebuffIcon" ..AdvancedBuff.TableOrderGood[i-1] , "topright", -5, 0)
				end
				WindowClearAnchors(iconName.."TimerLabel")
				WindowAddAnchor(iconName.."TimerLabel", "top", iconName, "bottom", 0, -2)
				LabelSetTextAlign(iconName.."TimerLabel", "center")
			end			
			AdvancedBuff.PrevIconsGood = endIcons			
		elseif (AdvancedBuff.GoodDirection == 3) then
		
			for i=position, endIcons do
				iconName = "BuffDebuffIcon"..AdvancedBuff.TableOrderGood[i]
				WindowClearAnchors(iconName)
				AdvancedBuff.ReverseOrderGood[AdvancedBuff.TableOrderGood[i]] = i
				if i == 1 then					
					WindowAddAnchor(iconName, "bottomleft", AdvancedBuff.WindowNameGood, "bottomleft", 18, -18)
				else
					WindowAddAnchor(iconName, "topleft", "BuffDebuffIcon" ..AdvancedBuff.TableOrderGood[i-1] , "bottomleft",0 , -5)
				end
				WindowClearAnchors(iconName.."TimerLabel")
				WindowAddAnchor(iconName.."TimerLabel", "right", iconName, "left", 2, 0)
				LabelSetTextAlign(iconName.."TimerLabel", "left")
			end			
			AdvancedBuff.PrevIconsGood = endIcons			
		elseif (AdvancedBuff.GoodDirection == 5) then
			for i=position, endIcons do
				iconName = "BuffDebuffIcon"..AdvancedBuff.TableOrderGood[i]
				WindowClearAnchors(iconName)
				AdvancedBuff.ReverseOrderGood[AdvancedBuff.TableOrderGood[i]] = i
				if i == 1 then
					WindowAddAnchor(iconName, "topleft", AdvancedBuff.WindowNameGood, "topleft", 20, 20)
				else
					WindowAddAnchor(iconName, "topright", "BuffDebuffIcon" ..AdvancedBuff.TableOrderGood[i-1] , "topleft", 5, 0)
				end
				WindowClearAnchors(iconName.."TimerLabel")
				WindowAddAnchor(iconName.."TimerLabel", "bottom", iconName, "top", 0, 2)
				LabelSetTextAlign(iconName.."TimerLabel", "center")
			end			
		elseif (AdvancedBuff.GoodDirection == 8) then
			for i=position, endIcons do
				iconName = "BuffDebuffIcon"..AdvancedBuff.TableOrderGood[i]
				WindowClearAnchors(iconName)
				AdvancedBuff.ReverseOrderGood[AdvancedBuff.TableOrderGood[i]] = i
				if i == 1 then					
					WindowAddAnchor(iconName, "topright", AdvancedBuff.WindowNameGood, "topright", -20, 20)
				else
					WindowAddAnchor(iconName, "bottomleft", "BuffDebuffIcon" ..AdvancedBuff.TableOrderGood[i-1] , "topleft",0 , 5)
				end
				WindowClearAnchors(iconName.."TimerLabel")
				WindowAddAnchor(iconName.."TimerLabel", "left", iconName, "right", -2, 0)
				LabelSetTextAlign(iconName.."TimerLabel", "right")
			end
			
		end
	end
end

function AdvancedBuff.HandleReAnchorBuffEvil(position)
	local endIcons = table.getn(AdvancedBuff.TableOrderEvil)
	if (endIcons > 0) then
		if (AdvancedBuff.EvilDirection == 2) then			
			for i=position, endIcons do
				iconName = "BuffDebuffIcon"..AdvancedBuff.TableOrderEvil[i]
				WindowClearAnchors(iconName)
				AdvancedBuff.ReverseOrderEvil[AdvancedBuff.TableOrderEvil[i]] = i
				if i == 1 then
					WindowAddAnchor(iconName, "topleft", AdvancedBuff.WindowNameEvil, "topleft", 20, 5)
				else
					WindowAddAnchor(iconName, "topright", "BuffDebuffIcon" ..AdvancedBuff.TableOrderEvil[i-1] , "topleft", 5, 0)
				end
				WindowClearAnchors(iconName.."TimerLabel")
				WindowAddAnchor(iconName.."TimerLabel", "top", iconName, "bottom", 0, 0)
				LabelSetTextAlign(iconName.."TimerLabel", "center")
			end			
		elseif (AdvancedBuff.EvilDirection == 4) then		
			for i=position, endIcons do
				iconName = "BuffDebuffIcon"..AdvancedBuff.TableOrderEvil[i]
				WindowClearAnchors(iconName)
				AdvancedBuff.ReverseOrderEvil[AdvancedBuff.TableOrderEvil[i]] = i
				if i == 1 then					
					WindowAddAnchor(iconName, "bottomright", AdvancedBuff.WindowNameEvil, "bottomright", -18, -18)
				else
					WindowAddAnchor(iconName, "topleft", "BuffDebuffIcon" ..AdvancedBuff.TableOrderEvil[i-1] , "bottomleft",0 , -5)
				end
				WindowClearAnchors(iconName.."TimerLabel")
				WindowAddAnchor(iconName.."TimerLabel", "left", iconName, "right", -2, 0)
				LabelSetTextAlign(iconName.."TimerLabel", "right")
			end			
			AdvancedBuff.PrevIconsEvil = endIcons			
		elseif (AdvancedBuff.EvilDirection == 6) then
			for i=position, endIcons do
				iconName = "BuffDebuffIcon"..AdvancedBuff.TableOrderEvil[i]
				WindowClearAnchors(iconName)
				AdvancedBuff.ReverseOrderEvil[AdvancedBuff.TableOrderEvil[i]] = i
				if i == 1 then					
					WindowAddAnchor(iconName, "topright", AdvancedBuff.WindowNameEvil, "topright", -20, 20)
				else
					WindowAddAnchor(iconName, "topleft", "BuffDebuffIcon" ..AdvancedBuff.TableOrderEvil[i-1] , "topright", -5, 0)
				end
				WindowClearAnchors(iconName.."TimerLabel")
				WindowAddAnchor(iconName.."TimerLabel", "bottom", iconName, "top", 0, 2)
				LabelSetTextAlign(iconName.."TimerLabel", "center")
			end			
			AdvancedBuff.PrevIconsEvil = endIcons
		elseif (AdvancedBuff.EvilDirection == 7) then
			for i=position, endIcons do
				iconName = "BuffDebuffIcon"..AdvancedBuff.TableOrderEvil[i]
				WindowClearAnchors(iconName)
				AdvancedBuff.ReverseOrderEvil[AdvancedBuff.TableOrderEvil[i]] = i
				if i == 1 then					
					WindowAddAnchor(iconName, "topright", AdvancedBuff.WindowNameEvil, "topright", -12, 18)
				else
					WindowAddAnchor(iconName, "bottomleft", "BuffDebuffIcon" ..AdvancedBuff.TableOrderEvil[i-1] , "topleft",0 , 5)
				end
				WindowClearAnchors(iconName.."TimerLabel")
				WindowAddAnchor(iconName.."TimerLabel", "right", iconName, "left", 2, 0)
				LabelSetTextAlign(iconName.."TimerLabel", "left")
			end
			
		end
	end
end