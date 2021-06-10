SettingsProfanityWindow = ListWindow:new(SettingsWindow.WINDOWS.Filters)

local badWordFilter = ListWindow:new("SettingsBadWordFilter")

local PreviousIgnoreListCount = 0

local CurIgnoreListIdx = -1

local IGNORE_LIST_ALL = 0

local checkBox = "IgnoreListOptionButton"

SettingsProfanityWindow.ignoreListType = IGNORE_LIST_ALL

local function overrideSettings()
    SystemData.Settings.Profanity.BadWordFilter = false
    WindowData.IgnoreConfListCount = 0
    SystemData.Settings.Profanity.IgnoreConfListFilter = false
end

local function PopulateProfanityList()
    -- clear ignore list
    for i = 1, PreviousIgnoreListCount do
        if next(badWordFilter.adapter.views) ~= nil then
            badWordFilter.adapter.views["IgnoreListItem"..i]:destroy()
        end
    end

    badWordFilter.adapter.views = {}

    for i = 1, WindowData.IgnoreListCount do
        badWordFilter.adapter:addTemplate(
                "IgnoreListItem"..i,
                "IgnoreListItem",
                "Label",
                L"- "..WindowData.IgnoreNameList[i]
        )
        WindowSetShowing("IgnoreListItem"..i, true)

        if (i == 1) then
            badWordFilter.adapter.views["IgnoreListItem"..i]:addAnchor("bottomleft", "IgnoreListDeleteButton", "topleft", 0, 10)
        else
            badWordFilter.adapter.views["IgnoreListItem"..i]:addAnchor("bottomleft", "IgnoreListItem"..(i - 1), "topleft", 0, 0)
        end
    end
    PreviousIgnoreListCount = WindowData.IgnoreListCount
    SettingsProfanityWindow:updateScrollRect()
end

function SettingsProfanityWindow.Initialize()
    WindowRegisterEventHandler( "Root", SystemData.Events.PROFANITYLIST_UPDATED, "SettingsProfanityWindow.ProfanityListUpdated" )
    overrideSettings()
    SettingsProfanityWindow.adapter:addLabel("SettingsBadWordFilterFilterSubSectionLabel", 3000173)
               :addLabel("IgnoreListOptionLabel", 3000462)
               :addCheckBox(checkBox, true)
               :addButton("IgnoreListAddButton", 1155473)
               :addButton("IgnoreListChatListButton", 1155474)
               :addButton("IgnoreListDeleteButton", 1155475)
    PopulateProfanityList()
end

function SettingsProfanityWindow.UpdateSettings()
    SettingsProfanityWindow.adapter.views[checkBox]:setChecked(SystemData.Settings.Profanity.IgnoreListFilter)
end

function SettingsProfanityWindow.OnApplyButton()
    SettingsProfanityWindow.adapter.views[checkBox]:isChecked(SystemData.Settings.Profanity.IgnoreListFilter)
end

function SettingsProfanityWindow.ProfanityListUpdated()
    SettingsWindow:setShowing(true)
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
        badWordFilter.adapter.views["IgnoreListItem"..i]:setTextColor({
            r = 255,
            g = 255,
            b = 255
        })
        if (SystemData.ActiveWindow.name == "IgnoreListItem"..i) then
            CurIgnoreListIdx = i
            break
        end
    end
    badWordFilter.adapter.views["IgnoreListItem"..CurIgnoreListIdx]:setTextColor({
        r = 250,
        g = 250,
        b = 0
    })
end