SettingsOverheadTextWindow = {}

local ShowNames = {}
ShowNames[1] = {tid = 1011051, id = SystemData.Settings.GameOptions.SHOWNAMES_NONE}
ShowNames[2] = {tid = 1078090, id = SystemData.Settings.GameOptions.SHOWNAMES_APPROACHING}
ShowNames[3] = {tid = 1078091, id = SystemData.Settings.GameOptions.SHOWNAMES_ALL}
local NUM_SHOWNAMES = 3

local DelayValues = {}
DelayValues[1] = 1078334
DelayValues[2] = 1078336
DelayValues[3] = 1078337
DelayValues[4] = 1078338
DelayValues[5] = 1078339
DelayValues[6] = 1078340
local NUM_DELAY_VALUES = 6

function SettingsOverheadTextWindow.Initialize()
    LabelSetText( "OverheadTextOptionsOTSubSectionLabel", GetStringFromTid(  1155333 ) )
    LabelSetText( "OverheadTextOptionsColorsSubSectionLabel", GetStringFromTid( 1155351 ) )

    LabelSetText( "clickableNames" .. "Label", GetStringFromTid( 1155340 ) )
    ButtonSetCheckButtonFlag( "clickableNames" .. "Button", true )

    -- Show Corpse Names
    LabelSetText( "ShowCorpseNamesLabel", GetStringFromTid( 1115927 ) )
    WindowSetId( "ShowCorpseNamesLabel", 1115928 )
    ButtonSetCheckButtonFlag( "ShowCorpseNamesButton", true )

    LabelSetText( "DisableSpells" .. "Label", GetStringFromTid( 1155334 ) )
    WindowSetId( "DisableSpells" .. "Label", 1155335 )
    ButtonSetCheckButtonFlag( "DisableSpells" .. "Button", true )

    LabelSetText( "ShowSpellName" .. "Label", GetStringFromTid( 1155336 ) )
    WindowSetId( "ShowSpellName" .. "Label", 1155337 )
    ButtonSetCheckButtonFlag( "ShowSpellName" .. "Button", true )

    LabelSetText( "noPoisonOthers" .. "Label", GetStringFromTid( 1155338 ) )
    WindowSetId( "noPoisonOthers" .. "Label", 1155339 )
    ButtonSetCheckButtonFlag( "noPoisonOthers" .. "Button", true )

    -- Show Names
    LabelSetText( "SettingsOptionsShowNamesLabel", GetStringFromTid( 1078093 )..L":" )
    WindowSetId( "SettingsOptionsShowNamesLabel", 1115309 )
    for sn = 1, NUM_SHOWNAMES do
        local text = GetStringFromTid( ShowNames[sn].tid )
        ComboBoxAddMenuItem( "SettingsOptionsShowNamesCombo", L""..text )
    end

    -- Overhead Chat
    LabelSetText( "OverheadChatLabel", GetStringFromTid( 1078083 ) )
    WindowSetId( "OverheadChatLabel", 1115310 )
    ButtonSetCheckButtonFlag( "OverheadChatButton", true )

    -- Overhead Chat Fade Delay
    LabelSetText( "OverheadChatFadeDelayLabel", GetStringFromTid( 1078084 )..L":" )
    WindowSetId( "OverheadChatFadeDelayLabel", 1115311 )
    for delay = 1,NUM_DELAY_VALUES do
        local text = GetStringFromTid( DelayValues[delay] )
        ComboBoxAddMenuItem( "OverheadChatFadeDelayCombo", L""..text )
    end

    ButtonSetText( "OverheadTextSizePlus",  GetStringFromTid( 1155341 ) )
    ButtonSetText( "OverheadTextSizeMinus", GetStringFromTid( 1155342 ) )
    ButtonSetText( "OverheadChatFont",   GetStringFromTid( 1155343 ) )
    ButtonSetText( "OverheadNamesFont", GetStringFromTid( 1155344 ) )
    ButtonSetText( "OverheadSpellFont", GetStringFromTid( 1155345 ) )
    ButtonSetText( "OverheadDamageFont", GetStringFromTid( 1155346 ) )

    LabelSetText( "OverheadTextOptionscolorHealLabel", GetStringFromTid( 1155352 ) )
    LabelSetText( "OverheadTextOptionscolorCurseLabel",  GetStringFromTid( 1155353 ) )
    LabelSetText( "OverheadTextOptionscolorParaLabel", GetStringFromTid( 1155354 ) )
    LabelSetText( "OverheadTextOptionscolorNeutralLabel", GetStringFromTid( 1155355 ) )
    LabelSetText( "OverheadTextOptionscolorNegLabel", GetStringFromTid( 1155356 ) )
    LabelSetText( "OverheadTextOptionscolorPosLabel", GetStringFromTid( 1155357 ) )
    LabelSetText( "OverheadTextOptionscolorYouLabel", GetStringFromTid( 1155358 ) )
    LabelSetText( "OverheadTextOptionscolorPetLabel", GetStringFromTid( 1155359 ) )
    LabelSetText( "OverheadTextOptionscolorEnemyLabel", GetStringFromTid( 1155360 ) )
    LabelSetText( "OverheadTextOptionscolorPhysLabel", GetStringFromTid( 1155361 ) )
    LabelSetText( "OverheadTextOptionscolorFireLabel", GetStringFromTid( 1155362) )
    LabelSetText( "OverheadTextOptionscolorColdLabel", GetStringFromTid( 1155363 ) )
    LabelSetText( "OverheadTextOptionscolorPoisLabel", GetStringFromTid( 1155364 ) )
    LabelSetText( "OverheadTextOptionscolorEnerLabel", GetStringFromTid( 1155365 ) )
    LabelSetText( "OverheadTextOptionscolorChaosLabel",GetStringFromTid( 1155366 ) )
end

function SettingsOverheadTextWindow.UpdateSettings()
    ButtonSetPressedFlag( "OverheadChatButton", SystemData.Settings.Interface.OverheadChat )
    ButtonSetPressedFlag( "clickableNames" .. "Button", OverheadText.clickableNames )
    ButtonSetPressedFlag( "DisableSpells" .. "Button", Interface.DisableSpells )
    ButtonSetPressedFlag( "ShowSpellName" .. "Button", Interface.ShowSpellName )
    ButtonSetPressedFlag( "noPoisonOthers" .. "Button", Interface.noPoisonOthers )
    ButtonSetPressedFlag( "ShowCorpseNamesButton", SystemData.Settings.GameOptions.showCorpseNames )

    for sn = 1, NUM_SHOWNAMES do
        if( SystemData.Settings.GameOptions.showNames == ShowNames[sn].id )then
            ComboBoxSetSelectedMenuItem( "SettingsOptionsShowNamesCombo", sn )
        end
    end

    if( SystemData.Settings.Interface.OverheadChatFadeDelay ~= nil )then
        ComboBoxSetSelectedMenuItem( "OverheadChatFadeDelayCombo", SystemData.Settings.Interface.OverheadChatFadeDelay )
    end

    WindowSetTintColor("OverheadTextOptions" .. "colorHeal" .. "Button", TextParsing.Heal.r,TextParsing.Heal.g,TextParsing.Heal.b)
    WindowSetTintColor("OverheadTextOptions" .. "colorCurse" .. "Button", TextParsing.Curse.r,TextParsing.Curse.g,TextParsing.Curse.b)
    WindowSetTintColor("OverheadTextOptions" .. "colorPara" .. "Button", TextParsing.Paralyze.r,TextParsing.Paralyze.g,TextParsing.Paralyze.b)
    WindowSetTintColor("OverheadTextOptions" .. "colorNeutral" .. "Button", TextParsing.Neutral.r,TextParsing.Neutral.g,TextParsing.Neutral.b)
    WindowSetTintColor("OverheadTextOptions" .. "colorNeg" .. "Button", TextParsing.OverHeadError.r,TextParsing.OverHeadError.g,TextParsing.OverHeadError.b)
    WindowSetTintColor("OverheadTextOptions" .. "colorPos" .. "Button", TextParsing.SpecialColor.r,TextParsing.SpecialColor.g,TextParsing.SpecialColor.b)
    WindowSetTintColor("OverheadTextOptions" .. "colorYou" .. "Button", DamageWindow.YOUGETAMAGE_COLOR.r,DamageWindow.YOUGETAMAGE_COLOR.g,DamageWindow.YOUGETAMAGE_COLOR.b)
    WindowSetTintColor("OverheadTextOptions" .. "colorPet" .. "Button", DamageWindow.PETGETDAMAGE_COLOR.r,DamageWindow.PETGETDAMAGE_COLOR.g,DamageWindow.PETGETDAMAGE_COLOR.b)
    WindowSetTintColor("OverheadTextOptions" .. "colorEnemy" .. "Button", DamageWindow.OTHERGETDAMAGE_COLOR.r,DamageWindow.OTHERGETDAMAGE_COLOR.g,DamageWindow.OTHERGETDAMAGE_COLOR.b)
    WindowSetTintColor("OverheadTextOptions" .. "colorPhys" .. "Button", SpellsInfo.PHYSICAL.r,SpellsInfo.PHYSICAL.g,SpellsInfo.PHYSICAL.b)
    WindowSetTintColor("OverheadTextOptions" .. "colorFire" .. "Button", SpellsInfo.FIRE.r,SpellsInfo.FIRE.g,SpellsInfo.FIRE.b)
    WindowSetTintColor("OverheadTextOptions" .. "colorCold" .. "Button", SpellsInfo.COLD.r,SpellsInfo.COLD.g,SpellsInfo.COLD.b)
    WindowSetTintColor("OverheadTextOptions" .. "colorPois" .. "Button", SpellsInfo.POISON.r,SpellsInfo.POISON.g,SpellsInfo.POISON.b)
    WindowSetTintColor("OverheadTextOptions" .. "colorEner" .. "Button", SpellsInfo.ENERGY.r,SpellsInfo.ENERGY.g,SpellsInfo.ENERGY.b)
    WindowSetTintColor("OverheadTextOptions" .. "colorChaos" .. "Button", SpellsInfo.Chaos.r,SpellsInfo.Chaos.g,SpellsInfo.Chaos.b)
end

function SettingsOverheadTextWindow.OnApplyButton()
    SystemData.Settings.GameOptions.showCorpseNames = ButtonGetPressedFlag( "ShowCorpseNamesButton" )

    OverheadText.clickableNames =	ButtonGetPressedFlag( "clickableNames" .. "Button" )
    Interface.SaveBoolean( "clickableNames", OverheadText.clickableNames )

    Interface.DisableSpells =	ButtonGetPressedFlag( "DisableSpells" .. "Button" )
    Interface.SaveBoolean( "DisableSpells", Interface.DisableSpells )

    Interface.ShowSpellName =	ButtonGetPressedFlag( "ShowSpellName" .. "Button" )
    Interface.SaveBoolean( "ShowSpellName", Interface.ShowSpellName )

    Interface.noPoisonOthers =	ButtonGetPressedFlag( "noPoisonOthers" .. "Button" )
    Interface.SaveBoolean( "noPoisonOthers", Interface.noPoisonOthers )

    -- Show Names
    local showNamesIndex = ComboBoxGetSelectedMenuItem( "SettingsOptionsShowNamesCombo" )
    SystemData.Settings.GameOptions.showNames = ShowNames[showNamesIndex].id

    SystemData.Settings.Interface.OverheadChat = ButtonGetPressedFlag( "OverheadChatButton" )
    SystemData.Settings.Interface.OverheadChatFadeDelay = ComboBoxGetSelectedMenuItem( "OverheadChatFadeDelayCombo" )

    OverheadText.UpdateSettings()
end

function SettingsOverheadTextWindow.IncreaseTextSize()
    OverheadText.OverhedTextSize =OverheadText.OverhedTextSize + 0.1

    if (OverheadText.OverhedTextSize > 1.5) then
        OverheadText.OverhedTextSize = 1.5
    end
    Interface.SaveNumber("OverhedTextSize", OverheadText.OverhedTextSize)
    WindowUtils.SendOverheadText(GetStringFromTid(1155472), 23  , false, false)
end

function SettingsOverheadTextWindow.DecreaseTextSize()
    OverheadText.OverhedTextSize =OverheadText.OverhedTextSize - 0.1
    if (OverheadText.OverhedTextSize < 0.5) then
        OverheadText.OverhedTextSize = 0.5
    end
    Interface.SaveNumber("OverhedTextSize", OverheadText.OverhedTextSize)
    WindowUtils.SendOverheadText(GetStringFromTid(1155472), 23 , false, false)
end

function SettingsOverheadTextWindow.ChatFont()
    FontSelector.Selection = "chat"
    if (not DoesWindowNameExist("FontSelector")) then
        CreateWindow("FontSelector", true)
    else
        WindowSetShowing("FontSelector", true)
    end

    FontSelector.OnShown()
    WindowSetShowing(FontSelector.RunicFontItem, false)
    WindowUtils.SetWindowTitle("FontSelector", GetStringFromTid(1155347))
end

function SettingsOverheadTextWindow.NamesFont()
    FontSelector.Selection = "names"
    if (not DoesWindowNameExist("FontSelector")) then
        CreateWindow("FontSelector", true)
    else
        WindowSetShowing("FontSelector", true)
    end
    FontSelector.OnShown()
    WindowSetShowing(FontSelector.RunicFontItem, false)
    WindowUtils.SetWindowTitle("FontSelector", GetStringFromTid(1155348))
end

function SettingsOverheadTextWindow.SpellFont()
    FontSelector.Selection = "spells"
    if (not DoesWindowNameExist("FontSelector")) then
        CreateWindow("FontSelector", true)
    else
        WindowSetShowing("FontSelector", true)
    end
    FontSelector.OnShown()
    WindowSetShowing(FontSelector.RunicFontItem, not Interface.ShowSpellName)
    WindowUtils.SetWindowTitle("FontSelector", GetStringFromTid(1155349))
end

function SettingsOverheadTextWindow.DamageFont()
    FontSelector.Selection = "damage"
    if (not DoesWindowNameExist("FontSelector")) then
        CreateWindow("FontSelector", true)
    else
        WindowSetShowing("FontSelector", true)
    end
    FontSelector.OnShown()
    WindowSetShowing(FontSelector.RunicFontItem, false)
    WindowUtils.SetWindowTitle("FontSelector", GetStringFromTid(1155350))
end