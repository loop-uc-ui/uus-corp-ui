UusCorpDebugWindow = UusCorpComposable:asView("UusCorpDebugWindow"):asWindow()

local LuaLog = {}
LuaLog.SYSTEM = 1
LuaLog.ERROR = 2
LuaLog.DEBUG = 3
LuaLog.FUNCTION = 4

local debugPrint = "DebugPrint"
local uiLog = "UiLog"

function UusCorpDebugWindow:onInitialize()
    TextLogApi.createTextLog(debugPrint, 1)
    TextLogApi.enableLog(debugPrint)
    TextLogApi.clearLog(debugPrint)

    local text = self.name .. "Text"
    LogApi.showTimestamp(text)
    LogApi.showLogName(text)
    LogApi.showFilterName(text)

    LogApi.addLog(text, uiLog)

    LogApi.setFilterColor(text, uiLog, LuaLog.SYSTEM, { r = 255, g = 0, b = 255 }) -- Magenta
    LogApi.setFilterColor(text, uiLog, LuaLog.ERROR, { r = 255, g = 0, b = 0}) -- Red
    LogApi.setFilterColor(text, uiLog, LuaLog.DEBUG, { r = 255, g = 255, b = 0}) -- Yellow
    LogApi.setFilterColor(text, uiLog, LuaLog.FUNCTION, { r = 0, g = 175, b = 50}) -- Green
    LogApi.setFilterColor(text, uiLog, LuaLog.WARNING, { r = 0, g = 175, b = 50}) -- Green

    TextLogApi.enableLog(uiLog)

    for index = 1, #DevData.DebugWindow.luaFilters do
        LogDisplaySetFilterState("UusCorpDebugWindowText", "UiLog", index,
                                 true)
    end

    UusCorpWindow.onInitialize(self)
end

function UusCorpDebugWindow:onShutdown()
    TextLogApi.enableLog(debugPrint, false)
    TextLogApi.enableLog(uiLog, false)
    UusCorpWindow.onShutdown(self)
end

function UusCorpDebugWindow.OnResizeBegin()
    WindowUtils.BeginResize("UusCorpDebugWindow", "topleft", 300, 200, false, nil)
end
