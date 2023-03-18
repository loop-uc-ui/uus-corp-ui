LogDisplayApi = {}

function LogDisplayApi.showTimestamp(name, doShow)
    LogDisplaySetShowTimestamp(name, doShow == nil or doShow)
end

function LogDisplayApi.getShowTimestamp(name)
    return LogDisplayGetShowTimestamp(name)
end

function LogDisplayApi.showLogName(name, doShow)
    LogDisplaySetShowLogName(name, doShow == nil or doShow)
end

function LogDisplayApi.showFilterName(name, doShow)
    LogDisplaySetShowFilterName(name, doShow == nil or doShow)
end

function LogDisplayApi.addLog(name, log, bool)
    LogDisplayAddLog(name, log, bool == nil or bool)
end

function LogDisplayApi.removeLog(name, log)
    LogDisplayRemoveLog(name, log)
end

function LogDisplayApi.setFilterColor(name, log, level, color)
    LogDisplaySetFilterColor(name, log, level, color.r, color.g, color.b)
end

function LogDisplayApi.setFilterState(name, log, filterId, filter)
    LogDisplaySetFilterState(name, log, filterId, filter)
end

function LogDisplayApi.setTextFadeTime(name, time)
    LogDisplaySetTextFadeTime(name, time)
end

function LogDisplayApi.getTextFadeTime(name)
    return LogDisplayGetTextFadeTime(name)
end

function LogDisplayApi.isScrollbarActive(name)
    return LogDisplayIsScrollbarActive(name)
end

function LogDisplayApi.setFont(name, font)
    LogDisplaySetFont(name, font)
end

function LogDisplayApi.getFont(name)
    return LogDisplayGetFont(name)
end

function LogDisplayApi.scrollToBottom(name)
    LogDisplayScrollToBottom(name)
end

function LogDisplayApi.isScrollToBottom(name)
    return LogDisplayIsScrolledToBottom(name)
end

function LogDisplayApi.resetLineFadeTime(name)
    LogDisplayResetLineFadeTime(name)
end

function LogDisplayApi.showScrollbar(name, showScrollbar)
    LogDisplayShowScrollbar(name, showScrollbar)
end

function LogDisplayApi.scrollToTop(name)
    LogDisplayScrollToTop(name)
end

function LogDisplayApi.isScrolledToTop(name)
    return LogDisplayIsScrolledToTop(name)
end