SettingsColorButton = {}

local HuePickerWindowRequest
local HuePickerWindow

function SettingsColorButton.ColorPicked()
    local huePicked = ColorPickerWindow.colorSelected["ColorPicker"]
    local color = {}
    color.r, color.g, color.b = HueRGBAValue(huePicked)

    if (HuePickerWindowRequest == "ContainerGridColorButton") then
        UserContainerSettings.gridColor(color)
        SettingsContainersWindow.DestroyContainers()
    elseif (HuePickerWindowRequest == "ContainerGridAlternateColorButton") then
        UserContainerSettings.alternateColor(color)
        SettingsContainersWindow.DestroyContainers()
    elseif (HuePickerWindowRequest == "colorHealButton") then
        Debug.Print(color)
        TextParsing.Heal = UserOverheadTextSettings.healColor(color)
    elseif (HuePickerWindowRequest== "colorCurseButton") then
        TextParsing.Curse = UserOverheadTextSettings.curseColor(color)
    elseif (HuePickerWindowRequest== "colorParaButton") then
        TextParsing.Paralyze = UserOverheadTextSettings.paralyzeColor(color)
    elseif (HuePickerWindowRequest== "colorNeutralButton") then
        TextParsing.Neutral = UserOverheadTextSettings.neutralColor(color)
    elseif (HuePickerWindowRequest== "colorNegButton") then
        TextParsing.OverHeadError = UserOverheadTextSettings.errorColor(color)
    elseif (HuePickerWindowRequest== "colorPosButton") then
        TextParsing.SpecialColor = UserOverheadTextSettings.specialColor(color)
    elseif (HuePickerWindowRequest== "colorYouButton") then
        DamageWindow.YOUGETAMAGE_COLOR = UserOverheadTextSettings.damagePlayerColor(color)
    elseif (HuePickerWindowRequest== "colorPetButton") then
        DamageWindow.PETGETDAMAGE_COLOR = UserOverheadTextSettings.damagePetColor(color)
    elseif (HuePickerWindowRequest== "colorEnemyButton") then
        DamageWindow.OTHERGETDAMAGE_COLOR = UserOverheadTextSettings.damageOtherColor(color)
    elseif (HuePickerWindowRequest== "colorPhysButton") then
        SpellsInfo.PHYSICAL = UserOverheadTextSettings.physicalColor(color)
    elseif (HuePickerWindowRequest== "colorFireButton") then
        SpellsInfo.FIRE = UserOverheadTextSettings.fireColor(color)
    elseif (HuePickerWindowRequest== "colorColdButton") then
        SpellsInfo.COLD = UserOverheadTextSettings.coldColor(color)
    elseif (HuePickerWindowRequest== "colorPoisButton") then
        SpellsInfo.POISON = UserOverheadTextSettings.poisonColor(color)
    elseif (HuePickerWindowRequest== "colorEnerButton") then
        SpellsInfo.ENERGY = serOverheadTextSettings.energyColor(color)
    elseif (HuePickerWindowRequest== "colorChaosButton") then
        SpellsInfo.Chaos = UserOverheadTextSettings.chaosColor(color)
    end

    WindowSetTintColor(HuePickerWindow .. "Button", color.r,color.g,color.b)
    DestroyWindow("ColorPicker")
end

function SettingsColorButton.PickColor()
    local color = SystemData.ActiveWindow.name
    HuePickerWindow = string.gsub(color, "Button", "")
    HuePickerWindowRequest = string.gsub(color, "OverheadTextOptions", "")
    local defaultColors = {
        0, --HUE_NONE
        34, --HUE_RED
        53, --HUE_YELLOW
        63, --HUE_GREEN
        89, --HUE_BLUE
        119, --HUE_PURPLE
        144, --HUE_ORANGE
        368, --HUE_GREEN_2
        946, --HUE_GREY
    }
    local hueTable = {}
    for idx, hue in pairs(defaultColors) do
        for i=0,8 do
            hueTable[(idx-1)*10+i+1] = hue+i
        end
    end

    CreateWindowFromTemplate( "ColorPicker", "ColorPickerWindowTemplate", "Root" )
    WindowSetLayer( "ColorPicker", Window.Layers.SECONDARY	)
    ColorPickerWindow.SetNumColorsPerRow(9)
    ColorPickerWindow.SetSwatchSize(30)
    ColorPickerWindow.SetWindowPadding(4,4)
    ColorPickerWindow.SetFrameEnabled(true)
    ColorPickerWindow.SetCloseButtonEnabled(true)
    ColorPickerWindow.SetColorTable(hueTable,"ColorPicker")
    ColorPickerWindow.DrawColorTable("ColorPicker")
    ColorPickerWindow.SetAfterColorSelectionFunction(SettingsColorButton.ColorPicked)
    local h = WindowGetDimensions("ColorPicker")
    WindowAddAnchor( "ColorPicker", "topleft", HuePickerWindow .. "Button", "topleft", 50, -h)
    ColorPickerWindow.SetFrameEnabled(false)
    WindowSetShowing( "ColorPicker", true )
    ColorPickerWindow.SelectColor("ColorPicker", 1)
end