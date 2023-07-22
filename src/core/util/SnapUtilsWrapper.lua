SnapUtilsWrapper = {}

function SnapUtilsWrapper.addWindow(windowName)
    SnapUtils.SnappableWindows[windowName] = true
end

function SnapUtilsWrapper.removeWindow(windowName)
    SnapUtils.SnappableWindows[windowName] = nil
end

function SnapUtilsWrapper.startSnap(windowName)
    SnapUtils.StartWindowSnap(windowName)
end