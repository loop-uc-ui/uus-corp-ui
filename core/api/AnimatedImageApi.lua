AnimatedImageApi = {}

AnimatedImageApi.Animations = {
    MobileArrow = "MobileArrowAnim"
}

function AnimatedImageApi.setTexture(imageName, texture)
    AnimatedImageSetTexture(imageName, texture)
end

function AnimatedImageApi.startAnimation(imageName, startFrame, loop, hideWhenDone, delay)
    AnimatedImageStartAnimation(imageName, startFrame, loop, hideWhenDone, delay)
end

function AnimatedImageApi.stopAnimation(imageName)
    AnimatedImageStopAnimation(imageName)
end

function AnimatedImageApi.setPlaySpeed(imageName, fps)
    AnimatedImageSetPlaySpeed(imageName, fps)
end