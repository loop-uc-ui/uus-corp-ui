UserHealthBarsSettings = {}

function UserHealthBarsSettings.showStrLabel(newValue)
    if newValue ~= nil then
        SystemData.Settings.GameOptions.showStrLabel = newValue
    end
    return SystemData.Settings.GameOptions.showStrLabel
end

function UserHealthBarsSettings.showStatusButtons(newValue)
    if newValue ~= nil then
        UserInterfaceVariables.SaveBoolean("StatusButtons" , newValue)
        return newValue
    end
    return UserInterfaceVariables.LoadBoolean("StatusButtons", true)
end

function UserHealthBarsSettings.enableAura(newValue)
    if newValue ~= nil then
        UserInterfaceVariables.SaveBoolean("AuraEnabled", newValue)
        return newValue
    end
    return UserInterfaceVariables.LoadBoolean("AuraEnabled", true)
end

function UserHealthBarsSettings.enableMobileArrow(newValue)
    if newValue ~= nil then
        UserInterfaceVariables.SaveBoolean("EnableMobileArrow", newValue)
        return newValue
    end
    return UserInterfaceVariables.LoadBoolean("EnableMobileArrow", true)
end

function UserHealthBarsSettings.legacyCloseStyle(newValue)
    if newValue ~= nil then
        UserInterfaceVariables.SaveBoolean("LegacyCloseStyle", newValue)
        return newValue
    end
    return UserInterfaceVariables.LoadBoolean("LegacyCloseStyle", true)
end

function UserHealthBarsSettings.legacyPetCloseStyle(newValue)
    if newValue ~= nil then
        UserInterfaceVariables.SaveBoolean("PetLegacyCloseStyle", newValue)
        return newValue
    end
    return UserInterfaceVariables.LoadBoolean("PetLegacyCloseStyle", true)
end

function UserHealthBarsSettings.showWordOfDeath(newValue)
    if newValue ~= nil then
        UserInterfaceVariables.SaveBoolean("HealthBarWod", newValue)
        return newValue
    end
    return UserInterfaceVariables.LoadBoolean("HealthBarWod", true)
end

function UserHealthBarsSettings.showClose(newValue)
    if newValue ~= nil then
        UserInterfaceVariables.SaveBoolean("ShowCloseExtract", newValue)
        return newValue
    end
    return UserInterfaceVariables.LoadBoolean("ShowCloseExtract", true)
end

function UserHealthBarsSettings.redButtonSpell1(newValue)
    if newValue ~= nil then
        UserInterfaceVariables.SaveNumber("RedButton", newValue)
        return newValue
    end
    return UserInterfaceVariables.LoadNumber("RedButton", 29)
end

function UserHealthBarsSettings.redButtonSpell2(newValue)
    if newValue ~= nil then
        UserInterfaceVariables.SaveNumber("RedButton2", newValue)
        return newValue
    end
    return UserInterfaceVariables.LoadNumber("RedButton2", 59)
end

function UserHealthBarsSettings.redButtonSpell3(newValue)
    if newValue ~= nil then
        UserInterfaceVariables.SaveNumber("RedButton3", newValue)
        return newValue
    end
    return UserInterfaceVariables.LoadNumber("RedButton3", 0)
end

function UserHealthBarsSettings.blueButtonSpell1(newValue)
    if newValue ~= nil then
        UserInterfaceVariables.SaveNumber("BlueButton", newValue)
        return newValue
    end
    return UserInterfaceVariables.LoadNumber("BlueButton", 44)
end

function UserHealthBarsSettings.blueButtonSpell2(newValue)
    if newValue ~= nil then
        UserInterfaceVariables.SaveNumber("BlueButton2", newValue)
        return newValue
    end
    return UserInterfaceVariables.LoadNumber("BlueButton2", 6)
end

function UserHealthBarsSettings.blueButtonSpell3(newValue)
    if newValue ~= nil then
        UserInterfaceVariables.SaveNumber("BlueButton3", newValue)
        return newValue
    end
    return UserInterfaceVariables.LoadNumber("BlueButton3", 0)
end

function UserHealthBarsSettings.greenButtonSpell1(newValue)
    if newValue ~= nil then
        UserInterfaceVariables.SaveNumber("GreenButton", newValue)
        return newValue
    end
    return UserInterfaceVariables.LoadNumber("GreenButton", 25)
end

function UserHealthBarsSettings.greenButtonSpell2(newValue)
    if newValue ~= nil then
        UserInterfaceVariables.SaveNumber("GreenButton2", newValue)
        return newValue
    end
    return UserInterfaceVariables.LoadNumber("GreenButton2", 17)
end

function UserHealthBarsSettings.greenButtonSpell3(newValue)
    if newValue ~= nil then
        UserInterfaceVariables.SaveNumber("GreenButton3", newValue)
        return newValue
    end
    return UserInterfaceVariables.LoadNumber("GreenButton3", 0)
end