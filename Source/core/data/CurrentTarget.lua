CurrentTarget = {}

function CurrentTarget.dataType()
    return WindowData.CurrentTarget.Type
end

function CurrentTarget.targetType()
    return WindowData.CurrentTarget.TargetType
end

function CurrentTarget.id()
    return WindowData.CurrentTarget.TargetId
end

function CurrentTarget.exists()
    return WindowData.CurrentTarget.HasTarget
end

function CurrentTarget.event()
    return WindowData.CurrentTarget.Event
end

function CurrentTarget.isMobile()
    return CurrentTarget.type() == 2
end

function CurrentTarget.isObject()
    return CurrentTarget.type() == 3
end

function CurrentTarget.isCorpse()
    return CurrentTarget.type() == 4
end