Animation = {}

function Animation.single()
    return Window.AnimationType.SINGLE
end

function Animation.singleNoReset()
    return Window.AnimationType.SINGLE_NO_RESET
end

function Animation.easeOut()
    return Window.AnimationType.EASE_OUT
end

function Animation.loop()
    return Window.AnimationType.LOOP
end

function Animation.repeating()
    return Window.AnimationType.REPEAT
end

function Animation.pop()
    return Window.AnimationType.POP
end

function Animation.popAndEase()
    return Window.AnimationType.POP_AND_EASE
end