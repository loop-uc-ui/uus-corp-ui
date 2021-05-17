SettingsProfanityWindow = {}

SettingsProfanityWindow.ignoreListType = IGNORE_LIST_ALL

local PreviousIgnoreListCount = 0
local CurIgnoreListIdx = -1
local IGNORE_LIST_ALL = 0
local checkBox = "IgnoreListOptionButton"
local mainAdapter = ViewAdapter:new("SettingsWindow", "SettingsProfanityWindow")
local listAdapters = { }

local function overrideSettings()
    SystemData.Settings.Profanity.BadWordFilter = false
    WindowData.IgnoreConfListCount = 0
    SystemData.Settings.Profanity.IgnoreConfListFilter = false
end

local function PopulateProfanityList()
    -- clear ignore list
    for i = 1, PreviousIgnoreListCount do
        if next(listAdapters) ~= nil then
            listAdapters[i]:destroy()
        end
    end

    listAdapters = {}

    for i = 1, WindowData.IgnoreListCount do
        listAdapters[i] = ViewAdapter:new("IgnoreListItem"..i)
        listAdapters[i]:addTemplate(
                "SettingsBadWordFilter",
                "IgnoreListItem",
                "Label",
                L"- "..WindowData.IgnoreNameList[i]
        )

        if (i == 1) then
            listAdapters[i]:addAnchor("bottomleft", "IgnoreListDeleteButton", "topleft", 0, 10)
        else
            listAdapters[i]:addAnchor("bottomleft", "IgnoreListItem"..(i - 1), "topleft", 0, 0)
        end
    end
    PreviousIgnoreListCount = WindowData.IgnoreListCount
    mainAdapter:updateScrollRect(mainAdapter.title)
end

function SettingsProfanityWindow.Initialize()
    WindowRegisterEventHandler( "Root", SystemData.Events.PROFANITYLIST_UPDATED, "SettingsProfanityWindow.ProfanityListUpdated" )
    overrideSettings()
    mainAdapter:addLabel("SettingsBadWordFilterFilterSubSectionLabel", 3000173)
               :addLabel("IgnoreListOptionLabel", 3000462)
               :addCheckBox(checkBox, true)
               :addButton("IgnoreListAddButton", 1155473)
               :addButton("IgnoreListChatListButton", 1155474)
               :addButton("IgnoreListDeleteButton", 1155475)
    PopulateProfanityList()
end

function SettingsProfanityWindow.UpdateSettings()
    mainAdapter.views[checkBox]:setChecked(SystemData.Settings.Profanity.IgnoreListFilter)
end

function SettingsProfanityWindow.OnApplyButton()
    mainAdapter.views[checkBox]:isChecked(SystemData.Settings.Profanity.IgnoreListFilter)
end

function SettingsProfanityWindow.ProfanityListUpdated()
    mainAdapter:setShowing(true)
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
        listAdapters[i].views["IgnoreListItem"..i]:setTextColor(255, 255, 255)
        if (SystemData.ActiveWindow.name == "IgnoreListItem"..i) then
            CurIgnoreListIdx = i
            break
        end
    end
    listAdapters[CurIgnoreListIdx].views["IgnoreListItem"..CurIgnoreListIdx]:setTextColor(250, 250, 0)
end