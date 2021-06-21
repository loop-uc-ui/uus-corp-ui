----------------------------------------------------------------
-- Global Variables
----------------------------------------------------------------

AdvancedBuff = {}

----------------------------------------------------------------
-- Local Variables
----------------------------------------------------------------

AdvancedBuff.WindowNameGood = "AdvancedBuffGood"

AdvancedBuff.GoodLocked = false

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

AdvancedBuff.ReverseOrderGood = {}
AdvancedBuff.TableOrderGood = {}

AdvancedBuff.PrevIconsGood = 0

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
    
    AdvancedBuff.GoodLocked = Interface.LoadBoolean( "AdvancedBuffGoodLocked",AdvancedBuff.GoodLocked )
    
    WindowSetMovable(AdvancedBuff.WindowNameGood, AdvancedBuff.GoodLocked)
    
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
		
    AdvancedBuff.GoodDirection = Interface.LoadNumber( "AdvancedBuffGoodDirection", AdvancedBuff.GoodDirection )
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
	WindowUtils.SaveWindowPosition(AdvancedBuff.WindowNameGood)
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
	end
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