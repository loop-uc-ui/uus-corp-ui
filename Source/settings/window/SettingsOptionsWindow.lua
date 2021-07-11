SettingsOptionsWindow = ListWindow:new(SettingsWindow.WINDOWS.Options)

local COMBO_BOXES = {
    Languages = "SettingsOptionsLanguageCombo",
    CustomSkins = "CustomSkinsCombo",
    HandleFilters = "SettingsOptionsObjHandleFilterCombo"
}

local CHECK_BOXES = {
    EnglishNames = "SettingsOptionsEnglishNamesButton",
    AlwaysRun = "AlwaysRunButton",
    AutoRun = "EnableAutorunButton",
    PathFinding = "EnablePathfindingButton",
    AlwaysAttack = "AlwaysAttackButton",
    QueryBeforeCriminalAction = "QueryBeforeCriminalActionsButton",
    ShiftToUnstack = "HoldShiftToUnstackButton",
    ShiftRightClickContextMenu = "ShiftRightClickContextMenusButton",
    TargetQueueing = "TargetQueueingButton",
    BlockWarOnPets = "BlockWarOnPetsButton",
    BlockWarOnParty = "BlockWarOnPartyButton",
    BlockWarOnGuild = "BlockWarOnGuildButton",
    ToggleWarShield = "ToggleWarShieldButton",
    AutoIgnoreCorpses = "AutoIgnoreCorpsesButton",
    ToolTips = "TooltipsButton",
    PartyInvitePopUp = "PartyInvitePopUpButton",
    ToggleWindowSnap = "ToggleWindowSnapButton",
    EnableChatLog = "EnableChatLogButton"
}

local SLIDERS = {
    UiScale = {
        Bar = "UiScaleSliderBar",
        Label = "UiScaleVal"
    },
    GenericGumpScale = {
        Bar = "GenericGumpScaleSliderBar",
        Label = "GenericGumpScaleVal"
    },
    CacheSize = {
        Bar = "SettingsOptionsCacheSizeSliderBar",
        Label = "SettingsOptionsCacheSizeVal"
    }
}

local function overrideDefaults()
    UserOptionsSettings.ignoreMouseActionsOnSelf(false)
end

function SettingsOptionsWindow.Initialize()
    local uiMods = {} do
        for i = 1, #UserOptionsSettings.CustomUI do
            local text = UserOptionsSettings.CustomUI[i]
            if text == "" then
                text = 3000094
            end
            uiMods[i] = text
        end
    end
    overrideDefaults()
    SettingsOptionsWindow.adapter:addLabel("SettingsOptionsGameOptionsSubSectionLabel", 1094695)
            :addLabel("SettingsOptionsInterfaceSubSectionLabel", 3000395)
            :addLabel("SettingsOptionsSystemSubSectionLabel", 1078905)
            :addLabel("SettingsOptionsLanguageLabel", 1077824)
            :addComboBox(COMBO_BOXES.Languages, {
                1077459, --English
                1077460, --Japanese
                1078516, --Chinese
                1156035 --Korean
            })
            :addLabel("SettingsOptionsEnglishNamesLabel", 1115913)
            :addCheckBox(CHECK_BOXES.EnglishNames)
            :addLabel("SettingsOptionsCacheSizeText", 1079480)
            :addLabel("AlwaysRunLabel", 1078078)
            :addCheckBox(CHECK_BOXES.AlwaysRun)
            :addLabel("EnableAutorunLabel", 1115321)
            :addCheckBox(CHECK_BOXES.AutoRun)
            :addLabel("EnablePathfindingLabel", 1115324)
            :addCheckBox(CHECK_BOXES.PathFinding)
            :addLabel("AlwaysAttackLabel", 1078858)
            :addCheckBox(CHECK_BOXES.AlwaysAttack)
            :addLabel("QueryBeforeCriminalActionsLabel", 1078080)
            :addCheckBox(CHECK_BOXES.QueryBeforeCriminalAction)
            :addLabel("HoldShiftToUnstackLabel", 1112076)
            :addCheckBox(CHECK_BOXES.ShiftToUnstack)
            :addLabel("ShiftRightClickContextMenusLabel", 1115355)
            :addCheckBox(CHECK_BOXES.ShiftRightClickContextMenu)
            :addLabel("TargetQueueingLabel", 1115337)
            :addCheckBox(CHECK_BOXES.TargetQueueing)
            :addLabel("BlockWarOnPetsLabel", 1155300)
            :addCheckBox(CHECK_BOXES.BlockWarOnPets)
            :addLabel("BlockWarOnPartyLabel", 1155302)
            :addCheckBox(CHECK_BOXES.BlockWarOnParty)
            :addLabel("BlockWarOnGuildLabel", 1155304)
            :addCheckBox(CHECK_BOXES.BlockWarOnGuild)
            :addLabel("ToggleWarShieldLabel", 1155367)
            :addCheckBox(CHECK_BOXES.ToggleWarShield)
            :addLabel("AutoIgnoreCorpsesLabel", 1156263)
            :addCheckBox(CHECK_BOXES.AutoIgnoreCorpses)
            :addLabel("UiScaleText", 1079205)
            :addLabel("GenericGumpScaleText", 1158011)
            :addLabel("TooltipsLabel", 1115211)
            :addCheckBox(CHECK_BOXES.ToolTips)
            :addLabel("PartyInvitePopUpLabel", 1115367)
            :addCheckBox(CHECK_BOXES.PartyInvitePopUp)
            :addLabel("ToggleWindowSnapLabel", 1155296)
            :addCheckBox(CHECK_BOXES.ToggleWindowSnap)
            :addButton("ResetUILocButton", 1153107)
            :addLabel("EnableChatLogLabel", 1149998)
            :addCheckBox(CHECK_BOXES.EnableChatLog)
            :addLabel("CustomSkinsLabel", 1079523)
            :addComboBox(COMBO_BOXES.CustomSkins, uiMods)
            :addLabel("SettingsOptionsObjHandleFilterLabel", 1079461)
            :addComboBox(COMBO_BOXES.HandleFilters, {
                    UserOptionsSettings.ObjectHandleFilters[1].text,
                    UserOptionsSettings.ObjectHandleFilters[2].text,
                    UserOptionsSettings.ObjectHandleFilters[3].text,
                    UserOptionsSettings.ObjectHandleFilters[4].text,
                    UserOptionsSettings.ObjectHandleFilters[5].text,
                    UserOptionsSettings.ObjectHandleFilters[6].text,
                    UserOptionsSettings.ObjectHandleFilters[7].text,
                }
            )
            :addSlider(SLIDERS.CacheSize.Bar)
            :addSlider(SLIDERS.UiScale.Bar)
            :addSlider(SLIDERS.GenericGumpScale.Bar)

    SettingsOptionsWindow:setOffset(0):updateScrollRect()

    --TODO add support for this
    -- Toggle Cartographer
    --[[
    LabelSetText( "ToggleCartographer" .. "Label", L"Enable UO Mapper")-- GetStringFromTid( SettingsWindow.TID.ToggleCartographer ) )
    WindowSetId( "ToggleCartographer" .. "Label", SettingsWindow.DetailTID.ToggleCartographer )
    ButtonSetCheckButtonFlag( "ToggleCartographer" .. "Button", true )
    WindowSetShowing("ToggleCartographer", false)
    --]]
end

function SettingsOptionsWindow.UpdateSettings()
    for i = 1, #UserOptionsSettings.Languages do
        local language = UserOptionsSettings.Languages[i]
        if UserOptionsSettings.language() == language then
            SettingsOptionsWindow.adapter.views[COMBO_BOXES.Languages]:setSelectedItem(i)
            break
        end
    end

    SettingsOptionsWindow.adapter.views[CHECK_BOXES.EnglishNames]:setChecked(UserOptionsSettings.useEnglishNames())
    SettingsOptionsWindow.adapter:addLabel(SLIDERS.CacheSize.Label,  L""..math.floor(UserOptionsSettings.cacheSize()))
    SettingsOptionsWindow.adapter.views[SLIDERS.CacheSize.Bar]:setPosition(UserOptionsSettings.cacheSize() / 1024)

    for i = 1, #UserOptionsSettings.ObjectHandleFilters do
        local filter = UserOptionsSettings.ObjectHandleFilters[i].id
        if UserOptionsSettings.objectHandleFilter() == filter then
            SettingsOptionsWindow.adapter.views[COMBO_BOXES.HandleFilters]:setSelectedItem(i)
            break
        end
    end

    for i = 1, #UserOptionsSettings.CustomUI do
        if UserOptionsSettings.customUI() == UserOptionsSettings.CustomUI[i] then
            SettingsOptionsWindow.adapter.views[COMBO_BOXES.CustomSkins]:setSelectedItem(i)
            break
        end
    end

    SettingsOptionsWindow.adapter.views[SLIDERS.UiScale.Bar]:setPosition((UserOptionsSettings.uiScale() - 0.5) * 2)
    SettingsOptionsWindow.adapter:addLabel(SLIDERS.UiScale.Label, wstring.format( L"%2.2f", UserOptionsSettings.uiScale()))
    SettingsOptionsWindow.adapter.views[SLIDERS.GenericGumpScale.Bar]:setPosition(((UserOptionsSettings.genericGumpScale() / 1.2) - 0.885) / 0.115)
    SettingsOptionsWindow.adapter:addLabel(SLIDERS.GenericGumpScale.Label, wstring.format( L"%2.2f", UserOptionsSettings.genericGumpScale()))

    SettingsOptionsWindow.adapter.views[CHECK_BOXES.AlwaysAttack]:setChecked(UserOptionsSettings.alwaysAttack())
    SettingsOptionsWindow.adapter.views[CHECK_BOXES.AutoRun]:setChecked(UserOptionsSettings.autoRun())
    SettingsOptionsWindow.adapter.views[CHECK_BOXES.PathFinding]:setChecked(UserOptionsSettings.pathfinding())
    SettingsOptionsWindow.adapter.views[CHECK_BOXES.QueryBeforeCriminalAction]:setChecked(UserOptionsSettings.queryBeforeCriminalAction())
    SettingsOptionsWindow.adapter.views[CHECK_BOXES.ShiftToUnstack]:setChecked(UserOptionsSettings.holdShiftToUnstack())
    SettingsOptionsWindow.adapter.views[CHECK_BOXES.ShiftRightClickContextMenu]:setChecked(UserOptionsSettings.shiftRightClickContextMenus())
    SettingsOptionsWindow.adapter.views[CHECK_BOXES.TargetQueueing]:setChecked(UserOptionsSettings.targetQueueing())
    SettingsOptionsWindow.adapter.views[CHECK_BOXES.AlwaysRun]:setChecked(UserOptionsSettings.alwaysRun())
    SettingsOptionsWindow.adapter.views[CHECK_BOXES.ToolTips]:setChecked(UserOptionsSettings.showTooltips())
    SettingsOptionsWindow.adapter.views[CHECK_BOXES.PartyInvitePopUp]:setChecked(UserOptionsSettings.partyInvitePopUp())
    SettingsOptionsWindow.adapter.views[CHECK_BOXES.EnableChatLog]:setChecked(UserOptionsSettings.enableChatLog())
    SettingsOptionsWindow.adapter.views[CHECK_BOXES.ToggleWindowSnap]:setChecked(UserOptionsSettings.enableSnapping())
    SettingsOptionsWindow.adapter.views[CHECK_BOXES.BlockWarOnPets]:setChecked(UserOptionsSettings.blockWarOnPets())
    SettingsOptionsWindow.adapter.views[CHECK_BOXES.BlockWarOnParty]:setChecked(UserOptionsSettings.blockWarOnParty())
    SettingsOptionsWindow.adapter.views[CHECK_BOXES.BlockWarOnGuild]:setChecked(UserOptionsSettings.blockWarOnFriendly())
    SettingsOptionsWindow.adapter.views[CHECK_BOXES.ToggleWarShield]:setChecked(UserOptionsSettings.showWarShield())
    SettingsOptionsWindow.adapter.views[CHECK_BOXES.AutoIgnoreCorpses]:setChecked(UserOptionsSettings.autoIgnoreCorpses())
    SettingsOptionsWindow.adapter.views[CHECK_BOXES.ToggleWindowSnap]:setChecked(UserOptionsSettings.enableSnapping())
end

function SettingsOptionsWindow.OnApplyButton()
    local index = SettingsOptionsWindow.adapter.views[COMBO_BOXES.Languages]:getSelectedItem()
    UserOptionsSettings.language(UserOptionsSettings.Languages[index])
    index = SettingsOptionsWindow.adapter.views[COMBO_BOXES.HandleFilters]:getSelectedItem()
    UserOptionsSettings.objectHandleFilter(UserOptionsSettings.ObjectHandleFilters[index].id)
    index = SettingsOptionsWindow.adapter.views[COMBO_BOXES.CustomSkins]:getSelectedItem()
    UserOptionsSettings.customUI(UserOptionsSettings.CustomUI[index])

    UserOptionsSettings.useEnglishNames(SettingsOptionsWindow.adapter.views[CHECK_BOXES.EnglishNames]:isChecked())
    UserOptionsSettings.alwaysRun(SettingsOptionsWindow.adapter.views[CHECK_BOXES.AlwaysRun]:isChecked())
    UserOptionsSettings.autoRun(SettingsOptionsWindow.adapter.views[CHECK_BOXES.AutoRun]:isChecked())
    UserOptionsSettings.pathfinding(SettingsOptionsWindow.adapter.views[CHECK_BOXES.PathFinding]:isChecked())
    UserOptionsSettings.queryBeforeCriminalAction(SettingsOptionsWindow.adapter.views[CHECK_BOXES.QueryBeforeCriminalAction]:isChecked())
    UserOptionsSettings.holdShiftToUnstack(SettingsOptionsWindow.adapter.views[CHECK_BOXES.ShiftToUnstack]:isChecked())
    UserOptionsSettings.shiftRightClickContextMenus(SettingsOptionsWindow.adapter.views[CHECK_BOXES.ShiftRightClickContextMenu]:isChecked())
    UserOptionsSettings.targetQueueing(SettingsOptionsWindow.adapter.views[CHECK_BOXES.TargetQueueing]:isChecked())
    UserOptionsSettings.alwaysAttack(SettingsOptionsWindow.adapter.views[CHECK_BOXES.AlwaysAttack]:isChecked())
    UserOptionsSettings.showTooltips(SettingsOptionsWindow.adapter.views[CHECK_BOXES.ToolTips]:isChecked())
    UserOptionsSettings.partyInvitePopUp(SettingsOptionsWindow.adapter.views[CHECK_BOXES.PartyInvitePopUp]:isChecked())
    UserOptionsSettings.enableChatLog(SettingsOptionsWindow.adapter.views[CHECK_BOXES.EnableChatLog]:isChecked())
    UserOptionsSettings.blockWarOnPets(SettingsOptionsWindow.adapter.views[CHECK_BOXES.BlockWarOnPets]:isChecked())
    UserOptionsSettings.blockWarOnParty(SettingsOptionsWindow.adapter.views[CHECK_BOXES.BlockWarOnParty]:isChecked())
    UserOptionsSettings.blockWarOnFriendly(SettingsOptionsWindow.adapter.views[CHECK_BOXES.BlockWarOnGuild]:isChecked())
    UserOptionsSettings.showWarShield(SettingsOptionsWindow.adapter.views[CHECK_BOXES.ToggleWarShield]:isChecked())
    UserOptionsSettings.autoIgnoreCorpses(SettingsOptionsWindow.adapter.views[CHECK_BOXES.AutoIgnoreCorpses]:isChecked())
    UserOptionsSettings.enableSnapping(SettingsOptionsWindow.adapter.views[CHECK_BOXES.ToggleWindowSnap]:isChecked())

    UserOptionsSettings.uiScale(SettingsOptionsWindow.adapter.views[SLIDERS.UiScale.Bar]:getPosition() / 2 + 0.5)
    UserOptionsSettings.genericGumpScale(((SettingsOptionsWindow.adapter.views[SLIDERS.GenericGumpScale.Bar]:getPosition() * 0.115) + 0.885) * 1.2)
    UserOptionsSettings.cacheSize(SettingsOptionsWindow.adapter.views[SLIDERS.CacheSize.Bar]:getPosition() * 1024)

    WindowSetShowing("WarShield",UserOptionsSettings.showWarShield())
end

--TODO move this when we've refactored everything
function SettingsOptionsWindow.UpdateSliderSettings(_)
    -- update ui scale
    local barName = string.gsub(SystemData.ActiveWindow.name, "SliderBar", "")
    local bar = SystemData.ActiveWindow.name

    if (barName == "UiScale") then
        local uiScale =( SliderBarGetCurrentPosition( "UiScaleSliderBar" )/2 )+ 0.5
        LabelSetText( "UiScaleVal", wstring.format( L"%2.2f", uiScale ) )
        return
    end

    if (barName == "GenericGumpScale") then
        local genericGumpScale = ( ((SliderBarGetCurrentPosition("GenericGumpScaleSliderBar") * 0.115) + 0.885) * 1.2)
        genericGumpScale = tonumber(string.format("%2.2f", genericGumpScale))
        LabelSetText( "GenericGumpScaleVal", L""..genericGumpScale)
        return
    end

    if (barName == "SettingsOptionsCacheSize") then
        -- update the cache size value
        local cacheSize = math.floor( SliderBarGetCurrentPosition( "SettingsOptionsCacheSizeSliderBar" ) * 1024 )
        LabelSetText( "SettingsOptionsCacheSizeVal", L""..cacheSize )
        return
    end
    if (barName == "BaseAlpha") then
        barVal = SliderBarGetCurrentPosition(bar )
        barVal = tonumber(string.format("%.2f", barVal))
        LabelSetText(barName .. "Val", L"" .. barVal)
        if (barVal < 0.01) then
            barVal = 0.01
            SliderBarSetCurrentPosition(barName .. "SliderBar", barVal )

            LabelSetText(barName .. "Val", L"" .. barVal)
        end
    elseif (barName == "FadeDelay") then
        barVal =  tonumber(string.format("%.0f", SliderBarGetCurrentPosition(bar ) * 20))
        LabelSetText(barName .. "Val", L"" .. barVal)
        if (barVal < 1) then
            barVal = 1
            SliderBarSetCurrentPosition(barName .. "SliderBar", barVal / 20 )
            LabelSetText(barName .. "Val", L"" .. barVal)
        end
    elseif (barName == "MinTotDamage") then
        barVal =  tonumber(string.format("%.0f", SliderBarGetCurrentPosition(bar ) * 1000))
        LabelSetText(barName .. "Val", L"" .. barVal)
        if (barVal < 1) then
            barVal = 1
            SliderBarSetCurrentPosition(barName .. "SliderBar", barVal / 1000 )
            LabelSetText(barName .. "Val", L"" .. barVal)
        end
    end
end

function SettingsOptionsWindow.OnResetUILocButton()
    WindowUtils.ForceResetWindowPositions()
end