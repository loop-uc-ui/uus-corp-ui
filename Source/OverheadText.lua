----------------------------------------------------------------
-- Global Variables
----------------------------------------------------------------

OverheadText = {}

----------------------------------------------------------------
-- *** Local Variables
----------------------------------------------------------------
OverheadText.ActiveIdList = {}
OverheadText.FadeTimeId = {}
OverheadText.TimePassed = {}
OverheadText.AlphaStart = 1
OverheadText.AlphaDiff = 0.01
OverheadText.FadeStartTime = 4

OverheadText.FontIndex = 1
OverheadText.NameFontIndex = 1
OverheadText.SpellsFontIndex = 1
OverheadText.DamageFontIndex = 1

OverheadText.OverhedTextSize = InterfaceCore.scale
OverheadText.ChatData = {}
--how long the overhead chats will stay on screen (in sec's)
OverheadText.OverheadAlive = 10
OverheadText.MaxOverheadHeight = 150

OverheadText.LastSeeName = {}


OverheadText.mouseOverId = 0

OverheadText.GetsOverhead = {
	false,	--	System
	true,	--	Say
	false,	--	Private
	false,	--	Custom
	true,	--	Emote
	true,	--	Gesture
	true,	--	Whisper
	true,	--	Yell
	false,	--	Party
	false,	--	Guild
	false,	--	Alliance
--	false,	--	Faction
}

----------------------------------------------------------------
-- OverheadText Functions
----------------------------------------------------------------
function OverheadText.InitializeEvents()
    -- we only want to register for these events once so we dont get the event for every instance of the name window
    WindowRegisterEventHandler("Root", WindowData.MobileName.Event, "OverheadText.HandleMobileNameUpdate")
    WindowRegisterEventHandler("Root", SystemData.Events.SHOWNAMES_UPDATED, "OverheadText.HandleSettingsUpdate")
    WindowRegisterEventHandler("Root", SystemData.Events.SHOWNAMES_FLASH_TEMP, "OverheadText.HandleFlashTempNames")
    WindowRegisterEventHandler("Root", SystemData.Events.USER_SETTINGS_UPDATED, "OverheadText.UpdateSettings")
    
    OverheadText.UpdateSettings()
end

function OverheadText.Initialize()
	local this = SystemData.ActiveWindow.name
	local mobileId = SystemData.DynamicWindowId

	WindowSetId(this, mobileId)
	
	OverheadText.FadeTimeId[mobileId] = OverheadText.AlphaStart
	OverheadText.TimePassed[mobileId] = 0
	OverheadText.ActiveIdList[mobileId] = true

	OverheadText.ChatData[mobileId] = {}
	OverheadText.ChatData[mobileId].numVisibleChat = 0
	OverheadText.ChatData[mobileId].timePassed = {}
	OverheadText.ChatData[mobileId].timePassed[1] = 0
	OverheadText.ChatData[mobileId].timePassed[2] = 0
	OverheadText.ChatData[mobileId].timePassed[3] = 0
	OverheadText.ChatData[mobileId].showName = true
	
	
	RegisterWindowData(WindowData.MobileName.Type, mobileId)


	OverheadText.UpdateName(mobileId)
	WindowSetShowing(this.."Chat1", false)
	WindowSetShowing(this.."Chat2", false)
	WindowSetShowing(this.."Chat3", false)
end

function OverheadText.Shutdown()
	local this = SystemData.ActiveWindow.name
	local mobileId = WindowGetId(this)
	
	OverheadText.FadeTimeId[mobileId] = nil
	OverheadText.TimePassed[mobileId] = nil
	OverheadText.ActiveIdList[mobileId] = nil
	OverheadText.ChatData[mobileId] = nil
	OverheadText.LastSeeName[mobileId] = nil
	OverheadText.NameParsed[mobileId] = nil
	
	if (OverheadText.mouseOverId == mobileId) then
		OverheadText.NameOnMouseOverEnd()
	end
	
	DetachWindowFromWorldObject( mobileId, "OverheadTextWindow_"..mobileId )
	UnregisterWindowData(WindowData.MobileName.Type, mobileId)	

end

function OverheadText.HandleMobileNameUpdate()
    OverheadText.UpdateName(WindowData.UpdateInstanceId)
end

function OverheadText.HandleSettingsUpdate()
	for i, id in pairs(OverheadText.ActiveIdList) do
		local windowName = "OverheadTextWindow_"..i
		if(SystemData.Settings.GameOptions.showNames == SystemData.Settings.GameOptions.SHOWNAMES_NONE) then
			OverheadText.HideName(i)
		elseif(SystemData.Settings.GameOptions.showNames == SystemData.Settings.GameOptions.SHOWNAMES_APPROACHING or SystemData.Settings.GameOptions.showNames == SystemData.Settings.GameOptions.SHOWNAMES_ALL) then
			OverheadText.ShowName(i)
		end
	end
end

-- Used in the Macro Action 'All Names'
-- If the Show Names setting isn't set on 'Always', it will show all the names temporarily on the screen.
function OverheadText.HandleFlashTempNames()
	for i, id in pairs(OverheadText.ActiveIdList) do
		OverheadText.ShowName(i)
	end
end

function OverheadText.UpdateSettings()
	local userSetting = UserOverheadTextSettings.delay()
	
	if (userSetting == 1) then
		OverheadText.OverheadAlive = 5
	elseif (userSetting == 2) then
		OverheadText.OverheadAlive = 10
	elseif (userSetting == 3) then
		OverheadText.OverheadAlive = 30
	elseif (userSetting == 4) then
		OverheadText.OverheadAlive = 60
	elseif (userSetting == 5) then
		OverheadText.OverheadAlive = 300
	elseif (userSetting == 6) then
		OverheadText.OverheadAlive = 0
	else
		OverheadText.OverheadAlive = 5
	end
end

OverheadText.NameParsed = {}

function OverheadText.UpdateName(mobileId)
	-- Player and object names are not displayed
	if( OverheadText.ChatData[mobileId] == nil ) then
		return
	end
	if( OverheadText.ChatData[mobileId].showName == false ) then
		return
	end

	local data = WindowData.MobileName[mobileId]
	local windowName = "OverheadTextWindow_"..mobileId
	
	--If windowName does not exist exit funciton
	if( DoesWindowNameExist( windowName) == false ) then
		return
	end

	if(data and data.MobName ~= nil) then
		OverheadText.ChangelingNameCheck(data, windowName, mobileId)
		if (mobileId ~= WindowData.PlayerStatus.PlayerId and true and not OverheadText.LastSeeName[mobileId]) then -- TODO: "you see" enabled?
			if(NewChatWindow) then
				local passa = NewChatWindow.SavedFilter[data.Notoriety+1]
				if (not NewChatWindow.SavedFilter[9] and MobilesOnScreen.IsFarm(data.MobName)) or wstring.find(data.MobName, L"A Mannequin") then
						passa = false
				end
				if (not NewChatWindow.SavedFilter[10] and MobilesOnScreen.IsSummon(data.MobName)) then
						passa = false
				end
			end
			if (data.MobName ~= nil and data.MobName ~= L"" and data.Notoriety+1 ~= NameColor.Notoriety.NONE and passa) then	
				if (not OverheadText.LastSeeName[mobileId]) then
					PrintWStringToChatWindow(GetStringFromTid(3002000) ..data.MobName,SystemData.ChatLogFilters.SYSTEM)
				end
				OverheadText.LastSeeName[mobileId] = true
			end
			
		end
	
		local labelName = windowName.."Name"
		LabelSetFont(labelName, FontSelector.Fonts[OverheadText.NameFontIndex].fontName, WindowUtils.FONT_DEFAULT_TEXT_LINESPACING)
		
		local x, y = LabelGetTextDimensions(labelName)
		WindowSetScale(windowName, OverheadText.OverhedTextSize)
		WindowSetDimensions(windowName, x, y)
		
		local noto = NameColor.TextColors[data.Notoriety+1]
		if (mobileId == Interface.CurrentHonor) then
			noto = {r=163, g=73, b=164}
			LabelSetTextColor(labelName, noto.r, noto.g, noto.b)
		else
			NameColor.UpdateLabelNameColor(labelName, data.Notoriety+1)
		end
		local name = string.gsub(WStringToString(data.MobName), "^%s*(.-)%s*$", "%1")
		
		if (WindowData.PlayerStatus.PlayerId ~= mobileId and name ~= "" and MobilesOnScreen.IsPet(mobileId) and not MobileHealthBar.HasWindow(mobileId)) then					
			PetWindow.UpdatePet()			
		end		
		
		CreaturesDB.updateSummonTimes()
		local isSumm, name = MobilesOnScreen.IsSummon(data.MobName, mobileId)
		if isSumm then
			if (MobileHealthBar.SummonTimer[mobileId] == nil) then
				
				MobileHealthBar.SummonTimer[mobileId] = Interface.TimeSinceLogin + CreaturesDB.SummonTimes[name]
			end
		elseif not OverheadText.NameParsed[mobileId] then
			
			local props = ItemProperties.GetObjectPropertiesParamsForTid( mobileId, 1153089, "Overhead Text - Check for lifespan summon" )
			if props  then
				time = tonumber(props[1]) * 60
				MobileHealthBar.SummonTimer[mobileId] = Interface.Clock.Timestamp + time
			end
		end

		if (name ~= L"" and name ~= "" and WindowData.PlayerStatus.PlayerId ~= mobileId and not MobilesOnScreen.IsPet(mobileId) and not HealthBarManager.IsPartyMember(mobileId)) then

			local filterVisable = false
			if (( noto == NameColor.Notoriety.NONE or noto == NameColor.Notoriety.CANATTACK or noto == NameColor.Notoriety.CRIMINAL) and DoesWindowNameExist("GreyDockspot") and WindowGetShowing("GreyDockspot")) then	
				filterVisable = true				
			elseif ( noto == NameColor.Notoriety.INNOCENT and DoesWindowNameExist("BlueDockspot") and WindowGetShowing("BlueDockspot")) then
				filterVisable = true
			elseif ( noto == NameColor.Notoriety.FRIEND  and DoesWindowNameExist("GreenDockspot") and WindowGetShowing("GreenDockspot")) then
				filterVisable = true				
			elseif ( noto == NameColor.Notoriety.ENEMY and DoesWindowNameExist("OrangeDockspot") and WindowGetShowing("OrangeDockspot")) then
				filterVisable = true
			elseif ( noto == NameColor.Notoriety.MURDERER and DoesWindowNameExist("RedDockspot") and WindowGetShowing("RedDockspot")) then
				filterVisable = true				
			elseif ( noto == NameColor.Notoriety.INVULNERABLE and DoesWindowNameExist("YellowDockspot") and WindowGetShowing("YellowDockspot")) then
				filterVisable = true
			elseif (noto ~= NameColor.Notoriety.INVULNERABLE and not MobilesOnScreen.Hidden) then				
				filterVisable = true
			end			
			if(filterVisable)then				
				if (MobilesOnScreen.MobilesSortReverse[mobileId] == nil) then					
					table.insert(MobilesOnScreen.MobilesSort, mobileId)
					MobilesOnScreen.MobilesSortReverse[mobileId] = table.getn(MobilesOnScreen.MobilesSort)										
				end														
				MobilesOnScreen.isDirty = true
			end
		end
		OverheadText.NameParsed[mobileId] = true
		OverheadText.UpdateOverheadAnchors(mobileId)
	else
		--Destroy the entire overhead text window if the mobile status is not there anymore.
		--Player probably teleported and we didn't delete the mobiles name.
  		DestroyWindow(windowName)
	end
end

function OverheadText.ChangelingNameCheck(data, windowName, mobileId)
	if not mobileId then
		return
	end
	local sfind = wstring.find
	local labelName = windowName.."Name"
	local name = LabelGetText(labelName) or L""

	if (sfind(name , L"Changeling")) then
		MobileHealthBar.Changelings[mobileId] = true
	elseif (sfind(name , L"Irk")) then
		MobileHealthBar.Irks[mobileId] = true
	elseif (sfind(name , L"Guile")) then
		MobileHealthBar.Guiles[mobileId] = true
	elseif (sfind(name , L"Spite")) then
		MobileHealthBar.Spites[mobileId] = true
	elseif ( sfind(name , L"Travesty")) then
		MobileHealthBar.Travestys[mobileId] = true
	end

	if (MobileHealthBar.Changelings[mobileId]) then
		if (not sfind(data.MobName , L"Changeling")) then
			data.MobName = data.MobName .. L" (Changeling)"
		end
		local name = data.MobName
		if (sfind(wstring.sub(data.MobName,3), L" The ")) then
			name = wstring.gsub(name, L" The ", L"<BR>The ", 1)
		end
		LabelSetText(labelName, L""..name)
	elseif (MobileHealthBar.Irks[mobileId]) then
		if (not sfind(data.MobName , L"Irk")) then
			data.MobName = data.MobName .. L" (Irk)"
		end
		local name = data.MobName
		if (sfind(wstring.sub(data.MobName,3), L" The ")) then
			name = wstring.gsub(name, L" The ", L"<BR>The ", 1)
		end
		LabelSetText(labelName, L""..name)
	elseif (MobileHealthBar.Guiles[mobileId]) then	
		if (not sfind(data.MobName , L"Guile")) then
			data.MobName = data.MobName .. L" (Guile)"
		end
		local name = data.MobName
		if (sfind(wstring.sub(data.MobName,3), L" The ")) then
			name = wstring.gsub(name, L" The ", L"<BR>The ", 1)
		end
		LabelSetText(labelName, L""..name)
	elseif (MobileHealthBar.Spites[mobileId]) then	
		if (not sfind(data.MobName , L"Spite")) then
			data.MobName = data.MobName .. L" (Spite)"
		end
		local name = data.MobName
		if (sfind(wstring.sub(data.MobName,3), L" The ")) then
			name = wstring.gsub(name, L" The ", L"<BR>The ", 1)
		end
		LabelSetText(labelName, L""..name)
	elseif (MobileHealthBar.Travestys[mobileId]) then	
		if (not  sfind(data.MobName , L"Travesty")) then
			data.MobName = data.MobName .. L" (Travesty)"
		end
		
		local name = data.MobName
		if (sfind(wstring.sub(data.MobName,3), L" The ")) then
			name = wstring.gsub(name, L" The ", L"<BR>The ", 1)
		end
		LabelSetText(labelName, L""..name)
	else
		local name = data.MobName
		if (sfind(data.MobName, L" The ")) then
			name =  wstring.gsub(data.MobName, L" The ", L"<BR>The ")			
		end

		LabelSetText(labelName, L""..name)
	end
	
end

function OverheadText.Update( timePassed )
	--timer for overhead msg
	if OverheadText.OverheadAlive ~= 0 then
		for id, data in pairs(OverheadText.ChatData) do
			for index, totalTimePassed in pairs(data.timePassed) do
				if totalTimePassed ~= nil then
					data.timePassed[index] = totalTimePassed + timePassed
					if data.timePassed[index] >= OverheadText.OverheadAlive then
						local windowName = "OverheadTextWindow_"..id
						local overheadChatWindow = windowName.."Chat"..index
						
						WindowSetShowing(overheadChatWindow, false)
						LabelSetText( overheadChatWindow, L"")
						
						data.timePassed[index] = nil
						data.numVisibleChat = data.numVisibleChat - 1
						if (data.numVisibleChat < 0) then
							data.numVisibleChat = 0
						end	
					end
				end
			end
		end
	end

	if (SystemData.Settings.GameOptions.showNames ~= SystemData.Settings.GameOptions.SHOWNAMES_ALL) then
		for i, id in pairs(OverheadText.ActiveIdList) do
			local mobileId = i
			
			if( OverheadText.FadeTimeId[i] ~= nil ) then
				OverheadText.TimePassed[i] = OverheadText.TimePassed[i] + timePassed
				if(OverheadText.TimePassed[i] > OverheadText.FadeStartTime ) then
					local windowName = "OverheadTextWindow_"..i
					OverheadText.FadeTimeId[i] = OverheadText.FadeTimeId[i] - OverheadText.AlphaDiff
					if(OverheadText.FadeTimeId[i] <= 0) then
						--Hide Name Window
						OverheadText.HideName(i)
					else
						local labelName = windowName.."Name"
						WindowSetFontAlpha(labelName, OverheadText.FadeTimeId[i])
						
					end
				end
			end
		end
	end
end

function OverheadText.ShowName(mobileId)
	if (OverheadText.ChatData[mobileId].showName == false) then
		return
	end
	
	OverheadText.FadeTimeId[mobileId] = OverheadText.AlphaStart
	OverheadText.TimePassed[mobileId] = 0
	
	local windowName = "OverheadTextWindow_"..mobileId
	WindowSetShowing(windowName.."Name", true)
	LabelSetFont(windowName.."Name", FontSelector.Fonts[OverheadText.NameFontIndex].fontName, WindowUtils.FONT_DEFAULT_TEXT_LINESPACING)
	WindowSetFontAlpha(windowName.."Name", 1)
	
	OverheadText.UpdateOverheadAnchors(mobileId)
end

function OverheadText.HideName(mobileId)
	OverheadText.FadeTimeId[mobileId] = nil
	OverheadText.TimePassed[mobileId] = nil
	
	local windowName = "OverheadTextWindow_"..mobileId
	WindowSetShowing(windowName.."Name", false)
	
	OverheadText.UpdateOverheadAnchors(mobileId)
end

function OverheadText.UpdateOverheadAnchors(mobileId)
	local windowName = "OverheadTextWindow_"..mobileId
	local overheadNameWindow = windowName.."Name"
	local overheadChat1Window = windowName.."Chat1"
	local overheadChat2Window = windowName.."Chat2"
	local overheadChat3Window = windowName.."Chat3"
	WindowSetHandleInput(overheadNameWindow, true)
	WindowSetScale(windowName, OverheadText.OverhedTextSize)
	
	if(DoesWindowNameExist(windowName) == true) then
		-- NOTE: Player and object names are not displayed, do not anchor chat window to name window.
		if( WindowGetShowing(overheadNameWindow) == true and OverheadText.ChatData[mobileId].showName == true ) then
			WindowClearAnchors(overheadChat1Window)
			WindowAddAnchor(overheadChat1Window, "top", overheadNameWindow, "bottom", 0, -10)
			WindowClearAnchors(overheadChat2Window)
			WindowAddAnchor(overheadChat2Window, "top", overheadChat1Window, "bottom", 0, 0)
			WindowClearAnchors(overheadChat3Window)
			WindowAddAnchor(overheadChat3Window, "top", overheadChat2Window, "bottom", 0, 0)
		else
			WindowClearAnchors(overheadChat1Window)
			WindowAddAnchor(overheadChat1Window, "bottom", windowName, "bottom", 0, 0)
			WindowClearAnchors(overheadChat2Window)
			WindowAddAnchor(overheadChat2Window, "top", overheadChat1Window, "bottom", 0, 0)
			WindowClearAnchors(overheadChat3Window)
			WindowAddAnchor(overheadChat3Window, "top", overheadChat2Window, "bottom", 0, 0)
		end
	end
end

function OverheadText.OnShown()
	local this = SystemData.ActiveWindow.name
	local mobileId = WindowGetId(this)
	local labelName = this.."Name"
	
	-- if names are not being displayed, keep name hidden
	if(SystemData.Settings.GameOptions.showNames == SystemData.Settings.GameOptions.SHOWNAMES_NONE) then
		OverheadText.HideName(mobileId)
		return
	end
	
    -- window was shown so reset the timers and the font alpha	
	OverheadText.FadeTimeId[mobileId] = OverheadText.AlphaStart
	OverheadText.TimePassed[mobileId] = 0

	WindowSetFontAlpha( labelName, OverheadText.AlphaStart)
end

function OverheadText.NameOnLClick()
	local this = SystemData.ActiveWindow.name
	local parent = WindowGetParent(this)
	local mobileId = WindowGetId(parent)
	
	--Let the targeting manager handle single left click on the target
	if(mobileId ~= nil)then
		--If player has a targeting cursor up and they target the overhead name
		--send a event telling the client they selected a target
		if( WindowData.Cursor ~= nil and WindowData.Cursor.target == true ) then
			--Let player select there window as there target
			HandleSingleLeftClkTarget(mobileId)
			return
		end
		
		if( SystemData.DragItem.DragType == SystemData.DragItem.TYPE_NONE and 
			IsMobile(mobileId) ) then
			HealthBarManager.OnBeginDragHealthBar(mobileId)
		end
	end
end

function OverheadText.OnLButtonUp()
	if( SystemData.DragItem.DragType == SystemData.DragItem.TYPE_ITEM ) then
		local this = SystemData.ActiveWindow.name
		local parent = WindowGetParent(this)
		local mobileId = WindowGetId(parent)
	    DragSlotDropObjectToObject(mobileId)
	end
end


function OverheadText.NameOnDblClick()
	local this = SystemData.ActiveWindow.name
	local parent = WindowGetParent(this)
	local mobileId = WindowGetId(parent)
	
	UserActionUseItem(mobileId,false)
end

function OverheadText.NameOnMouseOver()
	local this = SystemData.ActiveWindow.name
	local parent = WindowGetParent(this)
	local mobileId = WindowGetId(parent)
	local itemData =
	{
		windowName = this,
		itemId = mobileId,
		itemType = WindowData.ItemProperties.TYPE_ITEM,
	}					
	ItemProperties.SetActiveItem(itemData)
	OverheadText.mouseOverId = mobileId
end

function OverheadText.NameOnMouseOverEnd()
	ItemProperties.ClearMouseOverItem()
	OverheadText.mouseOverId = 0
end

function OverheadText.ShowOverheadText()
	if SystemData.TextSourceID == -1 then
		return
	end

	if (not OverheadText.GetsOverhead[SystemData.TextChannelID]) then
		return
	end
	
	local senderText = WStringToString(SystemData.Text)
	local find = string.find
	if ( find(senderText , " looks ill.*") 
		or find(senderText , " looks extremely ill. *")
		or find(senderText , " stumbles around in confusion and pain. *")
		or find(senderText , " is wracked with extreme pain. *")
		or find(senderText , " begins to spasm uncontrollably. *")
		or find(senderText , " seems resistant to the poison *")
		or senderText == "* The poison seems to have no effect. *"
		) and not Interface.noPoisonOthers then
		return
	end
	
	local spell = SpellsInfo.SpellsData[WStringToString(SystemData.Text)]
	local IsSpell = spell ~= nil
	if (IsSpell and Interface.DisableSpells) then
		SystemData.Text = L""
		return
	end
	
	if (IsSpell and Interface.ShowSpellName ) then
		SystemData.Text = SystemData.Text .. L" [" .. StringToWString(spell.name) .. L"]"
	end
	
	local windowName = "OverheadTextWindow_"..SystemData.TextSourceID	
	local overheadChatWindow = windowName.."Chat1"
	
	if OverheadText.ChatData[SystemData.TextSourceID] == nil then
	    if( DoesWindowNameExist(windowName) == false ) then
			-- Cases where this would hit are for either the player or non-mobile object
			SystemData.DynamicWindowId = SystemData.TextSourceID
			CreateWindowFromTemplate(windowName, "OverheadTextWindow", "Root")
			AttachWindowToWorldObject( SystemData.TextSourceID, windowName )
			WindowSetScale(windowName, OverheadText.OverhedTextSize)
			OverheadText.ChatData[SystemData.TextSourceID].showName = false
			OverheadText.HideName(SystemData.TextSourceID)
		end
	end
	
	-- if there are other chats move them all up one
	if( OverheadText.ChatData[SystemData.TextSourceID].numVisibleChat > 0 ) then
		for i=OverheadText.ChatData[SystemData.TextSourceID].numVisibleChat+1, 2, -1 do 
			if( i <= 3 ) then
				local oldWindow = windowName.."Chat"..(i-1)
				local newWindow = windowName.."Chat"..i
				
				local text = LabelGetText(oldWindow)
				if (fontName == FontSelector.Fonts[OverheadText.SpellsFontIndex].fontName) then
					LabelSetFont(newWindow, FontSelector.Fonts[OverheadText.SpellsFontIndex].fontName, WindowUtils.FONT_DEFAULT_TEXT_LINESPACING)
				else
					LabelSetFont(newWindow, FontSelector.Fonts[OverheadText.FontIndex].fontName, WindowUtils.FONT_DEFAULT_TEXT_LINESPACING)
				end
				local r,g,b = LabelGetTextColor(oldWindow)
				LabelSetText(newWindow,text)
				LabelSetTextColor(newWindow,r,g,b)
				WindowSetShowing(newWindow,true)
				WindowSetScale(newWindow, OverheadText.OverhedTextSize)
				WindowSetScale(oldWindow, OverheadText.OverhedTextSize)
				OverheadText.ChatData[SystemData.TextSourceID].timePassed[i] = OverheadText.ChatData[SystemData.TextSourceID].timePassed[i-1]
			end
		end
	end
	if( OverheadText.ChatData[SystemData.TextSourceID].numVisibleChat < 3 ) then
		OverheadText.ChatData[SystemData.TextSourceID].numVisibleChat = OverheadText.ChatData[SystemData.TextSourceID].numVisibleChat + 1
	end
		
	OverheadText.ChatData[SystemData.TextSourceID].timePassed[1] = 0

	local default = ChatSettings.ChannelColors[SystemData.TextChannelID]
	local color = {r= default.r, g=default.g, b=default.b}

	if (type(SystemData.TextColor) == "table") then
		color.r = SystemData.TextColor.r
		color.g  = SystemData.TextColor.g
		color.b  = SystemData.TextColor.b
	elseif (SystemData.TextColor ~= 0) then
		color.r,color.g,color.b = HueRGBAValue(SystemData.TextColor)
	end
	
	if (IsSpell) then
		LabelSetFont(overheadChatWindow, FontSelector.Fonts[OverheadText.SpellsFontIndex].fontName, WindowUtils.FONT_DEFAULT_TEXT_LINESPACING)
	else
		LabelSetFont(overheadChatWindow, FontSelector.Fonts[OverheadText.FontIndex].fontName, WindowUtils.FONT_DEFAULT_TEXT_LINESPACING)
	end
	
	LabelSetTextColor( overheadChatWindow, color.r, color.g, color.b)
	LabelSetText( overheadChatWindow, SystemData.Text)
	
	if( WindowGetShowing(overheadChatWindow) == false ) then
		OverheadText.UpdateOverheadAnchors(SystemData.TextSourceID)
		WindowSetShowing(overheadChatWindow, true)
	end
end

function OverheadText.OnOverheadChatShutdown()
    local windowName = SystemData.ActiveWindow.name
    local id = WindowGetId(windowName)
    
    OverheadText.ChatData[id] = nil
end