SettingsOverheadTextWindow = {}

local ShowNames = {
    1011051,
    1078090,
    1078091
}

local DelayValues = {
    1078334,
    1078336,
    1078337,
    1078338,
    1078339,
    1078340
}

local adapter = ViewAdapter:new("OverheadTextOptions", "OverheadTextOptions")

local CHECK_BOXES = {
    ClickableNames = "clickableNamesButton",
    ShowCorpseNames = "ShowCorpseNamesButton",
    DisableSpells = "DisableSpellsButton",
    ShowSpellNames = "ShowSpellNameButton",
    NoPoisonOthers = "noPoisonOthersButton",
    OverheadChat = "OverheadChatButton"
}

local COLOR_BUTTONS = {
    Heal = "OverheadTextOptionscolorHealButton",
    Curse = "OverheadTextOptionscolorCurseButton",
    Paralyze = "OverheadTextOptionscolorParaButton",
    Neutral = "OverheadTextOptionscolorNeutralButton",
    Negative = "OverheadTextOptionscolorNegButton",
    Positive = "OverheadTextOptionscolorPosButton",
    PlayerDamage = "OverheadTextOptionscolorYouButton",
    PetDamage = "OverheadTextOptionscolorPetButton",
    EnemyDamage = "OverheadTextOptionscolorEnemyButton",
    Physical = "OverheadTextOptionscolorPhysButton",
    Fire = "OverheadTextOptionscolorFireButton",
    Cold = "OverheadTextOptionscolorColdButton",
    Poison = "OverheadTextOptionscolorPoisButton",
    Energy = "OverheadTextOptionscolorEnerButton",
    Chaos = "OverheadTextOptionscolorChaosButton"
}

local COMBO_BOXES = {
    Delay = "OverheadChatFadeDelayCombo",
    ShowNames = "SettingsOptionsShowNamesCombo"
}

function SettingsOverheadTextWindow.Initialize()
    adapter:addLabel(
            "OverheadTextOptionsOTSubSectionLabel",
            1155333
    ):addLabel(
            "OverheadTextOptionsColorsSubSectionLabel",
            1155351
    ):addLabel(
            "clickableNamesLabel",
            1155340
    ):addCheckBox(
            CHECK_BOXES.ClickableNames
    ):addLabel(
            "ShowCorpseNamesLabel",
            1115927
    ):addCheckBox(
            CHECK_BOXES.ShowCorpseNames
    ):addLabel(
            "DisableSpellsLabel",
            1155334
    ):addCheckBox(
            CHECK_BOXES.DisableSpells
    ):addLabel(
            "ShowSpellNameLabel",
            1155336
    ):addCheckBox(
            CHECK_BOXES.ShowSpellNames
    ):addLabel(
            "noPoisonOthersLabel",
            1155338
    ):addCheckBox(
            CHECK_BOXES.NoPoisonOthers
    ):addLabel(
            "OverheadChatLabel",
            1078083
    ):addCheckBox(
            CHECK_BOXES.OverheadChat
    ):addButton(
            "OverheadTextSizePlus",
            1155341
    ):addButton(
            "OverheadTextSizeMinus",
            1155342
    ):addButton(
            "OverheadChatFont",
            1155343
    ):addButton(
            "OverheadNamesFont",
            1155344
    ):addButton(
            "OverheadSpellFont",
            1155345
    ):addButton(
            "OverheadDamageFont",
            1155346
    ):addLabel(
            "OverheadTextOptionscolorHealLabel",
            1155352
    ):addLabel(
            "OverheadTextOptionscolorCurseLabel",
            1155353
    ):addLabel(
            "OverheadTextOptionscolorParaLabel",
            1155354
    ):addLabel(
            "OverheadTextOptionscolorNeutralLabel",
            1155355
    ):addLabel(
            "OverheadTextOptionscolorNegLabel",
            1155356
    ):addLabel(
            "OverheadTextOptionscolorPosLabel",
            1155357
    ):addLabel(
            "OverheadTextOptionscolorYouLabel",
            1155358
    ):addLabel(
            "OverheadTextOptionscolorPetLabel",
            1155359
    ):addLabel(
            "OverheadTextOptionscolorEnemyLabel",
            1155360
    ):addLabel(
            "OverheadTextOptionscolorPhysLabel",
            1155361
    ):addLabel(
            "OverheadTextOptionscolorFireLabel",
            1155362
    ):addLabel(
            "OverheadTextOptionscolorColdLabel",
            1155363
    ):addLabel(
            "OverheadTextOptionscolorPoisLabel",
            1155364
    ):addLabel(
            "OverheadTextOptionscolorEnerLabel",
            1155365
    ):addLabel(
            "OverheadTextOptionscolorChaosLabel",
            1155366
    ):addLabel(
            "OverheadChatFadeDelayLabel",
            1078084
    ):addComboBox(
            COMBO_BOXES.Delay,
            DelayValues
    ):addLabel(
            "SettingsOptionsShowNamesLabel",
            1078093
    ):addComboBox(
            COMBO_BOXES.ShowNames,
            ShowNames
    )
end

function SettingsOverheadTextWindow.UpdateSettings()
    adapter.views[CHECK_BOXES.OverheadChat]:setChecked(
            UserOverheadTextSettings.showChat()
    )
    adapter.views[CHECK_BOXES.ClickableNames]:setChecked(
            UserOverheadTextSettings.clickableNames()
    )
    adapter.views[CHECK_BOXES.DisableSpells]:setChecked(
            UserOverheadTextSettings.disableSpells()
    )
    adapter.views[CHECK_BOXES.ShowSpellNames]:setChecked(
            UserOverheadTextSettings.showSpellNames()
    )
    adapter.views[CHECK_BOXES.NoPoisonOthers]:setChecked(
            UserOverheadTextSettings.disablePoison()
    )
    adapter.views[CHECK_BOXES.ShowCorpseNames]:setChecked(
            UserOverheadTextSettings.showCorpseNames()
    )

    adapter:setColor(
            COLOR_BUTTONS.Heal,
            UserOverheadTextSettings.healColor()
    ):setColor(
            COLOR_BUTTONS.Curse,
            UserOverheadTextSettings.curseColor()
    ):setColor(
            COLOR_BUTTONS.Paralyze,
            UserOverheadTextSettings.paralyzeColor()
    ):setColor(
            COLOR_BUTTONS.Neutral,
            UserOverheadTextSettings.neutralColor()
    ):setColor(
            COLOR_BUTTONS.Negative,
            UserOverheadTextSettings.errorColor()
    ):setColor(
            COLOR_BUTTONS.Positive,
            UserOverheadTextSettings.specialColor()
    ):setColor(
            COLOR_BUTTONS.PlayerDamage,
            UserOverheadTextSettings.damagePlayerColor()
    ):setColor(
            COLOR_BUTTONS.PetDamage,
            UserOverheadTextSettings.damagePetColor()
    ):setColor(
            COLOR_BUTTONS.EnemyDamage,
            UserOverheadTextSettings.damageOtherColor()
    ):setColor(
            COLOR_BUTTONS.Physical,
            UserOverheadTextSettings.physicalColor()
    ):setColor(
            COLOR_BUTTONS.Fire,
            UserOverheadTextSettings.fireColor()
    ):setColor(
            COLOR_BUTTONS.Cold,
            UserOverheadTextSettings.coldColor()
    ):setColor(
            COLOR_BUTTONS.Poison,
            UserOverheadTextSettings.poisonColor()
    ):setColor(
            COLOR_BUTTONS.Energy,
            UserOverheadTextSettings.energyColor()
    ):setColor(
            COLOR_BUTTONS.Chaos,
            UserOverheadTextSettings.chaosColor()
    )

    adapter.views[COMBO_BOXES.Delay]:setSelectedItem(
            UserOverheadTextSettings.delay()
    )

    adapter.views[COMBO_BOXES.ShowNames]:findItem(
            function(self, item)
                return TableFormatter.indexOf(self.items, item) == TableFormatter.indexOf(
                        UserOverheadTextSettings.ShowNamesOptions,
                        UserOverheadTextSettings.showNames()
                )
            end
    )
end

function SettingsOverheadTextWindow.OnApplyButton()
    UserOverheadTextSettings.showCorpseNames(
            adapter.views[CHECK_BOXES.ShowCorpseNames]:isChecked()
    )
    UserOverheadTextSettings.clickableNames(
            adapter.views[CHECK_BOXES.ClickableNames]:isChecked()
    )
    UserOverheadTextSettings.disableSpells(
            adapter.views[CHECK_BOXES.DisableSpells]:isChecked()
    )
    UserOverheadTextSettings.showSpellNames(
            adapter.views[CHECK_BOXES.ShowSpellNames]:isChecked()
    )
    UserOverheadTextSettings.disablePoison(
            adapter.views[CHECK_BOXES.NoPoisonOthers]:isChecked()
    )
    UserOverheadTextSettings.showChat(
            adapter.views[CHECK_BOXES.OverheadChat]:isChecked()
    )
    UserOverheadTextSettings.delay(
            adapter.views[COMBO_BOXES.Delay]:getSelectedItem()
    )
    UserOverheadTextSettings.showNames(
            UserOverheadTextSettings.ShowNamesOptions[adapter.views[COMBO_BOXES.ShowNames]:getSelectedItem()]
    )

    --TODO refactor this
    OverheadText.UpdateSettings()
end

function SettingsOverheadTextWindow.IncreaseTextSize()
    OverheadText.OverhedTextSize = OverheadText.OverhedTextSize + 0.1
    if (OverheadText.OverhedTextSize > 1.5) then
        OverheadText.OverhedTextSize = 1.5
    end
    UserOverheadTextSettings.textSize(OverheadText.OverhedTextSize)
end

function SettingsOverheadTextWindow.DecreaseTextSize()
    OverheadText.OverhedTextSize = OverheadText.OverhedTextSize - 0.1
    if (OverheadText.OverhedTextSize < 0.5) then
        OverheadText.OverhedTextSize = 0.5
    end
    UserOverheadTextSettings.textSize(OverheadText.OverhedTextSize)
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