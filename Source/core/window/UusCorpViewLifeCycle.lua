UusCorpViewLifeCycle = {}
UusCorpViewLifeCycle.Windows = {}
ROOT_WINDOW = "Root"

local function getActiveView()
    local active = ActiveWindow.name()
    for key, value in pairs(UusCorpViewLifeCycle.Windows) do
        if string.find(active, key) then
            return value
        end
    end
end

function UusCorpViewLifeCycle.onInitialize()
    getActiveView():onInitialize(ActiveWindow.name())
end

function UusCorpViewLifeCycle.onShutdown()
    local window = getActiveView()
    window:onShutdown(ActiveWindow.name())
    UusCorpViewLifeCycle.Windows[window.name] = nil
end

function UusCorpViewLifeCycle.onShown()
    getActiveView():onShown(ActiveWindow.name())
end

function UusCorpViewLifeCycle.onLButtonUp(flags, x, y)
    getActiveView():onLButtonUp(flags, x, y, ActiveWindow.name())
end

function UusCorpViewLifeCycle.onRButtonUp(flags, x, y)
    getActiveView():onRButtonUp(flags, x, y, ActiveWindow.name())
end

function UusCorpViewLifeCycle.onRButtonDown(flags, x, y)
    getActiveView():onRButtonDown(flags, x, y, ActiveWindow.name())
 end