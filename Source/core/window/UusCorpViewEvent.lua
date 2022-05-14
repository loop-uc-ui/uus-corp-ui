UusCorpViewEvent = {}
UusCorpViewEvent.__index = UusCorpViewEvent

UusCorpViewEvent.Names = {
    OnRButtonUp = "OnRButtonUp",
    OnLButtonUp = "OnLButtonUp",
    OnRButtonDown = "OnRButtonDown",
    OnLButtonDown = "OnLButtonDown"
}

function UusCorpViewEvent.new(name, onUpdate)
    local this = setmetatable({
        name = name
    }, UusCorpViewEvent)

    if onUpdate then
        this.func = function (...)
            onUpdate(...)
        end
    end

    return this
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