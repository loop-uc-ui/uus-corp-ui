----------------------------------------------------------------
-- Global Variables
----------------------------------------------------------------

IgnoreWindow = {}

----------------------------------------------------------------
-- Local Variables
----------------------------------------------------------------

IgnoreWindow.currentSelection = -1

IgnoreWindow.TID = {
	Title = 1114787,
	Add = 1114788,
	Cancel = 1006045
}

----------------------------------------------------------------
-- Functions
----------------------------------------------------------------

function IgnoreWindow.Initialize()
	Interface.DestroyWindowOnClose["IgnoreWindow"] = true
	
	WindowUtils.SetWindowTitle("IgnoreWindow", GetStringFromTid(IgnoreWindow.TID.Title))
	
	ButtonSetText( "IgnoreWindowAddButton", GetStringFromTid(IgnoreWindow.TID.Add) )
	ButtonSetText( "IgnoreWindowCancelButton", GetStringFromTid(IgnoreWindow.TID.Cancel) )
	
	local previousChannelButton
	local currentChannelButton

	for i = 1, WindowData.RecentChatPlayerListCount do
		currentChannelButton = "recentchatplayer_"..WindowData.RecentChatPlayerIdList[i]
		
		CreateWindowFromTemplate(currentChannelButton, "PlayerListIgnoreButtonTemplate", "PlayerListIgnoreChildWindow")
		ButtonSetText(currentChannelButton, L"<"..WindowData.RecentChatPlayerIdList[i]..L"> "..WindowData.RecentChatPlayerNameList[i])
		WindowSetId(currentChannelButton, WindowData.RecentChatPlayerIdList[i])
		ButtonSetPressedFlag(currentChannelButton, false)
		
		if (previousChannelButton == nil) then
			WindowAddAnchor(currentChannelButton, "topleft", "PlayerListIgnoreChildWindow", "topleft", 10, 5)
			ButtonSetPressedFlag(currentChannelButton, true)
			IgnoreWindow.currentSelection = WindowData.RecentChatPlayerIdList[i]
		else
			WindowAddAnchor(currentChannelButton, "bottomleft", previousChannelButton, "topleft", 0, 0)
		end
		previousChannelButton = currentChannelButton
	end
end

function IgnoreWindow.SelectPlayer()
	local previousSelection = IgnoreWindow.currentSelection

	IgnoreWindow.currentSelection = WindowGetId(SystemData.ActiveWindow.name)
	
	if(previousSelection and previousSelection ~= -1) then
		ButtonSetPressedFlag("recentchatplayer_"..tostring(previousSelection), false)
	end
	ButtonSetPressedFlag("recentchatplayer_"..tostring(IgnoreWindow.currentSelection), true)
	ScrollWindowUpdateScrollRect("PlayerListIgnoreWindow")
end

function IgnoreWindow.Add_OnLButtonUp()
	if(IgnoreWindow.currentSelection == -1) then
		DestroyWindow("IgnoreWindow")
		return
	end
	
	local windowName = "recentchatplayer_"..tostring(IgnoreWindow.currentSelection)
	
	local rawNameText = ButtonGetText(windowName)
	local nameSearchPos = wstring.find(rawNameText, L">")
	local nameString = wstring.sub(rawNameText, nameSearchPos+1)
	
	AddPlayerToIgnoreList(WindowGetId(windowName), nameString, SettingsProfanityWindow.ignoreListType)
	
	DestroyWindow("IgnoreWindow")
end

function IgnoreWindow.Cancel_OnLButtonUp()
	DestroyWindow("IgnoreWindow")
end