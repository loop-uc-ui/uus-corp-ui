----------------------------------------------------------------
-- Global Variables
----------------------------------------------------------------

DamageWindow = {}

----------------------------------------------------------------
-- Local Variables
----------------------------------------------------------------
DamageWindow.AttachedId = {}
--Used to shift the Y position to the max before it disappears off the screen
DamageWindow.OverheadAlive = -150
DamageWindow.OverheadMove = 2
DamageWindow.FadeStart = -10
DamageWindow.FadeDiff = 0.01
DamageWindow.DefaultAnchorY = 40
DamageWindow.ShiftYAmount = 15
DamageWindow.MaxAnchorYOverlap = 15
DamageWindow.AnchorY = {}

DamageWindow.DamageArray={}
DamageWindow.LastDamaged = 0
DamageWindow.waitSpecialDamage = nil
DamageWindow.lastSpecialWaiting = nil

DamageWindow.OTHERGETDAMAGE_COLOR = { r=255, g=255, b=0 }
DamageWindow.YOUGETAMAGE_COLOR = { r=255, g=0, b=0 }
DamageWindow.PETGETDAMAGE_COLOR = { r=255, g=80, b=255 }
 
----------------------------------------------------------------
-- DamageWindow Functions
----------------------------------------------------------------
function DamageWindow.Initialize()
	WindowRegisterEventHandler("Root", SystemData.Events.DAMAGE_NUMBER_INIT, "DamageWindow.Init")
end

--Creates a new window for the mobile Id and set the label text of the damage amount
function DamageWindow.Init()
	
	if DamageWindow.waitSpecialDamage then
		DamageWindow.AddText(Damage.mobileId, DamageWindow.waitSpecialDamage)
		DamageWindow.waitSpecialDamage = nil
		DamageWindow.lastSpecialWaiting = nil
	end
	local numWindow = DamageWindow.GetNextId()
	local windowName = "DamageWindow"..numWindow
	local labelName = windowName.."Text"

	if MobilesOnScreen.IsPet(Damage.mobileId) then
		color = DamageWindow.PETGETDAMAGE_COLOR
	elseif (Damage.mobileId == WindowData.PlayerStatus.PlayerId ) then
		color = DamageWindow.YOUGETAMAGE_COLOR	
	else
		color = DamageWindow.OTHERGETDAMAGE_COLOR
		if (not DamageWindow.DamageArray[Damage.mobileId]) then
			DamageWindow.DamageArray[Damage.mobileId] = 0
		end
		DamageWindow.DamageArray[Damage.mobileId] = DamageWindow.DamageArray[Damage.mobileId] + Damage.damageNumber
		DamageWindow.LastDamaged = Damage.mobileId
		if (NewChatWindow and DamageWindow.DamageArray[Damage.mobileId] >= NewChatWindow.minTotDmg ) then
			local mobname = L""
			if WindowData.MobileName[Damage.mobileId] then
				mobname = WindowData.MobileName[Damage.mobileId].MobName
			end
			local logVal = {text = L"Takes " .. Damage.damageNumber .. L" damage.\nA total of " .. DamageWindow.DamageArray[Damage.mobileId] .. L" from you." , channel = 14, color = color, sourceId = Damage.mobileId, sourceName = mobname, ignore = false, category = 0, timeStamp = StringToWString(string.format("%02.f", Interface.Clock.h) .. ":" .. string.format("%02.f", Interface.Clock.m) .. ":" .. string.format("%02.f", Interface.Clock.s))}
			table.insert(NewChatWindow.Messages, logVal)
			table.insert(NewChatWindow.Setting.Messages, logVal)
			if (table.getn(NewChatWindow.Setting.Messages) > 200) then
				table.remove(NewChatWindow.Setting.Messages, 1)
			end
			NewChatWindow.UpdateLog()
		end
	end
	
	CreateWindowFromTemplateShow(windowName, "DamageWindow", "Root", false)
	WindowSetScale(windowName, Interface.OverhedTextSize)
	
	AttachWindowToWorldObject(Damage.mobileId, windowName)


	--Shifts the previous damage numbers up if its too close to the new damage numbers
	--this way the damage numbers would not cover each other up
	DamageWindow.ShiftYWindowUp()
	
	--Set the time pass to 0 
	DamageWindow.AttachedId[numWindow] = Damage.mobileId
	DamageWindow.AnchorY[numWindow] = DamageWindow.DefaultAnchorY
	LabelSetText(labelName, L""..Damage.damageNumber)
	LabelSetFont(labelName, FontSelector.Fonts[OverheadText.DamageFontIndex].fontName, WindowUtils.FONT_DEFAULT_TEXT_LINESPACING)
	
	
	Interface.IsFighting = true
	Interface.IsFightingLastTime = Interface.TimeSinceLogin + 10
	Interface.CanLogout = Interface.TimeSinceLogin + 120

	

	if (color ~= nil ) then
		LabelSetTextColor( labelName, color.r, color.g, color.b )
	else
		LabelSetTextColor(labelName, Damage.red, Damage.green, Damage.blue)
	end

	PaperdollWindow.GotDamage =  true
	WindowAddAnchor(labelName, "bottom", windowName, "bottom", 0, DamageWindow.DefaultAnchorY)
end

function DamageWindow.GetNextId()
	local numWindow = 1
	while DoesWindowNameExist("DamageWindow"..numWindow) do
		numWindow = numWindow + 1
	end
	return numWindow
end

function DamageWindow.AddText(mobileId, text)
	
	local numWindow = DamageWindow.GetNextId()
	local windowName = "DamageWindow"..numWindow
	local labelName = windowName.."Text"
	CreateWindowFromTemplateShow(windowName, "DamageWindow", "Root", false)
	WindowSetScale(windowName, Interface.OverhedTextSize)
	
	AttachWindowToWorldObject(mobileId, windowName)


	--Shifts the previous damage numbers up if its too close to the new damage numbers
	--this way the damage numbers would not cover each other up
	DamageWindow.ShiftYWindowUp()
	
	--Set the time pass to 0 
	DamageWindow.AttachedId[numWindow] = mobileId
	DamageWindow.AnchorY[numWindow] = DamageWindow.DefaultAnchorY
	LabelSetText(labelName, text)
	LabelSetFont(labelName, FontSelector.Fonts[OverheadText.DamageFontIndex].fontName, WindowUtils.FONT_DEFAULT_TEXT_LINESPACING)
	
	if (mobileId == WindowData.PlayerStatus.PlayerId ) then
		color = DamageWindow.YOUGETAMAGE_COLOR	
	else
		color = DamageWindow.OTHERGETDAMAGE_COLOR
	end

	if (color ~= nil ) then
		LabelSetTextColor( labelName, color.r, color.g, color.b )
	else
		LabelSetTextColor(labelName, Damage.red, Damage.green, Damage.blue)
	end


	WindowAddAnchor(labelName, "bottom", windowName, "bottom", 0, DamageWindow.DefaultAnchorY)
end

-- If the previous Damage Number Y anchor too close to the new damage window, increase all the damage numbers y anchors
function DamageWindow.ShiftYWindowUp()
	if DamageWindow.IsOverlap() then
		for i, _ in pairs(DamageWindow.AttachedId) do
			DamageWindow.AnchorY[i] = DamageWindow.AnchorY[i] - DamageWindow.ShiftYAmount
			windowName = "DamageWindow"..i
  			labelName = windowName.."Text"
  			WindowClearAnchors(labelName)
  			WindowAddAnchor(labelName, "bottomleft",windowName , "bottomleft", 0, DamageWindow.AnchorY[i])
		end
	end
end

function DamageWindow.IsOverlap()
	for i, _ in pairs(DamageWindow.AttachedId) do
		if (DamageWindow.AnchorY[i] >= DamageWindow.MaxAnchorYOverlap ) then
  			return true
  		end
  	end
  	return false
end

--The damage number moves up and slowly disappears off the screen
function DamageWindow.UpdateTime(_)
	local count = 0
	for i, _ in pairs(DamageWindow.AttachedId) do
		DamageWindow.AnchorY[i] = DamageWindow.AnchorY[i] - DamageWindow.OverheadMove
	
		if (DamageWindow.AnchorY[i] < DamageWindow.OverheadAlive) then			
			DestroyWindow("DamageWindow"..i)
			DamageWindow.AnchorY[i] = 0
			DamageWindow.AttachedId[i] = nil
		else
			local windowName = "DamageWindow"..i
			local labelName = windowName.."Text"
			WindowClearAnchors(labelName)
			WindowAddAnchor(labelName, "bottom", windowName ,"bottom", 0, DamageWindow.AnchorY[i])
		end
		count = count +1
	end

	--If count is zero reset the numWindow to 1
	if( count == 0 ) then
		Damage.numWindow = 0
	end
end


