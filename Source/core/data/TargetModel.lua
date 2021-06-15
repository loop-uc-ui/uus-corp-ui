TargetModel = {}

function TargetModel.dataRegister()
    return WindowData.CurrentTarget.Type
end

function TargetModel.type()
    return WindowData.CurrentTarget.TargetType
end

function TargetModel.id()
    return WindowData.CurrentTarget.TargetId
end

function TargetModel.exists()
    return WindowData.CurrentTarget.HasTarget
end

function TargetModel.event()
    return WindowData.CurrentTarget.Event
end

function TargetModel.isMobile()
    return TargetModel.type() == 2
end

function TargetModel.isObject()
    return TargetModel.type() == 3
end

function TargetModel.isCorpse()
    return TargetModel.type() == 4
end