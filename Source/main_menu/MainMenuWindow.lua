local NAME = "MainMenuWindow"

MainMenuWindow = UusCorpWindow.new(NAME):child(
    UusCorpButton.new(NAME.. "DebugItemButton"):setText(L"Debug"):coreEvent(
        UusCorpViewEvent.onLButtonUp(function ()
            UusCorpDebugWindow:create(true)
            MainMenuWindow:show(false)
        end)
    )
):child(
    UusCorpButton.new(NAME .. "ExitGameItemButton"):setText(1077859):coreEvent(
        UusCorpViewEvent.onLButtonUp(function ()
             InterfaceCore.OnExitGame()
        end)
    )
):child(
    UusCorpButton.new(NAME .. "LogOutItemButton"):setText(3000128):coreEvent(
        UusCorpViewEvent.onLButtonUp(function ()
            EventApi.broadcast(SystemData.Events.LOG_OUT)
        end)
    )
):child(
    UusCorpButton.new(NAME .. "AgentsSettingsItemButton"):setText(L"Agents"):coreEvent(
        UusCorpViewEvent.onLButtonUp(function ()
            ToggleWindowByName("OrganizerWindow", "")
            MainMenuWindow:show(false)
        end)
    )
):child(
    UusCorpButton.new(NAME .. "MacrosItemButton"):setText(3000172):coreEvent(
        UusCorpViewEvent.onLButtonUp(function ()
            ToggleWindowByName("MacroWindow", "")
            MainMenuWindow:show(false)
        end)
    )
):child(
    UusCorpButton.new(NAME .. "ActionsItemButton"):setText(1079812):coreEvent(
        UusCorpViewEvent.onLButtonUp(function ()
            ToggleWindowByName("ActionsWindow", "")
            MainMenuWindow:show(false)
        end)
    )
):child(
    UusCorpButton.new(NAME .. "HelpItemButton"):setText(1061037):coreEvent(
        UusCorpViewEvent.onLButtonUp(function ()
            EventApi.broadcast(SystemData.Events.REQUEST_OPEN_HELP_MENU)
            MainMenuWindow:show(false)
        end)
    )
):child(
    UusCorpButton.new(NAME.. "UOStoreItemButton"):setText(L"Store"):coreEvent(
        UusCorpViewEvent.onLButtonUp(function ()
            EventApi.broadcast(SystemData.Events.UO_STORE_REQUEST)
            MainMenuWindow:show(false)
        end)
    )
):child(
    UusCorpButton.new(NAME .. "UserSettingsItemButton"):setText(L"Settings"):coreEvent(
        UusCorpViewEvent.onLButtonUp(function ()
            ToggleWindowByName("SettingsWindow", "")
            MainMenuWindow:show(false)
        end)
    )
):coreEvent(
    UusCorpViewEvent.onRButtonUp(function ()
        MainMenuWindow:show(false)
    end)
)