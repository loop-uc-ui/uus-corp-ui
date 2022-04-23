UusCorpDebugWindow = UusCorpComposable:asView("UusCorpDebugWindow"):asWindow()

local LuaLog = {}
LuaLog.SYSTEM = 1
LuaLog.ERROR = 2
LuaLog.DEBUG = 3
LuaLog.FUNCTION = 4

function UusCorpDebugWindow:onInitialize()
    local debugPrint = "DebugPrint"
    TextLogApi.createTextLog(debugPrint, 1)
    TextLogApi.enableLog(debugPrint)
    TextLogApi.clearLog(debugPrint)

    local text = self.name .. "Text"
    LogApi.showTimestamp(text)
    LogApi.showLogName(text)
    LogApi.showFilterName(text)

    local uiLog = "UiLog"
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

    Debug.Print(DevData.DebugWindow.luaFilters)
    UusCorpWindow.onInitialize(self)
end

function UusCorpDebugWindow.OnResizeBegin()
    WindowUtils.BeginResize("UusCorpDebugWindow", "topleft", 300, 200, false, nil)
end

function UusCorpDebugWindow.ReloadUIHover()
    Tooltips.CreateTextOnlyTooltip("UusCorpDebugWindowReloadUi",
                                   StringToWString("Reload UI"))
    Tooltips.Finalize()
    Tooltips.AnchorTooltip(Tooltips.ANCHOR_WINDOW_TOP)
end