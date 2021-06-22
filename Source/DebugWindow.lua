
----------------------------------------------------------------
-- Global Variables
----------------------------------------------------------------

DebugWindow = {}

----------------------------------------------------------------
-- Local Variables
----------------------------------------------------------------

-- Channel Id's.. These will be moved to code-generated variables soon.

local LuaLog            = {}
LuaLog.SYSTEM           = 1
LuaLog.ERROR            = 2
LuaLog.DEBUG            = 3
LuaLog.FUNCTION         = 4

DebugWindow.logging = false

----------------------------------------------------------------
-- DebugWindow Functions
----------------------------------------------------------------



-- OnInitialize Handler
function DebugWindow.Initialize()
	
	TextLogCreate("DebugPrint", 1)
	TextLogSetEnabled("DebugPrint", true)
	TextLogClear("DebugPrint")
	TextLogSetIncrementalSaving( "DebugPrint", true, "logs/Debug.Print.log")
		
	CreateWindow("DebugWindowOptions",false)
	
	WindowUtils.SetWindowTitle("DebugWindow",L"Debug Window")

    -- Display Settings
    LogDisplaySetShowTimestamp( "DebugWindowText", false )
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
    
    -- Init logging with negated value, then toggle it to update the window properly
    DebugWindow.logging = not TextLogGetEnabled( "UiLog" )
	DebugWindow.ToggleLogging()
    
    WindowSetAlpha("DebugWindow", 0.75)
    
    -- Load settings
    WindowSetShowing("DebugWindow", DevData.DebugWindow.isShowing )
    WindowClearAnchors("DebugWindow")
    WindowAddAnchor("DebugWindow", "topleft", "Root", "topleft", DevData.DebugWindow.screenPos.x, DevData.DebugWindow.screenPos.y )

	if( DevData.DebugWindow.size.x ~= 0 and DevData.DebugWindow.size.y ~= 0 ) then
		WindowSetDimensions("DebugWindow", DevData.DebugWindow.size.x, DevData.DebugWindow.size.y )
	end

	-- Options		
	LabelSetText( "DebugWindowToggleOptionsLabel", L"Show Options" )
	LabelSetText( "DebugWindowToggleLoggingLabel", L"Enable Logging" )
	
	WindowUtils.SetWindowTitle( "DebugWindow", L"Debug Log")
	
	
	LabelSetText(  "DebugWindowOptionsFiltersTitle", L"Logging Filters:" )
	LabelSetText(  "DebugWindowOptionsFilterType1Label", L"Ui System Messages" )
	LabelSetText(  "DebugWindowOptionsFilterType2Label", L"Error Messages" )
	LabelSetText(  "DebugWindowOptionsFilterType3Label", L"Debug Messages" )
	LabelSetText(  "DebugWindowOptionsFilterType4Label", L"Warning Messages" )
	LabelSetText(  "DebugWindowOptionsFilterType5Label", L"Function Calls Messages" )
	
	for index = 1, 5 do
		ButtonSetStayDownFlag( "DebugWindowOptionsFilterType"..index.."Button", true )
		LogDisplaySetFilterState( "DebugWindowText", "UiLog", index, DevData.DebugWindow.luaFilters[index] )
		ButtonSetPressedFlag( "DebugWindowOptionsFilterType"..index.."Button", DevData.DebugWindow.luaFilters[index] )
	end
	
	LabelSetText(  "DebugWindowOptionsErrorHandlingTitle", L"Generate lua-errors from:" )
	LabelSetText(  "DebugWindowOptionsErrorOption1Label", L"Lua calls to ERROR()" )
	LabelSetText(  "DebugWindowOptionsErrorOption2Label", L"Errors in lua calls to C" )
	
	for index = 1, 2 do
		ButtonSetStayDownFlag( "DebugWindowOptionsErrorOption"..index.."Button", true )
	end
	ButtonSetPressedFlag( "DebugWindowOptionsErrorOption1Button", DevData.useDevErrorHandling  )	
	ButtonSetPressedFlag( "DebugWindowOptionsErrorOption2Button", GetUseLuaErrorHandling() )	
	
	
	LabelSetText(  "DebugWindowOptionsLuaDebugLibraryLabel", L"Load Lua Debug Library" )
	ButtonSetPressedFlag( "DebugWindowOptionsLuaDebugLibraryButton", GetLoadLuaDebugLibrary() )
	
	WindowSetShowing("DebugWindowOptions", false )
	
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

function DebugWindow.ToggleLogging()

     if DebugWindow.logging == true then
        Debug.Print( L"Logging OFF")
    end
	
    DebugWindow.logging = not DebugWindow.logging
	
	ButtonSetPressedFlag( "DebugWindowToggleLoggingButton", DebugWindow.logging )

    TextLogSetIncrementalSaving( "UiLog", DebugWindow.logging, "logs/lua.log");
    TextLogSetEnabled( "UiLog", DebugWindow.logging )
    
    --TextLogSetIncrementalSaving( "Interface", logging, "logs/interface.log");
    --TextLogSetEnabled( "Interface", logging )
	
	if DebugWindow.logging == true then
		Debug.Print( L"Logging ON")
    end
end

function DebugWindow.OnResizeBegin()
    WindowUtils.BeginResize( "DebugWindow", "topleft", 300, 200, false, nil)
end

--- Options Window

function DebugWindow.ToggleOptions()
	local showing = WindowGetShowing( "DebugWindowOptions" )
	WindowSetShowing("DebugWindowOptions", not showing )
	
	ButtonSetPressedFlag( "DebugWindowToggleOptionsButton", not showing )
	WindowSetShowing("DebugWindowOptions", not showing )
end

function DebugWindow.UpdateDisplayFilter()

	local filterId = WindowGetId(SystemData.ActiveWindow.name)
	
	DevData.DebugWindow.luaFilters[filterId] = not DevData.DebugWindow.luaFilters[filterId]
	
	ButtonSetPressedFlag( "DebugWindowOptionsFilterType"..filterId.."Button", DevData.DebugWindow.luaFilters[filterId] )
	LogDisplaySetFilterState( "DebugWindowText", "UiLog", filterId, DevData.DebugWindow.luaFilters[filterId] )

end

function DebugWindow.UpdateLuaErrorHandling()

	DevData.useDevErrorHandling = not DevData.useDevErrorHandling ;
	ButtonSetPressedFlag( "DebugWindowOptionsErrorOption1Button", DevData.useDevErrorHandling  )	
end

function DebugWindow.UpdateCodeErrorHandling()
	local enabled = GetUseLuaErrorHandling()
	enabled = not enabled
	
	SetUseLuaErrorHandling( enabled )
	ButtonSetPressedFlag( "DebugWindowOptionsErrorOption2Button", enabled )
end

function DebugWindow.UpdateLoadLuaDebugLibrary()
	local enabled = GetLoadLuaDebugLibrary()
	enabled = not enabled

	SetLoadLuaDebugLibrary( enabled )
	ButtonSetPressedFlag( "DebugWindowOptionsLuaDebugLibraryButton", enabled )
end

function DebugWindow.ReloadUIHover()
	Tooltips.CreateTextOnlyTooltip("DebugWindowReloadUi", StringToWString("Reload UI"))
	Tooltips.Finalize()
	Tooltips.AnchorTooltip(Tooltips.ANCHOR_WINDOW_TOP)
end