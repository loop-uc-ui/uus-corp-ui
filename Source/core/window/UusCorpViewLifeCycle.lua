UusCorpViewLifeCycle = {}
UusCorpViewLifeCycle.__index = UusCorpViewLifeCycle
UusCorpViewLifeCycle.Views = {}

function UusCorpViewLifeCycle.onInitialize()
    UusCorpViewLifeCycle.Views[ActiveWindow.name()]:onInitialize()
end

function UusCorpViewLifeCycle.onShutdown()
    local window = ActiveWindow.name()
    UusCorpViewLifeCycle.Views[window]:onShutdown()
    UusCorpViewLifeCycle.Views[window] = nil
end

function UusCorpViewLifeCycle.onShown()
    UusCorpViewLifeCycle.Views[ActiveWindow.name()]:onShown()
end

function UusCorpViewLifeCycle.onLButtonUp(flags, x, y)
    UusCorpViewLifeCycle.Views[ActiveWindow.name()]:onLButtonUp(flags, x, y)
end

function UusCorpViewLifeCycle.onRButtonUp(flags, x, y) 
    UusCorpViewLifeCycle.Views[ActiveWindow.name()]:onRButtonUp(flags, x, y)
end

function UusCorpViewLifeCycle.onRButtonDown(flags, x, y)
    UusCorpViewLifeCycle.Views[ActiveWindow.name()]:onRButtonDown(flags, x, y)
 end