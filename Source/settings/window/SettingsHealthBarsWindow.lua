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

local COMBO_BOXES = {
    Red = "Red",
    Red2 = "Red2",
    Red3 = "Red3",
    Blue = "Blue",
    Blue2 = "Blue2",
    Blue3 = "Blue3",
    Green = "Green",
    Green2 = "Green2",
    Green3 = "Green3"
}

--TODO refactor this
local SPELLS = {
    [1] = { SpellId = 0; AltText = StringFormatter.fromTid(1011051)};
    [2] = { SpellId = 1; AltText = StringFormatter.fromTid(1015164)};
    [3] = { SpellId = 3; AltText = StringFormatter.fromTid(1015166)};
    [4] = { SpellId = 8; AltText = StringFormatter.fromTid(1015170)};
    [5] = { SpellId = 27; AltText = StringFormatter.fromTid(1015188)};

    [6] = { SpellId = 9; AltText = StringFormatter.fromTid(1027989)};
    [7] = { SpellId = 10; AltText = StringFormatter.fromTid(1027990)};
    [8] = { SpellId = 16; AltText = StringFormatter.fromTid(1027996)};
    [9] = { SpellId = 17; AltText = StringFormatter.fromTid(1027997)};

    [10] = { SpellId = 11; AltText = StringFormatter.fromTid(1027991)};
    [11] = { SpellId = 25; AltText = StringFormatter.fromTid(1028005)};

    [12] = { SpellId = 4; AltText = StringFormatter.fromTid(1027985)};
    [13] = { SpellId = 29; AltText = StringFormatter.fromTid(1028009)};
    [14] = { SpellId = 59; AltText = StringFormatter.fromTid(1028039)};

    [15] = { SpellId = 201; AltText = StringFormatter.fromTid(1028828)};
    [16] = { SpellId = 202; AltText = StringFormatter.fromTid(1028829)};
    [17] = { SpellId = 209; AltText = StringFormatter.fromTid(1060501)};

    [18] = { SpellId = 102; AltText = StringFormatter.fromTid(1060510)};
    [19] = { SpellId = 103; AltText = StringFormatter.fromTid(1060511)};
    [20] = { SpellId = 105; AltText = StringFormatter.fromTid(1060513)};
    [21] = { SpellId = 108; AltText = StringFormatter.fromTid(1060516)};

    [22] = { SpellId = 602; AltText = StringFormatter.fromTid(1071027)};
    [23] = { SpellId = 615; AltText = StringFormatter.fromTid(1071040)};

    [24] = { SpellId = 680; AltText = StringFormatter.fromTid(1031680)};
    [25] = { SpellId = 682; AltText = StringFormatter.fromTid(1031682)};
    [26] = { SpellId = 687; AltText = StringFormatter.fromTid(1031687)};
    [27] = { SpellId = 688; AltText = StringFormatter.fromTid(1031688)};

    [28] = { SpellId = 0; AltText = StringFormatter.fromTid(1011051)};
    [29] = { SpellId = 6; AltText = StringFormatter.fromTid(1044387)};
    [30] = { SpellId = 44; AltText = StringFormatter.fromTid(1044424)};

    [31] = { SpellId = 5; AltText = StringFormatter.fromTid(1044386)};
    [32] = { SpellId = 12; AltText = StringFormatter.fromTid(1044392)};
    [33] = { SpellId = 18; AltText = StringFormatter.fromTid(1044398)};
    [34] = { SpellId = 30; AltText = StringFormatter.fromTid(1044410)};
    [35] = { SpellId = 37; AltText = StringFormatter.fromTid(1044417)};
    [36] = { SpellId = 38; AltText = StringFormatter.fromTid(1044418)};
    [37] = { SpellId = 41; AltText = StringFormatter.fromTid(1044421)};
    [38] = { SpellId = 42; AltText = StringFormatter.fromTid(1044422)};
    [39] = { SpellId = 43; AltText = StringFormatter.fromTid(1044423)};
    [40] = { SpellId = 49; AltText = StringFormatter.fromTid(1044429)};
    [41] = { SpellId = 51; AltText = StringFormatter.fromTid(1044431)};
    [42] = { SpellId = 55; AltText = StringFormatter.fromTid(1044435)};

    [43] = { SpellId = 109; AltText = StringFormatter.fromTid(1060517)};
    [44] = { SpellId = 110; AltText = StringFormatter.fromTid(1060518)};
    [45] = { SpellId = 111; AltText = StringFormatter.fromTid(1060519)};

    [46] = { SpellId = 614; AltText = StringFormatter.fromTid(1071039)};

    [47] = { SpellId = 678; AltText = StringFormatter.fromTid(1031678)};
    [48] = { SpellId = 683; AltText = StringFormatter.fromTid(1031683)};
    [49] = { SpellId = 689; AltText = StringFormatter.fromTid(1031689)};
    [50] = { SpellId = 690; AltText = StringFormatter.fromTid(1031690)};
    [51] = { SpellId = 691; AltText = StringFormatter.fromTid(1031691)};
    [52] = { SpellId = 692; AltText = StringFormatter.fromTid(1031692)};
    [53] = { SpellId = 209; AltText = StringFormatter.fromTid(1060501)};
}

local SPELL_TEXT = {} do
    for i = 1, #SPELLS do
        local _, _, text, _ = GetAbilityData(SPELLS[i].SpellId)
        if text ~= nil then
            table.insert(SPELL_TEXT, StringFormatter.fromTid(text))
        else
            table.insert(SPELL_TEXT, SPELLS[i].AltText)
        end
    end
end

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
            :addComboBox(COMBO_BOXES.Red, SPELL_TEXT)
            :addComboBox(COMBO_BOXES.Red2, SPELL_TEXT)
            :addComboBox(COMBO_BOXES.Red3, SPELL_TEXT)
            :addComboBox(COMBO_BOXES.Blue, SPELL_TEXT)
            :addComboBox(COMBO_BOXES.Blue2, SPELL_TEXT)
            :addComboBox(COMBO_BOXES.Blue3, SPELL_TEXT)
            :addComboBox(COMBO_BOXES.Green, SPELL_TEXT)
            :addComboBox(COMBO_BOXES.Green2, SPELL_TEXT)
            :addComboBox(COMBO_BOXES.Green3, SPELL_TEXT)
end

function SettingsHealthBarsWindow.UpdateSettings()
    adapter.views[CHECK_BOXES.ShowStrButton]:setChecked(UserHealthBarsSettings.showStrLabel())
    adapter.views[CHECK_BOXES.HealthBarButtons]:setChecked(UserHealthBarsSettings.showStatusButtons())
    adapter.views[CHECK_BOXES.ToggleNotorietyAura]:setChecked(UserHealthBarsSettings.enableAura())
    adapter.views[CHECK_BOXES.ToggleMobileArrow]:setChecked(UserHealthBarsSettings.enableMobileArrow())
    adapter.views[CHECK_BOXES.LegacyCloseStyle]:setChecked(UserHealthBarsSettings.legacyCloseStyle())
    adapter.views[CHECK_BOXES.PetLegacyCloseStyle]:setChecked(UserHealthBarsSettings.legacyPetCloseStyle())
    adapter.views[CHECK_BOXES.ShowCloseExtract]:setChecked(UserHealthBarsSettings.showClose())
    adapter.views[CHECK_BOXES.HealthBarWod]:setChecked(UserHealthBarsSettings.showWordOfDeath())

    adapter.views[COMBO_BOXES.Red]:findItem(
            function (item)
                return SPELLS[TableFormatter.indexOf(SPELL_TEXT, item)].SpellId == UserHealthBarsSettings.redButtonSpell1()
            end
    )
    adapter.views[COMBO_BOXES.Red2]:findItem(
            function (item)
                return SPELLS[TableFormatter.indexOf(SPELL_TEXT, item)].SpellId == UserHealthBarsSettings.redButtonSpell2()
            end
    )
    adapter.views[COMBO_BOXES.Red3]:findItem(
            function (item)
                return SPELLS[TableFormatter.indexOf(SPELL_TEXT, item)].SpellId == UserHealthBarsSettings.redButtonSpell3()
            end
    )

    adapter.views[COMBO_BOXES.Blue]:findItem(
            function (item)
                return SPELLS[TableFormatter.indexOf(SPELL_TEXT, item)].SpellId == UserHealthBarsSettings.blueButtonSpell1()
            end
    )
    adapter.views[COMBO_BOXES.Blue2]:findItem(
            function (item)
                return SPELLS[TableFormatter.indexOf(SPELL_TEXT, item)].SpellId == UserHealthBarsSettings.blueButtonSpell2()
            end
    )
    adapter.views[COMBO_BOXES.Blue3]:findItem(
            function (item)
                return SPELLS[TableFormatter.indexOf(SPELL_TEXT, item)].SpellId == UserHealthBarsSettings.blueButtonSpell3()
            end
    )

    adapter.views[COMBO_BOXES.Green]:findItem(
            function (item)
                return SPELLS[TableFormatter.indexOf(SPELL_TEXT, item)].SpellId == UserHealthBarsSettings.greenButtonSpell1()
            end
    )
    adapter.views[COMBO_BOXES.Green2]:findItem(
            function (item)
                return SPELLS[TableFormatter.indexOf(SPELL_TEXT, item)].SpellId == UserHealthBarsSettings.greenButtonSpell2()
            end
    )
    adapter.views[COMBO_BOXES.Green3]:findItem(
            function (item)
                return SPELLS[TableFormatter.indexOf(SPELL_TEXT, item)].SpellId == UserHealthBarsSettings.greenButtonSpell3()
            end
    )
end

function SettingsHealthBarsWindow.OnApplyButton()
    UserHealthBarsSettings.showStrLabel(adapter.views[CHECK_BOXES.ShowStrButton]:isChecked())
    UserHealthBarsSettings.showStatusButtons(adapter.views[CHECK_BOXES.HealthBarButtons]:isChecked())
    StatusWindow.ToggleButtons()

    UserHealthBarsSettings.enableAura(adapter.views[CHECK_BOXES.ToggleNotorietyAura]:isChecked())
    UserHealthBarsSettings.enableMobileArrow(adapter.views[CHECK_BOXES.ToggleMobileArrow]:isChecked())

    if (DoesWindowNameExist("MobileArrow") and not Interface.EnableMobileArrow) then
        DetachWindowFromWorldObject( Interface.MobileArrowOver, "MobileArrow" )
        DestroyWindow("MobileArrow")
    end

    UserHealthBarsSettings.legacyCloseStyle(adapter.views[CHECK_BOXES.LegacyCloseStyle]:isChecked())
    UserHealthBarsSettings.legacyPetCloseStyle(adapter.views[CHECK_BOXES.PetLegacyCloseStyle]:isChecked())

    local isChecked = adapter.views[CHECK_BOXES.ShowCloseExtract]:isChecked()
    local updateHotbars = UserHealthBarsSettings.showClose() ~=	isChecked
    UserHealthBarsSettings.showClose(isChecked)

    isChecked = adapter.views[CHECK_BOXES.HealthBarWod]:isChecked()
    local updateHealthbars = updateHotbars or UserHealthBarsSettings.showWordOfDeath() ~= isChecked
    UserHealthBarsSettings.showWordOfDeath(isChecked)

    UserHealthBarsSettings.redButtonSpell1(
            SPELLS[adapter.views[COMBO_BOXES.Red]:getSelectedItem()].SpellId
    )
    UserHealthBarsSettings.redButtonSpell2(
            SPELLS[adapter.views[COMBO_BOXES.Red2]:getSelectedItem()].SpellId
    )
    UserHealthBarsSettings.redButtonSpell3(
            SPELLS[adapter.views[COMBO_BOXES.Red3]:getSelectedItem()].SpellId
    )

    UserHealthBarsSettings.greenButtonSpell1(
            SPELLS[adapter.views[COMBO_BOXES.Green]:getSelectedItem()].SpellId
    )
    UserHealthBarsSettings.greenButtonSpell2(
            SPELLS[adapter.views[COMBO_BOXES.Green2]:getSelectedItem()].SpellId
    )
    UserHealthBarsSettings.greenButtonSpell3(
            SPELLS[adapter.views[COMBO_BOXES.Green3]:getSelectedItem()].SpellId
    )

    UserHealthBarsSettings.blueButtonSpell1(
            SPELLS[adapter.views[COMBO_BOXES.Blue]:getSelectedItem()].SpellId
    )
    UserHealthBarsSettings.blueButtonSpell2(
            SPELLS[adapter.views[COMBO_BOXES.Blue2]:getSelectedItem()].SpellId
    )
    UserHealthBarsSettings.blueButtonSpell3(
            SPELLS[adapter.views[COMBO_BOXES.Blue3]:getSelectedItem()].SpellId
    )
    
    if (updateHealthbars) then
        for key, _ in pairs(MobileHealthBar.hasWindow) do
            MobileHealthBar.UpdateStatus(key)
        end
    end
end