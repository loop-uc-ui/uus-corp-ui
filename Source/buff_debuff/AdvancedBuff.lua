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
AdvancedBuff.Buffs = {}

AdvancedBuff.PrevIconsGood = 0

local function UpdateDirections(orientation)
	local background = adapter.views[DOCKSPOT]
	local rotateButton = adapter.views[ROTATE_BUTTON]
	local lockButton = adapter.views[AdvancedBuff.id.."Lock"]

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

	local buffs = AdvancedBuff.getBuffs()
	for i = 1, #buffs do
		if i == 1 then
			buffs[i]:anchor(orientation)
		else
			buffs[i]:anchor(orientation, buffs[i - 1])
		end
	end
end

function AdvancedBuff.Initialize()
	RegisterWindowData(WindowData.BuffDebuff.Type, 0)
	WindowRegisterEventHandler( "BuffDebuff", WindowData.BuffDebuff.Event, "AdvancedBuff.addBuff")
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
		local endIcons = table.getn(AdvancedBuff.Buffs)
		if (endIcons > 0) then
			for i=1, endIcons do
				--BuffDebuff.HandleBuffRemoved(AdvancedBuff.Buffs[i])
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

function AdvancedBuff.addBuff()
	local buffId = Buffs.id()
	local csv = Buffs.csv()
	local rowNum = CSVUtilities.getRowIdWithColumnValue(csv, "ServerId", buffId)
	local textureId = rowNum and csv and csv[rowNum] and csv[rowNum].IconId or -1
	local windowId = "BuffDebuffIcon"..buffId
	local buff = textureId ~= -1 and not Buffs.isBeingRemoved() and BuffDebuffIcon:new(
			table.getn(AdvancedBuff.getBuffs()) + 1,
			textureId,
			buffId,
			Buffs.timer(),
			Buffs.hasTimer(),
			Buffs.isBeingRemoved(),
			Buffs.nameVectorSize(),
			Buffs.toolTipVectorSize(),
			Buffs.nameVector(),
			Buffs.toolTipVector()
	) or adapter.views[windowId]

	--Overwrite the buff
	if buff ~= nil and buff:exists() then
		buff:destroy()
		adapter.views[windowId] = nil
	end

	if buff ~= nil then
		buff:create()
		adapter.views[windowId] = buff
	end
end

function AdvancedBuff.getBuffs()
	local buffs = {}
	for key, value in pairs(adapter.views) do
		if string.match(key, "BuffDebuff") then
			table.insert(buffs, value)
		end
	end
	return buffs
end

function AdvancedBuff.updateBuffs()
	local buffs = AdvancedBuff.getBuffs()
	if #buffs <= 0 then
		return
	end

	for i = 1, #buffs do
		local buff = buffs[i]
		local remainingTime = buff.timer - (TimeApi.getCurrentTime() - buff.time)
		if remainingTime >= 0 then
			buff:setTimerLabel(remainingTime)
		end

		if buff:getTimerLabel() ~= nil and remainingTime <= 10 and not buff.isAnimating then
			buff:getIcon():startAlphaAnimation(Window.AnimationType.LOOP, 0.1, 0.8, 0.8, false, 0, 0)
			buff.isAnimating = true
		end

		if remainingTime < 0 then
			ItemProperties.ClearMouseOverItem()
			buff:getIcon():stopAlphaAnimation()
			buff.isAnimating = false
			buff:destroy()
			adapter.views[buff.id] = nil
		end
	end
end