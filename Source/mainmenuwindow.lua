MainMenuWindow = {}

local adapter = ViewAdapter:new("MainMenuWindow", L"Menu")

function MainMenuWindow.Initialize()
    adapter:setAlpha(1.00)
            :addLabel("MainMenuWindowLogOutItemText", 3000128)
            :addLabel("MainMenuWindowExitGameItemText", 1077859)
            :addLabel("MainMenuWindowUserSettingsItemText", L"Settings")
            :addLabel("MainMenuWindowAgentsSettingsItemText", L"Agents")
            :addLabel("MainMenuWindowMacrosItemText", 3000172)
            :addLabel("MainMenuWindowActionsItemText", 1079812)
            :addLabel("MainMenuWindowHelpItemText", 1061037)
            :addLabel("MainMenuWindowUOStoreText", L"Store")
            :addLabel("MainMenuWindowDebugItemText", L"Debug")
            :clearAnchors()
            :addAnchor("center", "ResizeWindow", "center", 100, 0)
end

function MainMenuWindow.OnLogOut()
    Broadcast.Event(SystemData.Events.LOG_OUT)
end

function MainMenuWindow.OnOpenUserSettings()
    ToggleWindowByName("SettingsWindow", "", MainMenuWindow.ToggleSettingsWindow)
    adapter:setShowing(false)
end

function MainMenuWindow.OnOpenMacros()
    ToggleWindowByName("MacroWindow", "", MainMenuWindow.OnOpenMacros)
    adapter:setShowing(false)
end

function MainMenuWindow.OnOpenActions()
    ToggleWindowByName("ActionsWindow", "", MainMenuWindow.OnOpenActions)
    adapter:setShowing(false)
end

function MainMenuWindow.OnOpenHelp()
    Broadcast.Event(SystemData.Events.REQUEST_OPEN_HELP_MENU)
    adapter:setShowing(false)
end

function MainMenuWindow.OnOpenUOStore()
    Broadcast.Event(SystemData.Events.UO_STORE_REQUEST)
    adapter:setShowing(false)
end

function MainMenuWindow.OnDebug()
    ToggleWindowByName("DebugWindow", "", MainMenuWindow.OnDebug)
    adapter:setShowing(false)
end

function MainMenuWindow.ToggleSettingsWindow()
    ToggleWindowByName("SettingsWindow", "", MainMenuWindow.ToggleSettingsWindow)
end

function MainMenuWindow.OnToggleAgentsSettings()
    ToggleWindowByName("OrganizerWindow", "", MainMenuWindow.OnToggleAgentsSettings)
    adapter:setShowing(false)
end

function MainMenuWindow.Destroy()
    adapter:setShowing(false)
end
