SettingsOverheadTextWindow = ListWindow:new(SettingsWindow.WINDOWS.OverheadText)

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
    SettingsOverheadTextWindow.adapter:addLabel(
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

    for _, value in pairs(COLOR_BUTTONS) do
        SettingsOverheadTextWindow.adapter:addWindow(
                value
        )
    end
end

function SettingsOverheadTextWindow.UpdateSettings()
    SettingsOverheadTextWindow.adapter.views[CHECK_BOXES.OverheadChat]:setChecked(
            UserOverheadTextSettings.showChat()
    )
    SettingsOverheadTextWindow.adapter.views[CHECK_BOXES.ClickableNames]:setChecked(
            UserOverheadTextSettings.clickableNames()
    )
    SettingsOverheadTextWindow.adapter.views[CHECK_BOXES.DisableSpells]:setChecked(
            UserOverheadTextSettings.disableSpells()
    )
    SettingsOverheadTextWindow.adapter.views[CHECK_BOXES.ShowSpellNames]:setChecked(
            UserOverheadTextSettings.showSpellNames()
    )
    SettingsOverheadTextWindow.adapter.views[CHECK_BOXES.NoPoisonOthers]:setChecked(
            UserOverheadTextSettings.disablePoison()
    )
    SettingsOverheadTextWindow.adapter.views[CHECK_BOXES.ShowCorpseNames]:setChecked(
            UserOverheadTextSettings.showCorpseNames()
    )
    SettingsOverheadTextWindow.adapter.views[COLOR_BUTTONS.Heal]:setColor(
            UserOverheadTextSettings.healColor()
    )
    SettingsOverheadTextWindow.adapter.views[COLOR_BUTTONS.Curse]:setColor(
            UserOverheadTextSettings.curseColor()
    )
    SettingsOverheadTextWindow.adapter.views[COLOR_BUTTONS.Paralyze]:setColor(
            UserOverheadTextSettings.paralyzeColor()
    )
    SettingsOverheadTextWindow.adapter.views[COLOR_BUTTONS.Neutral]:setColor(
            UserOverheadTextSettings.neutralColor()
    )
    SettingsOverheadTextWindow.adapter.views[COLOR_BUTTONS.Negative]:setColor(
            UserOverheadTextSettings.errorColor()
    )
    SettingsOverheadTextWindow.adapter.views[COLOR_BUTTONS.Positive]:setColor(
            UserOverheadTextSettings.specialColor()
    )
    SettingsOverheadTextWindow.adapter.views[COLOR_BUTTONS.PlayerDamage]:setColor(
            UserOverheadTextSettings.damagePlayerColor()
    )
    SettingsOverheadTextWindow.adapter.views[COLOR_BUTTONS.PetDamage]:setColor(
            UserOverheadTextSettings.damagePetColor()
    )
    SettingsOverheadTextWindow.adapter.views[COLOR_BUTTONS.EnemyDamage]:setColor(
            UserOverheadTextSettings.damageOtherColor()
    )
    SettingsOverheadTextWindow.adapter.views[COLOR_BUTTONS.Physical]:setColor(
            UserOverheadTextSettings.physicalColor()
    )
    SettingsOverheadTextWindow.adapter.views[COLOR_BUTTONS.Fire]:setColor(
            UserOverheadTextSettings.fireColor()
    )
    SettingsOverheadTextWindow.adapter.views[COLOR_BUTTONS.Cold]:setColor(
            UserOverheadTextSettings.coldColor()
    )
    SettingsOverheadTextWindow.adapter.views[COLOR_BUTTONS.Poison]:setColor(
            UserOverheadTextSettings.poisonColor()
    )
    SettingsOverheadTextWindow.adapter.views[COLOR_BUTTONS.Energy]:setColor(
            UserOverheadTextSettings.energyColor()
    )
    SettingsOverheadTextWindow.adapter.views[COLOR_BUTTONS.Chaos]:setColor(
            UserOverheadTextSettings.chaosColor()
    )
    SettingsOverheadTextWindow.adapter.views[COMBO_BOXES.Delay]:setSelectedItem(
            UserOverheadTextSettings.delay()
    )

    SettingsOverheadTextWindow.adapter.views[COMBO_BOXES.ShowNames]:findItem(
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
            SettingsOverheadTextWindow.adapter.views[CHECK_BOXES.ShowCorpseNames]:isChecked()
    )
    UserOverheadTextSettings.clickableNames(
            SettingsOverheadTextWindow.adapter.views[CHECK_BOXES.ClickableNames]:isChecked()
    )
    UserOverheadTextSettings.disableSpells(
            SettingsOverheadTextWindow.adapter.views[CHECK_BOXES.DisableSpells]:isChecked()
    )
    UserOverheadTextSettings.showSpellNames(
            SettingsOverheadTextWindow.adapter.views[CHECK_BOXES.ShowSpellNames]:isChecked()
    )
    UserOverheadTextSettings.disablePoison(
            SettingsOverheadTextWindow.adapter.views[CHECK_BOXES.NoPoisonOthers]:isChecked()
    )
    UserOverheadTextSettings.showChat(
            SettingsOverheadTextWindow.adapter.views[CHECK_BOXES.OverheadChat]:isChecked()
    )
    UserOverheadTextSettings.delay(
            SettingsOverheadTextWindow.adapter.views[COMBO_BOXES.Delay]:getSelectedItem()
    )
    UserOverheadTextSettings.showNames(
            TableFormatter.getValues(
                    UserOverheadTextSettings.ShowNamesOptions
            )[SettingsOverheadTextWindow.adapter.views[COMBO_BOXES.ShowNames]:getSelectedItem()]
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