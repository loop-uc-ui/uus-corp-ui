UserOverheadTextSettings = {}

UserOverheadTextSettings.ShowNamesOptions = {
    None = SystemData.Settings.GameOptions.SHOWNAMES_NONE,
    Approaching = SystemData.Settings.GameOptions.SHOWNAMES_APPROACHING,
    All = SystemData.Settings.GameOptions.SHOWNAMES_ALL
}

function UserOverheadTextSettings.showNames(newValue)
    if newValue ~= nil then
        SystemData.Settings.GameOptions.showNames = newValue
        return newValue
    else
        return SystemData.Settings.GameOptions.showNames
    end
end

function UserOverheadTextSettings.showCorpseNames(newValue)
    if newValue ~= nil then
        SystemData.Settings.GameOptions.showCorpseNames = newValue
        return newValue
    else
        return SystemData.Settings.GameOptions.showCorpseNames
    end
end

function UserOverheadTextSettings.showChat(newValue)
    if newValue ~= nil then
        SystemData.Settings.Interface.OverheadChat = newValue
        return newValue
    else
        return SystemData.Settings.Interface.OverheadChat
    end
end

function UserOverheadTextSettings.delay(newValue)
    if newValue ~= nil then
        SystemData.Settings.Interface.OverheadChatFadeDelay = newValue
        return newValue
    else
        return SystemData.Settings.Interface.OverheadChatFadeDelay
    end
end

function UserOverheadTextSettings.disableSpells(newValue)
    if newValue ~= nil then
        UserInterfaceVariables.SaveBoolean("DisableSpells", newValue)
        Interface.DisableSpells = newValue
        return newValue
    else
        return UserInterfaceVariables.LoadBoolean("DisableSpells", false)
    end
end

function UserOverheadTextSettings.showSpellNames(newValue)
    if newValue ~= nil then
        UserInterfaceVariables.SaveBoolean("ShowSpellName", newValue)
        Interface.ShowSpellName = newValue
        return newValue
    else
        return UserInterfaceVariables.LoadBoolean("ShowSpellName", true)
    end
end

function UserOverheadTextSettings.disablePoison(newValue)
    if newValue ~= nil then
        UserInterfaceVariables.SaveBoolean("noPoisonOthers", newValue)
        Interface.noPoisonOthers = newValue
        return newValue
    else
        return UserInterfaceVariables.LoadBoolean("noPoisonOthers", true)
    end
end

function UserOverheadTextSettings.textSize(newValue)
    if newValue ~= nil then
        --retain typo from default UI for compatibility
        UserInterfaceVariables.SaveNumber("OverhedTextSize", newValue)
        return newValue
    else
        return UserInterfaceVariables.LoadNumber("OverhedTextSize", InterfaceCore.scale)
    end
end

function UserOverheadTextSettings.fontIndex(newValue)
    if newValue ~= nil then
        UserInterfaceVariables.SaveNumber("OverheadTextFontIndex", newValue)
        return newValue
    else
        return UserInterfaceVariables.SaveNumber("OverheadTextFontIndex", 1)
    end
end

function UserOverheadTextSettings.namesFontIndex(newValue)
    if newValue ~= nil then
        UserInterfaceVariables.SaveNumber("OverheadTextNameFontIndex", newValue)
        return newValue
    else
        return UserInterfaceVariables.LoadNumber("OverheadTextNameFontIndex", 1)
    end
end

function UserOverheadTextSettings.spellsFontIndex(newValue)
    if newValue ~= nil then
        UserInterfaceVariables.SaveNumber("OverheadTextSpellsFontIndex", newValue)
        return newValue
    else
        return UserInterfaceVariables.LoadNumber("OverheadTextSpellsFontIndex", 1)
    end
end

function UserOverheadTextSettings.damageFontIndex(newValue)
    if newValue ~= nil then
        UserInterfaceVariables.SaveNumber("OverheadTextDamageFontIndex", newValue)
        return newValue
    else
        return UserInterfaceVariables.LoadNumber("OverheadTextDamageFontIndex", 1)
    end
end

function UserOverheadTextSettings.healColor(newValue)
    if newValue ~= nil then
        UserInterfaceVariables.SaveColor("TextParsingHeal", newValue)
        return newValue
    else
        return UserInterfaceVariables.LoadColor("TextParsingHeal", {
            r = 255,
            g = 215,
            b = 0
        })
    end
end

function UserOverheadTextSettings.curseColor(newValue)
    if newValue ~= nil then
        UserInterfaceVariables.SaveColor("TextParsingCurse", newValue)
        return newValue
    else
        return UserInterfaceVariables.LoadColor("TextParsingCurse", {
            r = 162,
            g = 153,
            b = 185
        })
    end
end

function UserOverheadTextSettings.paralyzeColor(newValue)
    if newValue ~= nil then
        UserInterfaceVariables.SaveColor("TextParsingParalyze", newValue)
        return newValue
    else
        return UserInterfaceVariables.LoadColor("TextParsingParalyze", {
            r = 194,
            g = 67,
            b = 99
        })
    end
end

function UserOverheadTextSettings.neutralColor(newValue)
    if newValue ~= nil then
        UserInterfaceVariables.SaveColor("TextParsingNeutral", newValue)
        return newValue
    else
        return UserInterfaceVariables.LoadColor("TextParsingNeutral",  {
            r = 255,
            g = 255,
            b = 255
        })
    end
end

function UserOverheadTextSettings.errorColor(newValue)
    if newValue ~= nil then
        UserInterfaceVariables.SaveColor("TextParsingOverHeadError", newValue)
        return newValue
    else
        return UserInterfaceVariables.LoadColor("TextParsingOverHeadError",  {
            r = 255,
            g = 0,
            b = 0
        })
    end
end

function UserOverheadTextSettings.specialColor(newValue)
    if newValue ~= nil then
        UserInterfaceVariables.SaveColor("TextParsingSpecialColor", newValue)
        return newValue
    else
        return UserInterfaceVariables.LoadColor("TextParsingSpecialColor",  {
            r = 64,
            g = 164,
            b = 254
        })
    end
end

function UserOverheadTextSettings.damageOtherColor(newValue)
    if newValue ~= nil then
        UserInterfaceVariables.SaveColor("DamageWindowOTHERGETDAMAGE_COLOR", newValue)
        return newValue
    else
        return UserInterfaceVariables.LoadColor("DamageWindowOTHERGETDAMAGE_COLOR",  {
            r=255,
            g=255,
            b=0
        })
    end
end

function UserOverheadTextSettings.damagePlayerColor(newValue)
    if newValue ~= nil then
        UserInterfaceVariables.SaveColor("DamageWindowYOUGETAMAGE_COLOR", newValue)
        return newValue
    else
        return UserInterfaceVariables.LoadColor("DamageWindowYOUGETAMAGE_COLOR",  {
            r = 255,
            g = 0,
            b = 0
        })
    end
end

function UserOverheadTextSettings.damagePetColor(newValue)
    if newValue ~= nil then
        UserInterfaceVariables.SaveColor("DamageWindowPETGETDAMAGE_COLOR", newValue)
        return newValue
    else
        return UserInterfaceVariables.LoadColor("DamageWindowPETGETDAMAGE_COLOR",  {
            r = 255,
            g = 80,
            b = 255
        })
    end
end

function UserOverheadTextSettings.physicalColor(newValue)
    if newValue ~= nil then
        UserInterfaceVariables.SaveColor("SpellsInfoPHYSICAL", newValue)
        return newValue
    else
        return UserInterfaceVariables.LoadColor("SpellsInfoPHYSICAL",  {
            r = 168,
            g = 168,
            b = 168
        })
    end
end

function UserOverheadTextSettings.fireColor(newValue)
    if newValue ~= nil then
        UserInterfaceVariables.SaveColor("SpellsInfoFIRE", newValue)
        return newValue
    else
        return UserInterfaceVariables.LoadColor("SpellsInfoFIRE",  {
            r = 245,
            g = 155,
            b = 33
        })
    end
end

function UserOverheadTextSettings.coldColor(newValue)
    if newValue ~= nil then
        UserInterfaceVariables.SaveColor("SpellsInfoCOLD", newValue)
        return newValue
    else
        return UserInterfaceVariables.LoadColor("SpellsInfoCOLD",  {
            r = 28,
            g = 111,
            b = 234
        })
    end
end

function UserOverheadTextSettings.poisonColor(newValue)
    if newValue ~= nil then
        UserInterfaceVariables.SaveColor("SpellsInfoPOISON", newValue)
        return newValue
    else
        return UserInterfaceVariables.LoadColor("SpellsInfoPOISON",  {
            r = 63,
            g = 199,
            b = 73
        })
    end
end

function UserOverheadTextSettings.energyColor(newValue)
    if newValue ~= nil then
        UserInterfaceVariables.SaveColor("SpellsInfoENERGY", newValue)
        return newValue
    else
        return UserInterfaceVariables.LoadColor("SpellsInfoENERGY",  {
            r = 192,
            g = 69,
            b = 192
        })
    end
end

function UserOverheadTextSettings.chaosColor(newValue)
    if newValue ~= nil then
        UserInterfaceVariables.SaveColor("SpellsInfoChaos", newValue)
        return newValue
    else
        return UserInterfaceVariables.LoadColor("SpellsInfoChaos",  {
            r = 251,
            g = 30,
            b = 251
        })
    end
end