MainMenuWindow = {
    Name = "MainMenuWindow",
    init = function()
        local self = UusCorpWindow.init(MainMenuWindow.Name)
        self.doDestroy = false

        local function makeButton(button, text, onClick)
            local view = UusCorpView.init(self.getName() .. button .. "Item")
            view.getLifeCycle().onLButtonUp = function()
                onClick()
                self.setShowing(false)
            end

            local textView = UusCorpLabel.init(view.getName() .. "Text", text)

            self.addChild(view)
            self.addChild(textView)
        end

        self.addChild(UusCorpLabel.init(self.getName() .. "ExitGameItemText", 1077859))

        makeButton("LogOut", 3000128,
                function() EventApi.broadcast(SystemData.Events.LOG_OUT) end)

        makeButton("UserSettings", L"Settings",
                function() ToggleWindowByName("SettingsWindow", "") end)

        makeButton("AgentsSettings", L"Agents",
                function() ToggleWindowByName("OrganizerWindow", "") end)

        makeButton("Macros", 3000172,
                function() ToggleWindowByName("MacroWindow", "") end)

        makeButton("Actions", 1079812,
                function() ToggleWindowByName("ActionsWindow", "") end)

        makeButton("Help", 1061037, function()
            EventApi.broadcast(SystemData.Events.REQUEST_OPEN_HELP_MENU)
        end)

        makeButton("UOStore", L"Store", function()
            EventApi.broadcast(SystemData.Events.UO_STORE_REQUEST)
        end)

        makeButton("Debug", L"Debug",
                function() ToggleWindowByName("DebugWindow", "") end)

        return self
    end
}
