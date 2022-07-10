InterfaceSettingsWindow = {}

InterfaceSettingsWindow.Name = SettingsWindow.Name .. "InterfacePage"

InterfaceSettingsWindow.Container = InterfaceSettingsWindow.Name .. "Container"

InterfaceSettingsWindow.Labels = {
    Mod = {
        name = InterfaceSettingsWindow.Container .. "ModLabel",
        text = 1079523
    },
    LegacyContainers = {
        name = InterfaceSettingsWindow.Container .. "LegacyContainersLabel",
        text = "Use Legacy Containers"
    },
    ObjectHandleFilter = {
        name = InterfaceSettingsWindow.Container .. "ObjectHandleLabel",
        text = 1079461
    }
}

InterfaceSettingsWindow.CheckBoxes = {
    LegacyContainers = {
        name = InterfaceSettingsWindow.Container .. "LegacyContainersCheckBox",
        setting = function(newValue)
            return  UserContainerSettings.legacyContainers(newValue)
        end
    }
}

InterfaceSettingsWindow.ComboBoxes = {
    Mod = {
        name = InterfaceSettingsWindow.Container .. "ModCombo",
        start = 1,
        list = function()
            local list = UserOptionsSettings.customUiList()
            list[1] = 3000094
            return list
        end,
        setting = function(newValue)
            return UserOptionsSettings.customUI(newValue)
        end
    },
    ObjectHandleFilter = {
        name = InterfaceSettingsWindow.Container .. "ObjectHandleCombo",
        start = 0,
        list = function ()
            return {
                1079457,
                1078368,
                1079458,
                1079459,
                1075672,
                1154804,
                1154805
            }
        end,
        setting = function (newValue)
            if newValue == nil then
                return UserOptionsSettings.objectHandleFilter() + 1
            else
                return UserOptionsSettings.objectHandleFilter(newValue - 1)
            end
        end
    }
}

function InterfaceSettingsWindow.onInitialize()
    for _, v in pairs(InterfaceSettingsWindow.Labels) do
        LabelApi.setText(
            v.name,
            v.text
        )
    end

    for _, v in pairs(InterfaceSettingsWindow.ComboBoxes) do
        --Handling combo boxes is a little bit confusing.
        --For some, their index needs to start at 0.
        --For some, the items are populated by hard-coded textIds.
        for i = 1, #v.list() do
            local item = v.list()[i]

            ComboBoxApi.addItem(
                v.name,
                item
            )

            if item == v.setting() or i == v.setting() then
                ComboBoxApi.setSelectedItem(
                    v.name,
                    i
                )
            end
        end
    end

    for _, v in pairs(InterfaceSettingsWindow.CheckBoxes) do
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

function InterfaceSettingsWindow.onComboBoxChanged(index)
    for _, v in pairs(InterfaceSettingsWindow.ComboBoxes) do
        if v.name == Active.window() then
            v.setting(index)
            EventApi.broadcast(Events.userSettingsUpdated())
            break
        end
    end
end

function InterfaceSettingsWindow.onInterfaceSettingChecked()
    for _, v in pairs(InterfaceSettingsWindow.CheckBoxes) do
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