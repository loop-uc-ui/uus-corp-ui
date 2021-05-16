SettingsContainersWindow = {}

local ContainerViewOptions = {}
ContainerViewOptions[1] = {name="List", tid=1079824}
ContainerViewOptions[2] = {name="Grid", tid=1079825}

local function ResizeContainers()
    for id, value in pairs(ContainerWindow.OpenContainers) do
        ContainerWindow.LegacyGridDock("ContainerWindow_"..id)
    end
end

function SettingsContainersWindow.Initialize()
    LabelSetText( "ContainersOptionsSystemSubSectionLabel", GetStringFromTid( 1155277 ) )
    LabelSetText( "ContainerViewLabel", GetStringFromTid( 1079827 )..L":" )
    WindowSetId( "ContainerViewLabel", 1115302 )
    LabelSetText( "CorpseViewLabel", GetStringFromTid( 1079828 )..L":" )
    WindowSetId( "CorpseViewLabel", 1115303 )
    for id, data in ipairs(ContainerViewOptions) do
        ComboBoxAddMenuItem( "ContainerViewCombo", GetStringFromTid(data.tid) )
        ComboBoxAddMenuItem( "CorpseViewCombo", GetStringFromTid(data.tid) )
    end

    LabelSetText( "ToggleContentsInfo" .. "Label", GetStringFromTid( 1155284 ) )
    WindowSetId( "ToggleContentsInfo" .. "Label", 1155285 )
    ButtonSetCheckButtonFlag( "ToggleContentsInfo" .. "Button", true )

    LabelSetText( "ToggleGridLegacy" .. "Label", GetStringFromTid( 1155280 ) )
    WindowSetId( "ToggleGridLegacy" .. "Label",  1155281 )
    ButtonSetCheckButtonFlag( "ToggleGridLegacy" .. "Button", true )

    LabelSetText( "ToggleGrid" .. "Label",  GetStringFromTid( 1155282 ) )
    WindowSetId( "ToggleGrid" .. "Label", 1155283 )
    ButtonSetCheckButtonFlag( "ToggleGrid" .. "Button", true )

    LabelSetText( "ToggleAlternateGrid" .. "Label", GetStringFromTid( 1155286 ) )
    WindowSetId( "ToggleAlternateGrid" .. "Label", 1155287 )
    ButtonSetCheckButtonFlag( "ToggleAlternateGrid" .. "Button", true )

    LabelSetText( "ToggleExtraBright" .. "Label", GetStringFromTid( 1155288 ) )
    WindowSetId( "ToggleExtraBright" .. "Label", 1155289 )
    ButtonSetCheckButtonFlag( "ToggleExtraBright" .. "Button", true )

    LabelSetText( "ContainerGridColor" .. "Label", GetStringFromTid( 1155290 ) )
    WindowSetId( "ContainerGridColor" .. "Label", 1155291 )

    LabelSetText( "ContainerGridAlternateColor" .. "Label", GetStringFromTid( 1155292 ) )
    WindowSetId( "ContainerGridAlternateColor" .. "Label", 1155293 )
end

function SettingsContainersWindow.UpdateSettings()
    ComboBoxSetSelectedMenuItem( "ContainerViewCombo", 1)
    local containerMode = SystemData.Settings.Interface.defaultContainerMode
    for id, data in ipairs(ContainerViewOptions) do
        if( data.name == containerMode ) then
            ComboBoxSetSelectedMenuItem( "ContainerViewCombo", id)
            break
        end
    end

    ComboBoxSetSelectedMenuItem( "CorpseViewCombo", 1)
    local corpseMode = SystemData.Settings.Interface.defaultCorpseMode
    for id, data in ipairs(ContainerViewOptions) do
        if( data.name == corpseMode ) then
            ComboBoxSetSelectedMenuItem( "CorpseViewCombo", id)
            break
        end
    end

    ButtonSetPressedFlag( "ToggleContentsInfo" .. "Button", Interface.ToggleContentsInfo )
    ButtonSetPressedFlag( "ToggleGridLegacy" .. "Button", Interface.GridLegacy )
    ButtonSetPressedFlag( "ToggleGrid" .. "Button", Interface.EnableContainerGrid )
    ButtonSetPressedFlag( "ToggleAlternateGrid" .. "Button", Interface.AlternateGrid )
    ButtonSetPressedFlag( "ToggleExtraBright" .. "Button", Interface.ExtraBrightContainers )
    WindowSetTintColor( "ContainerGridColor" .. "Button", ContainerWindow.BaseGridColor.r,ContainerWindow.BaseGridColor.g,ContainerWindow.BaseGridColor.b)
    WindowSetTintColor( "ContainerGridAlternateColor" .. "Button", ContainerWindow.AlternateBackpack.r,ContainerWindow.AlternateBackpack.g,ContainerWindow.AlternateBackpack.b)
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

    local selectedId = ComboBoxGetSelectedMenuItem( "ContainerViewCombo" )
    SystemData.Settings.Interface.defaultContainerMode = ContainerViewOptions[selectedId].name

    selectedId = ComboBoxGetSelectedMenuItem( "CorpseViewCombo" )
    SystemData.Settings.Interface.defaultCorpseMode = ContainerViewOptions[selectedId].name

    Interface.ToggleContentsInfo = ButtonGetPressedFlag( "ToggleContentsInfo" .. "Button" )
    Interface.SaveBoolean( "ToggleContentsInfo" , Interface.ToggleContentsInfo )

    local containerReload = containerReload or Interface.GridLegacy ~= ButtonGetPressedFlag( "ToggleGridLegacy" .. "Button" )
    Interface.GridLegacy = ButtonGetPressedFlag( "ToggleGridLegacy" .. "Button" )
    Interface.SaveBoolean( "GridLegacy" , Interface.GridLegacy )

    containerReload = containerReload or Interface.EnableContainerGrid ~= ButtonGetPressedFlag( "ToggleGrid" .. "Button" )
    Interface.EnableContainerGrid = ButtonGetPressedFlag( "ToggleGrid" .. "Button" )
    Interface.SaveBoolean( "EnableContainerGrid" , Interface.EnableContainerGrid )

    containerReload = containerReload or Interface.AlternateGrid ~= ButtonGetPressedFlag( "ToggleAlternateGrid" .. "Button" )
    Interface.AlternateGrid = ButtonGetPressedFlag( "ToggleAlternateGrid" .. "Button" )
    Interface.SaveBoolean( "AlternateGrid" , Interface.AlternateGrid )

    containerReload = containerReload or Interface.ExtraBrightContainers ~= ButtonGetPressedFlag( "ToggleExtraBright" .. "Button" )
    Interface.ExtraBrightContainers = ButtonGetPressedFlag( "ToggleExtraBright" .. "Button" )
    Interface.SaveBoolean( "ExtraBrightContainers" , Interface.ExtraBrightContainers )

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