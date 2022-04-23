UusCorpDebugWindow = {}

local LuaLog = {}
LuaLog.SYSTEM = 1
LuaLog.ERROR = 2
LuaLog.DEBUG = 3
LuaLog.FUNCTION = 4

UusCorpDebugWindow.logging = false

-- OnInitialize Handler
function UusCorpDebugWindow.Initialize()
    TextLogCreate("DebugPrint", 1)
    TextLogSetEnabled("DebugPrint", true)
    TextLogClear("DebugPrint")

    -- Display Settings
    LogDisplaySetShowTimestamp("UusCorpDebugWindowText", true)
    LogDisplaySetShowLogName("UusCorpDebugWindowText", true)
    LogDisplaySetShowFilterName("UusCorpDebugWindowText", true)

    -- Add the Lua Log
    LogDisplayAddLog("UusCorpDebugWindowText", "UiLog", true)

    LogDisplaySetFilterColor("UusCorpDebugWindowText", "UiLog", LuaLog.SYSTEM, 255, 0,
                             255) -- Magenta
    LogDisplaySetFilterColor("UusCorpDebugWindowText", "UiLog", LuaLog.ERROR, 255, 0, 0) -- Red
    LogDisplaySetFilterColor("UusCorpDebugWindowText", "UiLog", LuaLog.DEBUG, 255, 255,
                             0) -- Yellow
    LogDisplaySetFilterColor("UusCorpDebugWindowText", "UiLog", LuaLog.FUNCTION, 0,
                             175, 50) -- Green
    LogDisplaySetFilterColor("UusCorpDebugWindowText", "UiLog", LuaLog.WARNING, 0, 175,
                             50) -- Green

    ButtonSetText("UusCorpDebugWindowReloadUi", L "Reload UI")

    TextLogSetEnabled("UiLog", true)

    for index = 1, 5 do
        LogDisplaySetFilterState("UusCorpDebugWindowText", "UiLog", index,
                                 DevData.DebugWindow.luaFilters[index])
    end

    WindowSetShowing("UusCorpDebugWindowOptionsChrome_UO_WindowCloseButton", false)
    WindowSetShowing("UusCorpDebugWindowOptionsChrome_UO_TitleBar", false)

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
