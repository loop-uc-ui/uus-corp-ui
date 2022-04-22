MainMenuWindow = UusCorpComposable:asView("MainMenuWindow"):asWindow()

function MainMenuWindow:onInitialize()
    self:addChild(
        UusCorpComposable:asView(self.name .. "DebugItemText"):asLabel():setText(L"Debug")
    ):addChild(
        UusCorpComposable:asView(self.name .. "DebugItemButton"):asButton():addAction(
            UusCorpViewAction:onLButtonUp(function ()
                ToggleWindowByName("DebugWindow", "")
                self:show(false)
            end)
        )
    ):addChild(
        UusCorpComposable:asView(self.name .. "ExitGameItemText"):asLabel():setText(1077859)
    ):addChild(
        UusCorpComposable:asView(self.name .. "ExitGameItemButton"):asButton():addAction(
            UusCorpViewAction:onLButtonUp(function ()
                InterfaceCore.OnExitGame()
            end)
        )
    ):addChild(
        UusCorpComposable:asView(self.name .. "LogOutItemText"):asLabel():setText(3000128)
    ):addChild(
        UusCorpComposable:asView(self.name .. "LogOutItemButton"):asButton():addAction(
            UusCorpViewAction:onLButtonUp(function ()
                EventApi.broadcast(SystemData.Events.LOG_OUT)
            end)
        )
    ):addChild(
        UusCorpComposable:asView(self.name .. "AgentsSettingsItemText"):asLabel():setText(L"Agents")
    ):addChild(
        UusCorpComposable:asView(self.name .. "AgentsSettingsItemButton"):asButton():addAction(
            UusCorpViewAction:onLButtonUp(function ()
                ToggleWindowByName("OrganizerWindow", "")
                self:show(false)
            end)
        )
    ):addChild(
        UusCorpComposable:asView(self.name .. "MacrosItemText"):asLabel():setText(3000172)
    ):addChild(
        UusCorpComposable:asView(self.name .. "MacrosItemButton"):asButton():addAction(
            UusCorpViewAction:onLButtonUp(function ()
                ToggleWindowByName("MacroWindow", "")
                self:show(false)
            end)
        )
    ):addChild(
        UusCorpComposable:asView(self.name .. "ActionsItemText"):asLabel():setText(1079812)
    ):addChild(
        UusCorpComposable:asView(self.name .. "ActionsItemButton"):asButton():addAction(
            UusCorpViewAction:onLButtonUp(function ()
                ToggleWindowByName("ActionsWindow", "")
                self:show(false)
            end)
        )
    ):addChild(
        UusCorpComposable:asView(self.name .. "HelpItemText"):asLabel():setText(1061037)
    ):addChild(
        UusCorpComposable:asView(self.name .. "HelpItemButton"):asButton():addAction(
            UusCorpViewAction:onLButtonUp(function ()
                EventApi.broadcast(SystemData.Events.REQUEST_OPEN_HELP_MENU)
                self:show(false)
            end)
        )
    ):addChild(
        UusCorpComposable:asView(self.name .. "UOStoreItemText"):asLabel():setText(L"Store")
    ):addChild(
        UusCorpComposable:asView(self.name .. "UOStoreItemButton"):asButton():addAction(
            UusCorpViewAction:onLButtonUp(function ()
                EventApi.broadcast(SystemData.Events.UO_STORE_REQUEST)
                self:show(false)
            end)
        )
    ):addChild(
        UusCorpComposable:asView(self.name .. "UserSettingsItemText"):asLabel():setText(L"Settings")
    ):addChild(
        UusCorpComposable:asView(self.name .. "UserSettingsItemButton"):asButton():addAction(
            UusCorpViewAction:onLButtonUp(function ()
                ToggleWindowByName("SettingsWindow", "")
                self:show(false)
            end)
        )
    )
    UusCorpWindow.onInitialize(self)
end