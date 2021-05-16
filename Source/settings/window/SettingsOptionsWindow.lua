SettingsOptionsWindow = {}

local Languages = {}
Languages[1] = {tid = 1077459, id = SystemData.Settings.Language.LANGUAGE_ENU}
Languages[2] = {tid = 1077460, id = SystemData.Settings.Language.LANGUAGE_JPN}
Languages[3] = {tid = 1078516, id = SystemData.Settings.Language.LANGUAGE_CHINESE_TRADITIONAL}
Languages[4] = {tid = 1156035, id = SystemData.Settings.Language.LANGUAGE_KOR}
local NUM_LANGUAGES = 4

local ObjectHandles = {}
ObjectHandles[1] = { id = SystemData.Settings.ObjectHandleFilter.eDynamicFilter, tid = 1079457}
ObjectHandles[2] = { id = SystemData.Settings.ObjectHandleFilter.eCorpseFilter, tid = 1078368}
ObjectHandles[3] = { id = SystemData.Settings.ObjectHandleFilter.eNPCFilter, tid = 1079458}
ObjectHandles[4] = { id = SystemData.Settings.ObjectHandleFilter.eNPCVendorFilter, tid = 1079459}
ObjectHandles[5] = { id = SystemData.Settings.ObjectHandleFilter.eMobileFilter, tid = 1075672}
ObjectHandles[6] = { id = SystemData.Settings.ObjectHandleFilter.eItemsOnlyFilter, tid=1154804}
ObjectHandles[7] = { id = SystemData.Settings.ObjectHandleFilter.eLostItemsOnlyFilter, tid=1154805}

local NUM_OBJHANDLE_FILTERS = #ObjectHandles

local ObjectHandleSizes = {50, 100, 200, 300, -1}

function SettingsOptionsWindow.Initialize()
    LabelSetText( "SettingsOptionsMapOptionsSubSectionLabel", GetStringFromTid( 1155405 ) )
    LabelSetText( "SettingsOptionsGameOptionsSubSectionLabel", GetStringFromTid( 1094695 ) )
    LabelSetText( "SettingsOptionsCenterScreenTextSubSectionLabel", GetStringFromTid( 1155428 ) )
    LabelSetText( "SettingsOptionsInterfaceSubSectionLabel", GetStringFromTid( 3000395 ) )
    LabelSetText( "SettingsOptionsSystemSubSectionLabel", GetStringFromTid( 1078905 ) )

    -- Options --

    -- Language
    LabelSetText( "SettingsOptionsLanguageLabel", GetStringFromTid( 1077824 ) )
    WindowSetId( "SettingsOptionsLanguageLabel", 1115294 )
    for lan = 1, NUM_LANGUAGES do
        local text = GetStringFromTid( Languages[lan].tid )
        ComboBoxAddMenuItem( "SettingsOptionsLanguageCombo", L""..text )
    end

    -- English item names
    LabelSetText( "SettingsOptionsEnglishNamesLabel", GetStringFromTid( 1115913 ) )
    WindowSetId( "SettingsOptionsEnglishNamesLabel", 1115914 )
    ButtonSetCheckButtonFlag( "SettingsOptionsEnglishNamesButton", true )

    -- Cache
    LabelSetText( "SettingsOptionsCacheSizeText", GetStringFromTid( 1079480 ) )
    WindowSetId( "SettingsOptionsCacheSizeText", 1115295 )

    -- Map Combo
    LabelSetText( "ToggleMapCombo" .. "Label", GetStringFromTid( 1155294 ) )
    WindowSetId( "ToggleMapCombo" .. "Label", 1155295 )
    ButtonSetCheckButtonFlag( "ToggleMapCombo" .. "Button", true )

    -- Toggle Cartographer
    --[[
    LabelSetText( "ToggleCartographer" .. "Label", L"Enable UO Mapper")-- GetStringFromTid( SettingsWindow.TID.ToggleCartographer ) )
    WindowSetId( "ToggleCartographer" .. "Label", SettingsWindow.DetailTID.ToggleCartographer )
    ButtonSetCheckButtonFlag( "ToggleCartographer" .. "Button", true )
    WindowSetShowing("ToggleCartographer", false)
    --]]

    -- Always Run
    LabelSetText( "AlwaysRunLabel", GetStringFromTid( 1078078 ) )
    WindowSetId( "AlwaysRunLabel", 1115296 )
    ButtonSetCheckButtonFlag( "AlwaysRunButton", true )

    -- Enable Autorun
    LabelSetText( "EnableAutorunLabel", GetStringFromTid( 1115321 ) )
    WindowSetId( "EnableAutorunLabel", 1115322 )
    ButtonSetCheckButtonFlag( "EnableAutorunButton", true )

    -- Enable Pathfinding
    LabelSetText( "EnablePathfindingLabel", GetStringFromTid( 1115324 ) )
    WindowSetId( "EnablePathfindingLabel", 1115325 )
    ButtonSetCheckButtonFlag( "EnablePathfindingButton", true )

    -- Always Attack
    LabelSetText( "AlwaysAttackLabel", GetStringFromTid( 1078858 ) )
    WindowSetId( "AlwaysAttackLabel", 1115297 )
    ButtonSetCheckButtonFlag( "AlwaysAttackButton", true )

    -- Query Before Criminal Actions
    LabelSetText( "QueryBeforeCriminalActionsLabel", GetStringFromTid( 1078080 ) )
    WindowSetId( "QueryBeforeCriminalActionsLabel", 1115298 )
    ButtonSetCheckButtonFlag( "QueryBeforeCriminalActionsButton", true )

    -- Ignore Mouse Actions on Self
    LabelSetText( "IgnoreMouseActionsOnSelfLabel", GetStringFromTid( 1115918 ) )
    WindowSetId( "IgnoreMouseActionsOnSelfLabel", 1115919 )
    ButtonSetCheckButtonFlag( "IgnoreMouseActionsOnSelfButton", true )

    -- Hold Shift to Unstack
    LabelSetText( "HoldShiftToUnstackLabel", GetStringFromTid( 1112076 ) )
    WindowSetId( "HoldShiftToUnstackLabel", 1115299 )
    ButtonSetCheckButtonFlag( "HoldShiftToUnstackButton", true )

    -- Shift-Right Click to Open Context Menus
    LabelSetText( "ShiftRightClickContextMenusLabel", GetStringFromTid( 1115355 ) )
    WindowSetId( "ShiftRightClickContextMenusLabel", 1115356 )
    ButtonSetCheckButtonFlag( "ShiftRightClickContextMenusButton", true )

    -- Cursor Target Queueing
    LabelSetText( "TargetQueueingLabel", GetStringFromTid( 1115337 ) )
    WindowSetId( "TargetQueueingLabel", 1115338 )
    ButtonSetCheckButtonFlag( "TargetQueueingButton", true )

    -- Block Others Paperdoll
    LabelSetText( "BlockOthersPaperdoll" .. "Label", GetStringFromTid( 1155298) )
    WindowSetId( "BlockOthersPaperdoll" .. "Label", 1155299 )
    ButtonSetCheckButtonFlag( "BlockOthersPaperdoll" .. "Button", true )

    -- BlockWarOnPets
    LabelSetText( "BlockWarOnPets" .. "Label", GetStringFromTid( 1155300) )
    WindowSetId( "BlockWarOnPets" .. "Label", 1155301 )
    ButtonSetCheckButtonFlag( "BlockWarOnPets" .. "Button", true )

    -- BlockWarOnParty
    LabelSetText( "BlockWarOnParty" .. "Label", GetStringFromTid( 1155302) )
    WindowSetId( "BlockWarOnParty" .. "Label", 1155303 )
    ButtonSetCheckButtonFlag( "BlockWarOnParty" .. "Button", true )

    -- BlockWarOnGuild
    LabelSetText( "BlockWarOnGuild" .. "Label", GetStringFromTid( 1155304) )
    WindowSetId( "BlockWarOnGuild" .. "Label", 1155305 )
    ButtonSetCheckButtonFlag( "BlockWarOnGuild" .. "Button", true )

    -- ToggleWarShield
    LabelSetText( "ToggleWarShield" .. "Label", GetStringFromTid( 1155367) )
    WindowSetId( "ToggleWarShield" .. "Label", 1155368 )
    ButtonSetCheckButtonFlag( "ToggleWarShield" .. "Button", true )

    -- AutoIgnoreCorpses
    LabelSetText( "AutoIgnoreCorpses" .. "Label", GetStringFromTid( 1156263) )
    WindowSetId( "AutoIgnoreCorpses" .. "Label", 1156264 )
    ButtonSetCheckButtonFlag( "AutoIgnoreCorpses" .. "Button", true )

    -- LowHPLabel
    LabelSetText( "LowHP" .. "Label", GetStringFromTid( 1155306) )
    WindowSetId( "LowHP" .. "Label", 1155309 )

    ComboBoxAddMenuItem( "LowHPCombo", L"5%" )
    ComboBoxAddMenuItem( "LowHPCombo", L"10%" )
    ComboBoxAddMenuItem( "LowHPCombo", L"15%" )
    ComboBoxAddMenuItem( "LowHPCombo", L"20%" )
    ComboBoxAddMenuItem( "LowHPCombo", L"25%" )
    ComboBoxAddMenuItem( "LowHPCombo", L"30%" )
    ComboBoxAddMenuItem( "LowHPCombo", L"35%" )
    ComboBoxAddMenuItem( "LowHPCombo", L"40%" )
    ComboBoxAddMenuItem( "LowHPCombo", L"45%" )
    ComboBoxAddMenuItem( "LowHPCombo", L"50%" )
    ComboBoxAddMenuItem( "LowHPCombo", L"60%" )
    ComboBoxAddMenuItem( "LowHPCombo", L"70%" )
    ComboBoxAddMenuItem( "LowHPCombo", L"80%" )
    ComboBoxAddMenuItem( "LowHPCombo", L"90%" )
    ComboBoxAddMenuItem( "LowHPCombo", L"99%" )
    ComboBoxAddMenuItem( "LowHPCombo", GetStringFromTid(1155308) )

    -- LowHPPetLabel
    LabelSetText( "LowHPPet" .. "Label", GetStringFromTid( 1155307) )
    WindowSetId( "LowHPPet" .. "Label", 1155310 )

    ComboBoxAddMenuItem( "LowHPPetCombo", L"5%" )
    ComboBoxAddMenuItem( "LowHPPetCombo", L"10%" )
    ComboBoxAddMenuItem( "LowHPPetCombo", L"15%" )
    ComboBoxAddMenuItem( "LowHPPetCombo", L"20%" )
    ComboBoxAddMenuItem( "LowHPPetCombo", L"25%" )
    ComboBoxAddMenuItem( "LowHPPetCombo", L"30%" )
    ComboBoxAddMenuItem( "LowHPPetCombo", L"35%" )
    ComboBoxAddMenuItem( "LowHPPetCombo", L"40%" )
    ComboBoxAddMenuItem( "LowHPPetCombo", L"45%" )
    ComboBoxAddMenuItem( "LowHPPetCombo", L"50%" )
    ComboBoxAddMenuItem( "LowHPPetCombo", L"60%" )
    ComboBoxAddMenuItem( "LowHPPetCombo", L"70%" )
    ComboBoxAddMenuItem( "LowHPPetCombo", L"80%" )
    ComboBoxAddMenuItem( "LowHPPetCombo", L"90%" )
    ComboBoxAddMenuItem( "LowHPPetCombo", L"99%" )
    ComboBoxAddMenuItem( "LowHPPetCombo", GetStringFromTid(1155308) )

    -- Ignore Summons
    LabelSetText( "IgnoreSummons" .. "Label", GetStringFromTid( 1155311) )
    WindowSetId( "IgnoreSummons" .. "Label", 1155312 )
    ButtonSetCheckButtonFlag( "IgnoreSummons" .. "Button", true )

    -- Use Custom UI
    LabelSetText( "CustomSkinsLabel", GetStringFromTid( 1079523 )..L":" )
    WindowSetId( "CustomSkinsLabel", 1115300 )
    for skinItr = 1, #SystemData.CustomUIList do
        local text = SystemData.CustomUIList[skinItr]
        if text == "" then
            ComboBoxAddMenuItem( "CustomSkinsCombo", GetStringFromTid( 3000094 ) )-- "Default"
        else
            ComboBoxAddMenuItem( "CustomSkinsCombo", StringToWString( text ) )
        end
    end

    -- UI Scale
    LabelSetText( "UiScaleText", GetStringFromTid( 1079205 ) )
    WindowSetId( "UiScaleText", 1115301 )

    -- Generic Gump Scale
    LabelSetText( "GenericGumpScaleText", GetStringFromTid( 1158011 ) )
    WindowSetId( "GenericGumpScaleText", 1158012 )

    -- Tooltips
    LabelSetText( "TooltipsLabel", GetStringFromTid( 1115211 ) )
    WindowSetId( "TooltipsLabel", 1115305 )
    ButtonSetCheckButtonFlag( "TooltipsButton", true )

    -- Display Pop-Up Window for Party Invitations
    LabelSetText( "PartyInvitePopUpLabel", GetStringFromTid( 1115367 ) )
    WindowSetId( "PartyInvitePopUpLabel", 1115368 )
    ButtonSetCheckButtonFlag( "PartyInvitePopUpButton", true )

    -- Toggle Window Snap
    LabelSetText( "ToggleWindowSnap" .. "Label", GetStringFromTid( 1155296) )
    WindowSetId( "ToggleWindowSnap" .. "Label", 1155297 )
    ButtonSetCheckButtonFlag( "ToggleWindowSnap" .. "Button", true )

    -- Reset UI Locs
    ButtonSetText( "ResetUILocButton", GetStringFromTid( 1153107) )

    -- Object Handle Filter
    LabelSetText( "SettingsOptionsObjHandleFilterLabel", L""..GetStringFromTid( 1079461 )..L":" )
    WindowSetId( "SettingsOptionsObjHandleFilterLabel", 1115307 )
    for filter = 1, NUM_OBJHANDLE_FILTERS do
        local text = L""
        if ObjectHandles[filter].tid then
            text = GetStringFromTid( ObjectHandles[filter].tid )
        elseif ObjectHandles[filter].text then
            text = ObjectHandles[filter].text
        end

        ComboBoxAddMenuItem( "SettingsOptionsObjHandleFilterCombo", L""..text )
    end

    -- Object Handle Quantity
    LabelSetText( "SettingsOptionsObjHandleSizeLabel", L""..GetStringFromTid( 1094696 )..L":" )
    WindowSetId( "SettingsOptionsObjHandleSizeLabel", 1115308 )
    for indexSize, objHandleSize in pairs( ObjectHandleSizes )do
        --( -1 )is considered max size
        local text = ObjectHandleSizes[indexSize]
        if( objHandleSize == -1 )then
            text = GetStringFromTid( 1077866 )-- "All"
        end
        ComboBoxAddMenuItem( "SettingsOptionsObjHandleSizeCombo", L""..text )
    end

    -- Enable chat log
    LabelSetText( "EnableChatLogLabel", GetStringFromTid( 1149998 ) )
    WindowSetId( "EnableChatLogLabel", 1149999 )
    ButtonSetCheckButtonFlag( "EnableChatLogButton", true )

    ScrollWindowSetOffset( "SettingsOptionsWindow", 0 )
    ScrollWindowUpdateScrollRect( "SettingsOptionsWindow" )
end

function SettingsOptionsWindow.UpdateSettings()
    --Language
    for lan = 1, NUM_LANGUAGES do
        if( SystemData.Settings.Language.type == Languages[lan].id )then
            ComboBoxSetSelectedMenuItem( "SettingsOptionsLanguageCombo", lan )
        end
    end
    ButtonSetPressedFlag( "SettingsOptionsEnglishNamesButton", SystemData.Settings.Language.englishNames )

    --Cache Size
    SliderBarSetCurrentPosition( "SettingsOptionsCacheSizeSliderBar", (SystemData.Settings.Optimization.cacheSize / 1024) )
    LabelSetText( "SettingsOptionsCacheSizeVal",  L""..SystemData.Settings.Optimization.cacheSize )

    for filter = 1, NUM_OBJHANDLE_FILTERS do
        if( SystemData.Settings.GameOptions.objectHandleFilter == ObjectHandles[filter].id )then
            ComboBoxSetSelectedMenuItem( "SettingsOptionsObjHandleFilterCombo", filter )
        end
    end

    for skinItr = 1, #SystemData.CustomUIList do
        if( SystemData.Settings.Interface.customUiName == SystemData.CustomUIList[skinItr] )then
            ComboBoxSetSelectedMenuItem( "CustomSkinsCombo", skinItr )
        end
    end

    for indexSize, objHandleSize in pairs( ObjectHandleSizes )do
        if( SystemData.Settings.GameOptions.objectHandleSize == objHandleSize )then
            ComboBoxSetSelectedMenuItem( "SettingsOptionsObjHandleSizeCombo", indexSize )
        end
    end

    SliderBarSetCurrentPosition( "UiScaleSliderBar", ( ( SystemData.Settings.Interface.customUiScale - 0.5 )*2 ) )
    LabelSetText( "UiScaleVal", wstring.format( L"%2.2f", SystemData.Settings.Interface.customUiScale ) )

    SliderBarSetCurrentPosition( "GenericGumpScaleSliderBar", ((((SystemData.Settings.Interface.customGenericGumpScale) / 1.2) - 0.885) /0.115))
    LabelSetText( "GenericGumpScaleVal", wstring.format( L"%2.2f", SystemData.Settings.Interface.customGenericGumpScale ) )

    ButtonSetPressedFlag( "AlwaysRunButton", SystemData.Settings.GameOptions.alwaysRun )
    ButtonSetPressedFlag( "EnableAutorunButton", SystemData.Settings.GameOptions.enableAutorun )
    ButtonSetPressedFlag( "EnablePathfindingButton", SystemData.Settings.GameOptions.enablePathfinding )
    ButtonSetPressedFlag( "QueryBeforeCriminalActionsButton", SystemData.Settings.GameOptions.queryBeforeCriminalAction )
    ButtonSetPressedFlag( "IgnoreMouseActionsOnSelfButton", SystemData.Settings.GameOptions.ignoreMouseActionsOnSelf )
    ButtonSetPressedFlag( "HoldShiftToUnstackButton", SystemData.Settings.GameOptions.holdShiftToUnstack )
    ButtonSetPressedFlag( "ShiftRightClickContextMenusButton", SystemData.Settings.GameOptions.shiftRightClickContextMenus )
    ButtonSetPressedFlag( "TargetQueueingButton", SystemData.Settings.GameOptions.targetQueueing )
    ButtonSetPressedFlag( "AlwaysAttackButton", SystemData.Settings.GameOptions.alwaysAttack )
    ButtonSetPressedFlag( "TooltipsButton", SystemData.Settings.Interface.showTooltips )
    ButtonSetPressedFlag( "PartyInvitePopUpButton", SystemData.Settings.Interface.partyInvitePopUp )
    ButtonSetPressedFlag( "EnableChatLogButton", SystemData.Settings.GameOptions.enableChatLog )

    ButtonSetPressedFlag( "ToggleMapCombo" .. "Button", Interface.ShowMapCombos )
    ButtonSetPressedFlag( "ToggleWindowSnap" .. "Button", Interface.EnableSnapping )

    ButtonSetPressedFlag( "BlockOthersPaperdoll" .. "Button", Interface.BlockOthersPaperdoll	)

    ButtonSetPressedFlag( "BlockWarOnPets" .. "Button", SystemData.Settings.GameOptions.noWarOnPets	)
    ButtonSetPressedFlag( "BlockWarOnParty" .. "Button",SystemData.Settings.GameOptions.noWarOnParty )
    ButtonSetPressedFlag( "BlockWarOnGuild" .. "Button",SystemData.Settings.GameOptions.noWarOnFriendly )

    ButtonSetPressedFlag( "ToggleWarShield" .. "Button",Interface.WarShield )
    ButtonSetPressedFlag( "AutoIgnoreCorpses" .. "Button",ContainerWindow.EnableAutoIgnoreCorpses )

    ButtonSetPressedFlag( "IgnoreSummons" .. "Button",CenterScreenText.EnableIgnoreSummons)

    if (CenterScreenText.LowHPPercDisabled) then
        ComboBoxSetSelectedMenuItem( "LowHPCombo", 16 )
    elseif CenterScreenText.LowHPPerc <= 50 then
        ComboBoxSetSelectedMenuItem( "LowHPCombo", (CenterScreenText.LowHPPerc  / 5)  )
    elseif CenterScreenText.LowHPPerc == 60 then
        ComboBoxSetSelectedMenuItem( "LowHPCombo", 11  )
    elseif CenterScreenText.LowHPPerc == 70 then
        ComboBoxSetSelectedMenuItem( "LowHPCombo", 12  )
    elseif CenterScreenText.LowHPPerc == 80 then
        ComboBoxSetSelectedMenuItem( "LowHPCombo", 13  )
    elseif CenterScreenText.LowHPPerc == 90 then
        ComboBoxSetSelectedMenuItem( "LowHPCombo", 14  )
    elseif CenterScreenText.LowHPPerc == 99 then
        ComboBoxSetSelectedMenuItem( "LowHPCombo", 15  )
    end

    if (CenterScreenText.LowHPPETPercDisabled) then
        ComboBoxSetSelectedMenuItem( "LowHPPetCombo", 16 )
    elseif CenterScreenText.LowPETHPPerc <= 50 then
        ComboBoxSetSelectedMenuItem( "LowHPPetCombo", (CenterScreenText.LowPETHPPerc  / 5)  )
    elseif CenterScreenText.LowPETHPPerc == 60 then
        ComboBoxSetSelectedMenuItem( "LowHPPetCombo", 11  )
    elseif CenterScreenText.LowPETHPPerc == 70 then
        ComboBoxSetSelectedMenuItem( "LowHPPetCombo", 12  )
    elseif CenterScreenText.LowPETHPPerc == 80 then
        ComboBoxSetSelectedMenuItem( "LowHPPetCombo", 13  )
    elseif CenterScreenText.LowPETHPPerc == 90 then
        ComboBoxSetSelectedMenuItem( "LowHPPetCombo", 14  )
    elseif CenterScreenText.LowPETHPPerc == 99 then
        ComboBoxSetSelectedMenuItem( "LowHPPetCombo", 15  )
    end

    ButtonSetPressedFlag( "ToggleWindowSnap" .. "Button", Interface.EnableSnapping )
end

function SettingsOptionsWindow.OnApplyButton()
    -- Language
    local languageIndex = ComboBoxGetSelectedMenuItem( "SettingsOptionsLanguageCombo" )
    SystemData.Settings.Language.type = Languages[languageIndex].id
    SystemData.Settings.Language.englishNames = ButtonGetPressedFlag( "SettingsOptionsEnglishNamesButton" )

    -- Cache Size
    SystemData.Settings.Optimization.cacheSize = (SliderBarGetCurrentPosition( "SettingsOptionsCacheSizeSliderBar" ) * 1024)

    -- Options
    SystemData.Settings.GameOptions.alwaysRun = ButtonGetPressedFlag( "AlwaysRunButton" )
    SystemData.Settings.GameOptions.enableAutorun = ButtonGetPressedFlag( "EnableAutorunButton" )
    SystemData.Settings.GameOptions.enablePathfinding = ButtonGetPressedFlag( "EnablePathfindingButton" )
    SystemData.Settings.GameOptions.queryBeforeCriminalAction = ButtonGetPressedFlag( "QueryBeforeCriminalActionsButton" )
    SystemData.Settings.GameOptions.ignoreMouseActionsOnSelf = ButtonGetPressedFlag( "IgnoreMouseActionsOnSelfButton" )
    SystemData.Settings.GameOptions.holdShiftToUnstack = ButtonGetPressedFlag( "HoldShiftToUnstackButton" )
    SystemData.Settings.GameOptions.shiftRightClickContextMenus = ButtonGetPressedFlag( "ShiftRightClickContextMenusButton" )
    SystemData.Settings.GameOptions.targetQueueing = ButtonGetPressedFlag( "TargetQueueingButton" )
    SystemData.Settings.GameOptions.alwaysAttack = ButtonGetPressedFlag( "AlwaysAttackButton" )

    -- Object Handle Filter
    local filterIndex = ComboBoxGetSelectedMenuItem( "SettingsOptionsObjHandleFilterCombo" )
    SystemData.Settings.GameOptions.objectHandleFilter = ObjectHandles[filterIndex].id

    local skinIndex = ComboBoxGetSelectedMenuItem( "CustomSkinsCombo" )
    SystemData.Settings.Interface.customUiName = SystemData.CustomUIList[skinIndex]

    local objHandleSize = ComboBoxGetSelectedMenuItem( "SettingsOptionsObjHandleSizeCombo" )
    SystemData.Settings.GameOptions.objectHandleSize = ObjectHandleSizes[objHandleSize]

    -- Interface
    SystemData.Settings.Interface.showTooltips = ButtonGetPressedFlag( "TooltipsButton" )
    SystemData.Settings.Interface.partyInvitePopUp = ButtonGetPressedFlag( "PartyInvitePopUpButton" )

    -- only update the scale if necesary
    local uiScale =( SliderBarGetCurrentPosition( "UiScaleSliderBar" )/2 )+ 0.5
    SystemData.Settings.Interface.customUiScale = uiScale

    local genericGumpScale = ( ((SliderBarGetCurrentPosition("GenericGumpScaleSliderBar") * 0.115) + 0.885) * 1.2)
    SystemData.Settings.Interface.customGenericGumpScale = genericGumpScale

    SystemData.Settings.GameOptions.enableChatLog = ButtonGetPressedFlag( "EnableChatLogButton" )

    MapWindow.ToggleCombos(ButtonGetPressedFlag( "ToggleMapComboButton" ))

    Interface.BlockOthersPaperdoll = ButtonGetPressedFlag( "BlockOthersPaperdoll" .. "Button" )
    Interface.SaveBoolean( "BlockOthersPaperdoll" , Interface.BlockOthersPaperdoll )

    SystemData.Settings.GameOptions.noWarOnPets = ButtonGetPressedFlag( "BlockWarOnPets" .. "Button"  )
    Interface.SaveBoolean( "noWarOnPets" , SystemData.Settings.GameOptions.noWarOnPets )
    SystemData.Settings.GameOptions.noWarOnParty = ButtonGetPressedFlag( "BlockWarOnParty" .. "Button"  )
    Interface.SaveBoolean( "noWarOnParty" , SystemData.Settings.GameOptions.noWarOnParty )
    SystemData.Settings.GameOptions.noWarOnFriendly = ButtonGetPressedFlag( "BlockWarOnGuild" .. "Button"  )
    Interface.SaveBoolean( "noWarOnFriendly" , SystemData.Settings.GameOptions.noWarOnFriendly )

    Interface.WarShield = ButtonGetPressedFlag( "ToggleWarShield" .. "Button"  )
    Interface.SaveBoolean( "WarShield" , Interface.WarShield )
    WindowSetShowing("WarShield",Interface.WarShield)

    ContainerWindow.EnableAutoIgnoreCorpses = ButtonGetPressedFlag( "AutoIgnoreCorpses" .. "Button"  )
    Interface.SaveBoolean( "AutoIgnoreCorpses" , ContainerWindow.EnableAutoIgnoreCorpses)

    local lowHP = ComboBoxGetSelectedMenuItem( "LowHPCombo" )
    CenterScreenText.LowHPPerc = 35
    CenterScreenText.LowHPPercDisabled = false
    if lowHP <= 10 then
        CenterScreenText.LowHPPerc = lowHP * 5
    elseif lowHP == 11 then
        CenterScreenText.LowHPPerc = 60
    elseif lowHP == 12 then
        CenterScreenText.LowHPPerc = 70
    elseif lowHP == 13 then
        CenterScreenText.LowHPPerc = 80
    elseif lowHP == 14 then
        CenterScreenText.LowHPPerc = 90
    elseif lowHP == 15 then
        CenterScreenText.LowHPPerc = 99
    elseif lowHP == 16 then
        CenterScreenText.LowHPPercDisabled = true
        if CenterScreenText.LOWHPMEStarted then
            CenterScreenText.LOWHPMEStarted = false
            WindowStopAlphaAnimation("CenterScreenTextImage")
            WindowSetAlpha("CenterScreenTextImage", 0)
        end
    end
    Interface.SaveNumber( "LowHPPerc" , CenterScreenText.LowHPPerc )
    Interface.SaveBoolean( "LowHPPercDisabled" , CenterScreenText.LowHPPercDisabled )

    local lowHPPet = ComboBoxGetSelectedMenuItem( "LowHPPetCombo" )
    CenterScreenText.LowPETHPPerc = 35
    CenterScreenText.LowPETHPPercDisabled = false
    if lowHPPet <= 10 then
        CenterScreenText.LowPETHPPerc = lowHPPet * 5
    elseif lowHPPet == 11 then
        CenterScreenText.LowPETHPPerc = 60
    elseif lowHPPet == 12 then
        CenterScreenText.LowPETHPPerc = 70
    elseif lowHPPet == 13 then
        CenterScreenText.LowPETHPPerc = 80
    elseif lowHPPet == 14 then
        CenterScreenText.LowPETHPPerc = 90
    elseif lowHPPet == 15 then
        CenterScreenText.LowPETHPPerc = 99
    elseif lowHPPet == 16 then
        CenterScreenText.LowPETHPPercDisabled = true
        if CenterScreenText.LOWHPPetStarted then
            CenterScreenText.LOWHPPetStarted = false
            WindowStopAlphaAnimation("CenterScreenTextImage")
            WindowSetAlpha("CenterScreenTextImage", 0)
        end
    end

    Interface.SaveNumber( "LowPETHPPerc" , CenterScreenText.LowPETHPPerc )
    Interface.SaveBoolean( "LowPETHPPercDisabled" , CenterScreenText.LowPETHPPercDisabled )

    CenterScreenText.EnableIgnoreSummons = ButtonGetPressedFlag( "IgnoreSummons" .. "Button" )
    Interface.SaveBoolean( "EnableIgnoreSummons" , CenterScreenText.EnableIgnoreSummons )

    Interface.EnableSnapping = ButtonGetPressedFlag( "ToggleWindowSnap" .. "Button" )
    Interface.SaveBoolean( "EnableSnapping" , Interface.EnableSnapping )
end


function SettingsOptionsWindow.UpdateSliderSettings(curPos)
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

    if (barName == "UiScale") then
        -- update the cache size value
        local cacheSize = math.floor( SliderBarGetCurrentPosition( "SettingsOptionsCacheSizeSliderBar" ) * 1024 )
        LabelSetText( "SettingsOptionsCacheSizeVal", L""..cacheSize )
        return
    end

    MobilesOnScreen.OnSlide( curPos )

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