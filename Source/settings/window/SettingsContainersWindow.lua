SettingsContainersWindow = ListWindow:new(SettingsWindow.WINDOWS.Containers)

local ComboBoxes = {
    ContainerView = "ContainerViewCombo",
    CorpseView = "CorpseViewCombo",
    BackpackStyle = "SettingsLegacyBackpackStyleCombo"
}

local CheckBoxes = {
    ToggleGrid = "ToggleGridButton",
    ToggleAlternateGrid = "ToggleAlternateGridButton",
    ToggleExtraBright = "ToggleExtraBrightButton",
    UseLegacyContainers = "SettingsLegacyUseLegacyContainersButton"
}

local ColorButtons = {
    GridColor = "ContainerGridColorButton",
    AlternateColor = "ContainerGridAlternateColorButton"
}

local isGridContainer = true
local isExtraBrightContainer = false
local isAlternateGrid = false
local isUseLegacyContainers = false
local currentBackPackStyle = UserContainerSettings.LegacyBackpackStyles[1]

local function ResizeContainers()
    for id, _ in pairs(ContainerWindow.OpenContainers) do
        ContainerWindow.LegacyGridDock("ContainerWindow_"..id)
    end
end

function SettingsContainersWindow.Initialize()
    local containerViewOptions = {
        1079825,
        1079824
    }

    local backpackStyles = {
        1157260, --Default
        1157261, --Suede
        1157262, --Polar Bear
        1157263 --Ghoul Skin
    }

    SettingsContainersWindow.adapter:addLabel("ContainersOptionsSystemSubSectionLabel", 1155277)
            :addLabel("ContainerViewLabel", 1079827)
            :addLabel("CorpseViewLabel", 1079828)
            :addComboBox(ComboBoxes.ContainerView, containerViewOptions, 1)
            :addComboBox(ComboBoxes.CorpseView, containerViewOptions, 1)
            :addLabel("ToggleGridLabel", 1155282)
            :addCheckBox(CheckBoxes.ToggleGrid)
            :addLabel("ToggleAlternateGridLabel", 1155286)
            :addCheckBox(CheckBoxes.ToggleAlternateGrid)
            :addLabel("ToggleExtraBrightLabel", 1155288)
            :addCheckBox(CheckBoxes.ToggleExtraBright)
            :addLabel("ContainerGridColorLabel", 1155290)
            :addLabel("ContainerGridAlternateColorLabel", 1155292)
            :addLabel("SettingsLegacyLegacySubSectionLabel", 1094697)
            :addLabel("SettingsLegacyUseLegacyContainersLabel", 1094708)
            :addCheckBox(CheckBoxes.UseLegacyContainers)
            :addLabel("SettingsLegacyBackpackStyleLabel", 1157257)
            :addComboBox(ComboBoxes.BackpackStyle, backpackStyles, 1)
            :addWindow(ColorButtons.GridColor)
            :addWindow(ColorButtons.AlternateColor)
end

function SettingsContainersWindow.UpdateSettings()
    SettingsContainersWindow.adapter.views[ComboBoxes.ContainerView]:findItem(
        function (_, item)
            return item == StringFormatter.toWString(UserContainerSettings.containerView())
        end
    )

    SettingsContainersWindow.adapter.views[ComboBoxes.CorpseView]:findItem(
            function (_, item)
                return item == StringFormatter.toWString(UserContainerSettings.corpseView())
            end
    )

    isAlternateGrid = UserContainerSettings.alternateGrid()
    isExtraBrightContainer = UserContainerSettings.brightContainers()
    isGridContainer = UserContainerSettings.gridContainer()
    isUseLegacyContainers = UserContainerSettings.legacyContainers()

    SettingsContainersWindow.adapter.views[CheckBoxes.ToggleGrid]:setChecked(isGridContainer)
    SettingsContainersWindow.adapter.views[CheckBoxes.ToggleAlternateGrid]:setChecked(isAlternateGrid)
    SettingsContainersWindow.adapter.views[CheckBoxes.ToggleExtraBright]:setChecked(isExtraBrightContainer)
    SettingsContainersWindow.adapter.views[ColorButtons.GridColor]:setColor(
            UserContainerSettings.gridColor()
    )
    SettingsContainersWindow.adapter.views[ColorButtons.AlternateColor]:setColor(
            UserContainerSettings.alternateColor()
    )

    SettingsContainersWindow.adapter.views[CheckBoxes.UseLegacyContainers]:setChecked(isUseLegacyContainers)

    currentBackPackStyle = UserContainerSettings.legacyBackPackStyle()
    for i = 1, #UserContainerSettings.LegacyBackpackStyles do
        if UserContainerSettings.LegacyBackpackStyles[i] == currentBackPackStyle then
            SettingsContainersWindow.adapter.views[ComboBoxes.BackpackStyle]:setSelectedItem(i)
            break
        end
    end
end

function SettingsContainersWindow.OnApplyButton()
    local containerView = SettingsContainersWindow.adapter.views[ComboBoxes.ContainerView]
    UserContainerSettings.containerView(StringFormatter.fromWString(
            containerView.items[containerView:getSelectedItem()]
    ))
    local corpseView = SettingsContainersWindow.adapter.views[ComboBoxes.CorpseView]
    UserContainerSettings.corpseView(StringFormatter.fromWString(
            containerView.items[corpseView:getSelectedItem()]
    ))

    local isChecked = SettingsContainersWindow.adapter.views[CheckBoxes.ToggleGrid]:isChecked()
    local doReload = isGridContainer ~= isChecked
    UserContainerSettings.gridContainer(isChecked)

    isChecked = SettingsContainersWindow.adapter.views[CheckBoxes.ToggleAlternateGrid]:isChecked()
    doReload = doReload or isAlternateGrid ~= isChecked
    UserContainerSettings.alternateGrid(isChecked)

    isChecked = SettingsContainersWindow.adapter.views[CheckBoxes.ToggleExtraBright]:isChecked()
    doReload = doReload or isExtraBrightContainer ~= isChecked
    UserContainerSettings.brightContainers(isChecked)

    isChecked = SettingsContainersWindow.adapter.views[CheckBoxes.UseLegacyContainers]:isChecked()
    doReload = doReload or isUseLegacyContainers ~= isChecked
    UserContainerSettings.legacyContainers(isChecked)

    local legacyStyle = SettingsContainersWindow.adapter.views[ComboBoxes.BackpackStyle]:getSelectedItem()
    doReload = doReload or (currentBackPackStyle ~= UserContainerSettings.LegacyBackpackStyles[legacyStyle] and UserContainerSettings.legacyContainers())
    UserContainerSettings.legacyBackPackStyle(UserContainerSettings.LegacyBackpackStyles[legacyStyle])

    if doReload then
        SettingsContainersWindow.DestroyContainers()
        ResizeContainers()
    end
end

function SettingsContainersWindow.DestroyContainers()
    for id, _ in pairs(ContainerWindow.OpenContainers) do
        SettingsContainersWindow.adapter:destroy("ContainerWindow_"..id)
    end

    for cId, _ in pairs(WindowData.ContainerWindow) do
        WindowDataApi.unregisterData(WindowData.ContainerWindow.Type, cId)
    end
end