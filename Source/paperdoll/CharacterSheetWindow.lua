CharacterSheetWindow = {}

CharacterSheetWindow.Name = "CharacterSheetWindow"

function CharacterSheetWindow.onInitialize()
    WindowDataApi.registerData(PlayerStatus.type())
    WindowApi.registerEventHandler(
        CharacterSheetWindow.Name,
        PlayerStatus.event(),
        "CharacterSheetWindow.onUpdate"
    )
    Debug.Print(PlayerStatus.stats())
end

function CharacterSheetWindow.onShutdown()
    WindowDataApi.unregisterData(PlayerStatus.type())
    WindowApi.unregisterEventHandler(
        CharacterSheetWindow.Name,
        PlayerStatus.event()
    )
end

function CharacterSheetWindow.onRightClick()
    WindowApi.destroyWindow(CharacterSheetWindow.Name)
end

function CharacterSheetWindow.onUpdate()
    
end