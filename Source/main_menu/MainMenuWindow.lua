
MainMenuWindow = UusCorpWindow.new("MainMenuWindow")

MainMenuWindow.onInitialize = function ()
    MainMenuWindow:makeButton(
            "LogOut",
            3000128,
            function () 
                EventApi.broadcast(SystemData.Events.LOG_OUT)
            end
        ):addChild(
            UusCorpLabel.new(MainMenuWindow.name.."ExitGameItemText"):setText(1077859)
        ):makeButton(
            "UserSettings",
            L"Settings",
            function () 
                ToggleWindowByName("SettingsWindow", "")
            end
        ):makeButton(
            "AgentsSettings",
            L"Agents",
            function () 
                ToggleWindowByName("OrganizerWindow", "")
            end
        ):makeButton(
            "Macros",
            3000172,
            function () 
                ToggleWindowByName("MacroWindow", "")
            end
        ):makeButton(
            "Actions",
            1079812,
            function () 
                ToggleWindowByName("ActionsWindow", "")
            end
        ):makeButton(
            "Help",
            1061037,
            function () 
                EventApi.broadcast(SystemData.Events.REQUEST_OPEN_HELP_MENU)
            end
        ):makeButton(
            "UOStore",
            L"Store",
            function () 
                EventApi.broadcast(SystemData.Events.UO_STORE_REQUEST)
            end
        ):makeButton(
            "Debug",
            L"Debug",
            function () 
                ToggleWindowByName("DebugWindow", "")
            end
        )
end

MainMenuWindow.onRButtonUp = function ()
    MainMenuWindow:hide()
end

function MainMenuWindow:makeButton(button, text, onClick)
    local view = UusCorpView.new(self.name..button.."Item")
    view.onLButtonUp = function()
        onClick()
        self:hide()
    end
    
    return self:addChild(
        view
    ):addChild(
        UusCorpLabel.new(view.name.."Text"):setText(text)
    )
end
