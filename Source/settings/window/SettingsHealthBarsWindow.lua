SettingsHealthBarsWindow = {}

local adapter = ViewAdapter:new("SettingsWindow", "SettingsHealthBarWindow")

local CHECK_BOXES = {
    ShowStrButton = "ShowStrButton",
    HealthBarButtons = "HealthbarsButtons",
    ToggleNotorietyAura = "ToggleNotorietyAuraButton",
    ToggleMobileArrow = "ToggleMobileArrowButton",
    LegacyCloseStyle = "LegacyCloseStyleButton",
    PetLegacyCloseStyle = "PetLegacyCloseStyleButton",
    ShowCloseExtract = "ShowCloseExtractButton",
    HealthBarWod = "HealthBarWodButton"
}

function SettingsHealthBarsWindow.Initialize()
    adapter:addLabel("HealthbarsOptionsStatusWindowSubSectionLabel", 1155313)
            :addLabel("HealthbarsOptionsButtonsSubSectionLabel", 1155323)
            :addLabel("HealthbarsOptionsSpellsButtonsSubSectionLabel", 1155332)
            :addLabel("HealthbarsOptionsSpellsButtonsSubSectionLabel", 1155332)
            :addLabel("ShowStrLabel",1079171)
            :addCheckBox(CHECK_BOXES.ShowStrButton)
            :addLabel("HealthbarsButtonsLabel", 1155317)
            :addCheckBox(CHECK_BOXES.HealthBarButtons)
            :addLabel("ToggleNotorietyAuraLabel", 1155319)
            :addCheckBox(CHECK_BOXES.ToggleNotorietyAura)
            :addLabel("ToggleMobileArrowLabel", 1155321)
            :addCheckBox(CHECK_BOXES.ToggleMobileArrow)
            :addLabel("LegacyCloseStyleLabel", 1155324)
            :addCheckBox(CHECK_BOXES.LegacyCloseStyle)
            :addLabel("PetLegacyCloseStyleLabel", 1155326)
            :addCheckBox(CHECK_BOXES.PetLegacyCloseStyle)
            :addLabel("ShowCloseExtractLabel", 1155328)
            :addCheckBox(CHECK_BOXES.ShowCloseExtract)
            :addLabel("HealthBarWodLabel", 1155330)
            :addCheckBox(CHECK_BOXES.HealthBarWod)
end

function SettingsHealthBarsWindow.UpdateSettings()
    ButtonSetPressedFlag( "ShowStrButton", SystemData.Settings.GameOptions.showStrLabel )
    ButtonSetPressedFlag( "HealthbarsButtons" .. "Button", Interface.StatusButtons )
    ButtonSetPressedFlag( "ToggleNotorietyAura" .. "Button", Interface.AuraEnabled )
    ButtonSetPressedFlag( "ToggleMobileArrow" .. "Button", Interface.EnableMobileArrow )
    ButtonSetPressedFlag( "LegacyCloseStyle" .. "Button", MobileHealthBar.LegacyCloseStyle )
    ButtonSetPressedFlag( "PetLegacyCloseStyle" .. "Button", MobileHealthBar.PetLegacyCloseStyle )
    ButtonSetPressedFlag( "ShowCloseExtract" .. "Button", Interface.ShowCloseExtract )
    ButtonSetPressedFlag( "HealthBarWod" .. "Button", Interface.HealthBarWod )

    ComboBoxClearMenuItems( "Red" )
    local sel = 1
    for i = 1 , table.getn(Interface.RedButtonSpells) do
        local _, _, tid, _ = GetAbilityData(Interface.RedButtonSpells[i].SpellId)
        if (tid) then
            ComboBoxAddMenuItem( "Red", wstring.sub(GetStringFromTid(tid),1,14)  )
        else
            ComboBoxAddMenuItem( "Red", wstring.sub(Interface.BlueButtonSpells[i].AltText,1,14)  )
        end
        if (Interface.RedButtonSpells[i].SpellId == Interface.RedButton) then
            sel = i
        end
    end
    ComboBoxSetSelectedMenuItem( "Red", sel )

    ComboBoxClearMenuItems( "Red2" )
    sel = 1
    for i = 1 , table.getn(Interface.RedButtonSpells) do
        local _, _, tid, _ = GetAbilityData(Interface.RedButtonSpells[i].SpellId)
        if (tid) then
            ComboBoxAddMenuItem( "Red2", wstring.sub(GetStringFromTid(tid),1,14)  )
        else
            ComboBoxAddMenuItem( "Red2", wstring.sub(Interface.BlueButtonSpells[i].AltText,1,14)  )
        end
        if (Interface.RedButtonSpells[i].SpellId == Interface.RedButton2) then
            sel = i
        end
    end
    ComboBoxSetSelectedMenuItem( "Red2", sel )

    ComboBoxClearMenuItems( "Red3" )
    sel = 1
    for i = 1 , table.getn(Interface.RedButtonSpells) do
        local _, _, tid, _ = GetAbilityData(Interface.RedButtonSpells[i].SpellId)
        if (tid) then
            ComboBoxAddMenuItem( "Red3", wstring.sub(GetStringFromTid(tid),1,14)  )
        else
            ComboBoxAddMenuItem( "Red3", wstring.sub(Interface.BlueButtonSpells[i].AltText,1,14)  )
        end
        if (Interface.RedButtonSpells[i].SpellId == Interface.RedButton3) then
            sel = i
        end
    end
    ComboBoxSetSelectedMenuItem( "Red3", sel )

    sel = 1
    ComboBoxClearMenuItems( "Green" )
    for i = 1 , table.getn(Interface.GreenButtonSpells) do
        local _, _, tid, _ = GetAbilityData(Interface.GreenButtonSpells[i].SpellId)
        if (tid) then
            ComboBoxAddMenuItem( "Green", wstring.sub(GetStringFromTid(tid),1,14)  )
        else
            ComboBoxAddMenuItem( "Green", wstring.sub(Interface.BlueButtonSpells[i].AltText,1,14)  )
        end
        if (Interface.GreenButtonSpells[i].SpellId == Interface.GreenButton) then
            sel = i
        end
    end
    ComboBoxSetSelectedMenuItem( "Green", sel )

    sel = 1
    ComboBoxClearMenuItems( "Green2" )
    for i = 1 , table.getn(Interface.GreenButtonSpells) do
        local _, _, tid, _ = GetAbilityData(Interface.GreenButtonSpells[i].SpellId)
        if (tid) then
            ComboBoxAddMenuItem( "Green2", wstring.sub(GetStringFromTid(tid),1,14)  )
        else
            ComboBoxAddMenuItem( "Green2", wstring.sub(Interface.BlueButtonSpells[i].AltText,1,14)  )
        end
        if (Interface.GreenButtonSpells[i].SpellId == Interface.GreenButton2) then
            sel = i
        end
    end
    ComboBoxSetSelectedMenuItem( "Green2", sel )

    sel = 1
    ComboBoxClearMenuItems( "Green3" )
    for i = 1 , table.getn(Interface.GreenButtonSpells) do
        local _, _, tid, _ = GetAbilityData(Interface.GreenButtonSpells[i].SpellId)
        if (tid) then
            ComboBoxAddMenuItem( "Green3", wstring.sub(GetStringFromTid(tid),1,14)  )
        else
            ComboBoxAddMenuItem( "Green3", wstring.sub(Interface.GreenButtonSpells[i].AltText,1,14)  )
        end
        if (Interface.GreenButtonSpells[i].SpellId == Interface.GreenButton3) then
            sel = i
        end
    end
    ComboBoxSetSelectedMenuItem( "Green3", sel )

    sel = 1
    ComboBoxClearMenuItems( "Blue" )
    for i = 1 , table.getn(Interface.BlueButtonSpells) do
        local _, _, tid, _ = GetAbilityData(Interface.BlueButtonSpells[i].SpellId)
        if (tid) then
            ComboBoxAddMenuItem( "Blue", wstring.sub(GetStringFromTid(tid),1,14)  )
        else
            ComboBoxAddMenuItem( "Blue", wstring.sub(Interface.BlueButtonSpells[i].AltText,1,14)  )
        end
        if (Interface.BlueButtonSpells[i].SpellId == Interface.BlueButton) then
            sel = i
        end
    end
    ComboBoxSetSelectedMenuItem( "Blue", sel )

    sel = 1
    ComboBoxClearMenuItems( "Blue2" )
    for i = 1 , table.getn(Interface.BlueButtonSpells) do
        local _, _, tid, _ = GetAbilityData(Interface.BlueButtonSpells[i].SpellId)
        if (tid) then
            ComboBoxAddMenuItem( "Blue2", wstring.sub(GetStringFromTid(tid),1,14)  )
        else
            ComboBoxAddMenuItem( "Blue2", wstring.sub(Interface.BlueButtonSpells[i].AltText,1,14)  )
        end
        if (Interface.BlueButtonSpells[i].SpellId == Interface.BlueButton2) then
            sel = i
        end
    end
    ComboBoxSetSelectedMenuItem( "Blue2", sel )

    sel = 1
    ComboBoxClearMenuItems( "Blue3" )
    for i = 1 , table.getn(Interface.BlueButtonSpells) do
        local _, _, tid, _ = GetAbilityData(Interface.BlueButtonSpells[i].SpellId)
        if (tid) then
            ComboBoxAddMenuItem( "Blue3", wstring.sub(GetStringFromTid(tid),1,14)  )
        else
            ComboBoxAddMenuItem( "Blue3", wstring.sub(Interface.BlueButtonSpells[i].AltText,1,14)  )
        end
        if (Interface.BlueButtonSpells[i].SpellId == Interface.BlueButton3) then
            sel = i
        end
    end
    ComboBoxSetSelectedMenuItem( "Blue3", sel )
end

function SettingsHealthBarsWindow.OnApplyButton()
    SystemData.Settings.GameOptions.showStrLabel = ButtonGetPressedFlag( "ShowStrButton" )
    Interface.SaveBoolean( "StatusLabels", SystemData.Settings.GameOptions.showStrLabel )

    Interface.StatusButtons = ButtonGetPressedFlag( "HealthbarsButtons" .. "Button" )
    Interface.SaveBoolean( "StatusButtons" , Interface.StatusButtons )
    StatusWindow.ToggleButtons()

    Interface.AuraEnabled = ButtonGetPressedFlag( "ToggleNotorietyAura" .. "Button" )
    Interface.SaveBoolean( "AuraEnabled" , Interface.AuraEnabled )

    Interface.EnableMobileArrow = ButtonGetPressedFlag( "ToggleMobileArrow" .. "Button" )
    Interface.SaveBoolean( "EnableMobileArrow" , Interface.EnableMobileArrow )
    if (DoesWindowNameExist("MobileArrow") and not Interface.EnableMobileArrow) then
        DetachWindowFromWorldObject( Interface.MobileArrowOver, "MobileArrow" )
        DestroyWindow("MobileArrow")
    end

    MobileHealthBar.LegacyCloseStyle =	ButtonGetPressedFlag( "LegacyCloseStyle" .. "Button" )
    Interface.SaveBoolean( "LegacyCloseStyle", MobileHealthBar.LegacyCloseStyle )
    MobileHealthBar.PetLegacyCloseStyle =	ButtonGetPressedFlag( "PetLegacyCloseStyle" .. "Button" )
    Interface.SaveBoolean( "PetLegacyCloseStyle", MobileHealthBar.PetLegacyCloseStyle )

    local updateHotbars = Interface.ShowCloseExtract ~=	ButtonGetPressedFlag( "ShowCloseExtract" .. "Button" )
    Interface.ShowCloseExtract =	ButtonGetPressedFlag( "ShowCloseExtract" .. "Button" )
    Interface.SaveBoolean( "ShowCloseExtract", Interface.ShowCloseExtract )

    updateHealthbars = updateHotbars or Interface.PetLegacyCloseStyle ~= ButtonGetPressedFlag( "HealthBarWod" .. "Button" )
    Interface.PetLegacyCloseStyle =	ButtonGetPressedFlag( "HealthBarWod" .. "Button" )
    Interface.SaveBoolean( "HealthBarWod", Interface.HealthBarWod )

    local i = ComboBoxGetSelectedMenuItem( "Red" )
    Interface.RedButton = Interface.RedButtonSpells[i].SpellId
    Interface.SaveNumber( "RedButton", Interface.RedButton )

    i = ComboBoxGetSelectedMenuItem( "Red2" )
    Interface.RedButton2 = Interface.RedButtonSpells[i].SpellId
    Interface.SaveNumber( "RedButton2", Interface.RedButton2 )

    i = ComboBoxGetSelectedMenuItem( "Red3" )
    Interface.RedButton3 = Interface.RedButtonSpells[i].SpellId
    Interface.SaveNumber( "RedButton3", Interface.RedButton3 )

    i = ComboBoxGetSelectedMenuItem( "Green" )
    Interface.GreenButton = Interface.GreenButtonSpells[i].SpellId
    Interface.SaveNumber( "GreenButton", Interface.GreenButton )

    i = ComboBoxGetSelectedMenuItem( "Green2" )
    Interface.GreenButton2 = Interface.GreenButtonSpells[i].SpellId
    Interface.SaveNumber( "GreenButton2", Interface.GreenButton2 )

    i = ComboBoxGetSelectedMenuItem( "Green3" )
    Interface.GreenButton3 = Interface.GreenButtonSpells[i].SpellId
    Interface.SaveNumber( "GreenButton3", Interface.GreenButton3 )

    i = ComboBoxGetSelectedMenuItem( "Blue" )
    Interface.BlueButton = Interface.BlueButtonSpells[i].SpellId
    Interface.SaveNumber( "BlueButton", Interface.BlueButton )

    i = ComboBoxGetSelectedMenuItem( "Blue2" )
    Interface.BlueButton2 = Interface.BlueButtonSpells[i].SpellId
    Interface.SaveNumber( "BlueButton2", Interface.BlueButton2 )

    i = ComboBoxGetSelectedMenuItem( "Blue3" )
    Interface.BlueButton3 = Interface.BlueButtonSpells[i].SpellId
    Interface.SaveNumber( "BlueButton3", Interface.BlueButton3 )

    if (updateHealthbars) then
        for key, _ in pairs(MobileHealthBar.hasWindow) do
            MobileHealthBar.UpdateStatus(key)
        end
    end
end