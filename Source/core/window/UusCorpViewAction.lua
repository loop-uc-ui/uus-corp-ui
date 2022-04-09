UusCorpViewAction = {}
UusCorpViewAction.__index = UusCorpViewAction

UusCorpViewAction.Names = {
    OnRButtonUp = "OnRButtonUp",
    OnLButtonUp = "OnLButtonUp",
    OnRButtonDown = "OnRButtonDown",
    OnLButtonDown = "OnLButtonDown"
}

local function action(name, func)
    return setmetatable({
        name = name,
        callback = "UusCorpViewActionManager" .. "." .. name,
        func = function (...)
            func(...)
        end
    }, UusCorpViewAction)
end

function UusCorpViewAction:onRButtonUp(func)
    return action(UusCorpViewAction.Names.OnRButtonUp, func)
end

function UusCorpViewAction:onRButtonDown(func)
    return action(UusCorpViewAction.Names.OnRButtonDown, func)
end

function UusCorpViewAction:onLButtonUp(func)
    return action(UusCorpViewAction.Names.OnLButtonUp, func)
end

function UusCorpViewAction:onLButtonDown(func)
    return action(UusCorpViewAction.Names.OnLButtonDown, func)
end