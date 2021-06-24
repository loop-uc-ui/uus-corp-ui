--[[
	This window shows the list of buffs.
	We've kept the original window name for compatibility purposes.
]]--
AdvancedBuff = ListWindow:new("AdvancedBuffGood", false)

local adapter = AdvancedBuff.adapter

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


local direction = 1

AdvancedBuff.ReverseOrderGood = {}
AdvancedBuff.TableOrderGood = {}

AdvancedBuff.PrevIconsGood = 0

----------------------------------------------------------------
-- Functions
----------------------------------------------------------------

function AdvancedBuff.Initialize()
	adapter:addLock()
	if AdvancedBuff:getAnchorCount() > 0 then
		AdvancedBuff:clearAnchors()
	end
	AdvancedBuff:setOffsetFromParent(451, 125)
    WindowUtils.RestoreWindowPosition(AdvancedBuff.id)
    WindowUtils.LoadScale(AdvancedBuff.id)
    direction = BuffDebuffSettings.windowDirection()
    AdvancedBuff.UpdateDirections()
end

function AdvancedBuff.Shutdown()
	if (direction == 1 or direction == 3) then
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
	local goodX, goodY = WindowGetOffsetFromParent(AdvancedBuff.WindowNameGood .. "Context")
	if (direction == 1) then
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
		
	elseif (direction == 3) then
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
	elseif (direction == 5) then
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
	elseif (direction == 8) then
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
	if (direction == 1) then
		direction = 3
	elseif (direction == 3) then
		direction = 5
	elseif (direction == 5) then
		direction = 8
	elseif (direction == 8) then
		direction = 1
	end
	BuffDebuffSettings.windowDirection(direction)
	AdvancedBuff.UpdateDirections(0)
end

function AdvancedBuff.ContextToolsTooltip()
	Tooltips.CreateTextOnlyTooltip(SystemData.ActiveWindow.name, GetStringFromTid(1151586))	
	Tooltips.Finalize()
	Tooltips.AnchorTooltip( Tooltips.ANCHOR_WINDOW_TOP )
end

function AdvancedBuff.OnLButtonDown()
	AdvancedBuff:onLeftClickDown()
end

function AdvancedBuff.HandleReAnchorBuffGood(position)
	local endIcons = table.getn(AdvancedBuff.TableOrderGood)
	if (endIcons > 0) then
		if (direction == 1) then
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
		elseif (direction == 3) then
		
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
		elseif (direction == 5) then
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
		elseif (direction == 8) then
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