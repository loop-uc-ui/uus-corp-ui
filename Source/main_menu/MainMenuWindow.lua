MainMenuWindow = middleclass.class("MainMenuWindow", UusCorpWindow)

function MainMenuWindow:init()
    UusCorpWindow.init(self, "MainMenuWindow")
    self:addChild(UusCorpLabel:new(self.name .. "ExitGameItemText", 1077859))
    
    self:makeButton("LogOut", 3000128, function()
        EventApi.broadcast(SystemData.Events.LOG_OUT)
    end)
    
    self:makeButton("UserSettings", L"Settings", function()
        ToggleWindowByName("SettingsWindow", "")
    end)

    self:makeButton("AgentsSettings", L"Agents", function()
        ToggleWindowByName("OrganizerWindow", "")
    end)

    self:makeButton("Macros", 3000172, function()
        ToggleWindowByName("MacroWindow", "")
    end)

    self:makeButton("Actions", 1079812, function()
        ToggleWindowByName("ActionsWindow", "")
    end)

    self:makeButton("Help", 1061037, function()
        EventApi.broadcast(SystemData.Events.REQUEST_OPEN_HELP_MENU)
    end)

    self:makeButton("UOStore", L"Store", function()
        EventApi.broadcast(SystemData.Events.UO_STORE_REQUEST)
    end)

    self:makeButton("Debug", L"Debug", function()
        ToggleWindowByName("DebugWindow", "")
    end)
end

function MainMenuWindow:onRButtonUp()
    self:setShowing(false)
end

function MainMenuWindow:makeButton(button, text, onClick)
    local view = UusCorpView:new(self.name .. button .. "Item")
    view.onLButtonUp = function()
        onClick()
        self:setShowing(false)
    end

    local textView = UusCorpLabel:new(view.name .. "Text", text)

    self:addChild(view)
    self:addChild(textView)
end
