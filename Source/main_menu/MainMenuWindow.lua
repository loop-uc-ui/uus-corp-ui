MainMenuWindow = {}

MainMenuWindow.Name = "MainMenuWindow"

MainMenuWindow.Buttons = {
    Debug = MainMenuWindow.Name .. "DebugItemButton",
    ExitGame = MainMenuWindow.Name .. "ExitGameItemButton",
    LogOut = MainMenuWindow.Name .. "LogOutItemButton",
    Agents = MainMenuWindow.Name .. "AgentsSettingsItemButton",
    Macros = MainMenuWindow.Name .. "MacrosItemButton",
    Actions = MainMenuWindow.Name .. "ActionsItemButton",
    Help = MainMenuWindow.Name .. "HelpItemButton",
    Store = MainMenuWindow.Name .. "UOStoreItemButton",
    Settings = MainMenuWindow.Name .. "UserSettingsItemButton"
}

function MainMenuWindow.onInitialize()
    ButtonApi.setText(MainMenuWindow.Buttons.Debug, L"Debug")
    ButtonApi.setText(MainMenuWindow.Buttons.ExitGame, 1077859)
    ButtonApi.setText(MainMenuWindow.Buttons.LogOut, 3000128)
    ButtonApi.setText(MainMenuWindow.Buttons.Agents, L"Agents")
    ButtonApi.setText(MainMenuWindow.Buttons.Macros, 3000172)
    ButtonApi.setText(MainMenuWindow.Buttons.Actions, 1079812)
    ButtonApi.setText(MainMenuWindow.Buttons.Help, 1061037)
    ButtonApi.setText(MainMenuWindow.Buttons.Store, L"Store")
    ButtonApi.setText(MainMenuWindow.Buttons.Settings, L"Settings")
end

function MainMenuWindow.onButtonClick()
    local window = Active.window()

    if window == MainMenuWindow.Buttons.Debug then
        WindowApi.createWindow(UusCorpDebugWindow.Name, true)
    elseif window == MainMenuWindow.Buttons.ExitGame then
        InterfaceCore.OnExitGame()
        return
    elseif window == MainMenuWindow.Buttons.LogOut then
        EventApi.broadcast(Events.logOut())
        return
    elseif window == MainMenuWindow.Buttons.Agents then
        ToggleWindowByName("OrganizerWindow", "")
    elseif window == MainMenuWindow.Buttons.Macros then
        ToggleWindowByName("MacroWindow", "")
    elseif window == MainMenuWindow.Buttons.Actions then
        ToggleWindowByName("ActionsWindow", "")
    elseif window == MainMenuWindow.Buttons.Help then
        EventApi.broadcast(Events.help())
    elseif window == MainMenuWindow.Buttons.Store then
        EventApi.broadcast(Events.store())
    elseif window == MainMenuWindow.Buttons.Settings then
        ToggleWindowByName("SettingsWindow", "")
    end

    WindowApi.setShowing(MainMenuWindow.Name, false)
end

function MainMenuWindow.onRightClick()
    WindowApi.setShowing(MainMenuWindow.Name, false)
end
