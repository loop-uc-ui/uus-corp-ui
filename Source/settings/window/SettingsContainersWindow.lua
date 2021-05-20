SettingsContainersWindow = {}

local ComboBoxes = {
    ContainerView = "ContainerViewCombo",
    CorpseView = "CorpseViewCombo"
}

local CheckBoxes = {
    ToggleContentsInfo = "ToggleContentsInfoButton",
    ToggleGridLegacy = "ToggleGridLegacyButton",
    ToggleGrid = "ToggleGridButton",
    ToggleAlternateGrid = "ToggleAlternateGridButton",
    ToggleExtraBright = "ToggleExtraBrightButton"
}

local adapter = ViewAdapter:new("SettingsContainersWindow")

local isGridContainer = true
local isToggleContentsInfo = false
local isGridLegacy = false
local isExtraBrightContainer = false
local isAlternateGrid = false

local function ResizeContainers()
    for id, value in pairs(ContainerWindow.OpenContainers) do
        ContainerWindow.LegacyGridDock("ContainerWindow_"..id)
    end
end

function SettingsContainersWindow.Initialize()
    local containerViewOptions = {
        1079824,
        1079825
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
end

function SettingsContainersWindow.UpdateSettings()
    local containerViewComboBox = adapter.views[ComboBoxes.ContainerView]

    for i = 1, #containerViewComboBox.items do
        if containerViewComboBox.items[i] == UserContainerSettings.containerView() then
            containerViewComboBox:setSelectedItem(i)
            break
        end
    end

    local corpseComboBox = adapter.views[ComboBoxes.CorpseView]

    for i = 1, #corpseComboBox.items do
        if corpseComboBox.items[i] == UserContainerSettings.corpseView() then
            corpseComboBox:setSelectedItem(i)
            break
        end
    end

    isAlternateGrid = UserContainerSettings.alternateGrid()
    isExtraBrightContainer = UserContainerSettings.brightContainers()
    isGridContainer = UserContainerSettings.gridContainer()
    isGridLegacy = UserContainerSettings.gridLegacy()
    isToggleContentsInfo = UserContainerSettings.toggleContentsInfo()

    adapter.views[CheckBoxes.ToggleGridLegacy]:setChecked(isGridLegacy)
    adapter.views[CheckBoxes.ToggleGrid]:setChecked(isGridContainer)
    adapter.views[CheckBoxes.ToggleContentsInfo]:setChecked(isAlternateGrid)
    adapter.views[CheckBoxes.ToggleExtraBright]:setChecked(isExtraBrightContainer)
    adapter.views[CheckBoxes.ToggleContentsInfo]:setChecked(isToggleContentsInfo)

    local gridColor = UserContainerSettings.gridColor()
    if gridColor == nil then
        gridColor = {
            r = 255,
            g = 255,
            b = 255
        }
    end
    adapter:setColor(
            "ContainerGridColorButton",
            gridColor.r,
            gridColor.g,
            gridColor.b
    )

    local alternateGridColor = UserContainerSettings.alternateColor()
    if alternateGridColor == nil then
        alternateGridColor = {
            r = 80,
            g = 80,
            b = 80
        }
    end
    adapter:setColor(
            "ContainerGridAlternateColorButton",
            alternateGridColor.r,
            alternateGridColor.g,
            alternateGridColor.b
    )
end

function SettingsContainersWindow.OnApplyButton()
    if ContainerWindow.PlayerBackpack and UserContainerSettings.gridLegacy() then
        local playerbackpackWindow = "ContainerWindow_"..ContainerWindow.PlayerBackpack
        if adapter:isShowing(playerbackpackWindow) then
           adapter:setShowing(false, playerbackpackWindow)
        end
        adapter:destroy(playerbackpackWindow)
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