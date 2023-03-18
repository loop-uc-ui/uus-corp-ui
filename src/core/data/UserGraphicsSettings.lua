UserGraphicsSettings = {}

function UserGraphicsSettings.availableResolutions()
    return {
        widths = SystemData.AvailableResolutions.widths,
        heights = SystemData.AvailableResolutions.heights
    }
end

function UserGraphicsSettings.resolution(newValue)
    if newValue ~= nil then
        SystemData.Settings.Resolution.fullScreen.height = newValue.height
        SystemData.Settings.Resolution.fullScreen.width = newValue.width
    end
    return {
        height = SystemData.Settings.Resolution.fullScreen.height,
        width = SystemData.Settings.Resolution.fullScreen.width
    }
end

function UserGraphicsSettings.fullScreen(newValue)
    if newValue ~= nil then
        SystemData.Settings.Resolution.useFullScreen = newValue
    end
    return SystemData.Settings.Resolution.useFullScreen
end

function UserGraphicsSettings.frameRate(newValue)
    if newValue ~= nil then
        SystemData.Settings.Resolution.framerateMax = newValue
    end
    return SystemData.Settings.Resolution.framerateMax
end

function UserGraphicsSettings.particleDetail(newValue)
    if newValue ~= nil then
        SystemData.Settings.Resolution.particleLOD = newValue
    end
    return SystemData.Settings.Resolution.particleLOD
end

function UserGraphicsSettings.particleFilter(newValue)
    if newValue ~= nil then
        SystemData.Settings.Resolution.particleFilter = newValue
    end
    return SystemData.Settings.Resolution.particleFilter
end

function UserGraphicsSettings.animationDetail(newValue)
    if newValue ~= nil then
        SystemData.Settings.Optimization.frameSetRestriction = newValue
    end
    return SystemData.Settings.Optimization.frameSetRestriction
end

function UserGraphicsSettings.showFrame(newValue)
    if newValue ~= nil then
        SystemData.Settings.Resolution.showWindowFrame = newValue
    end
    return SystemData.Settings.Resolution.showWindowFrame
end

function UserGraphicsSettings.showShadows(newValue)
    if newValue ~= nil then
        SystemData.Settings.Resolution.showShadows = newValue
    end
    return SystemData.Settings.Resolution.showShadows
end

function UserGraphicsSettings.enableVSync(newValue)
    if newValue ~= nil then
        SystemData.Settings.Resolution.enableVSync = newValue
    end
    return SystemData.Settings.Resolution.enableVSync
end

function UserGraphicsSettings.circleOfTransparency(newValue)
    if newValue ~= nil then
        SystemData.Settings.GameOptions.circleOfTransEnabled = newValue
    end
    return SystemData.Settings.GameOptions.circleOfTransEnabled
end

function UserGraphicsSettings.hardwareDeathEffect(newValue)
    if newValue ~= nil then
        SystemData.Settings.GameOptions.useHardwareDeathEffect = newValue
    end
    return SystemData.Settings.GameOptions.useHardwareDeathEffect
end

function UserGraphicsSettings.idleAnimation(newValue)
    if newValue ~= nil then
        SystemData.Settings.Optimization.idleAnimation = newValue
    end
    return SystemData.Settings.Optimization.idleAnimation
end

function UserGraphicsSettings.flyingAnimation(newValue)
    if newValue ~= nil then
        SystemData.Settings.Optimization.bEnableFlyingAnimation = newValue
    end
    return SystemData.Settings.Optimization.bEnableFlyingAnimation
end

function UserGraphicsSettings.displayHousingContents(newValue)
    if newValue ~= nil then
        SystemData.Settings.Optimization.bDisplayAllHouseContents = newValue
    end
    return SystemData.Settings.Optimization.bDisplayAllHouseContents
end

function UserGraphicsSettings.foliage(newValue)
    if newValue ~= nil then
        SystemData.Settings.Resolution.displayFoliage = newValue
    end
    return SystemData.Settings.Resolution.displayFoliage
end

function UserGraphicsSettings.gamma(newValue)
    if newValue ~= nil then
        SystemData.Settings.Resolution.gamma = newValue
    end
    return SystemData.Settings.Resolution.gamma
end