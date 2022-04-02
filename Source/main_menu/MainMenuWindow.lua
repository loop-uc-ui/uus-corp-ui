MainMenuWindow = setmetatable({}, {__index = UusCorpWindow})
MainMenuWindow.__index = MainMenuWindow

function MainMenuWindow:init()
    local this = setmetatable(
        UusCorpWindow.init(self, "MainMenuWindow"),
        self
    )
    
    local function makeButton(button, text, onClick)
        local view = UusCorpView:init(this.name .. button .. "Item")
    
        view.eventAdapter:onLButtonUp(function ()
            onClick()
            this:setShowing(false)
        end)


        local textView = UusCorpLabel:init(view.name .. "Text", text)

        this.childAdapter:addChild(view)
        this.childAdapter:addChild(textView)
    end

    makeButton("ExitGame", 1077859,
        function () InterfaceCore.OnExitGame() end)

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

    return this
end
