UusCorpRoot = UusCorpLifeCycle()
UusCorpRoot.Windows = {}

local function getActiveView()
    local active = ActiveWindow.name()
    for key, value in pairs(UusCorpRoot.Windows) do
        if string.find(active, key) then return value end
    end
end

UusCorpRoot.onInitialize = function()
    getActiveView().getLifeCycle().onInitialize(ActiveWindow.name())
end

UusCorpRoot.onShutdown = function()
    local view = getActiveView()
    view.getLifeCycle().onShutdown(ActiveWindow.name())
    UusCorpRoot.Windows[view.getName()] = nil
end

UusCorpRoot.onLButtonUp = function(flag, x, y)
    getActiveView().getLifeCycle().onLButtonUp(flag, x, y, ActiveWindow.name())
end

UusCorpRoot.onLButtonDown = function(flag, x, y)
    getActiveView().getLifeCycle()
        .onLButtonDown(flag, x, y, ActiveWindow.name())
end

UusCorpRoot.onRButtonUp = function(flag, x, y)
    getActiveView().getLifeCycle().onRButtonUp(flag, x, y, ActiveWindow.name())
end

UusCorpRoot.onRButtonDown = function(flag, x, y)
    getActiveView().getLifeCycle()
        .onRButtonDown(flag, x, y, ActiveWindow.name())
end

UusCorpRoot.onEvent = function()
    getActiveView().getLifeCycle().onEvent(ActiveWindow.name())
end
