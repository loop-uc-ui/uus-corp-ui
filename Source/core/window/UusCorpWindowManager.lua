UusCorpWindowManager = {}

UusCorpWindowManager.Windows = {}

local function findChild(name)
    for _, value in pairs(UusCorpWindowManager.Windows) do
        for k, v in pairs(value.children) do
            if k == name then
                return v
            end
        end
    end
end

local function findActiveWindow()
    local active = ActiveWindow.name()
    local window = UusCorpWindowManager.Windows[active]

    if window == nil then
        window = findChild(active)
    end

    return window
end

function UusCorpWindowManager.onInitialize()
    local activeWindow = findActiveWindow()
    
    if UusCorpWindowManager.Windows[activeWindow.name] then
        WindowUtils.RestoreWindowPosition(activeWindow.name, true)    
    end

    findActiveWindow().onInitialize()
end

function UusCorpWindowManager.onShutdown()
    local activeWindow = findActiveWindow()
    
    if UusCorpWindowManager.Windows[activeWindow.name] then
        WindowUtils.SaveWindowPosition(StatusWindow.id)
    end

    activeWindow.onShutdown()
    UusCorpWindowManager.Windows[activeWindow.name] = nil
end

function UusCorpWindowManager.onLButtonUp(flags, x, y)
    findActiveWindow().onLButtonUp(flags, x, y)
end

function UusCorpWindowManager.onLButtonDown(flags, x, y)
    findActiveWindow().onLButtonDown(flags, x, y)
end

function UusCorpWindowManager.onRButtonUp(flags, x, y)
    findActiveWindow().onRButtonUp(flags, x, y)
end

function UusCorpWindowManager.onRButtonDown(flags, x, y)
    findActiveWindow().onRButtonDown(flags, x, y)
end
