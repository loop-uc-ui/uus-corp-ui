ButtonFlags = {}

function ButtonFlags.flags()
    return SystemData.ButtonFlags
end

function ButtonFlags.isControl(flag)
    return ButtonFlags.flags().CONTROL == flag
end

function ButtonFlags.isShift(flag)
    return ButtonFlags.flags().SHIFT == flag
end