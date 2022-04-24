UusCorpViewActionManager = {}

UusCorpViewActionManager.Views = {}

function UusCorpViewActionManager.OnRButtonUp(flag, x, y)
    local view = UusCorpViewActionManager.Views[ActiveWindow.name()]
    view.actions[UusCorpViewAction.Names.OnRButtonUp].func(view, flag, x, y)
end

function UusCorpViewActionManager.OnRButtonDown(flag, x, y)
    local view = UusCorpViewActionManager.Views[ActiveWindow.name()]
    view.actions[UusCorpViewAction.Names.OnRButtonDown].func(view, flag, x, y)
end

function UusCorpViewActionManager.OnLButtonUp(flag, x, y)
    local view = UusCorpViewActionManager.Views[ActiveWindow.name()]
    view.actions[UusCorpViewAction.Names.OnLButtonUp].func(view, flag, x, y)
end

function UusCorpViewActionManager.OnLButtonDown(flag, x, y)
    local view = UusCorpViewActionManager.Views[ActiveWindow.name()]
    view.actions[UusCorpViewAction.Names.OnLButtoDown].func(view, flag, x, y)
end

function UusCorpViewActionManager.OnEvent()
    UusCorpViewActionManager.Views[ActiveWindow.name()]:onEvent()
end