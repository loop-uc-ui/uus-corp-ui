UusCorpRoot = {}

UusCorpRoot.Windows = {}

UusCorpRoot.Name = "Root"

local function getActiveView()
    local active = ActiveWindow.name()
    local view

    for key, value in pairs(UusCorpRoot.Windows) do
        if string.find(active, key) then 
            view = value
            break
        end
    end

    if view.name == active then
        return view
    end

    for _, value in pairs(view.childAdapter.children) do
        if value.name == active then
            return value
        end
    end
end

UusCorpRoot.onShutdown = function()
    local view = getActiveView()
    view.eventAdapter.coreEvents.onShutdown.windowCallback()
    UusCorpRoot.Windows[view.name] = nil
    view = nil
end

UusCorpRoot.onShown = function ()
    getActiveView().eventAdapter.coreEvents.onShown.windowCallback()
end

UusCorpRoot.onLButtonUp = function(flag, x, y)
    getActiveView().eventAdapter.coreEvents.onLButtonUp.windowCallback(flag, x, y)
end

UusCorpRoot.onLButtonDown = function(flag, x, y)
    getActiveView().eventAdapter.coreEvents.onLButtonDown.windowCallback(flag, x, y)
end

UusCorpRoot.onRButtonUp = function(flag, x, y)
    getActiveView().eventAdapter.coreEvents.onRButtonUp.windowCallback(flag, x, y)
end

UusCorpRoot.onRButtonDown = function(flag, x, y)
    getActiveView().eventAdapter.coreEvents.onRButtonDown.windowCallback(flag, x, y)
end

UusCorpRoot.onEvent = function()
    getActiveView().eventAdapter.event.windowCallback()
end
