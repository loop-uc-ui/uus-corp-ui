SettingsProfanityWindow = {}

local PreviousIgnoreListCount = 0
local CurIgnoreListIdx = -1
local PreviousIgnoreConfListCount = 0
local CurIgnoreConfListIdx = -1
local IGNORE_LIST_ALL = 0
local IGNORE_LIST_CONF	= 1

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

    -- clear conf ignore list
    for i = 1, PreviousIgnoreConfListCount do
        --Debug.PrintToDebugConsole( L"destroy IgnoreConfListItem"..i )
        --Debug.PrintToDebugConsole( LabelGetText( "IgnoreConfListItem"..i ) )
        DestroyWindow( "IgnoreConfListItem"..i)
    end

    -- list all player in the ignore list
    first = true
    previousListItem = ""
    for i = 1, WindowData.IgnoreConfListCount do
        --Debug.PrintToDebugConsole( L"create IgnoreConfListItem"..i )
        --Debug.PrintToDebugConsole( L""..WindowData.IgnoreConfIdList[i]..L" "..WindowData.IgnoreConfNameList[i] )
        CreateWindowFromTemplate( "IgnoreConfListItem"..i, "IgnoreConfListItem", "SettingsBadWordFilter" )

        WindowSetShowing( "IgnoreConfListItem"..i, true )
        LabelSetText( "IgnoreConfListItem"..i, L"- "..WindowData.IgnoreConfNameList[i] )
        if( first )then
            first = false
            WindowAddAnchor( "IgnoreConfListItem"..i, "bottomleft", "IgnoreConfListDeleteButton", "topleft", 0, 10 )
        else
            WindowAddAnchor( "IgnoreConfListItem"..i, "bottomleft", previousListItem, "topleft", 0, 0 )
        end

        previousListItem = "IgnoreConfListItem"..i
    end
    PreviousIgnoreConfListCount = WindowData.IgnoreConfListCount

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
    LabelSetText( "IgnoreConfListOptionLabel", GetStringFromTid(  1151906 ) )
    WindowSetId( "IgnoreConfListOptionLabel", 1151906)
    ButtonSetStayDownFlag( "IgnoreConfListOptionButton", true )
    ButtonSetCheckButtonFlag( "IgnoreConfListOptionButton", true )
    ButtonSetText( "IgnoreConfListAddButton", GetStringFromTid(1155473) )
    ButtonSetText( "IgnoreConfListChatListButton", GetStringFromTid(1155474) )
    ButtonSetText( "IgnoreConfListDeleteButton", GetStringFromTid(1155475) )
    PopulateProfanityList()
end

function SettingsProfanityWindow.UpdateSettings()
    ButtonSetPressedFlag( "IgnoreListOptionButton", SystemData.Settings.Profanity.IgnoreListFilter )
    ButtonSetPressedFlag( "IgnoreConfListOptionButton", SystemData.Settings.Profanity.IgnoreConfListFilter )
end

function SettingsProfanityWindow.OnApplyButton()
    SystemData.Settings.Profanity.IgnoreListFilter = ButtonGetPressedFlag( "IgnoreListOptionButton" )
    SystemData.Settings.Profanity.IgnoreConfListFilter = ButtonGetPressedFlag( "IgnoreConfListOptionButton" )
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

function SettingsProfanityWindow.OnIgnoreConfListDeleteButton()
    if CurIgnoreConfListIdx == -1 then
        return
    end

    local idx = CurIgnoreConfListIdx
    --Debug.PrintToDebugConsole( L"conf current idx "..idx )
    local id = WindowData.IgnoreConfIdList[idx]
    --Debug.PrintToDebugConsole( L"conf id at idx "..id )
    DeleteFromIgnoreList( id, IGNORE_LIST_CONF )
    CurIgnoreConfListIdx = -1
    PopulateProfanityList()
end

function SettingsProfanityWindow.OnIgnoreListChatListButton()
    SettingsProfanityWindow.ignoreListType = IGNORE_LIST_ALL
    CreateWindow("IgnoreWindow", true)
end

function SettingsProfanityWindow.OnIgnoreConfListChatListButton()
    SettingsProfanityWindow.ignoreListType = IGNORE_LIST_CONF
    CreateWindow("IgnoreWindow", true)
end

function SettingsProfanityWindow.OnIgnoreListAddButton()
    StartIgnoreListAdd(IGNORE_LIST_ALL)
    --hide the settings window and main menu window so player can pick something on screen
    WindowSetShowing( "SettingsWindow", false )
    WindowSetShowing( "MainMenuWindow", false )
end

function SettingsProfanityWindow.OnIgnoreConfListAddButton()
    StartIgnoreListAdd(IGNORE_LIST_CONF)
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

function SettingsProfanityWindow.OnIgnoreConfListItemClicked()
    for i = 1, WindowData.IgnoreConfListCount do
        LabelSetTextColor( "IgnoreConfListItem"..i, 255, 255, 255 )
        if( SystemData.ActiveWindow.name == "IgnoreConfListItem"..i )then
            CurIgnoreConfListIdx = i
        end
    end
    LabelSetTextColor( SystemData.ActiveWindow.name, 250, 250, 0 )
end