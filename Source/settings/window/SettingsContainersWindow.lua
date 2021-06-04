SettingsContainersWindow = {}

local ComboBoxes = {
    ContainerView = "ContainerViewCombo",
    CorpseView = "CorpseViewCombo",
    BackpackStyle = "SettingsLegacyBackpackStyleCombo"
}

local CheckBoxes = {
    ToggleContentsInfo = "ToggleContentsInfoButton",
    ToggleGridLegacy = "ToggleGridLegacyButton",
    ToggleGrid = "ToggleGridButton",
    ToggleAlternateGrid = "ToggleAlternateGridButton",
    ToggleExtraBright = "ToggleExtraBrightButton",
    UseLegacyContainers = "SettingsLegacyUseLegacyContainersButton"
}

local adapter = ViewAdapter:new("SettingsContainersWindow")

local isGridContainer = true
local isToggleContentsInfo = false
local isGridLegacy = false
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

    adapter:addLabel("ContainersOptionsSystemSubSectionLabel", 1155277)
            :addLabel("ContainerViewLabel", 1079827)
            :addLabel("CorpseViewLabel", 1079828)
            :addComboBox(ComboBoxes.ContainerView, containerViewOptions, 1)
            :addComboBox(ComboBoxes.CorpseView, containerViewOptions, 1)
            :addLabel( "ToggleContentsInfoLabel", 1155284)
            :addCheckBox(CheckBoxes.ToggleContentsInfo)
            :addLabel("ToggleGridLegacyLabel", 1155280)
            :addCheckBox( CheckBoxes.ToggleGridLegacy)
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
end

function SettingsContainersWindow.UpdateSettings()
    adapter.views[ComboBoxes.ContainerView]:findItem(
        function (item)
            return item == StringFormatter.toWString(UserContainerSettings.containerView())
        end
    )

    adapter.views[ComboBoxes.CorpseView]:findItem(
            function (item)
                return item == StringFormatter.toWString(UserContainerSettings.corpseView())
            end
    )

    isAlternateGrid = UserContainerSettings.alternateGrid()
    isExtraBrightContainer = UserContainerSettings.brightContainers()
    isGridContainer = UserContainerSettings.gridContainer()
    isGridLegacy = UserContainerSettings.gridLegacy()
    isToggleContentsInfo = UserContainerSettings.toggleContentsInfo()
    isUseLegacyContainers = UserContainerSettings.legacyContainers()

    adapter.views[CheckBoxes.ToggleGridLegacy]:setChecked(isGridLegacy)
    adapter.views[CheckBoxes.ToggleGrid]:setChecked(isGridContainer)
    adapter.views[CheckBoxes.ToggleContentsInfo]:setChecked(isAlternateGrid)
    adapter.views[CheckBoxes.ToggleExtraBright]:setChecked(isExtraBrightContainer)
    adapter.views[CheckBoxes.ToggleContentsInfo]:setChecked(isToggleContentsInfo)

    local gridColor = UserContainerSettings.gridColor()
    adapter:setColor(
            "ContainerGridColorButton",
            gridColor.r,
            gridColor.g,
            gridColor.b
    )

    local alternateGridColor = UserContainerSettings.alternateColor()
    adapter:setColor(
            "ContainerGridAlternateColorButton",
            alternateGridColor.r,
            alternateGridColor.g,
            alternateGridColor.b
    )

    adapter.views[CheckBoxes.UseLegacyContainers]:setChecked(isUseLegacyContainers)

    currentBackPackStyle = UserContainerSettings.legacyBackPackStyle()
    for i = 1, #UserContainerSettings.LegacyBackpackStyles do
        if UserContainerSettings.LegacyBackpackStyles[i] == currentBackPackStyle then
            adapter.views[ComboBoxes.BackpackStyle]:setSelectedItem(i)
            break
        end
    end
end

function SettingsContainersWindow.OnApplyButton()
    if ContainerWindow.PlayerBackpack and UserContainerSettings.gridLegacy() then
        local playerBackpackWindow = "ContainerWindow_"..ContainerWindow.PlayerBackpack
        if adapter:isShowing(playerBackpackWindow) then
           adapter:setShowing(false, playerBackpackWindow)
        end
        adapter:destroy(playerBackpackWindow)
        WindowDataStore.unregister(WindowData.ContainerWindow.Type, ContainerWindow.PlayerBackpack)
    end

    local containerView = adapter.views[ComboBoxes.ContainerView]
    UserContainerSettings.containerView(StringFormatter.fromWString(
            containerView.items[containerView:getSelectedItem()]
    ))
    local corpseView = adapter.views[ComboBoxes.CorpseView]
    UserContainerSettings.corpseView(StringFormatter.fromWString(
            containerView.items[corpseView:getSelectedItem()]
    ))

    local isChecked = adapter.views[CheckBoxes.ToggleContentsInfo]:isChecked()
    local doReload = isToggleContentsInfo ~= isChecked
    UserContainerSettings.toggleContentsInfo(isChecked)

    isChecked = adapter.views[CheckBoxes.ToggleGridLegacy]:isChecked()
    doReload = doReload or isGridLegacy ~= isChecked
    UserContainerSettings.gridLegacy(isChecked)

    isChecked = adapter.views[CheckBoxes.ToggleGrid]:isChecked()
    doReload = doReload or isGridContainer ~= isChecked
    UserContainerSettings.gridContainer(isChecked)

    isChecked = adapter.views[CheckBoxes.ToggleAlternateGrid]:isChecked()
    doReload = doReload or isAlternateGrid ~= isChecked
    UserContainerSettings.alternateGrid(isChecked)

    isChecked = adapter.views[CheckBoxes.ToggleExtraBright]:isChecked()
    doReload = doReload or isExtraBrightContainer ~= isChecked
    UserContainerSettings.brightContainers(isChecked)

    isChecked = adapter.views[CheckBoxes.UseLegacyContainers]:isChecked()
    doReload = doReload or isUseLegacyContainers ~= isChecked
    UserContainerSettings.legacyContainers(isChecked)

    local legacyStyle = adapter.views[ComboBoxes.BackpackStyle]:getSelectedItem()
    doReload = doReload or (currentBackPackStyle ~= UserContainerSettings.LegacyBackpackStyles[legacyStyle] and UserContainerSettings.legacyContainers())
    UserContainerSettings.legacyBackPackStyle(UserContainerSettings.LegacyBackpackStyles[legacyStyle])

    if doReload then
        SettingsContainersWindow.DestroyContainers()
        if not UserContainerSettings.gridLegacy() then
            ResizeContainers()
        end
    end
end

function SettingsContainersWindow.DestroyContainers()
    for id, _ in pairs(ContainerWindow.OpenContainers) do
        adapter:destroy("ContainerWindow_"..id)
    end

    for cId, _ in pairs(WindowData.ContainerWindow) do
        WindowDataStore.unregister(WindowData.ContainerWindow.Type, cId)
    end
end