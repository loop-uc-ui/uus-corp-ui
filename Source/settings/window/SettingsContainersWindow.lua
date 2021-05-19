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

    adapter.views[CheckBoxes.ToggleGridLegacy]:setChecked(UserContainerSettings.gridLegacy())
    adapter.views[CheckBoxes.ToggleGrid]:setChecked(UserContainerSettings.gridContainer())
    adapter.views[CheckBoxes.ToggleContentsInfo]:setChecked(UserContainerSettings.alternateGrid())
    adapter.views[CheckBoxes.ToggleExtraBright]:setChecked(UserContainerSettings.brightContainers())
    adapter.views[CheckBoxes.ToggleContentsInfo]:setChecked(UserContainerSettings.toggleContentsInfo())
    
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
    if (ContainerWindow.PlayerBackpack or Interface.GridLegacy) then
        local playerbackpackWindow = "ContainerWindow_"..ContainerWindow.PlayerBackpack
        if WindowGetShowing(playerbackpackWindow) then
            WindowSetShowing(playerbackpackWindow,false)
        end
        DestroyWindow(playerbackpackWindow)
        UnregisterWindowData(WindowData.ContainerWindow.Type, ContainerWindow.PlayerBackpack)
    end

    UserContainerSettings.containerView(adapter.views[ComboBoxes.ContainerView]:getSelectedItem())
    UserContainerSettings.corpseView(adapter.views[ComboBoxes.CorpseView]:getSelectedItem())
    UserContainerSettings.toggleContentsInfo(adapter.views[CheckBoxes.ToggleContentsInfo]:isChecked())
    UserContainerSettings.gridLegacy(adapter.views[CheckBoxes.ToggleGridLegacy]:isChecked())
    UserContainerSettings.gridContainer(adapter.views[CheckBoxes.ToggleGrid]:isChecked())
    UserContainerSettings.alternateGrid(adapter.views[CheckBoxes.ToggleAlternateGrid]:isChecked())
    UserContainerSettings.brightContainers(adapter.views[CheckBoxes.ToggleExtraBright]:isChecked())

    if containerReload then
        SettingsContainersWindow.DestroyContainers()
        if not Interface.GridLegacy then
            ResizeContainers()
        end
    end
end

function SettingsContainersWindow.DestroyContainers()
    for id, value in pairs(ContainerWindow.OpenContainers) do
        DestroyWindow("ContainerWindow_"..id)
    end

    for cId, cValue in pairs(WindowData.ContainerWindow) do
        --Debug.Print("SettingsWindow.DestroyContainers: "..cId)
        UnregisterWindowData(WindowData.ContainerWindow.Type, cId)
    end
end