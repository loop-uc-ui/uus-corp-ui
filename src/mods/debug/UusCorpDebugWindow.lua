UusCorpDebugWindow = {}
UusCorpDebugWindow.Name = "DebugWindow"

local LuaLog = {}
LuaLog.SYSTEM = 1
LuaLog.ERROR = 2
LuaLog.DEBUG = 3
LuaLog.FUNCTION = 4

local debugPrint = "DebugPrint"
local uiLog = "UiLog"

function UusCorpDebugWindow.initialize()
    UusCorpCore.loadResources(
        "/src/mods/debug",
        "UusCorpDebugWindow.xml"
    )

    WindowApi.destroyWindow(UusCorpDebugWindow.Name)

    DebugWindow.Initialize = function ()
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

    WindowApi.createFromTemplate(UusCorpDebugWindow.Name, UusCorpDebugWindow.Name, "Root")
    WindowApi.setShowing(UusCorpDebugWindow.Name, false)
end

function UusCorpDebugWindow.onShown()
    DebugWindow.logging = true
end

function UusCorpDebugWindow.onHidden()
    DebugWindow.logging = false
end

function UusCorpDebugWindow.OnResizeBegin()
    WindowUtils.BeginResize(UusCorpDebugWindow.Name, "topleft", 300, 200, false, function ()
        WindowApi.forceProcessAnchors(UusCorpDebugWindow.Name)
    end)
end

function UusCorpDebugWindow.onRightClick()
    WindowApi.setShowing(UusCorpDebugWindow.Name, false)
end
