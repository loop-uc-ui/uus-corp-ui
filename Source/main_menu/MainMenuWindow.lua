



MainMenuWindow = UusCorpWindow.new("MainMenuWindow")
MainMenuWindow:addChild(UusCorpLabel.new(MainMenuWindow.name.."ExitGameItemText", 1077859))

function MainMenuWindow:onRButtonUp() 
    MainMenuWindow:setShowing(false)
end

local function makeButton(button, text, onClick)
    local view = UusCorpView.new(MainMenuWindow.name..button.."Item")
    view.onLButtonUp = function()
        onClick()
        MainMenuWindow:setShowing(false)
    end
    
    local textView = UusCorpLabel.new(view.name.."Text", text)

    MainMenuWindow:addChild(view)
    MainMenuWindow:addChild(textView)
end

makeButton(
    "LogOut",
    3000128,
    function ()
        EventApi.broadcast(SystemData.Events.LOG_OUT)
    end
)

makeButton(
    "UserSettings",
    L"Settings",
    function () 
        ToggleWindowByName("SettingsWindow", "")
    end
)

makeButton(
    "AgentsSettings",
    L"Agents",
    function () 
        ToggleWindowByName("OrganizerWindow", "")
    end
)

makeButton(
    "Macros",
    3000172,
    function () 
        ToggleWindowByName("MacroWindow", "")
    end
)

makeButton(
    "Actions",
    1079812,
    function () 
        ToggleWindowByName("ActionsWindow", "")
    end
)

makeButton(
    "Help",
    1061037,
    function () 
        EventApi.broadcast(SystemData.Events.REQUEST_OPEN_HELP_MENU)
    end
)

makeButton(
    "UOStore",
    L"Store",
    function () 
        EventApi.broadcast(SystemData.Events.UO_STORE_REQUEST)
    end
)

makeButton(
    "Debug",
    L"Debug",
    function () 
        ToggleWindowByName("DebugWindow", "")
    end
)
