LogApi = {}

function LogApi.showTimestamp(name, doShow)
    LogDisplaySetShowTimestamp(name, doShow == nil or doShow)
end

function LogApi.showLogName(name, doShow)
    LogDisplaySetShowLogName(name, doShow == nil or doShow)
end

function LogApi.showFilterName(name, doShow)
    LogDisplaySetShowFilterName(name, doShow == nil or doShow)
end

function LogApi.addLog(name, log, bool)
    LogDisplayAddLog(name, log, bool == nil or bool)
end

function LogApi.setFilterColor(name, log, level, color)
    LogDisplaySetFilterColor(name, log, level, color.r, color.g, color.b)
end

function LogApi.setFilterState(name, log, filterId, filter)
    LogDisplaySetFilterState(name, log, filterId, filter)
end