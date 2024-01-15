---Right now this mod just properly destroys the Character
---Sheet instead of hiding it, as the Default UI does wastefully with all its
---windows.
UusCorpCharacterSheetMod = {}

function UusCorpCharacterSheetMod.onInitialize()
    WindowApi.destroyWindow("CharacterSheet")
    local characterSheet = UusCorpCore.copyTable(CharacterSheet)

    function CharacterSheet.Initialize()
        characterSheet.Initialize()
        WindowApi.registerCoreEventHandler(
            Active.window(),
            "OnRButtonUp",
            "UusCorpCharacterSheetMod.onRightClick"
        )
    end

    function CharacterSheet.OnHidden()
        characterSheet.OnHidden()
        WindowApi.destroyWindow(Active.window())
    end

    function Actions.ToggleCharacterSheet()
        WindowApi.toggleWindow("CharacterSheet")
    end
end

function UusCorpCharacterSheetMod.onRightClick()
    WindowApi.setShowing(Active.window(), false)
end