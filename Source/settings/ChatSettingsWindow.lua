ChatSettingsWindow = {}

ChatSettingsWindow.Name = SettingsWindow.Name .. "ChatPage"

ChatSettingsWindow.Container = ChatSettingsWindow.Name .. "Container"

ChatSettingsWindow.Labels = {
    DisableSpells = {
        name = ChatSettingsWindow.Container .. "DisableSpellsLabel",
        text = 1155334
    },
    ShowSpellName = {
        name = ChatSettingsWindow.Container .. "ShowSpellNameLabel",
        text = 1155336
    },
    DisablePoisonText = {
        name = ChatSettingsWindow.Container .. "DisablePoisonTextLabel",
        text = 1155338
    },
    SaveJournal = {
        name = ChatSettingsWindow.Container .. "SaveJournalLabel",
        text = 1149998
    },
    ShowOverheadChat = {
        name = ChatSettingsWindow.Container .. "ShowOverheadChatLabel",
        text = 1078083
    },
    ShowCorpseNames = {
        name = ChatSettingsWindow.Container .. "ShowCorpseNamesLabel",
        text = 1115927
    }
}

ChatSettingsWindow.CheckBoxes = {
    DisableSpells = {
        name = ChatSettingsWindow.Container .. "DisableSpellsCheckBox",
        setting = function(newValue)
            return UserOverheadTextSettings.disableSpells(newValue)
        end
    },
    ShowSpellName = {
        name = ChatSettingsWindow.Container .. "ShowSpellNameCheckBox",
        setting = function(newValue)
            return UserOverheadTextSettings.showSpellNames(newValue)
        end
    },
    DisablePoisonText = {
        name = ChatSettingsWindow.Container .. "DisablePoisonTextCheckBox",
        setting = function(newValue)
            return UserOverheadTextSettings.disablePoison(newValue)
        end
    },
    SaveJournal = {
        name = ChatSettingsWindow.Container .. "SaveJournalCheckBox",
        setting = function(newValue)
            return UserOptionsSettings.enableChatLog(newValue)
        end
    },
    ShowOverheadChat = {
        name = ChatSettingsWindow.Container .. "ShowOverheadChatCheckBox",
        setting = function(newValue)
            return UserOverheadTextSettings.showChat(newValue)
        end
    },
    ShowCorpseNames = {
        name = ChatSettingsWindow.Container .. "ShowCorpseNamesCheckBox",
        setting = function(newValue)
            return UserOverheadTextSettings.showCorpseNames(newValue)
        end
    }
}

function ChatSettingsWindow.onInitialize()
    for _, v in pairs(ChatSettingsWindow.Labels) do
        LabelApi.setText(
            v.name,
            v.text
        )
    end

    for _, v in pairs(ChatSettingsWindow.CheckBoxes) do
        ButtonApi.setChecked(
            v.name,
            v.setting()
        )
        ButtonApi.setStayDown(
            v.name,
            true
        )
    end
end

function ChatSettingsWindow.onChatSettingChecked()
    for _, v in pairs(ChatSettingsWindow.CheckBoxes) do
        if v.name == Active.window() then
            v.setting(not v.setting())
            ButtonApi.setChecked(
                v.name,
                v.setting()
            )
            EventApi.broadcast(Events.userSettingsUpdated())
            break
        end
    end
end