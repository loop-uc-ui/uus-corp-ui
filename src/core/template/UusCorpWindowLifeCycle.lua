---@class UusCorpWindowLifeCycle:UusCorpEventHandler
UusCorpWindowLifeCycle = UusCorpEventHandler:new {
    name = "UusCorpWindowLifeCycle"
}

UusCorpWindowLifeCycle.Windows = {}

local function getWindow()
    return UusCorpWindowLifeCycle.Windows[Active.window()]
end

function UusCorpWindowLifeCycle.onInitialize()
    UusCorpEventHandler.onInitialize(getWindow())
end

function UusCorpWindowLifeCycle.onShown()
    UusCorpEventHandler.onShown(getWindow())
end

function UusCorpWindowLifeCycle.onRButtonDown(x, y, flags)
    UusCorpEventHandler.onRButtonDown(getWindow(), x, y, flags)
end