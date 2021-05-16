SettingsColorButton = {}

local function ColorPicked(HuePickerWindowRequest, HuePickerWindow)
    local huePicked = ColorPickerWindow.colorSelected["ColorPicker"]

    if (HuePickerWindowRequest== "ContainerGridColor") then
        ContainerWindow.BaseGridColor.r,ContainerWindow.BaseGridColor.g,ContainerWindow.BaseGridColor.b,ContainerWindow.BaseGridColor.a = HueRGBAValue(huePicked)
        Interface.SaveColor("BaseGridColor", ContainerWindow.BaseGridColor)
        SettingsContainersWindow.DestroyContainers()

    elseif (HuePickerWindowRequest== "ContainerGridAlternateColor") then
        ContainerWindow.AlternateBackpack.r,ContainerWindow.AlternateBackpack.g,ContainerWindow.AlternateBackpack.b,ContainerWindow.AlternateBackpack.a = HueRGBAValue(huePicked)
        Interface.SaveColor("AlternateBackpack", ContainerWindow.AlternateBackpack)
        SettingsContainersWindow.DestroyContainers()

    elseif (HuePickerWindowRequest== "colorHeal") then
        TextParsing.Heal.r,TextParsing.Heal.g,TextParsing.Heal.b,TextParsing.Heal.a = HueRGBAValue(huePicked)
        Interface.SaveColor("TextParsingHeal", TextParsing.Heal)
    elseif (HuePickerWindowRequest== "colorCurse") then
        TextParsing.Curse.r,TextParsing.Curse.g,TextParsing.Curse.b,TextParsing.Curse.a = HueRGBAValue(huePicked)
        Interface.SaveColor("TextParsingCurse", TextParsing.Curse)
    elseif (HuePickerWindowRequest== "colorPara") then
        TextParsing.Paralyze.r,TextParsing.Paralyze.g,TextParsing.Paralyze.b,TextParsing.Paralyze.a = HueRGBAValue(huePicked)
        Interface.SaveColor("TextParsingParalyze", TextParsing.Paralyze)
    elseif (HuePickerWindowRequest== "colorNeutral") then
        TextParsing.Neutral.r,TextParsing.Neutral.g,TextParsing.Neutral.b,TextParsing.Neutral.a = HueRGBAValue(huePicked)
        Interface.SaveColor("TextParsingNeutral", TextParsing.Neutral)
    elseif (HuePickerWindowRequest== "colorNeg") then
        TextParsing.OverHeadError.r,TextParsing.OverHeadError.g,TextParsing.OverHeadError.b,TextParsing.OverHeadError.a = HueRGBAValue(huePicked)
        Interface.SaveColor("TextParsingOverHeadError", TextParsing.OverHeadError)
    elseif (HuePickerWindowRequest== "colorPos") then
        TextParsing.SpecialColor.r,TextParsing.SpecialColor.g,TextParsing.SpecialColor.b,TextParsing.SpecialColor.a = HueRGBAValue(huePicked)
        Interface.SaveColor("TextParsingSpecialColor", TextParsing.SpecialColor)

    elseif (HuePickerWindowRequest== "colorYou") then
        DamageWindow.YOUGETAMAGE_COLOR.r,DamageWindow.YOUGETAMAGE_COLOR.g,DamageWindow.YOUGETAMAGE_COLOR.b,DamageWindow.YOUGETAMAGE_COLOR.a = HueRGBAValue(huePicked)
        Interface.SaveColor("DamageWindowYOUGETAMAGE_COLOR", DamageWindow.YOUGETAMAGE_COLOR)
    elseif (HuePickerWindowRequest== "colorPet") then
        DamageWindow.PETGETDAMAGE_COLOR.r,DamageWindow.PETGETDAMAGE_COLOR.g,DamageWindow.PETGETDAMAGE_COLOR.b,DamageWindow.PETGETDAMAGE_COLOR.a = HueRGBAValue(huePicked)
        Interface.SaveColor("DamageWindowPETGETDAMAGE_COLOR", DamageWindow.PETGETDAMAGE_COLOR)
    elseif (HuePickerWindowRequest== "colorEnemy") then
        DamageWindow.OTHERGETDAMAGE_COLOR.r,DamageWindow.OTHERGETDAMAGE_COLOR.g,DamageWindow.OTHERGETDAMAGE_COLOR.b,DamageWindow.OTHERGETDAMAGE_COLOR.a = HueRGBAValue(huePicked)
        Interface.SaveColor("DamageWindowOTHERGETDAMAGE_COLOR", DamageWindow.OTHERGETDAMAGE_COLOR)

    elseif (HuePickerWindowRequest== "colorPhys") then
        SpellsInfo.PHYSICAL.r,SpellsInfo.PHYSICAL.g,SpellsInfo.PHYSICAL.b,SpellsInfo.PHYSICAL.a  = HueRGBAValue(huePicked)
        Interface.SaveColor("SpellsInfoPHYSICAL", SpellsInfo.PHYSICAL)
    elseif (HuePickerWindowRequest== "colorFire") then
        SpellsInfo.FIRE.r,SpellsInfo.FIRE.g,SpellsInfo.FIRE.b,SpellsInfo.FIRE.a = HueRGBAValue(huePicked)
        Interface.SaveColor("SpellsInfoFIRE", SpellsInfo.FIRE)
    elseif (HuePickerWindowRequest== "colorCold") then
        SpellsInfo.COLD.r,SpellsInfo.COLD.g,SpellsInfo.COLD.b,SpellsInfo.COLD.a = HueRGBAValue(huePicked)
        Interface.SaveColor("SpellsInfoCOLD", SpellsInfo.COLD)
    elseif (HuePickerWindowRequest== "colorPois") then
        SpellsInfo.POISON.r,SpellsInfo.POISON.g,SpellsInfo.POISON.b,SpellsInfo.POISON.a = HueRGBAValue(huePicked)
        Interface.SaveColor("SpellsInfoPOISON", SpellsInfo.POISON)
    elseif (HuePickerWindowRequest== "colorEner") then
        SpellsInfo.ENERGY.r,SpellsInfo.ENERGY.g,SpellsInfo.ENERGY.b,SpellsInfo.ENERGY.a = HueRGBAValue(huePicked)
        Interface.SaveColor("SpellsInfoENERGY", SpellsInfo.ENERGY)
    elseif (HuePickerWindowRequest== "colorChaos") then
        SpellsInfo.Chaos.r,SpellsInfo.Chaos.g,SpellsInfo.Chaos.b,SpellsInfo.Chaos.a = HueRGBAValue(huePicked)
        Interface.SaveColor("SpellsInfoChaos", SpellsInfo.Chaos)
    end

    local r,g,b = HueRGBAValue(huePicked)
    WindowSetTintColor(HuePickerWindow .. "Button", r,g,b)
    DestroyWindow("ColorPicker")
end

function SettingsColorButton.PickColor()
    local color = SystemData.ActiveWindow.name
    local HuePickerWindow = string.gsub(color, "Button", "")
    local HuePickerWindowRequest = string.gsub(color, "OverheadTextOptions", "")
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
    ColorPickerWindow.SetAfterColorSelectionFunction(
            function ()
                ColorPicked(HuePickerWindowRequest, HuePickerWindow)
            end
    )
    local h = WindowGetDimensions("ColorPicker")
    WindowAddAnchor( "ColorPicker", "topleft", HuePickerWindow .. "Button", "topleft", 50, -h)
    ColorPickerWindow.SetFrameEnabled(false)
    WindowSetShowing( "ColorPicker", true )
    ColorPickerWindow.SelectColor("ColorPicker", 1)
end