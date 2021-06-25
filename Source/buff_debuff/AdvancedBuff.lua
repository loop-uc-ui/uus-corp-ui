--[[
	This window shows the list of buffs.
	We've kept the original window name for compatibility purposes.
]]--
AdvancedBuff = ListWindow:new("AdvancedBuffGood", false)

local adapter = AdvancedBuff.adapter

AdvancedBuff.WindowNameGood = "AdvancedBuffGood"

local direction = 0
local DOCKSPOT = "AdvancedBuffGoodImage"
local DOCKSPOT_TEXTURE = "AdvancedBuffDockspot"
local ROTATE_BUTTON = "AdvancedBuffGoodContext"

AdvancedBuff.ReverseOrderGood = {}
AdvancedBuff.TableOrderGood = {}

AdvancedBuff.PrevIconsGood = 0

local function UpdateDirections(orientation)
	local background = adapter.views[DOCKSPOT]
	local rotateButton = adapter.views[ROTATE_BUTTON]
	local lockButton = adapter.views["AdvancedBuffGoodLock"]

	if orientation == 1 then
		AdvancedBuff:setDimensions(106, 71)
		background:setTexture(DOCKSPOT_TEXTURE, 3, 0)
				  :setDimensions(97, 52)
				  :setTextureDimensions(97, 52)
				  :clearAnchors()
				  :addAnchor("topright", AdvancedBuff.id, "topright", 0, 10)
		rotateButton:clearAnchors()
					:addAnchor("bottomright", AdvancedBuff.id, "bottomright", -3, -11)
		lockButton:clearAnchors()
				  :addAnchor("topleft", rotateButton.id, "topright", -5, -5)
	elseif orientation == 3 then
		AdvancedBuff:setDimensions(71, 106)
		background:setTexture(DOCKSPOT_TEXTURE, 107, 1)
				  :setDimensions(52, 97)
				  :setTextureDimensions(52, 97)
				  :clearAnchors()
				  :addAnchor("bottomleft", AdvancedBuff.id, "bottomleft", 0, 0)
		rotateButton:clearAnchors()
					:addAnchor("bottomleft", AdvancedBuff.id, "bottomleft", 3, -2)
		lockButton:clearAnchors()
				  :addAnchor("topright", rotateButton.id, "topleft", 5, -5)
	elseif orientation == 5 then
		AdvancedBuff:setDimensions(106, 71)
		background:setTexture(DOCKSPOT_TEXTURE, 121, 112)
				  :setDimensions(97, 52)
				  :setTextureDimensions(97, 52)
				  :clearAnchors()
				  :addAnchor("topleft", AdvancedBuff.id, "topleft", 0, 0)
		rotateButton:clearAnchors()
					:addAnchor("topleft", AdvancedBuff.id, "topleft", 2, 3)
		lockButton:clearAnchors()
				  :addAnchor("topright", rotateButton.id, "topleft", 5, -5)
	elseif orientation == 8 then
		AdvancedBuff:setDimensions(71, 106)
		background:setTexture(DOCKSPOT_TEXTURE, 55, 121)
				  :setDimensions(52, 97)
				  :setTextureDimensions(52, 97)
				  :clearAnchors()
				  :addAnchor("topright", AdvancedBuff.id, "topright", 0, 0)
		rotateButton:clearAnchors()
					:addAnchor("topright", AdvancedBuff.id, "topright", -2, 2)
		lockButton:clearAnchors()
				  :addAnchor("topleft", rotateButton.id, "topright", -5, -5)
	else
		UpdateDirections(1)
	end
	AdvancedBuff.HandleReAnchorBuffGood(1)
end

function AdvancedBuff.Initialize()
	adapter:addLock()
			:addDynamicImage(DOCKSPOT, DOCKSPOT_TEXTURE, 3, 0)
			:addButton(ROTATE_BUTTON)

	if AdvancedBuff:getAnchorCount() > 0 then
		AdvancedBuff:clearAnchors()
	end

	adapter.views[DOCKSPOT]:setColor({
		r = 170,
		g = 254,
		b = 141
	})

	AdvancedBuff:setOffsetFromParent(451, 125)
    WindowUtils.RestoreWindowPosition(AdvancedBuff.id)
    WindowUtils.LoadScale(AdvancedBuff.id)
    direction = BuffDebuffSettings.windowDirection()
    UpdateDirections()
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

function AdvancedBuff.Rotate()
	if direction == 1 then
		direction = 3
	elseif direction == 3 then
		direction = 5
	elseif direction == 5 then
		direction = 8
	else
		direction = 1
	end
	BuffDebuffSettings.windowDirection(direction)
	UpdateDirections(direction)
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