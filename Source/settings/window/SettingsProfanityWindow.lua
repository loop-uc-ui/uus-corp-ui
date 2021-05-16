SettingsProfanityWindow = {}

local PreviousIgnoreListCount = 0
local CurIgnoreListIdx = -1
local IGNORE_LIST_ALL = 0
local checkBox = "IgnoreListOptionButton"

SettingsProfanityWindow.ignoreListType = IGNORE_LIST_ALL

local adapter = ViewAdapter:new("SettingsWindow", "SettingsProfanityWindow")

local function overrideSettings()
    SystemData.Settings.Profanity.BadWordFilter = false
end

local function PopulateProfanityList()
    -- clear ignore list
    for i = 1, PreviousIgnoreListCount do
        DestroyWindow( "IgnoreListItem"..i)
    end

    -- list all player in the ignore list
    local first = true
    local previousListItem = ""

    for i = 1, WindowData.IgnoreListCount do
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
    adapter:updateScrollRect(adapter.title)
end

function SettingsProfanityWindow.Initialize()
    WindowRegisterEventHandler( "Root", SystemData.Events.PROFANITYLIST_UPDATED, "SettingsProfanityWindow.ProfanityListUpdated" )
    overrideSettings()
    adapter:addLabel("SettingsBadWordFilterFilterSubSectionLabel", 3000173)
            :addLabel("IgnoreListOptionLabel", 3000462)
            :addCheckBox(checkBox, true)
            :addButton("IgnoreListAddButton", 1155473)
            :addButton("IgnoreListChatListButton", 1155474)
            :addButton("IgnoreListDeleteButton", 1155475)
    PopulateProfanityList()
end

function SettingsProfanityWindow.UpdateSettings()
    adapter.views[checkBox]:setChecked(SystemData.Settings.Profanity.IgnoreListFilter)
end

function SettingsProfanityWindow.OnApplyButton()
    adapter.views[checkBox]:isChecked(SystemData.Settings.Profanity.IgnoreListFilter)
end

function SettingsProfanityWindow.ProfanityListUpdated()
    WindowSetShowing( "SettingsWindow", true )
    PopulateProfanityList()
end

function SettingsProfanityWindow.OnIgnoreListDeleteButton()
    if CurIgnoreListIdx == -1 then
        return
    end

    local idx = CurIgnoreListIdx
    local id = WindowData.IgnoreIdList[idx]

    DeleteFromIgnoreList(id, IGNORE_LIST_ALL)
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
    WindowSetShowing("SettingsWindow", false)
    WindowSetShowing("MainMenuWindow", false)
end

function SettingsProfanityWindow.OnIgnoreListItemClicked()
    for i = 1, WindowData.IgnoreListCount do
        LabelSetTextColor( "IgnoreListItem"..i, 255, 255, 255)
        if (SystemData.ActiveWindow.name == "IgnoreListItem"..i) then
            CurIgnoreListIdx = i
            break
        end
    end
    LabelSetTextColor( SystemData.ActiveWindow.name, 250, 250, 0 )
end