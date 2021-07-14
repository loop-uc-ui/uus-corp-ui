SkillsWindow = { }

TID_SKILLS = 3000084
TID_SKILLINCREASE_TOK = 3000260 --"Your skill in ~1skillname~ has increased by ~2changeamount~.  It is now ~3newvalue~."
TID_SKILLDECREASE_TOK = 3000261 --"Your skill in ~1skillname~ has decreased by ~2changeamount~.  It is now ~3newvalue~."

-- Contents and order for each page. The numbers are the skills
-- as assigned in /Runtime/GameData/skilldata.csv
local tab1 = { 7,  22, 28, 53 }
local tab2 = { 2, 5, 18, 21, 23, 31, 40, 50, 51, 58, 54 }
local tab3 = { 1, 6, 8, 11, 12, 14, 20, 27, 30, 35, 52, 55 }
local tab4 = { 9, 13, 17, 32, 33, 34, 38, 39, 46, 47, 37, 26 }
local tab5 = { 3, 4, 10, 19, 24, 56, 57 }
local tab6 = { 15, 25, 29, 42, 44, 45, 48, 49 }
local tab7 = { 16, 36, 41, 43 }
local tabContents = { tab1, tab2, tab3, tab4, tab5, tab6, tab7 }
local maxskill_index = 57

SkillsWindow.NUM_SKILLS_PER_TAB = 12

SkillsWindow.SessionGains = {}

-- don't attempt to draw the window when we are first registering for skill data
local updateOff = 0

-- boolean to make sure we have initialized the window 
local SkillsWindowInitialized = 0

-- this gets set equal to WindowData.SkillsWindow[id] 
local data = 0

-- SkillDataMode 0 = real skill value, 1 = skill with mods
SkillsWindow.SkillDataMode = 0

local oldSkillValues = {}
local hasSkillValues = false

SkillsWindow.Delta = 0

SkillsWindow.SkillTargetVals = {}

function SkillsWindow.Initialize()
	if SkillsWindowInitialized == 1 then
		return
	end
	UOBuildTableFromCSV ("data/gamedata/skilldata.csv","SkillsCSV")
	local this = "SkillsWindow"
    SkillsWindow.SkillDataMode = (SystemData.Settings.Interface.SkillsWindowShowModified and 1 or 0)
	
	local id = SystemData.DynamicWindowId
	WindowSetId(this, id)
	if (WindowData.SkillsWindow ~= nil) then
		data = WindowData.SkillsWindow[id]
	end
	updateOff = 1
	for i = 0, maxskill_index do
		RegisterWindowData(WindowData.SkillDynamicData.Type, i)
	end
	updateOff = 0
	
	RegisterWindowData(WindowData.SkillList.Type,0)
	WindowRegisterEventHandler( this, WindowData.SkillDynamicData.Event, "SkillsWindow.UpdateSkill")
	WindowUtils.SetActiveDialogTitle(GetStringFromTid(TID_SKILLS))
	ButtonSetText( "SkillsWindowTabButton1", GetStringFromTid(1078117) )  -- "Misc"
	ButtonSetText( "SkillsWindowTabButton2", GetStringFromTid(1077760) ) -- "Combat"
	ButtonSetText( "SkillsWindowTabButton3", GetStringFromTid(1077761) ) -- "Trade"
	ButtonSetText( "SkillsWindowTabButton4", GetStringFromTid(1077762) ) -- "Magic"
	ButtonSetText( "SkillsWindowTabButton5", GetStringFromTid(1077763) ) -- "Wild"
	ButtonSetText( "SkillsWindowTabButton6", GetStringFromTid(1078116) ) -- "Thief"
	ButtonSetText( "SkillsWindowTabButton7", GetStringFromTid(1077765) ) -- "Bard"
	ButtonSetText( "SkillsWindowSkillsLock", GetStringFromTid(1154796))
	ButtonSetText( "SkillsWindowSkillsDown", GetStringFromTid(1154797))

	data = {}
	data.activeTab = 1
	data.numTabs = table.getn(tabContents)
	SkillsWindowInitialized = 1
	
	local WindowName = "SkillsWindow"
	local showing = WindowGetShowing(WindowName)
	if (showing) then
		SkillsWindow.ShowTab(data.activeTab)
	end
	SkillsWindow.UpdateSkillValueTypeToggleButtonText()
	SkillsWindow.UpdateTotalSkillPoints()
	WindowUtils.RestoreWindowPosition("SkillsWindow")
	hasSkillValues = false
	for i = 1, 58 do
		SkillsWindow.SkillTargetVals[i] = Interface.LoadNumber("SkillTargetVals_"..i, nil)
	end
end


function SkillsWindow.UpdateTotalSkillPoints()
	local TotalPoints = 720
	local SkillPointsUsed = 0
	for i = 0, maxskill_index do
		SkillPointsUsed = SkillPointsUsed + WindowData.SkillDynamicData[i].RealSkillValue
	end
	SkillPointsUsed = SkillPointsUsed / 10
	local SkillPointsUsedStr = string.format("%.0f", SkillPointsUsed) -- truncate off any decimal places
	LabelSetText("SkillsWindowTotalSkillPoints", GetStringFromTid(1077767)..StringToWString(SkillPointsUsedStr)..L"/"..StringToWString(tostring(TotalPoints))) -- "Skill Points Used: "
end

function SkillsWindow.DoNothing()
end

function SkillsWindow.ToggleSkillsWindow()
	if SkillsWindowInitialized == 0 then
		Debug.PrintToDebugConsole(L"SkillsWindow.ToggleSkillsWindow: window not initialized, returning")
		return
	end
	ToggleWindowByName( "SkillsWindow", "", SkillsWindow.DoNothing, SkillsWindow.DoNothing, SkillsWindow.DoNothing )
	local WindowName = "SkillsWindow"
	local showing = WindowGetShowing(WindowName)
	if (showing) then
		SkillsWindow.UpdateAllSkills()
	end
end

function SkillsWindow.OnUpdate(timepassed)
	SkillsWindow.Delta = SkillsWindow.Delta + timepassed
	if SkillsWindow.Delta >= 1 then
		SkillsWindow.ShowTab(SkillsWindow.CurrentTab)
		SkillsWindow.Delta = 0
	end
end

function SkillsWindow.EnableAllTabs(parent)
	for i = 1, data.numTabs do
		local tabName = parent.."TabButton"..i
		WindowSetShowing(tabName.."Tab", true)
		ButtonSetDisabledFlag(tabName, false)
	end
end

function SkillsWindow.DisableTab(parent, tabNum)
	local tabName = parent.."TabButton"..tostring(tabNum)
	WindowSetShowing(tabName.."TabSelected", true)
	ButtonSetDisabledFlag(tabName, true);
end
	
function SkillsWindow.UpdateAllSkills()
	SkillsWindow.CheckAllSkillsForUpdate()
	SkillsWindow.SaveCurrentSkillValues()

	if updateOff == 1 then
		return
	end
	
	local WindowName = "SkillsWindow"
	local showing = WindowGetShowing(WindowName)
	if showing then
		SkillsWindow.ShowTab(data.activeTab)
		SkillsWindow.UpdateTotalSkillPoints()
	end
end

function SkillsWindow.UpdateSkill()
	local skillId = WindowData.UpdateInstanceId
	if SkillsWindow.CheckSkillForUpdate(skillId) then
		SkillsWindow.SaveCurrentSkillValue(skillId)
		if updateOff == 1 then
			return
		end
		
		local WindowName = "SkillsWindow"
		local showing = WindowGetShowing(WindowName)
		if showing then
			SkillsWindow.ShowTab(data.activeTab)
			SkillsWindow.UpdateTotalSkillPoints()
		end
	end
end

function SkillsWindow.ForceActiveTabSetting(tabnum)
	data.activeTab = tabnum
end

function SkillsWindow.ShowTab(tabnum)
	local WindowName = "SkillsWindow"
	local showing = WindowGetShowing(WindowName)
	if showing then
		doNothing = 0
	else
		do return end
	end
	
	local this = "SkillsWindow"
	if tabnum == nil then
		tabnum = 1
		SkillsWindow.ForceActiveTabSetting(tabnum)
	end

	SkillsWindow.EnableAllTabs(this)
	SkillsWindow.DisableTab(this, tabnum)

	for i = 1, data.numTabs do
		local tabWindowName = "SkillsWindowTabWindow"..tostring(i)
		WindowSetShowing(tabWindowName, false)
	end

	if data.activeTab ~= tabnum then
		data.activeTab = tabnum
		SkillsWindow.CurrentTab = data.activeTab
	end

	local tabWindowName = "SkillsWindowTabWindow"..tostring(tabnum)
	WindowSetShowing(tabWindowName, true)

	local activeContents = tabContents[tabnum]
	local numItemsInTab = table.getn(activeContents)

	for i = 1, SkillsWindow.NUM_SKILLS_PER_TAB do
		local base = "SkillsWindowTabWindow"..tostring(tabnum).."Entry"..tostring(i)

		if i <= numItemsInTab then
			local skillId = activeContents[i]
			local serverId = WindowData.SkillsCSV[skillId].ServerId
			local iconPath = base .. "IconGraphic"
			local namePath = base .. "Name"
			local titlePath = base .. "Title"
			local valuePath = base .. "Value"			
			local buttonPath = base .. "SkillStateButton"
			local iconId = WindowData.SkillsCSV[skillId].IconId
			local iconTexture, x, y = GetIconData(iconId)
			local displayName = GetStringFromTid(WindowData.SkillsCSV[skillId].NameTid)	
			
			local skillLevel
			if (SkillsWindow.SkillDataMode == 0) then
				skillLevel = WindowData.SkillDynamicData[serverId].RealSkillValue
			else
				skillLevel = WindowData.SkillDynamicData[serverId].TempSkillValue
			end

			local skillLevelCap = WindowData.SkillDynamicData[serverId].SkillCap
			if (SkillsWindow.SkillTargetVals[skillId]) then
				skillLevelCap = SkillsWindow.SkillTargetVals[skillId]
			end

			local skillState = WindowData.SkillDynamicData[serverId].SkillState
			DynamicImageSetTexture(iconPath, iconTexture, x, y)
			DynamicImageSetTexture(iconPath.."BG", MiniTexturePack.DB[MiniTexturePack.Current].texture .. "Icon", 0, 0 )
			local titleString = SkillsWindow.GetSkillTitle (WindowData.SkillDynamicData[serverId].RealSkillValue)

			LabelSetText(namePath, displayName)
			LabelSetText(titlePath, titleString)

			-- Clean up the number so it works as a percentage
			local skillFormatted = SkillsWindow.FormatSkillValue(skillLevel)
			local capFormatted = SkillsWindow.FormatSkillValue(skillLevelCap)
			if skillLevel ~= nil then
				LabelSetText(valuePath, skillFormatted..L"/"..capFormatted..L"%")
			else
				-- This shouldn't happen unless it misregisters the skills
				LabelSetText(valuePath, L"---.-/---.-%")
			end
			WindowSetId(base.."Icon", i)
			WindowSetId(buttonPath, i)
			SkillsWindow.SetStateButton(buttonPath, skillState)
			WindowSetShowing(base, true)
		else
			WindowSetShowing(base, false)
		end
	end
end

function SkillsWindow.Shutdown()
	for i = 0, maxskill_index do
		UnregisterWindowData(WindowData.SkillDynamicData.Type, i)
	end
	UnregisterWindowData(WindowData.SkillList.Type,0)
	WindowUtils.SaveWindowPosition("SkillsWindow")
	UOUnloadCSVTable("SkillsCSV")
end

function SkillsWindow.SkillLButtonDown(flags)
    if( SystemData.DragItem.DragType == SystemData.DragItem.TYPE_NONE ) then
	    local buttonNum = WindowGetId( SystemData.ActiveWindow.name)
	    local tab = data.activeTab
	    local activeContent = tabContents[tab]
    	
	    -- skillIndex is the line index in the csv file for this skill
	    local skillIndex = activeContent[buttonNum]
	    local skillId = WindowData.SkillsCSV[skillIndex].ServerId
	    local iconId = WindowData.SkillsCSV[skillIndex].IconId

		if (WindowData.SkillsCSV[skillIndex].DragIcon == 1) then
			if( skillId ~= nil ) then
				if flags == SystemData.ButtonFlags.CONTROL then -- SINGLE HOTBAR ICON
					local blockBar = HotbarSystem.GetNextHotbarId()
					Interface.SaveBoolean("Hotbar" .. blockBar .. "_IsBlockbar", true)
					HotbarSystem.SpawnNewHotbar()

					HotbarSystem.SetActionOnHotbar(SystemData.UserAction.TYPE_SKILL, skillId,iconId, blockBar,  1)

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

				else
					DragSlotSetActionMouseClickData(SystemData.UserAction.TYPE_SKILL,skillId,iconId)
				end
			end
		end
	end       
end

-- OnLButtonUP Handler
function SkillsWindow.SkillsLockLButtonUp()
	if (not SkillsWindow.LockAll and not SkillsWindow.DownAll) then
		SkillsWindow.CurrentIndex = 1
		SkillsWindow.LockAll = true
	end
end
function SkillsWindow.SkillsDownLButtonUp()
	if (not SkillsWindow.LockAll and not SkillsWindow.DownAll) then
		SkillsWindow.CurrentIndex = 1
		SkillsWindow.DownAll = true
	end
end

function SkillsWindow.LockSkills()
	if(SkillsWindow.LockAll) then
		if (SkillsWindow.CurrentIndex > 0 and SkillsWindow.CurrentIndex < 59) then
			local serverId = WindowData.SkillsCSV[SkillsWindow.CurrentIndex].ServerId
			WindowData.SkillDynamicData[serverId].SkillState = 2
			ReturnWindowData.SkillSystem.SkillId = serverId
			ReturnWindowData.SkillSystem.SkillButtonState = 2
			BroadcastEvent(SystemData.Events.SKILLS_ACTION_SKILL_STATE_CHANGE)
			SkillsWindow.CurrentIndex = SkillsWindow.CurrentIndex  + 1
		else
			SkillsWindow.CurrentIndex = -1
			SkillsWindow.LockAll = false
			SkillsWindow.ShowTab(SkillsWindow.CurrentTab)
		end
	end
end

function SkillsWindow.DownSkills()
	if(SkillsWindow.DownAll) then
		if (SkillsWindow.CurrentIndex > 0 and SkillsWindow.CurrentIndex < 59) then
			local serverId = WindowData.SkillsCSV[SkillsWindow.CurrentIndex].ServerId
			WindowData.SkillDynamicData[serverId].SkillState = 1
			ReturnWindowData.SkillSystem.SkillId = serverId
			ReturnWindowData.SkillSystem.SkillButtonState = 1
			BroadcastEvent(SystemData.Events.SKILLS_ACTION_SKILL_STATE_CHANGE)
			SkillsWindow.CurrentIndex = SkillsWindow.CurrentIndex  + 1
		else
			SkillsWindow.CurrentIndex = -1
			SkillsWindow.DownAll = false
			SkillsWindow.ShowTab(SkillsWindow.CurrentTab)
		end
	end
end

function SkillsWindow.SkillLButtonUp()
	local buttonNum = WindowGetId( SystemData.ActiveWindow.name)
	local tab = data.activeTab
	local activeContent = tabContents[tab]
	local skillIndex = activeContent[buttonNum]
	local skillId = WindowData.SkillsCSV[skillIndex].ServerId
	if (WindowData.SkillsCSV[skillIndex].DragIcon == 1) then
		SkillsWindow.UseSkill (skillId)
	else
	    PrintTidToChatWindow(500014,SystemData.ChatLogFilters.SYSTEM)
	end		
end

function SkillsWindow.UseSkill (skillId)
	UserActionUseSkill(skillId)
end

function SkillsWindow.ToggleTab()
	tab_clicked = tonumber (string.sub( SystemData.ActiveWindow.name, -1, -1))
	SkillsWindow.ShowTab(tab_clicked)
	currentTab = tab_clicked  
end

function SkillsWindow.SetStateButton(button, val)
	if val == 0 then
	    WindowSetDimensions(button, 22, 22)
		ButtonSetTexture(button, InterfaceCore.ButtonStates.STATE_NORMAL, "arrowup", 0, 0)
		ButtonSetTexture(button, InterfaceCore.ButtonStates.STATE_PRESSED, "arrowup", 0, 0)		
		ButtonSetTexture(button, InterfaceCore.ButtonStates.STATE_PRESSED_HIGHLITE, "arrowup", 24, 0)
		ButtonSetTexture(button, InterfaceCore.ButtonStates.STATE_NORMAL_HIGHLITE, "arrowup", 24, 0)		
	elseif val == 1 then
	    WindowSetDimensions(button, 22, 22)
		ButtonSetTexture(button, InterfaceCore.ButtonStates.STATE_NORMAL, "arrowdown", 0, 0)		
		ButtonSetTexture(button, InterfaceCore.ButtonStates.STATE_PRESSED, "arrowdown", 0, 0)
		ButtonSetTexture(button, InterfaceCore.ButtonStates.STATE_NORMAL_HIGHLITE, "arrowdown", 24 , 0)
		ButtonSetTexture(button, InterfaceCore.ButtonStates.STATE_PRESSED_HIGHLITE, "arrowdown", 24 , 0)
	elseif val == 2 then
	    WindowSetDimensions(button, 22, 22)
		ButtonSetTexture(button, InterfaceCore.ButtonStates.STATE_NORMAL, "Lock_Button", 0, 0)
		ButtonSetTexture(button,InterfaceCore.ButtonStates.STATE_PRESSED, "Lock_Button", 0, 0)
		ButtonSetTexture(button, InterfaceCore.ButtonStates.STATE_NORMAL_HIGHLITE, "Lock_Button", 24, 0)
		ButtonSetTexture(button, InterfaceCore.ButtonStates.STATE_PRESSED_HIGHLITE, "Lock_Button", 24, 0)
	end
end

function SkillsWindow.CycleLButtonUp()
	local tab = data.activeTab
	local buttonNum = WindowGetId(SystemData.ActiveWindow.name)
	local activeContent = tabContents[tab]
	local skillId = activeContent[buttonNum]
	
	local state = WindowData.SkillDynamicData[WindowData.SkillsCSV[skillId].ServerId].SkillState
	state = state + 1

	if state > 2 then
		state = 0
	end

	WindowData.SkillDynamicData[WindowData.SkillsCSV[skillId].ServerId].SkillState = state
	local buttonPath = "SkillsWindowTabWindow"..tostring(tab).."Entry"..tostring(buttonNum).."SkillStateButton"
	SkillsWindow.SetStateButton(buttonPath, state)
	ReturnWindowData.SkillSystem.SkillId = WindowData.SkillsCSV[skillId].ServerId
	ReturnWindowData.SkillSystem.SkillButtonState = state
	BroadcastEvent (SystemData.Events.SKILLS_ACTION_SKILL_STATE_CHANGE)
end

function SkillsWindow.FormatSkillValue(skillLevel)
	local whole = tostring(skillLevel)
	local lastDigit = towstring(string.sub(whole, -1, -1))
	whole = towstring(string.sub(whole, 0, string.len(whole) - 1))
	if whole == L"" then 
		whole = L"0"
	end
	local output = whole..L"."..lastDigit
	return output
end

function SkillsWindow.GetSkillTitle (skillLevel)
	local titleString = L""
	local level = skillLevel/100
	
	if (level > 2) then
		if ((level >= 3) and (level < 4)) then
			titleString = L"("..GetStringFromTid(1077474)..L")" -- "Neophyte"
		elseif ((level >= 4) and (level < 5)) then
			titleString = L"("..GetStringFromTid(1077475)..L")"-- "Novice"
		elseif ((level >= 5) and (level < 6)) then
			titleString = L"("..GetStringFromTid(1077476)..L")" -- "Apprentice"
		elseif ((level >= 6) and (level < 7)) then
			titleString = L"("..GetStringFromTid(1077477)..L")"  -- "Journeyman"
		elseif ((level >= 7) and (level < 8)) then
			titleString = L"("..GetStringFromTid(1077478)..L")" -- "Expert"
		elseif ((level >= 8) and (level < 9)) then
			titleString = L"("..GetStringFromTid(1077479)..L")" -- "Adept"
		elseif ((level >= 9) and (level < 10)) then
			titleString = L"("..GetStringFromTid(1077480)..L")"  -- "Master"
		elseif (level >= 10) and (level < 11)  then
			titleString = L"("..GetStringFromTid(1079309)..L")" -- "Grandmaster"
		elseif (level >= 11) and (level < 12)  then
			titleString = L"("..GetStringFromTid(1079272)..L")" -- "Elder"
		elseif (level >= 12)   then
			titleString = L"("..GetStringFromTid(1079273)..L")" -- "Legendary"
		end		
	end
	return titleString
end

function SkillsWindow.SkillValueTypeToggleLButtonUp()
	if (SkillsWindow.SkillDataMode == 0) then
		SkillsWindow.SkillDataMode = 1
	else
		SkillsWindow.SkillDataMode = 0
	end
    SystemData.Settings.Interface.SkillsWindowShowModified = (SkillsWindow.SkillDataMode == 1)
	SkillsWindow.UpdateSkillValueTypeToggleButtonText()	
	SkillsWindow.ShowTab(data.activeTab)
end

function SkillsWindow.UpdateSkillValueTypeToggleButtonText()
	if (SkillsWindow.SkillDataMode == 0) then
		ButtonSetText( "SkillsWindowSkillValueTypeToggleButton", GetStringFromTid(1077768) ) -- "Show Modified"
	else
		ButtonSetText( "SkillsWindowSkillValueTypeToggleButton", GetStringFromTid(1077769) ) -- "Show Real"
	end
end

function SkillsWindow.CheckSkillForUpdate(skill)
	if oldSkillValues[skill] ~= nil and WindowData.SkillDynamicData[skill] ~= nil then
		local newSkillValue = WindowData.SkillDynamicData[skill].RealSkillValue
		local skillId = WindowData.SkillList[skill].CSVId
		if not SkillsWindow.SessionGains[skill] then
			SkillsWindow.SessionGains[skill] = 0
		end
		if (SkillsWindow.SkillTargetVals[skillId]) then
			if (newSkillValue > SkillsWindow.SkillTargetVals[skillId] and WindowData.SkillDynamicData[WindowData.SkillsCSV[skillId].ServerId].SkillState ~= 1) then
				WindowData.SkillDynamicData[WindowData.SkillsCSV[skillId].ServerId].SkillState = 1
				ReturnWindowData.SkillSystem.SkillId = WindowData.SkillsCSV[skillId].ServerId
				ReturnWindowData.SkillSystem.SkillButtonState = 2
				BroadcastEvent(SystemData.Events.SKILLS_ACTION_SKILL_STATE_CHANGE)
			end
			
			if (newSkillValue == SkillsWindow.SkillTargetVals[skillId] and WindowData.SkillDynamicData[WindowData.SkillsCSV[skillId].ServerId].SkillState ~= 2) then
				WindowData.SkillDynamicData[WindowData.SkillsCSV[skillId].ServerId].SkillState = 2
				ReturnWindowData.SkillSystem.SkillId = WindowData.SkillsCSV[skillId].ServerId
				ReturnWindowData.SkillSystem.SkillButtonState = 2
				BroadcastEvent(SystemData.Events.SKILLS_ACTION_SKILL_STATE_CHANGE)
			end
			SkillsWindow.ShowTab(data.activeTab)
		end

		local oldSkillValue = oldSkillValues[skill]
		newSkillValue = WindowData.SkillDynamicData[skill].RealSkillValue
		if oldSkillValue > newSkillValue then
			local skillValueDiff = SkillsWindow.FormatSkillValue(oldSkillValue - newSkillValue)..L"%"
			local skillName = WindowData.SkillList[skill].skillName
			local text = ReplaceTokens(GetStringFromTid(TID_SKILLDECREASE_TOK), {skillName, skillValueDiff, SkillsWindow.FormatSkillValue(newSkillValue)..L"%"})
			if (Interface.UseNewChat) then
				local logVal = {text = text, channel = SystemData.ChatLogFilters.SYSTEM, color = TextParsing.SpecialColor, sourceId = 0, sourceName = "", ignore = false, category = 0, timeStamp = StringToWString(string.format("%02.f", Interface.Clock.h) .. ":" .. string.format("%02.f", Interface.Clock.m) .. ":" .. string.format("%02.f", Interface.Clock.s))}
				table.insert(NewChatWindow.Messages, logVal)
				NewChatWindow.UpdateLog()
			else
				PrintWStringToChatWindow(text,SystemData.ChatLogFilters.SYSTEM)
			end
			return 1
		end

		if oldSkillValue < newSkillValue then
			local skillValueDiff = SkillsWindow.FormatSkillValue(newSkillValue - oldSkillValue)..L"%"
			local skillName = WindowData.SkillList[skill].skillName
			local text = ReplaceTokens(GetStringFromTid(TID_SKILLINCREASE_TOK), {skillName, skillValueDiff, SkillsWindow.FormatSkillValue(newSkillValue)..L"%"})
			
			if (Interface.UseNewChat) then
				local logVal = {text = text, channel = SystemData.ChatLogFilters.SYSTEM, color = TextParsing.SpecialColor, sourceId = 0, sourceName = "", ignore = false, category = 0, timeStamp = StringToWString(string.format("%02.f", Interface.Clock.h) .. ":" .. string.format("%02.f", Interface.Clock.m) .. ":" .. string.format("%02.f", Interface.Clock.s))}
				table.insert(NewChatWindow.Messages, logVal)
				NewChatWindow.UpdateLog()
			else
				PrintWStringToChatWindow(text,SystemData.ChatLogFilters.SYSTEM)
			end
			return 1
		end
	else
		SkillsWindow.SaveCurrentSkillValue(skill)
	end
	return 0
end

function SkillsWindow.CheckAllSkillsForUpdate()
	if hasSkillValues then
		for _, tab in ipairs(tabContents) do
			for _, skill in ipairs(tab) do
				SkillsWindow.CheckSkillForUpdate(WindowData.SkillsCSV[skill].ServerId)
			end
		end
	end
end

function SkillsWindow.SaveCurrentSkillValue(skill)
	oldSkillValues[skill] = WindowData.SkillDynamicData[skill].RealSkillValue
end

function SkillsWindow.SaveCurrentSkillValues()
	hasSkillValues = true
	for _, tab in ipairs(tabContents) do
		for _, skill in ipairs(tab) do
			SkillsWindow.SaveCurrentSkillValue(WindowData.SkillsCSV[skill].ServerId)
		end
	end
end
