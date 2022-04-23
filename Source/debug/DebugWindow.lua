DebugWindow = {}

local LuaLog            = {}
LuaLog.SYSTEM           = 1
LuaLog.ERROR            = 2
LuaLog.DEBUG            = 3
LuaLog.FUNCTION         = 4

DebugWindow.logging = false

-- OnInitialize Handler
function DebugWindow.Initialize()
	TextLogCreate("DebugPrint", 1)
	TextLogSetEnabled("DebugPrint", true)
	TextLogClear("DebugPrint")
	TextLogSetIncrementalSaving( "DebugPrint", true, "logs/Debug.Print.log")

    -- Display Settings
    LogDisplaySetShowTimestamp( "DebugWindowText", true)
    LogDisplaySetShowLogName( "DebugWindowText", true )
    LogDisplaySetShowFilterName( "DebugWindowText", true )

     -- Add the Lua Log
    LogDisplayAddLog("DebugWindowText", "UiLog", true)
    
    LogDisplaySetFilterColor("DebugWindowText", "UiLog", LuaLog.SYSTEM, 255, 0, 255 ) -- Magenta
    LogDisplaySetFilterColor("DebugWindowText", "UiLog", LuaLog.ERROR, 255, 0, 0 ) -- Red
    LogDisplaySetFilterColor("DebugWindowText", "UiLog", LuaLog.DEBUG, 255, 255, 0 ) -- Yellow
    LogDisplaySetFilterColor("DebugWindowText", "UiLog", LuaLog.FUNCTION, 0, 175, 50 ) -- Green
    LogDisplaySetFilterColor("DebugWindowText", "UiLog", LuaLog.WARNING, 0, 175, 50 ) -- Green
    
    ButtonSetText("DebugWindowReloadUi", L"Reload UI")

	TextLogSetIncrementalSaving( "UiLog", true, "logs/lua.log");
    TextLogSetEnabled( "UiLog", true)
	
	for index = 1, 5 do
		LogDisplaySetFilterState( "DebugWindowText", "UiLog", index, DevData.DebugWindow.luaFilters[index])
	end
	
	WindowSetShowing("DebugWindowOptionsChrome_UO_WindowCloseButton", false )
	WindowSetShowing("DebugWindowOptionsChrome_UO_TitleBar", false )
	
end

-- OnShutdown Handler
function DebugWindow.Shutdown()
	-- Save the settings across reloads
	DevData.DebugWindow.isShowing = WindowGetShowing("DebugWindow")
	DevData.DebugWindow.screenPos.x, DevData.DebugWindow.screenPos.y = WindowGetOffsetFromParent("DebugWindow")
	DevData.DebugWindow.size.x, DevData.DebugWindow.size.y = WindowGetDimensions("DebugWindow")
end

function DebugWindow.OnResizeBegin()
    WindowUtils.BeginResize( "DebugWindow", "topleft", 300, 200, false, nil)
end

function DebugWindow.ReloadUIHover()
	Tooltips.CreateTextOnlyTooltip("DebugWindowReloadUi", StringToWString("Reload UI"))
	Tooltips.Finalize()
	Tooltips.AnchorTooltip(Tooltips.ANCHOR_WINDOW_TOP)
end