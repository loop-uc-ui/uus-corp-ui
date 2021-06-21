
----------------------------------------------------------------
-- Global Variables
----------------------------------------------------------------

BuffDebuff = {}

BuffDebuff.BuffData = {}
BuffDebuff.Timers = {}
BuffDebuff.BuffWindowId = {}
BuffDebuff.TableOrder = {}
BuffDebuff.ReverseOrder = {}
BuffDebuff.MaxLength = 6
BuffDebuff.Gap = 2
BuffDebuff.DeltaTime = 0
BuffDebuff.Fade = {start = 30, endtime = 10, amount = 0.2 }
BuffDebuff.TID = {}
BuffDebuff.TID.timeleft = 1075611
BuffDebuff.IconSize = 38
BuffDebuff.ActiveBuffs = {}
BuffDebuff.Fade = {}
BuffDebuff.FadeRaising = {}

----------------------------------------------------------------
-- Functions
----------------------------------------------------------------
function BuffDebuff.Update(timePassed)
	BuffDebuff.DeltaTime = BuffDebuff.DeltaTime + timePassed
	
	if (BuffDebuff.Timers ~= nil) then
		for key, value in pairs(BuffDebuff.Timers) do
			local buffId = key
			local parent = "BuffDebuff"
			local iconName = parent.."Icon"..buffId .. "TextureIcon"
			if ( type(BuffDebuff.Timers[buffId]) == "number") then
				local sec = tonumber(BuffDebuff.Timers[buffId])
				if ( sec < 10 and not BuffDebuff.Fade[buffId]) then
					
					BuffDebuff.Fade[buffId] = true
					WindowStartAlphaAnimation(iconName, Window.AnimationType.LOOP, 0.1, 0.8, 0.8, false, 0, 0)
				elseif (sec >= 10) then
					BuffDebuff.Fade[buffId] = false
					WindowStopAlphaAnimation(iconName)
				end
				
			end
		end
	end
	
	if( BuffDebuff.DeltaTime >= 1 ) then
		for key, value in pairs(BuffDebuff.Timers) do
			local time = value - BuffDebuff.DeltaTime
			--Debug.Print("Time passed for key ="..key.."time = "..math.ceil(time))
			if( time > 0 ) then
				BuffDebuff.Timers[key] = math.ceil(time)
			else
				BuffDebuff.Timers[key] = 0
				BuffDebuff.HandleBuffRemoved(key)
			end	
		end
		--Update Timer Label
		BuffDebuff.UpdateTimer(timePassed)
		--Reset delta time when it gets used to decrement the timers
		BuffDebuff.DeltaTime = 0
	end
end

function BuffDebuff.retrieveBuffData( buffData )
	if not buffData then
		return false
	end      

	if(WindowData.BuffDebuffSystem.CurrentBuffId == 0) then
		return false
	end
	
	buffData.abilityId = WindowData.BuffDebuffSystem.CurrentBuffId
	buffData.TimerSeconds = WindowData.BuffDebuff.TimerSeconds
	buffData.HasTimer = WindowData.BuffDebuff.HasTimer
	buffData.NameVectorSize = WindowData.BuffDebuff.NameVectorSize
	buffData.ToolTipVectorSize = WindowData.BuffDebuff.ToolTipVectorSize
	buffData.IsBeingRemoved = WindowData.BuffDebuff.IsBeingRemoved
	buffData.NameWStringVector = WindowData.BuffDebuff.NameWStringVector
	buffData.ToolTipWStringVector =  WindowData.BuffDebuff.ToolTipWStringVector
	return true
end

function BuffDebuff.Initialize()
	--Debug.Print("BuffDebuff.Initialize() ")
	UOBuildTableFromCSV("Data/GameData/buffdata.csv", "BuffDataCSV")
	RegisterWindowData(WindowData.BuffDebuff.Type, 0)
	WindowRegisterEventHandler( "BuffDebuff", WindowData.BuffDebuff.Event, "BuffDebuff.ShouldCreateNewBuff")
end

function BuffDebuff.ShouldCreateNewBuff()
	local buffId = WindowData.BuffDebuffSystem.CurrentBuffId
	
	--If we have a buff debuff icon up, check to see if that is being removed
	--Debug.Print("BuffDebuf event triggered")
	--Debug.Print(buffId)
	local buffData = {}
	if( BuffDebuff.retrieveBuffData( buffData ) ) then		
		BuffDebuff.BuffData[buffId] = buffData		
		if( WindowData.BuffDebuff.IsBeingRemoved == true ) then
			--Debug.Print("BuffDebuf getting destroyed"..buffId)
			if (BuffDebuff.BuffWindowId[buffId] == true) then
				if(buffId == 1043) then --1043 Curse
					if( BuffDebuff.ReverseOrder[1040] ~= nil) then --Clumsy
						BuffDebuff.HandleBuffRemoved(1040)
					end
					if( BuffDebuff.ReverseOrder[1041] ~= nil) then --Feeblemind
						BuffDebuff.HandleBuffRemoved(1041)
					end
					if( BuffDebuff.ReverseOrder[1042] ~= nil) then --Weaken
						BuffDebuff.HandleBuffRemoved(1042)
					end
				end
				BuffDebuff.HandleBuffRemoved(buffId)
			end
		else			
			local textureId = -1
			local rowServerNum = CSVUtilities.getRowIdWithColumnValue(WindowData.BuffDataCSV, "ServerId", buffId)
			if(rowServerNum ~= nil and WindowData.BuffDataCSV ~= nil and WindowData.BuffDataCSV[rowServerNum] ~= nil and WindowData.BuffDataCSV[rowServerNum].IconId ~= nil) then
				textureId = tonumber(WindowData.BuffDataCSV[rowServerNum].IconId)
				--Debug.Print("Trying to get the icon "..WindowData.BuffDataCSV[rowServerNum].IconId)
			end
			if(textureId ~= nil and textureId ~= -1 )then
				--Debug.Print("BuffDebuff.CreateNewBuff()")					
				BuffDebuff.CreateNewBuff()
			else
				--Debug.Print("BuffDebuff.CreateNewBuff() failed: "..tostring(textureId))
				BuffDebuff.BuffData[buffId] = nil
			end
		end		
	else
		--Debug.Print("BuffDebuff.retrieveBuffData failed")
	end
end

function BuffDebuff.HandleBuffRemoved(buffId)
	local iconName = "BuffDebuffIcon"..buffId
	local position = AdvancedBuff.ReverseOrderGood[buffId]
	table.remove(AdvancedBuff.TableOrderGood, position)
	AdvancedBuff.HandleReAnchorBuffGood(1)
	
	if (buffId == 1094) then
		HotbarSystem.EvasionCooldown = 20
	end
	if (buffId == 1021) then
		HotbarSystem.AttunementCooldown = 120
	end
	if (buffId == 1024) then
		HotbarSystem.EtherealVoyageCooldown = 300
	end
	
	-- Have to set this to nil since the buffId is removed from the table
	BuffDebuff.ReverseOrder[buffId] = nil
	BuffDebuff.BuffWindowId[buffId] = false
	BuffDebuff.BuffData[buffId] = nil
	BuffDebuff.Timers[buffId] = nil
	BuffDebuff.ActiveBuffs[buffId] = nil
	
	WindowUtils.SaveWindowPosition(iconName)
	DestroyWindow(iconName)
end

function BuffDebuff.UpdateTimer(timePassed)
	local endNumber = table.getn(AdvancedBuff.TableOrderGood)
	for i=1, endNumber do
		local buffId = AdvancedBuff.TableOrderGood[i]
		local parent = "BuffDebuff"
		local iconName = parent.."Icon"..buffId
		local timer = L" "

		if ( BuffDebuff.Timers[buffId] ~= nil and BuffDebuff.Timers[buffId] > 0   ) then
			local min = math.floor(BuffDebuff.Timers[buffId]/60)
			if min > 60 then
				local prefix = ""
				if ((min / 60) - math.floor(min / 60) > 0) then
					prefix = ">"
				end
				local h = math.floor(min / 60)
				timer = StringToWString(prefix .. tostring(h) .. "h")
			elseif min > 0 then
				local prefix = ""
				if (BuffDebuff.Timers[buffId] - (min * 60) > 0) then
					prefix = ">"
				end
				timer = StringToWString(prefix .. tostring(min)	.. "m")
			else
				timer = StringToWString(tostring(BuffDebuff.Timers[buffId])	.. "s")
			end
		end
		LabelSetText(iconName.."TimerLabel",timer)
		local scale = 1
		scale = WindowGetScale( AdvancedBuff.WindowNameGood )
		WindowSetScale(iconName, scale)
	end
end

function BuffDebuff.CreateNewBuff()
	local buffId = WindowData.BuffDebuffSystem.CurrentBuffId
	local buffData = BuffDebuff.BuffData[buffId]
	
	if( BuffDebuff.BuffWindowId[buffId] ~= true)then
		-- Need to know the ordering so we can anchor the buffs correctly 
		local parent = "BuffDebuff"
		local iconName = parent.."Icon"..buffId
		table.insert(AdvancedBuff.TableOrderGood, buffId)
		CreateWindowFromTemplate(iconName, "BuffDebuffTemplate", "Root")
		table.insert(BuffDebuff.TableOrder, buffId) 
	
		local scale = WindowGetScale( AdvancedBuff.WindowNameGood )
		WindowSetScale(iconName, scale)
		WindowSetId(iconName, buffId)
		local numIcons = table.getn(AdvancedBuff.TableOrderGood)
		AdvancedBuff.ReverseOrderGood[buffId] = numIcons
		AdvancedBuff.HandleReAnchorBuffGood(numIcons)
		BuffDebuff.BuffWindowId[buffId] = true
		BuffDebuff.UpdateStatus(buffId)
	else
		BuffDebuff.UpdateStatus(buffId)
	end
	
	if(buffData.HasTimer == true) then
		BuffDebuff.Timers[buffId] = buffData.TimerSeconds
		if buffId == 1069 or buffId == 1101 then
			HotbarSystem.BandageDelayTime = tonumber(BuffDebuff.Timers[buffId])
		end
	end
	BuffDebuff.UpdateTimer()
end

function BuffDebuff.ResizeOuterWindow(windowName, numIcons)
	local numRows = math.ceil(numIcons / (BuffDebuff.MaxLength))
	local width = BuffDebuff.IconSize * BuffDebuff.MaxLength
	if(numIcons < BuffDebuff.MaxLength ) then
		width = BuffDebuff.IconSize * numIcons
	end
	
	local height = BuffDebuff.IconSize * (numRows)
	
	if( numIcons > 0) then
		WindowSetDimensions(windowName, width, height)
	else
		WindowSetDimensions(windowName, 0 , 0)
	end
end

function BuffDebuff.MouseOver()
	local buffId = WindowGetId(SystemData.ActiveWindow.name)
	local data = BuffDebuff.BuffData[buffId]
	if( data ) then
		local nameString = L""
		for i = 1, data.NameVectorSize do
			nameString = nameString..data.NameWStringVector[i]
		end
		
		local tooltipString = L""
		for i = 1, data.ToolTipVectorSize do
			tooltipString = tooltipString..data.ToolTipWStringVector[i]
		end	

		local bodyText = WindowUtils.translateMarkup(tooltipString)
		local itemData = {
			windowName = "BuffDebuffIcon"..buffId,
			itemId = buffId,
			itemType = WindowData.ItemProperties.TYPE_WSTRINGDATA,
			binding = L"",
			detail = nil,
			title =	WindowUtils.translateMarkup(nameString),
			body = bodyText
		}
		ItemProperties.SetActiveItem(itemData)
	end
end

function BuffDebuff.Shutdown()
	UnregisterWindowData(WindowData.BuffDebuff.Type, 0)
	
	UOUnloadCSVTable("BuffDataCSV")
end

function BuffDebuff.UpdateStatus(iconId)
	local buffId = iconId
	
	local parent = "BuffDebuffIcon"..buffId
	local iconTextureName = parent.."TextureIcon"
	
	--Debug.Print("BuffDebuff buffId = "..buffId)
	local rowServerNum = CSVUtilities.getRowIdWithColumnValue(WindowData.BuffDataCSV, "ServerId", buffId)
	local textureId = tonumber(WindowData.BuffDataCSV[rowServerNum].IconId)
	if( textureId ~= nil or textureId ~= -1) then
		--Debug.Print("BuffDebuff UpdateStatus textureId = "..textureId)
		local texture, x, y = GetIconData( textureId )
		DynamicImageSetTexture( iconTextureName, texture, x, y )
	end	
end
