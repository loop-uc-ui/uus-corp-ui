UusCorpMainMenuWindow = {}

UusCorpMainMenuWindow.Name = "MainMenuWindow"

UusCorpMainMenuWindow.Buttons = {
    Debug = UusCorpMainMenuWindow.Name .. "DebugItemButton",
    ExitGame = UusCorpMainMenuWindow.Name .. "ExitGameItemButton",
    LogOut = UusCorpMainMenuWindow.Name .. "LogOutItemButton",
    Agents = UusCorpMainMenuWindow.Name .. "AgentsSettingsItemButton",
    Macros = UusCorpMainMenuWindow.Name .. "MacrosItemButton",
    Actions = UusCorpMainMenuWindow.Name .. "ActionsItemButton",
    Help = UusCorpMainMenuWindow.Name .. "HelpItemButton",
    Store = UusCorpMainMenuWindow.Name .. "UOStoreItemButton",
    Settings = UusCorpMainMenuWindow.Name .. "UserSettingsItemButton"
}

function UusCorpMainMenuWindow.initialize()
    UusCorpCore.loadResources(
        "/mods/main-menu",
        "UusCorpMainMenuWindow.xml"
    )

    -- Destroy the old main menu menu, so our custom one
    -- takes precendence
    WindowApi.destroyWindow(UusCorpMainMenuWindow.Name)
    WindowApi.createWindow(UusCorpMainMenuWindow.Name, false)
end

function UusCorpMainMenuWindow.onInitialize()
    ButtonApi.setText(UusCorpMainMenuWindow.Buttons.Debug, L"Debug")
    ButtonApi.setText(UusCorpMainMenuWindow.Buttons.ExitGame, 1077859)
    ButtonApi.setText(UusCorpMainMenuWindow.Buttons.LogOut, 3000128)
    ButtonApi.setText(UusCorpMainMenuWindow.Buttons.Agents, L"Agents")
    ButtonApi.setText(UusCorpMainMenuWindow.Buttons.Macros, 3000172)
    ButtonApi.setText(UusCorpMainMenuWindow.Buttons.Actions, 1079812)
    ButtonApi.setText(UusCorpMainMenuWindow.Buttons.Help, 1061037)
    ButtonApi.setText(UusCorpMainMenuWindow.Buttons.Store, L"Store")
    ButtonApi.setText(UusCorpMainMenuWindow.Buttons.Settings, L"Settings")
end

function UusCorpMainMenuWindow.onButtonClick()
    local window = Active.window()

    if window == UusCorpMainMenuWindow.Buttons.Debug then
        WindowApi.createWindow(UusCorpDebugWindow.Name, true)
    elseif window == UusCorpMainMenuWindow.Buttons.ExitGame then
        InterfaceCore.OnExitGame()
        return
    elseif window == UusCorpMainMenuWindow.Buttons.LogOut then
        EventApi.broadcast(Events.logOut())
        return
    elseif window == UusCorpMainMenuWindow.Buttons.Agents then
        ToggleWindowByName("OrganizerWindow", "")
    elseif window == UusCorpMainMenuWindow.Buttons.Macros then
        ToggleWindowByName("MacroWindow", "")
    elseif window == UusCorpMainMenuWindow.Buttons.Actions then
        ToggleWindowByName("ActionsWindow", "")
    elseif window == UusCorpMainMenuWindow.Buttons.Help then
        EventApi.broadcast(Events.help())
    elseif window == UusCorpMainMenuWindow.Buttons.Store then
        EventApi.broadcast(Events.store())
    elseif window == UusCorpMainMenuWindow.Buttons.Settings then
        ToggleWindowByName("SettingsWindow", "")
    end

    WindowApi.setShowing(UusCorpMainMenuWindow.Name, false)
end

function UusCorpMainMenuWindow.onRightClick()
    WindowApi.setShowing(UusCorpMainMenuWindow.Name, false)
end
