UusCorpDebugWindow = {}
UusCorpDebugWindow.Name = "UusCorpDebugWindow"

local LuaLog = {}
LuaLog.SYSTEM = 1
LuaLog.ERROR = 2
LuaLog.DEBUG = 3
LuaLog.FUNCTION = 4

local debugPrint = "DebugPrint"
local uiLog = "UiLog"

function UusCorpDebugWindow.onInitialize()
    TextLogApi.createTextLog(debugPrint, 1)
    TextLogApi.enableLog(debugPrint)
    TextLogApi.clearLog(debugPrint)

    local text = UusCorpDebugWindow.Name .. "Text"
    LogDisplayApi.showTimestamp(text)
    LogDisplayApi.showLogName(text)
    LogDisplayApi.showFilterName(text)

    LogDisplayApi.addLog(text, uiLog)

    LogDisplayApi.setFilterColor(text, uiLog, LuaLog.SYSTEM, { r = 255, g = 0, b = 255 }) -- Magenta
    LogDisplayApi.setFilterColor(text, uiLog, LuaLog.ERROR, { r = 255, g = 0, b = 0}) -- Red
    LogDisplayApi.setFilterColor(text, uiLog, LuaLog.DEBUG, { r = 255, g = 255, b = 0}) -- Yellow
    LogDisplayApi.setFilterColor(text, uiLog, LuaLog.FUNCTION, { r = 0, g = 175, b = 50}) -- Green
    LogDisplayApi.setFilterColor(text, uiLog, LuaLog.WARNING, { r = 0, g = 175, b = 50}) -- Green

    TextLogApi.enableLog(uiLog)

    for index = 1, #DevData.DebugWindow.luaFilters do
        LogDisplayApi.setFilterState(
            text,
            uiLog,
            index,
            true
        )
    end
end

function UusCorpDebugWindow.onShutdown()
    TextLogApi.enableLog(debugPrint, false)
    TextLogApi.destroyTextLog(debugPrint)
    TextLogApi.enableLog(uiLog, false)
    TextLogApi.destroyTextLog(uiLog)
end

function UusCorpDebugWindow.OnResizeBegin()
    WindowUtils.BeginResize(UusCorpDebugWindow.Name, "topleft", 300, 200, false, function ()
        WindowApi.forceProcessAnchors(UusCorpDebugWindow.Name)
    end)
end

function UusCorpDebugWindow.onRightClick()
    WindowApi.destroyWindow(UusCorpDebugWindow.Name)
end
