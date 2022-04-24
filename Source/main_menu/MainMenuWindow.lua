MainMenuWindow = UusCorpComposable.asView("MainMenuWindow"):asWindow():addAction(
    UusCorpViewAction.onRButtonUp(function ()
        MainMenuWindow:show(false)
    end)
)

function MainMenuWindow:onInitialize()
    self:addChild(
        UusCorpComposable.asView(self.name .. "DebugItemButton"):asButton():setText(L"Debug"):addAction(
            UusCorpViewAction.onLButtonUp(function ()
                UusCorpDebugWindow:create(true)
                self:show(false)
            end)
        )
    ):addChild(
        UusCorpComposable.asView(self.name .. "ExitGameItemButton"):asButton():setText(1077859):addAction(
            UusCorpViewAction.onLButtonUp(function ()
                InterfaceCore.OnExitGame()
            end)
        )
    ):addChild(
        UusCorpComposable.asView(self.name .. "LogOutItemButton"):asButton():setText(3000128):addAction(
            UusCorpViewAction.onLButtonUp(function ()
                EventApi.broadcast(SystemData.Events.LOG_OUT)
            end)
        )
    ):addChild(
        UusCorpComposable.asView(self.name .. "AgentsSettingsItemButton"):asButton():setText(L"Agents"):addAction(
            UusCorpViewAction.onLButtonUp(function ()
                ToggleWindowByName("OrganizerWindow", "")
                self:show(false)
            end)
        )
    ):addChild(
        UusCorpComposable.asView(self.name .. "MacrosItemButton"):asButton():setText(3000172):addAction(
            UusCorpViewAction.onLButtonUp(function ()
                ToggleWindowByName("MacroWindow", "")
                self:show(false)
            end)
        )
    ):addChild(
        UusCorpComposable.asView(self.name .. "ActionsItemButton"):asButton():setText(1079812):addAction(
            UusCorpViewAction.onLButtonUp(function ()
                ToggleWindowByName("ActionsWindow", "")
                self:show(false)
            end)
        )
    ):addChild(
        UusCorpComposable.asView(self.name .. "HelpItemButton"):asButton():setText(1061037):addAction(
            UusCorpViewAction.onLButtonUp(function ()
                EventApi.broadcast(SystemData.Events.REQUEST_OPEN_HELP_MENU)
                self:show(false)
            end)
        )
    ):addChild(
        UusCorpComposable.asView(self.name .. "UOStoreItemButton"):asButton():setText(L"Store"):addAction(
            UusCorpViewAction.onLButtonUp(function ()
                EventApi.broadcast(SystemData.Events.UO_STORE_REQUEST)
                self:show(false)
            end)
        )
    ):addChild(
        UusCorpComposable.asView(self.name .. "UserSettingsItemButton"):asButton():setText(L"Settings"):addAction(
            UusCorpViewAction.onLButtonUp(function ()
                ToggleWindowByName("SettingsWindow", "")
                self:show(false)
            end)
        )
    )
    UusCorpWindow.onInitialize(self)
end