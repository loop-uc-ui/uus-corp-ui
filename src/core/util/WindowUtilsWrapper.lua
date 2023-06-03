WindowUtilsWrapper = {}

function WindowUtilsWrapper.restoreWindowPosition(window, trackSize, alias, ignoreBounds)
    WindowUtils.RestoreWindowPosition(window, trackSize, alias, ignoreBounds)
end

function WindowUtilsWrapper.saveWindowPosition(window, closing, alias)
    WindowUtils.SaveWindowPosition(window, closing, alias)
end