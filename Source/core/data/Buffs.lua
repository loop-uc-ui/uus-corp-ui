Buffs = {}

function Buffs.event()
    return WindowData.BuffDebuff.Event
end

function Buffs.dataType()
   return WindowData.BuffDebuff.Type
end

function Buffs.id()
    return WindowData.BuffDebuffSystem.CurrentBuffId
end

function Buffs.data()
    return WindowData.BuffDebuff
end

function Buffs.timer()
    return WindowData.BuffDebuff.TimerSeconds
end

function Buffs.hasTimer()
    return WindowData.BuffDebuff.HasTimer
end

function Buffs.nameVectorSize()
    return WindowData.BuffDebuff.NameVectorSize
end

function Buffs.toolTipVectorSize()
    return WindowData.BuffDebuff.ToolTipVectorSize
end

function Buffs.isBeingRemoved()
    return WindowData.BuffDebuff.IsBeingRemoved
end

function Buffs.nameVector()
    return WindowData.BuffDebuff.NameWStringVector
end

function Buffs.toolTipVector()
    return WindowData.BuffDebuff.ToolTipWStringVector
end

function Buffs.csv()
    return WindowData.BuffDataCSV
end