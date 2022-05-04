UusCorpViewEvent = {}
UusCorpViewEvent.__index = UusCorpViewEvent

UusCorpViewEvent.Names = {
    OnRButtonUp = "OnRButtonUp",
    OnLButtonUp = "OnLButtonUp",
    OnRButtonDown = "OnRButtonDown",
    OnLButtonDown = "OnLButtonDown"
}

function UusCorpViewEvent.new(name, func)
    return setmetatable({
        name = name,
        func = function (...)
            func(...)
        end
    }, UusCorpViewEvent)
end

function UusCorpViewEvent.onRButtonUp(func)
    return UusCorpViewEvent.new(UusCorpViewEvent.Names.OnRButtonUp, func)
end

function UusCorpViewEvent.onRButtonDown(func)
    return UusCorpViewEvent.new(UusCorpViewEvent.Names.OnRButtonDown, func)
end

function UusCorpViewEvent.onLButtonUp(func)
    return UusCorpViewEvent.new(UusCorpViewEvent.Names.OnLButtonUp, func)
end

function UusCorpViewEvent.onLButtonDown(func)
    return UusCorpViewEvent.new(UusCorpViewEvent.Names.OnLButtonDown, func)
end