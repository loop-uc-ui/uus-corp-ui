SettingsProfanityWindow = {}

local PreviousIgnoreListCount = 0
local CurIgnoreListIdx = -1
local IGNORE_LIST_ALL = 0

SettingsProfanityWindow.ignoreListType = IGNORE_LIST_ALL

local function overrideSettings()
    SystemData.Settings.Profanity.BadWordFilter = false
end

local function PopulateProfanityList()
    -- clear ignore list
    for i = 1, PreviousIgnoreListCount do
        --Debug.PrintToDebugConsole( L"destroy IgnoreListItem"..i )
        --Debug.PrintToDebugConsole( LabelGetText( "IgnoreListItem"..i ) )
        DestroyWindow( "IgnoreListItem"..i)
    end

    -- list all player in the ignore list
    local first = true
    local previousListItem = ""

    for i = 1, WindowData.IgnoreListCount do
        --Debug.PrintToDebugConsole( L"create IgnoreListItem"..i )
        --Debug.PrintToDebugConsole( L""..WindowData.IgnoreIdList[i]..L" "..WindowData.IgnoreNameList[i] )
        CreateWindowFromTemplate( "IgnoreListItem"..i, "IgnoreListItem", "SettingsBadWordFilter" )

        WindowSetShowing( "IgnoreListItem"..i, true )
        LabelSetText( "IgnoreListItem"..i, L"- "..WindowData.IgnoreNameList[i] )
        if( first )then
            first = false
            WindowAddAnchor( "IgnoreListItem"..i, "bottomleft", "IgnoreListDeleteButton", "topleft", 0, 10 )
        else
            WindowAddAnchor( "IgnoreListItem"..i, "bottomleft", previousListItem, "topleft", 0, 0 )
        end

        previousListItem = "IgnoreListItem"..i
    end
    PreviousIgnoreListCount = WindowData.IgnoreListCount
    ScrollWindowUpdateScrollRect( "SettingsProfanityWindow" )
end

function SettingsProfanityWindow.Initialize()
    WindowRegisterEventHandler( "Root", SystemData.Events.PROFANITYLIST_UPDATED, "SettingsProfanityWindow.ProfanityListUpdated" )
    overrideSettings()
    LabelSetText( "SettingsBadWordFilterFilterSubSectionLabel", GetStringFromTid( 3000173 ) )
    LabelSetText( "IgnoreListOptionLabel", GetStringFromTid( 3000462 ) )
    WindowSetId( "IgnoreListOptionLabel",1115316 )
    ButtonSetStayDownFlag( "IgnoreListOptionButton", true )
    ButtonSetCheckButtonFlag( "IgnoreListOptionButton", true )
    ButtonSetText( "IgnoreListAddButton", GetStringFromTid(1155473) )
    ButtonSetText( "IgnoreListChatListButton", GetStringFromTid(1155474) )
    ButtonSetText( "IgnoreListDeleteButton", GetStringFromTid(1155475) )
    PopulateProfanityList()
end

function SettingsProfanityWindow.UpdateSettings()
    ButtonSetPressedFlag( "IgnoreListOptionButton", SystemData.Settings.Profanity.IgnoreListFilter )
end

function SettingsProfanityWindow.OnApplyButton()
    SystemData.Settings.Profanity.IgnoreListFilter = ButtonGetPressedFlag( "IgnoreListOptionButton" )
end

function SettingsProfanityWindow.ProfanityListUpdated()
    --the player has picked something, show the main menu and settings window
    --	WindowSetShowing( "MainMenuWindow", true )
    WindowSetShowing( "SettingsWindow", true )
    PopulateProfanityList()
end

function SettingsProfanityWindow.OnIgnoreListDeleteButton()
    if CurIgnoreListIdx == -1 then
        return
    end

    local idx = CurIgnoreListIdx
    --Debug.PrintToDebugConsole( L"current idx "..idx )
    local id = WindowData.IgnoreIdList[idx]
    --Debug.PrintToDebugConsole( L"id at idx "..id )
    DeleteFromIgnoreList( id, IGNORE_LIST_ALL )
    CurIgnoreListIdx = -1
    PopulateProfanityList()
end

function SettingsProfanityWindow.OnIgnoreListChatListButton()
    SettingsProfanityWindow.ignoreListType = IGNORE_LIST_ALL
    CreateWindow("IgnoreWindow", true)
end

function SettingsProfanityWindow.OnIgnoreListAddButton()
    StartIgnoreListAdd(IGNORE_LIST_ALL)
    --hide the settings window and main menu window so player can pick something on screen
    WindowSetShowing( "SettingsWindow", false )
    WindowSetShowing( "MainMenuWindow", false )
end

function SettingsProfanityWindow.OnIgnoreListItemClicked()
    for i = 1, WindowData.IgnoreListCount do
        LabelSetTextColor( "IgnoreListItem"..i, 255, 255, 255 )
        if( SystemData.ActiveWindow.name == "IgnoreListItem"..i )then
            CurIgnoreListIdx = i
        end
    end
    LabelSetTextColor( SystemData.ActiveWindow.name, 250, 250, 0 )
end