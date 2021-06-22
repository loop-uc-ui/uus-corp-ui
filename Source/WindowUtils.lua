----------------------------------------------------------------
-- WindowUtil Global Variables
----------------------------------------------------------------
WindowUtils = {}


WindowUtils.resizing = false
WindowUtils.resizeWindow = nil
WindowUtils.resizeAnchor = ""
WindowUtils.resizeEndCallback = nil
WindowUtils.resizeMin = { x=0, y=0 }

WindowUtils.DRAG_PICKUP_TIME = 3 -- 3 Seconds
WindowUtils.DRAG_DISTANCE = 5 -- 5 Pixels
WindowUtils.dragging = false
WindowUtils.dragCallback = nil
WindowUtils.dragData = nil
WindowUtils.dragTime = 0
WindowUtils.dragX = nil
WindowUtils.dragY = nil

WindowUtils.openWindows = {}
WindowUtils.trackSize = {}

WindowUtils.FONT_DEFAULT_TEXT_LINESPACING = 20
WindowUtils.FONT_DEFAULT_SUB_HEADING_LINESPACING = 22

----------------------------------------------------------------
-- WindowUtil Functions
----------------------------------------------------------------
function WindowUtils.Initialize()
	-- Create the Util Windows	
	CreateWindow( "ResizingWindowFrame", false )	
	WindowRegisterEventHandler( "ResizingWindowFrame", SystemData.Events.L_BUTTON_UP_PROCESSED, "WindowUtils.OnLButtonUp")
end

function WindowUtils.Update( timePassed )

	-- Update the resize frame
	if( WindowUtils.resizing ) then
		local x, y = WindowGetDimensions( "ResizingWindowFrame" )
		local resize = false;
		
		if( x < WindowUtils.resizeMin.x  ) then
			x = WindowUtils.resizeMin.x
			resize = true
		end
		if( y < WindowUtils.resizeMin.y ) then
			y = WindowUtils.resizeMin.y
			resize = true
		end
		
		
		if( resize ) then
			--Debug.PrintToDebugConsole(L"Resizing: "..x..L", "..y )
			WindowSetDimensions( "ResizingWindowFrame", x, y )
		end
    elseif( WindowUtils.dragging ) then
        WindowUtils.dragTime = WindowUtils.dragTime - timePassed
			
		local mouseDistanceX = math.abs(WindowUtils.dragX - SystemData.MousePosition.x)
		local mouseDistanceY = math.abs(WindowUtils.dragY - SystemData.MousePosition.y)
		if( WindowUtils.dragTime <= 0 or mouseDistanceX > WindowUtils.DRAG_DISTANCE or mouseDistanceY > WindowUtils.DRAG_DISTANCE ) then        
            WindowUtils.dragCallback(WindowUtils.dragData)
            WindowUtils.dragging = false
        end
	end
	
	SnapUtils.SnapUpdate(timePassed)
end

function WindowUtils.BeginResize( windowName, anchorCorner, minX, minY, lockRatio, endCallback )
    --Debug.Print("WindowUtils.BeginResize: "..tostring(windowName)..", "..tostring(anchorCorner)..", "..tostring(minX)..", "..tostring(minY)..", "..tostring(lockRatio)..", "..tostring(endCallback) )
    if ( WindowUtils.resizing ) then
        return
    end

    -- Anchor the resizing frame to the window
    local scale = WindowGetScale(windowName)
    local width, height = WindowGetDimensions( windowName )
    
    WindowSetDimensions( "ResizingWindowFrame", width, height )
    WindowSetScale("ResizingWindowFrame", scale)
    
    WindowAddAnchor( "ResizingWindowFrame", anchorCorner, windowName, anchorCorner, 0, 0 )
    WindowSetResizing( "ResizingWindowFrame", true, anchorCorner, lockRatio );    
    WindowSetShowing( "ResizingWindowFrame", true )    
    
    WindowUtils.resizing = true
    WindowUtils.resizeWindow = windowName
    WindowUtils.resizeAnchor = anchorCorner
    WindowUtils.resizeMin.x = minX
    WindowUtils.resizeMin.y = minY    
    WindowUtils.resizeEndCallback = endCallback
	--Debug.PrintToDebugConsole(L"BeginResize: "..minX..L", "..minY )
end 

function WindowUtils.BeginDrag( callback, data )
    WindowUtils.dragging = true
    WindowUtils.dragCallback = callback
    WindowUtils.dragData = data
    WindowUtils.dragTime = WindowUtils.DRAG_PICKUP_TIME
    WindowUtils.dragX = SystemData.MousePosition.x
    WindowUtils.dragY = SystemData.MousePosition.y
end

function WindowUtils.EndDrag( )
	WindowUtils.dragging = false
end

function WindowUtils.OnLButtonUp(_, _, _)

	-- End the resize
	if( WindowUtils.resizing ) then
        if ( not WindowUtils.resizing ) then
            return
        end

        local width, height = WindowGetDimensions( "ResizingWindowFrame" )

		-- Detatch and Hide the Resizing Frame
        WindowSetResizing( "ResizingWindowFrame", false, "", false );
        WindowClearAnchors( "ResizingWindowFrame" )
        WindowSetShowing( "ResizingWindowFrame", false )    
         
        -- Assign the settings to the new window
        WindowSetDimensions( WindowUtils.resizeWindow, width, height )      
                
        if( WindowUtils.resizeEndCallback ~= nil ) then        	
            WindowUtils.resizeEndCallback(WindowUtils.resizeWindow)
            WindowUtils.resizeEndCallback = nil
        end
        
        -- Clear the Resizing Data
        WindowUtils.resizing = false
        WindowUtils.resizeWindow = nil
        WindowUtils.resizeAnchor = nil        
    elseif( WindowUtils.dragging ) then
        WindowUtils.dragging = false
	end
end

function WindowUtils.GetTopmostDialog(wndName)
	if( wndName == nil ) or (wndName == "") then 
		--Debug.Print("WindowUtils.GetTopmostDialog: Active dialog is nil or empty!") 
        return 
    end
	parent = wndName
	repeat
		wnd = parent
		parent = WindowGetParent(wnd)
		if( parent == nil ) then
		    --Debug.Print("WindowUtils.GetTopmostDialog: someone's parent is nil or empty!") 
		    return
		end
	until (parent == "Root") 
	
    return wnd
end

function WindowUtils.GetActiveDialog()
	return WindowUtils.GetTopmostDialog(SystemData.ActiveWindow.name)
end

function WindowUtils.SetActiveDialogTitle(title)
	if( WindowUtils.GetActiveDialog() == nil ) then
		--Debug.Print("WindowUtils.SetActiveDialogTitle: Active dialog is nil!")
		return
	end

	WindowUtils.SetWindowTitle(WindowUtils.GetActiveDialog(),title)
end

function WindowUtils.SetWindowTitle(window,title)
	if not title or not window  or title == "" then
		return
	end
	title = wstring.upper(title)
	if type(title) == "string" then
	    title = StringToWString(title)	
	end
	WindowUtils.FitTextToLabel(window, title, true)
end

function WindowUtils.RetrieveWindowSettings()
	-- update the positions for any window thats currently open
	for window, _ in pairs(WindowUtils.openWindows) do
		WindowUtils.RestoreWindowPosition(window, false)
	end
end

function WindowUtils.ForceResetWindowPositions()
	-- update the positions for any window thats currently open
	for window, _ in pairs(WindowUtils.openWindows) do
		WindowUtils.ForceResetWindowPosition(window)		
	end
end

function WindowUtils.SendWindowSettings()
	-- save the positions for any window thats currently open
	for window, _ in pairs(WindowUtils.openWindows) do
		WindowUtils.SaveWindowPosition(window, false)
	end
end

function WindowUtils.CanRestorePosition(window)
	local result = false
	
	for _, windowName in pairs(SystemData.Settings.Interface.WindowPositions.Names) do
		if( window == windowName ) then
			result = true
			break
		end
	end
	
	return result
end

function WindowUtils.RestoreWindowPosition(window, trackSize, alias, ignoreBounds)
	local index

	--if no explicit alias, then use actual window name:
	if not alias then
		alias = window
	end
	
	for i, windowName in pairs(SystemData.Settings.Interface.WindowPositions.Names) do
		if( alias == windowName ) then
			index = i
			break
		end
	end
	
	if( index ~= nil ) then		
		local x = SystemData.Settings.Interface.WindowPositions.WindowPosX[index]
		local y = SystemData.Settings.Interface.WindowPositions.WindowPosY[index]
		
		-- make sure this window is on screen!
	    local winWidth, winHeight = WindowGetDimensions(window)
	    local resy = SystemData.screenResolution.y / InterfaceCore.scale
	    local resx = SystemData.screenResolution.x / InterfaceCore.scale
		
		if not ignoreBounds then
			if( x + winWidth < 0 ) then
			   x = 0
			elseif( x > resx ) then
				x = resx - winWidth
			end
			
			if( y + winHeight < 0 ) then
				y = 0
			elseif( y > resy ) then
				y = resy - winHeight
			end
		end
		if( x ~= nil and y ~= nil ) then			
			WindowClearAnchors(window)
			WindowAddAnchor(window, "topleft","Root" , "topleft", x, y)	
		end
		
		if( trackSize == true ) then
			local width = SystemData.Settings.Interface.WindowPositions.WindowWidth[index]
			local height = SystemData.Settings.Interface.WindowPositions.WindowHeight[index]
			if( width ~= nil and height ~= nil and width ~= 0 and height ~= 0 ) then
				WindowSetDimensions(window,width,height)
			end
		end
	end
		
	WindowUtils.openWindows[alias] = true
	WindowUtils.trackSize[alias] = trackSize
end

function WindowUtils.ForceResetWindowPosition(window)
	local index
	for i, windowName in pairs(SystemData.Settings.Interface.WindowPositions.Names) do		
		if( window == windowName ) then			
			index = i
			break
		end
	end
	
	if( index ~= nil ) then		
		local x = 10
		local y = 10
		if( x ~= nil and y ~= nil ) then			
			WindowClearAnchors(window)
			WindowAddAnchor(window, "topleft","Root" , "topleft", x, y)				
		end
	end
end

function WindowUtils.SaveWindowPosition(window, closing, alias)	
	--if no explicit alias, then use actual window name:
	if not alias then
		alias = window
	end

	-- always save the position if its in the list
	if( WindowUtils.openWindows[alias] == true) then
		--Debug.Print("saving " .. alias)
		local x, y = WindowGetScreenPosition(window)
        x = math.floor( x/InterfaceCore.scale + 0.5 )
        y = math.floor( y/InterfaceCore.scale + 0.5 )
        
		local width, height = WindowGetDimensions(window)
		local windowPositions = SystemData.Settings.Interface.WindowPositions
		
		local index
		for i, windowName in pairs(windowPositions.Names) do
			if( alias == windowName ) then
				index = i
				break
			end
		end
		
		-- if it doesnt exist yet then add it
		if( index == nil ) then
			index = table.getn(windowPositions.Names) + 1
			windowPositions.Names[index] = alias
		end	
		
		windowPositions.WindowPosX[index] = x
		windowPositions.WindowPosY[index] = y
		
		if (string.find(window, "Hotbar")) then
			local closed = Interface.LoadBoolean( window.. "Closed",false )
			if (closed) then
				width = Interface.LoadNumber( window .. "SizeW", width )
				height = Interface.LoadNumber( window .. "SizeH", width )
			end
		end
		
		if( WindowUtils.trackSize[alias] == true ) then
			windowPositions.WindowWidth[index] = width
			windowPositions.WindowHeight[index] = height
		else
			windowPositions.WindowWidth[index] = 0
			windowPositions.WindowHeight[index] = 0
		end
		
		-- the closing bool is true by default
		if( closing == true or closing == nil ) then
			WindowUtils.openWindows[alias] = nil
			WindowUtils.trackSize[alias] = nil
		end
	end
end

function WindowUtils.ClearWindowPosition(window)	
	local windowPositions = SystemData.Settings.Interface.WindowPositions

	local index
	for i, windowName in pairs(windowPositions.Names) do
		if( window == windowName ) then
			index = i
			break
		end
	end	
	
	if( index ~= nil ) then
		-- shift all the elements up
		local lastElement = table.getn(windowPositions.Names)
		for index2 = index + 1, lastElement do
			local previous = index2 - 1
			windowPositions.Names[previous] = windowPositions.Names[index2]
			windowPositions.WindowWidth[previous] = windowPositions.WindowWidth[index2]
			windowPositions.WindowHeight[previous] = windowPositions.WindowHeight[index2]
			windowPositions.WindowWidth[previous] = windowPositions.WindowWidth[index2]
			windowPositions.WindowHeight[previous] = windowPositions.WindowHeight[index2]
		end
		windowPositions.Names[lastElement] = nil
		windowPositions.WindowWidth[lastElement] = nil
		windowPositions.WindowHeight[lastElement] = nil
		windowPositions.WindowWidth[lastElement] = nil
		windowPositions.WindowHeight[lastElement] = nil		
	end
	
	WindowUtils.openWindows[window] = nil
	WindowUtils.trackSize[window] = nil
end

-- replaces HTML markup tags where possible
--   and strips out all others
-- 
-- str is  of type wstring
--
-- Current substitutions are:
--   <BR>  -->  single carriage return
--   <P>  -->  double carriage return
--   <center>-----</center>  -->  deleted 
--   anything else between < >  -->  deleted 
--
-- NOTE: LuaPlus has some bugginess with wstring routines, e.g. gsub returning
--    the string as ASCII instead of unicode, particularly if the return string is empty
--
function WindowUtils.translateMarkup(str)

	--gsub function doesn't work on empty source strings.
	if(not str or str == L"" or str == "") then 
		return L""
	end	
	str = wstring.gsub(str, L"<[Bb][Rr]>", L"\n")
	if str == L"" or str == "" then 
		return L""
	end	
	str = wstring.gsub(str, L"<[Pp]>", L"\n\n")
	if str == L"" or str == "" then 
		return L""
	end	
	str = wstring.gsub(str, L"<center>-----</center>", L"\n\n")
--	str = wstring.gsub(str, L"<center>-----</center>", L"\n     ___________________\n")
	if str == L"" or str == "" then 
		return L""
	end	
	
	str = WindowUtils.translateLinkTag(str)
	
	str = wstring.gsub(str, L"<.->", L"")

	if str == L"" or str == "" then 
		return L""
	end	

	-- *** NOTE: this is the correct replaced of the above line once wstring.gsub works with captures. 
	--   For now we use KLUDGE2a and KLUDGE2b
	--[[
	str = wstring.gsub(str, L"<(.-)>", function(tag) 
											if wstring.sub(tag,1,4) == L"LINK" then 
												return  L"<"..tag..L">"
											else
												return  L""
											end
										end
						)
	--]]
	
	-- *** KLUDGE2b - because the above gsub isn't properly returning any value other than ""
	-- we used KLUDGE2a in translateLinkTag to surrounded the LINK tag with {}.  So here we change it back
	--
	local KLUDGED_LINK_TAG = L"{LINK(.-)}"
	
	local linkBody = wstring.match(str, KLUDGED_LINK_TAG)
	if type(linkBody) == "wstring" then
		str = wstring.gsub(str, KLUDGED_LINK_TAG, L"<LINK"..linkBody..L">" )
		--Debug.Print(str)
	end
	-- END KLUDGE2b
	
	if str == "" then 
		return L""
	end	
	
	return str 
end


-- WindowUtils.translateLinkTag
--   Translates our legacy code link tag to the KR link tag
--
-- the legacy client uses something like <A HREF="some url">text</A> for it's link tag 
--
-- our new style of link tags is currently NEW_LINK_TAG = L"<LINK=%1,%2>", but
-- in the future it may change to L"<LINK data=\"%1\" text=\"%2\" />"
--
function WindowUtils.translateLinkTag(str)

	local LEGACY_LINK_TAG = L"<[Aa]%s+[Hh][Rr][Ee][Ff]%s*=%s*\"(.-)\">(.-)</[Aa]>"
	
	-- *** KLUDGE - wstring.gsub is not setting the captures corrrectly, so I'm extracting the captures
	--  with  wstring.match and manually inserting them into NEW_LINK_TAG
	--
	local dataCapture, textCapture = wstring.match(str, LEGACY_LINK_TAG)
	if type(dataCapture) ~= "wstring" or type(textCapture) ~= "wstring" then
		return str
	end

	-- *** KLUDGE2a - because we do a final wstring.gsub(str, L"<.->", L"") and using a function as the
	-- third argument isn't working, we use {} instead of <> to surroudn the link tag and change them later
	--local NEW_LINK_TAG = L"{LINK data=\""..dataCapture..L"\" text=\""..textCapture..L"\" /}"
	local NEW_LINK_TAG = L"{LINK="..dataCapture..L","..textCapture..L"}"
	-- END KLUDGE2a
	
	-- END KLUDGE
	
	str = wstring.gsub(str, LEGACY_LINK_TAG, NEW_LINK_TAG)
	if str == "" then 
		return L""
	end	
	
	return str 
end



-- Add commas to a number : i.e. 1000000 becomes 1,000,000
--
-- str needs to be a wstring 
-- returns a wstring
-- 
function WindowUtils.AddCommasToNumber (str)
  local str2 = tostring(tonumber(str))
  local formatted = str2
  while true do  
    formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", '%1,%2')
    if (k==0) then
      break
    end
  end
  return (StringToWString(formatted))
end


-- currently only handles the case of http links bringing up the web browser but
--	 we could add other generic cases, e.g. opening a help gump or a generic gump or whatever
--
-- linkParam is of type wstring
--
function WindowUtils.ProcessLink( linkParam )
    if( wstring.sub(linkParam, 1, 4) == L"http" ) then
       local url = WStringToString( linkParam )
       OpenWebBrowser( url)
    end
end

-- Note that if you are dynamically adding elements to the ScrollWindow, you should be done adding elements and have 
-- called ScrollWindowUpdateScrollRect before using this function
--
function WindowUtils.ScrollToElementInScrollWindow( element, scrollWindow, scrollChild )
	local _,elementY = WindowGetScreenPosition(element)
	local _,parentY = WindowGetScreenPosition(scrollChild)
	local _, maxOffset = WindowGetDimensions(scrollChild)
	local scrollOffset = elementY - parentY
	-- sanity checks
	if( scrollOffset < 0 ) then
	    scrollOffset = 0
	end
	if( scrollOffset > maxOffset ) then
	    scrollOffset = maxOffset
	end
	ScrollWindowSetOffset(scrollWindow, scrollOffset)
end

-- Note that if you are dynamically adding elements to the ScrollWindow, you should be done adding elements and have 
-- called HorizontalScrollWindowUpdateScrollRect before using this function
--
function WindowUtils.ScrollToElementInHorizontalScrollWindow( element, scrollWindow, scrollChild )

	if (not DoesWindowNameExist(element)) or (not DoesWindowNameExist(scrollChild)) then
		--Debug.Print("WindowUtils.GotoElementInScrollChild: Window does not exist!")
		return
	end
	
	local elementX, _ = WindowGetScreenPosition(element)
	local parentX, _ = WindowGetScreenPosition(scrollChild)
	local maxOffset = WindowGetDimensions(scrollChild)
	local scrollOffset = elementX - parentX
	
	-- sanity checks
	if( scrollOffset < 0 ) then
	    scrollOffset = 0
	end
	if( scrollOffset > maxOffset ) then
	    scrollOffset = maxOffset
	end
	
	HorizontalScrollWindowSetOffset(scrollWindow, scrollOffset)
end

-- Append label text with ellipsis (...) if label text width exceeds label width
-- Used by the function that sets window titles too, so that all titles don't extend beyond the window that contains them
function WindowUtils.FitTextToLabel(labelName, labelText, isTitle )
	local DEBUG = false -- enable for verbose debugging of this function
	local labelWindowName = labelName
	if isTitle then
		labelText = wstring.upper(labelText)
		labelWindowName = labelName.."Chrome_UO_TitleBar_WindowTitle"
		if DEBUG then
			Debug.Print( L"Called WindowUtils.FitTextToLabel() to set the title for window ''"..StringToWString(labelName)..L"'' to ''"..labelText..L"''" )
		end
	elseif DEBUG then
		Debug.Print( L"Called WindowUtils.FitTextToLabel( "..StringToWString(labelWindowName)..L", "..labelText..L" )" )
	end

	if labelWindowName == nil or labelText == nil or labelWindowName == "" or labelText == "" or labelText == L"" then
	   --Debug.Print("ERROR in WindowUtils.FitTextToLabel()! Window name or text is bad")
	   return 0
	end

    LabelSetWordWrap(labelWindowName, false)
	local labelX, _ = WindowGetDimensions(labelName)
	if isTitle then
		labelX = labelX - 55 -- The window has about 55 pixels of spacing on both ends total that the title shouldn't use.
	end
	LabelSetText( labelWindowName, labelText )
	local textX, textY = LabelGetTextDimensions(labelWindowName)
	if DEBUG then
		Debug.Print( L"The space allowed for this label is "..labelX..L" pixels." )
		Debug.Print( L"The text size is width="..textX..L" height="..textY )
	end
    local text = labelText

	if not textX or not labelX then
		return
	end
	
	while (textX  > labelX) and (text:len() > 1) do
		text = wstring.sub(text, 1, -2)
		if DEBUG then
			Debug.Print( L"The text width ("..textX..L") is still greater than the label width ("..labelX..L"), so we're changing the text to ''"..text..L"...''" )
		end
		LabelSetText(labelWindowName, text..L"...")
		textX, textY = LabelGetTextDimensions(labelWindowName)
		if DEBUG then
			Debug.Print( L"The new text size is width="..textX..L" height="..textY )
		end
	end
	if DEBUG then
		Debug.Print( L"The text width ("..textX..L") is less than the label width ("..labelX..L"), so we are done." )
	end
end

-- Local Functions
function WindowUtils.CopyAnchors( sourceWindow, destWindow, xOffset, yOffset )

    WindowClearAnchors( destWindow )

    local numAnchors = WindowGetAnchorCount( sourceWindow )
    for index = 1, numAnchors
    do
        local point, relativePoint, relativeTo, xoffs, yoffs = WindowGetAnchor( sourceWindow, index )           
        WindowAddAnchor( destWindow , point, relativeTo, relativePoint, xoffs+xOffset, yoffs+yOffset )
    end
end

function WindowUtils.CopyScreenPosition( sourceWindow, destWindow, xOffset, yOffset )
    local uiScale = InterfaceCore.scale
    local screenX, screenY = WindowGetScreenPosition( sourceWindow )        
    
    local xPos = math.floor( (screenX + xOffset)/uiScale + 0.5 )
    local yPos = math.floor( (screenY + yOffset)/uiScale + 0.5 )
    
    --Debug.Print("CopyScreenPosition "..destWindow..": "..xPos..", "..yPos)
    
    WindowClearAnchors( destWindow )
    WindowAddAnchor(destWindow,"topleft","Root","topleft",xPos,yPos)
end

function WindowUtils.CopySize( sourceWindow, destWindow, xOffset, yOffset, offsetInDestCoords )
        
    local width, height = WindowGetDimensions( sourceWindow )
           
    local sourceScale = WindowGetScale( sourceWindow )
    local destScale   = WindowGetScale( destWindow )
    local scaleConvert = destScale / sourceScale
    
    if( offsetInDestCoords ) 
    then
        width  = width*scaleConvert + xOffset
        height = height*scaleConvert + yOffset
    else
        width  = (width + xOffset) * scaleConvert
        height = (height + yOffset)* scaleConvert
    end
    
    WindowSetDimensions( destWindow, width, height ) 
end

function WindowUtils.GetScaledScreenPosition( sourceWindow )
    local uiScale = InterfaceCore.scale
    local screenX, screenY = WindowGetScreenPosition( sourceWindow )        
    
    local xPos = math.floor( screenX/uiScale + 0.5 )
    local yPos = math.floor( screenY/uiScale + 0.5 )
    
    --Debug.Print("GetScaledScreenPosition "..destWindow..": "..xPos..", "..yPos)
    
    return xPos, yPos
end

-- Debugging purposes. Used for creating visible outlines of windows passed into this function.
-- Make sure to use DestroyWindowOutline during window destruction as well.
function WindowUtils.CreateWindowOutline(windowName)
	local debugWindow = "DebugWindowOutline_"..windowName
	
	if(DoesWindowNameExist(debugWindow) == false) then
		CreateWindowFromTemplate(debugWindow, "SnapWindowTemplate", "Root")
		WindowUtils.CopySize( windowName, debugWindow, 0, 0 )
	    
		WindowClearAnchors(debugWindow)
		WindowAddAnchor(debugWindow, "topleft", windowName, "topleft", 0, 0)
	    
		WindowSetShowing(debugWindow, true)
	end
end

function WindowUtils.DestroyWindowOutline(windowName)
	local debugWindow = "DebugWindowOutline_"..windowName
	if(DoesWindowNameExist(debugWindow) == true) then
		DestroyWindow(debugWindow)
	end
end

----------------------------
-- Snapping functionality
----------------------------

SnapUtils = {}
SnapUtils.SnappableWindows = {}

SnapUtils.CurWindow = nil
SnapUtils.SnapWindow = nil
SnapUtils.SnapIndex = nil

SnapUtils.ANCHOR_POINT_TOP_LEFT       = 1
SnapUtils.ANCHOR_POINT_TOP            = 2
SnapUtils.ANCHOR_POINT_TOP_RIGHT      = 3
SnapUtils.ANCHOR_POINT_LEFT           = 4
SnapUtils.ANCHOR_POINT_CENTER         = 5
SnapUtils.ANCHOR_POINT_RIGHT          = 6
SnapUtils.ANCHOR_POINT_BOTTOM_LEFT    = 7
SnapUtils.ANCHOR_POINT_BOTTOM         = 8
SnapUtils.ANCHOR_POINT_BOTTOM_RIGHT   = 9

SnapUtils.ANCHOR_POINTS =
{ 
    [SnapUtils.ANCHOR_POINT_TOP_LEFT      ] = { name="topleft",       widthMultipler=0.0,  heightMultiplier=0.0 },
    [SnapUtils.ANCHOR_POINT_TOP           ] = { name="top",           widthMultipler=0.5,  heightMultiplier=0.0 },
    [SnapUtils.ANCHOR_POINT_TOP_RIGHT     ] = { name="topright",      widthMultipler=1.0,  heightMultiplier=0.0 },
    [SnapUtils.ANCHOR_POINT_LEFT          ] = { name="left",          widthMultipler=0.0,  heightMultiplier=0.5 },
    [SnapUtils.ANCHOR_POINT_CENTER        ] = { name="center",        widthMultipler=0.5,  heightMultiplier=0.5 },
    [SnapUtils.ANCHOR_POINT_RIGHT         ] = { name="right",         widthMultipler=1.0,  heightMultiplier=0.5 },
    [SnapUtils.ANCHOR_POINT_BOTTOM_LEFT   ] = { name="bottomleft",    widthMultipler=0.0,  heightMultiplier=1.0 },
    [SnapUtils.ANCHOR_POINT_BOTTOM        ] = { name="bottom",        widthMultipler=0.5,  heightMultiplier=1.0 },
    [SnapUtils.ANCHOR_POINT_BOTTOM_RIGHT  ] = { name="bottomright",   widthMultipler=1.0,  heightMultiplier=1.0 },
}

SnapUtils.SNAP_PAIRS =
{ 
    -- Window 1                                 -- Window 2
    {SnapUtils.ANCHOR_POINT_TOP_LEFT,         SnapUtils.ANCHOR_POINT_BOTTOM_LEFT },
    {SnapUtils.ANCHOR_POINT_TOP_LEFT,         SnapUtils.ANCHOR_POINT_TOP_RIGHT },
    {SnapUtils.ANCHOR_POINT_TOP,              SnapUtils.ANCHOR_POINT_BOTTOM },
    {SnapUtils.ANCHOR_POINT_TOP_RIGHT,        SnapUtils.ANCHOR_POINT_BOTTOM_RIGHT },
    {SnapUtils.ANCHOR_POINT_TOP_RIGHT,        SnapUtils.ANCHOR_POINT_TOP_LEFT },
    {SnapUtils.ANCHOR_POINT_LEFT,             SnapUtils.ANCHOR_POINT_RIGHT },
    {SnapUtils.ANCHOR_POINT_RIGHT,            SnapUtils.ANCHOR_POINT_LEFT },
    {SnapUtils.ANCHOR_POINT_RIGHT,            SnapUtils.ANCHOR_POINT_LEFT },
    {SnapUtils.ANCHOR_POINT_BOTTOM_LEFT,      SnapUtils.ANCHOR_POINT_BOTTOM_RIGHT },
    {SnapUtils.ANCHOR_POINT_BOTTOM_LEFT,      SnapUtils.ANCHOR_POINT_TOP_LEFT },
    {SnapUtils.ANCHOR_POINT_BOTTOM,           SnapUtils.ANCHOR_POINT_TOP },    
    {SnapUtils.ANCHOR_POINT_BOTTOM_RIGHT,     SnapUtils.ANCHOR_POINT_TOP_RIGHT },
    {SnapUtils.ANCHOR_POINT_BOTTOM_RIGHT,     SnapUtils.ANCHOR_POINT_BOTTOM_LEFT },
}

function SnapUtils.GetAnchorDistance( anchorsList1, anchor1, anchorsList2, anchor2 )

    local xDistance = anchorsList1[anchor1].x - anchorsList2[anchor2].x 
    local yDistance = anchorsList1[anchor1].y - anchorsList2[anchor2].y 

    return math.sqrt( xDistance*xDistance + yDistance*yDistance )
end

function SnapUtils.ComputeAnchorScreenPositions( windowName )
	local screenX, screenY = WindowGetScreenPosition( windowName )
    local width, height = WindowGetDimensions( windowName ) 
    local scale = WindowGetScale( windowName ) 
        
    width   = width*scale
    height  = height*scale
    
    -- Compute the XY coordates for each anchor point
        
    local positions = {}    
    for index, anchorPoint in ipairs( SnapUtils.ANCHOR_POINTS ) do
        positions[index] = { 
                             x=screenX + width*anchorPoint.widthMultipler,
                             y=screenY + height*anchorPoint.heightMultiplier
                           }
    end   
    
    return positions

end

function SnapUtils.StartWindowSnap( windowName )
	if ( not UserOptionsSettings.enableSnapping()) then
		WindowSetMoving(windowName,true)
		return 
	end
    --Debug.Print("SnapUtils.StartWindowSnap: "..tostring(windowName))
    local scale = WindowGetScale(windowName)
    if (not DoesWindowNameExist("SnapWindow") ) then
		CreateWindowFromTemplate("SnapWindow", "SnapWindowTemplate", "Root")
    end
    WindowSetScale("SnapWindow", scale)
    WindowUtils.CopySize( windowName, "SnapWindow", 0, 0 )
    WindowSetShowing("SnapWindow",false)
	SnapUtils.CurWindow = windowName
	WindowSetMoving(windowName,true)
end

function SnapUtils.EndWindowSnap(_)
    --Debug.Print("SnapUtils.EndWindowSnap: "..tostring(windowName))
    
    if( SnapUtils.SnapWindow and DoesWindowNameExist(SnapUtils.CurWindow) ) then
        WindowUtils.CopyScreenPosition( "SnapWindow", SnapUtils.CurWindow, 0, 0)
    end
    SnapUtils.SnapWindow = nil
    DestroyWindow("SnapWindow")
end

function SnapUtils.SnapUpdate(_)
    if( SnapUtils.CurWindow ) then
		if( WindowGetMoving(SnapUtils.CurWindow) == false or DoesWindowNameExist(SnapUtils.CurWindow) == false ) then
		    SnapUtils.EndWindowSnap( SnapUtils.CurWindow )
			SnapUtils.CurWindow = nil
		else
		    SnapUtils.FindSnap()
	    end
    end 
end

function SnapUtils.FindSnap()
    local maxSnapDistance = 20
    local anchorPositions = SnapUtils.ComputeAnchorScreenPositions(SnapUtils.CurWindow)
    local distance = maxSnapDistance + 1
    SnapUtils.SnapWindow = nil
    SnapUtils.SnapIndex = nil
    
    for windowName,_ in pairs(SnapUtils.SnappableWindows) do
        if( windowName ~= SnapUtils.CurWindow )
        then          
            local comparePositions = SnapUtils.ComputeAnchorScreenPositions(windowName)            
            
            for index, snapPair in ipairs( SnapUtils.SNAP_PAIRS )
            do
                local dist = SnapUtils.GetAnchorDistance( anchorPositions, snapPair[1], comparePositions, snapPair[2] )
                
                -- If the distance between the anchors is within the snap threshold, save the value
                if( (dist <= maxSnapDistance) and (dist < distance) and WindowGetShowing(windowName) )
                then
                    distance = dist
                    SnapUtils.SnapWindow = windowName
                    SnapUtils.SnapIndex = index
                end
           end
        end
    end
    
    if( SnapUtils.SnapWindow ) then
        WindowSetShowing("SnapWindow", true)
        
        local anchorPt   = SnapUtils.SNAP_PAIRS[ SnapUtils.SnapIndex][2]
        local anchorToPt = SnapUtils.SNAP_PAIRS[ SnapUtils.SnapIndex][1]

        -- Anchor the SnapFrame to it's anchor point.
        WindowClearAnchors("SnapWindow")
        WindowAddAnchor( "SnapWindow", SnapUtils.ANCHOR_POINTS[anchorPt].name, SnapUtils.SnapWindow, SnapUtils.ANCHOR_POINTS[anchorToPt].name, 0, 0 )
        
        return true
    else
        WindowSetShowing("SnapWindow", false)
    end
    
    return false
end

function WindowUtils.TrapClick()
end

WindowUtils.LastMessage = L""

function WindowUtils.SendOverheadText(message, hue, chat, ignoreLast)
		if (ignoreLast == nil) then
			ignoreLast = true
		end
		SystemData.Text = message
		SystemData.TextChannelID = 2
		SystemData.TextSourceID = WindowData.PlayerStatus.PlayerId
		SystemData.TextColor = hue
		OverheadText.ShowOverheadText()
		if (ignoreLast) then
			WindowUtils.LastMessage = message
		end
		if ( chat == true )	then
			PrintWStringToChatWindow(message, SystemData.ChatLogFilters.SYSTEM )
		end
end

function IsPartyMember( mobileId )

	for i = 1, HealthBarManager.MAX_PARTY_MEMBERS do
		if (mobileId == WindowData.PartyMember[i].memberId) then
			return true
		end
	end
	return false
end
	




function WindowUtils.Aplpha(_, _, delta)
	
	local windowname = WindowUtils.GetActiveDialog()

	local originalWindow = windowname
	local text = string.find(windowname , "PaperdollWindow")
	if ( text ~= nil ) then
		windowname = "PperdollWindow"
		
	end
	
	
	
	text = string.find(windowname , "ContainerWindow")
	if ( text ~= nil ) then
		windowname = "ContainerWindowALPHA"
		if (SystemData.Settings.Interface.LegacyContainers) then
			return
		end
	end
	
	text = string.find(windowname , "PartyHealthBar_")
	if ( text ~= nil ) then
		windowname = "PrtyHealthBarALPHA"
	end
	
	text = string.find(windowname , "MobileHealthBar_")
	if ( text ~= nil ) or (windowname == "PetWindow") or (windowname == "MobilesOnScreenWindow") then
		
		windowname = "MobileHealthBarALPHA"

	end
	
	if(string.find(originalWindow,"ItemHealthBar")) then
		originalWindow = "DurabilityBar"
		windowname = "DurabilityBar"
	end
		
	local scale = WindowGetAlpha(originalWindow)
	
	
	text = string.find(windowname , "CourseMapWindow")
	if ( text ~= nil ) then
		windowname = "CourseMapWindowALPHA"
	end
	
	
	
	local endscale = delta * 0.05 + scale
	
	if (endscale < 1 and endscale > 0.01) then
		
		if (windowname == "PrtyHealthBarALPHA") then
			for i=1, HealthBarManager.MAX_PARTY_MEMBERS do
				if (PartyHealthBar.HasWindowByIndex(i)) then
					WindowSetAlpha("PartyHealthBar_" .. i, endscale)
					WindowSetFontAlpha("PartyHealthBar_" .. i, endscale)
				end
			end
		elseif (windowname == "MobileHealthBarALPHA") then
			for key, _ in pairs(MobileHealthBar.hasWindow) do
				local windowName = "MobileHealthBar_"..key
				WindowSetAlpha(windowName, endscale)
				WindowSetFontAlpha(windowName, endscale)
			end
			WindowSetAlpha("PetWindow", endscale)
			WindowSetFontAlpha("PetWindow", endscale)
			WindowSetAlpha("MobilesOnScreenWindow", endscale)
			WindowSetFontAlpha("MobilesOnScreenWindow", endscale)
			WindowSetAlpha("YellowDockspot", endscale)
			WindowSetFontAlpha("YellowDockspot", endscale)
			WindowSetAlpha("GreyDockspot", endscale)
			WindowSetFontAlpha("GreyDockspot", endscale)
			WindowSetAlpha("BlueDockspot", endscale)
			WindowSetFontAlpha("BlueDockspot", endscale)
			WindowSetAlpha("RedDockspot", endscale)
			WindowSetFontAlpha("RedDockspot", endscale)
			WindowSetAlpha("GreenDockspot", endscale)
			WindowSetFontAlpha("GreenDockspot", endscale)
			WindowSetAlpha("OrangeDockspot", endscale)
			WindowSetFontAlpha("OrangeDockspot", endscale)
		elseif (windowname == "MapWindow") then
			if (MapWindow.Big) then
				windowname = "MapWindowBig"
			else
				windowname = "MapWindow"
			end
			WindowSetAlpha(originalWindow, endscale)
			WindowSetFontAlpha(originalWindow, endscale)
		elseif(windowname == "PperdollWindow") then
			WindowSetAlpha(originalWindow, endscale)
			WindowSetFontAlpha(originalWindow, endscale)
		elseif(windowname == "CourseMapWindowALPHA") then
			WindowSetAlpha(originalWindow, endscale)

		elseif (string.find(originalWindow, "hotbar")) then
			for slot = 1, Hotbar.NUM_BUTTONS do
			   local element = originalWindow.."Button"..slot

			   WindowSetAlpha(element .. "Cooldown", endscale)
			end	
			WindowSetAlpha(originalWindow, endscale)
			WindowSetFontAlpha(originalWindow, endscale)
		elseif (originalWindow == "StatusWindow") then
			WindowSetAlpha(originalWindow, endscale)
			WindowSetFontAlpha(originalWindow, endscale)
			WindowSetAlpha("WarButton", endscale)
		else
			WindowSetAlpha(originalWindow, endscale)
			WindowSetFontAlpha(originalWindow, endscale)
		end
		
		Interface.SaveNumber( windowname.."ALP", endscale )
	end
	
end

function WindowUtils.Scale(x, y, delta)
	local maxScale = 1.5
	if (WindowUtils.ToggleAlpha) then
		WindowUtils.Aplpha(x, y, delta)
	elseif (WindowUtils.ToggleScale) then
		local windowname = WindowUtils.GetActiveDialog()

		local originalWindow = windowname
		local text = string.find(windowname , "PaperdollWindow")
		if ( text ~= nil ) then
			windowname = "PperdollWindow"
			
		end
		
		
		
		text = string.find(windowname , "ContainerWindow")
		if ( text ~= nil ) then
			windowname = "ContainerWindowSCALE"
			if (SystemData.Settings.Interface.LegacyContainers) then
				return
			end
		end
		
		text = string.find(windowname , "PartyHealthBar_")
		if ( text ~= nil ) then
			windowname = "PrtyHealthBarSCALE"
		end
		
		text = string.find(windowname , "MobileHealthBar_")
		if ( text ~= nil ) or (windowname == "PetWindow") or (windowname == "MobilesOnScreenWindow") then
			windowname = "MobileHealthBarSCALE"
		end
		
		if(string.find(originalWindow,"ItemHealthBar")) then
			originalWindow = "DurabilityBar"
			windowname = "DurabilityBar"
		end
		local scale = WindowGetScale(originalWindow)
		
		text = string.find(windowname , "GenericGump")
		if ( text ~= nil ) then
			windowname = "GGump"
			maxScale = 3.0
		end
		
		text = string.find(windowname , "CourseMapWindow")
		if ( text ~= nil ) then
			windowname = "CourseMapWindowSCALE"
			maxScale = 3.0
		end

		
		local endscale = delta * 0.05 + scale
		
		if (endscale < maxScale and endscale > 0.25) then
			if (windowname == "GGump") then
				GenericGump.GGumps[originalWindow] = endscale
			end
			
			if (windowname == "PrtyHealthBarSCALE") then
				for i=1, HealthBarManager.MAX_PARTY_MEMBERS do
					if (PartyHealthBar.HasWindowByIndex(i)) then
						WindowSetScale("PartyHealthBar_" .. i, endscale)
					end
				end
			elseif (windowname == "MobileHealthBarSCALE") then
				for key, _ in pairs(MobileHealthBar.hasWindow) do
					local windowName = "MobileHealthBar_"..key
					WindowSetScale(windowName, endscale)
				end
				WindowSetScale("PetWindow", endscale)
				WindowSetScale("MobilesOnScreenWindow", endscale)
				WindowSetScale("YellowDockspot", endscale)
				WindowSetScale("GreyDockspot", endscale)
				WindowSetScale("BlueDockspot", endscale)
				WindowSetScale("RedDockspot", endscale)
				WindowSetScale("GreenDockspot", endscale)
				WindowSetScale("OrangeDockspot", endscale)
				MobilesOnScreen.BarScale = endscale				
				MobilesOnScreen.isDirty= true
			elseif (windowname == "MapWindow") then
				if (MapWindow.Big) then
					windowname = "MapWindowBig"
				else
					windowname = "MapWindow"
				end
				WindowSetScale(originalWindow, endscale)
				WindowSetScale("MapWindowCoordsText", 0.9 * InterfaceCore.scale)
				WindowSetScale("MapWindowPlayerCoordsText", 0.9 * InterfaceCore.scale)
				WindowSetScale("MapWindowCenterOnPlayerButton", 0.9 * InterfaceCore.scale)
				WindowSetScale("MapWindowCenterOnPlayerLabel", 0.9 * InterfaceCore.scale)
				WindowSetScale("MapWindowTiltButton", 0.9 * InterfaceCore.scale)
				WindowSetScale("MapWindowTiltLabel", 0.9 * InterfaceCore.scale)
			elseif(windowname == "PperdollWindow") then
				WindowSetScale(originalWindow, endscale)
				local paperdollId = WindowGetId(originalWindow)
				PaperdollWindow.UpdatePaperdoll(originalWindow,paperdollId, true)
			elseif(windowname == "CourseMapWindowSCALE") then
				WindowSetScale(originalWindow, endscale)
				local width, height = WindowGetDimensions(originalWindow.."Texture")
				CourseMapWindow.CurrMapSize.width = width * endscale
				CourseMapWindow.CurrMapSize.height = height * endscale
				
				CourseMapWindow.UpdatePoints()
			elseif (string.find(originalWindow, "hotbar")) then
				for slot = 1, Hotbar.NUM_BUTTONS do
				   local element = originalWindow.."Button"..slot

				   WindowSetScale(element .. "Cooldown", endscale)
				end	
				WindowSetScale(originalWindow, endscale)
			else
				
				WindowSetScale(originalWindow, endscale)
			end
			
			Interface.SaveNumber( windowname.."SC", endscale )
			if windowname == "ContainerWindowSCALE" then
				--Resize End
				ContainerWindow.LegacyGridDock(originalWindow)
				ContainerWindow.UpdateContents(WindowGetId(originalWindow))				
			end
		end
	end
end

function WindowUtils.LoadAlpha( windowname )
	if (windowname ~= nil) then
		
		local originalWindow = windowname
		local text = string.find(windowname , "PaperdollWindow")
		if ( text ~= nil ) then
			windowname = "PperdollWindow"
		end

		text = string.find(windowname , "ContainerWindow")
		if ( text ~= nil ) then
			windowname = "ContainerWindowALPHA"
			if (SystemData.Settings.Interface.LegacyContainers) then
				return
			end
		end
		text = string.find(windowname , "PartyHealthBar_")
		if ( text ~= nil ) then
			windowname = "PrtyHealthBarALPHA"
		end
		
		text = string.find(windowname , "MobileHealthBar_") or string.find(windowname , "MobileHealthBarSCALE")
		if ( text ~= nil ) then
			windowname = "MobileHealthBarALPHA"
		end

		text = string.find(windowname , "CourseMapWindow")
		if ( text ~= nil ) then
			windowname = "CourseMapWindowALPHA"
		end
		
		
		if (MapWindow.Big and windowname == "MapWindow") then
			windowname = "MapWindowBig"
		end
		local scale = Interface.LoadNumber( windowname.."ALP", -5 )
		

		if (scale ~= nil and scale ~= -5) then
			if (scale <  0.01) then
				scale = 0.01
			end

			
			if (windowname == "PrtyHealthBarALPHA") then
				for i=1, HealthBarManager.MAX_PARTY_MEMBERS do
					if (PartyHealthBar.HasWindowByIndex(i)) then
						WindowSetAlpha("PartyHealthBar_" .. i, scale)
						WindowSetFontAlpha("PartyHealthBar_" .. i, scale)
					end
				end
			elseif (windowname == "MobileHealthBarALPHA") then
				for key, _ in pairs(MobileHealthBar.hasWindow) do
					if (not MobileHealthBar.ObjecHasWindow[key]) then
						local windowName = "MobileHealthBar_"..key
						if DoesWindowNameExist(windowName) then
							WindowSetAlpha(windowName, scale)
							WindowSetFontAlpha(windowName, scale)
						end
					end
				end
				WindowSetAlpha("PetWindow", scale)
				WindowSetFontAlpha("PetWindow", scale)
				WindowSetAlpha("MobilesOnScreenWindow", scale)
				WindowSetFontAlpha("MobilesOnScreenWindow", scale)
				WindowSetAlpha("YellowDockspot", scale)
				WindowSetFontAlpha("YellowDockspot", scale)
				WindowSetAlpha("GreyDockspot", scale)
				WindowSetFontAlpha("GreyDockspot", scale)
				WindowSetAlpha("BlueDockspot", scale)
				WindowSetFontAlpha("BlueDockspot", scale)
				WindowSetAlpha("RedDockspot", scale)
				WindowSetFontAlpha("RedDockspot", scale)
				WindowSetAlpha("GreenDockspot", scale)
				WindowSetFontAlpha("GreenDockspot", scale)
				WindowSetAlpha("OrangeDockspot", scale)
				WindowSetFontAlpha("OrangeDockspot", scale)
			elseif (windowname == "MapWindow") then
				
				WindowSetAlpha(originalWindow, scale)
				WindowSetFontAlpha(originalWindow, scale)
			elseif(windowname == "PperdollWindow") then
				WindowSetAlpha(originalWindow, scale)
				WindowSetFontAlpha(originalWindow, scale)
			elseif(windowname == "CourseMapWindowALPHA") then
				WindowSetAlpha(originalWindow, scale)
			elseif (originalWindow == "StatusWindow") then
				WindowSetAlpha(originalWindow, scale)
				WindowSetFontAlpha(originalWindow, scale)
				WindowSetAlpha("WarButton", scale)
			else
				WindowSetAlpha(originalWindow, scale)
				WindowSetFontAlpha(originalWindow, scale)
			end
			
			
		end
	end
end

function WindowUtils.LoadScale(windowname, _)
	if (windowname ~= nil) then
		WindowUtils.LoadAlpha( windowname )
		
		local originalWindow = windowname
		local text = string.find(windowname , "PaperdollWindow")
		if ( text ~= nil ) then
			windowname = "PperdollWindow"
		end
		text = string.find(windowname , "GenericGump")
		if ( text ~= nil ) then
			
			windowname = "GGump"			
		end
		text = string.find(windowname , "ContainerWindow")
		if ( text ~= nil ) then
			windowname = "ContainerWindowSCALE"
			if (SystemData.Settings.Interface.LegacyContainers) then
				return
			end
		end
		text = string.find(windowname , "PartyHealthBar_")
		if ( text ~= nil ) then
			windowname = "PrtyHealthBarSCALE"
		end
		
		text = string.find(windowname , "MobileHealthBar_")
		if ( text ~= nil ) then
			windowname = "MobileHealthBarSCALE"
		end
		
		text = string.find(windowname , "CourseMapWindow")
		if ( text ~= nil ) then
			windowname = "CourseMapWindowSCALE"
		end
		
		
		if (MapWindow.Big and windowname == "MapWindow") then
			windowname = "MapWindowBig"
		end
		local scale = Interface.LoadNumber( windowname.."SC", -5 )
		

		if (scale ~= nil and scale ~= -5) then
			if (scale <  0.25) then
				scale = 0.25
			end
			if ((windowname == "CourseMapWindowSCALE"  or windowname == "GGump") and scale > 3) then
				scale = 3
			elseif (scale > 1.5) and not (windowname == "CourseMapWindowSCALE"  or windowname == "GGump") then
				scale = 1.5
			end
			
			if (windowname == "PrtyHealthBarSCALE") then
				for i=1, HealthBarManager.MAX_PARTY_MEMBERS do
					if (PartyHealthBar.HasWindowByIndex(i)) then
						WindowSetScale("PartyHealthBar_" .. i, scale)
					end
				end
			elseif (windowname == "MobileHealthBarSCALE") then
				for key, _ in pairs(MobileHealthBar.hasWindow) do
					local windowName = "MobileHealthBar_"..key
					if DoesWindowNameExist(windowName) then
						WindowSetDimensions(windowName, 190, 50)
						WindowSetScale(windowName, scale)
					end
				end
				WindowSetScale("PetWindow", scale)
				WindowSetScale("MobilesOnScreenWindow", scale)
				
				WindowSetScale("YellowDockspot", scale)
				WindowSetScale("GreyDockspot", scale)
				WindowSetScale("BlueDockspot", scale)
				WindowSetScale("RedDockspot", scale)
				WindowSetScale("GreenDockspot", scale)
				WindowSetScale("OrangeDockspot", scale)
			elseif (windowname == "MapWindow") then
				
				WindowSetScale(originalWindow, scale)
				WindowSetScale("MapWindowCoordsText", 0.9 * InterfaceCore.scale)
				WindowSetScale("MapWindowPlayerCoordsText", 0.9 * InterfaceCore.scale)
				WindowSetScale("MapWindowCenterOnPlayerButton", 0.9 * InterfaceCore.scale)
				WindowSetScale("MapWindowCenterOnPlayerLabel", 0.9 * InterfaceCore.scale)
				WindowSetScale("MapWindowTiltButton", 0.9 * InterfaceCore.scale)
				WindowSetScale("MapWindowTiltLabel", 0.9 * InterfaceCore.scale)
				WindowUtils.RestoreWindowPosition(originalWindow)
			elseif(windowname == "PperdollWindow") then
				WindowSetScale(originalWindow, scale)
			elseif(windowname == "CourseMapWindowSCALE") then
				WindowSetScale(originalWindow, scale)
				local width, height = WindowGetDimensions(originalWindow.."Texture")
				CourseMapWindow.CurrMapSize.width = width * scale
				CourseMapWindow.CurrMapSize.height = height * scale
			else
				WindowSetScale(originalWindow, scale)
			end
		end
	end
end





function WindowUtils.SendOverheadText(message, hue, chat, ignoreLast)
	SystemData.Text = message
	SystemData.TextChannelID = 2
	SystemData.TextSourceID = WindowData.PlayerStatus.PlayerId
	SystemData.TextColor = hue
	OverheadText.ShowOverheadText()
	if ( chat == true )	then
		PrintWStringToChatWindow(message, SystemData.ChatLogFilters.SYSTEM )
	end
end

function IsPlayerDead()
	local mobileData = Interface.GetMobileData(WindowData.PlayerStatus.PlayerId, false)
	if not mobileData then
		return false
	end
	
	return mobileData.IsDead
end

function IsContainer(id)
	if IsMobile(id) then
		if MobilesOnScreen.IsPet(id) then
			RegisterWindowData(WindowData.Paperdoll.Type, id)
			if WindowData.Paperdoll[id] and WindowData.Paperdoll[id].backpackId then
				UnregisterWindowData(WindowData.Paperdoll.Type, mobileId)
				return true
			end
			UnregisterWindowData(WindowData.Paperdoll.Type, mobileId)
			return false
		end
		return false
	end

	if not WindowData.ContainerWindow[id] then		
		return false
	else
		return true
	end
end

local function tchelper(first, rest)
  return first:upper()..rest:lower()
end


function WindowUtils.Decapitalizing(value)
	if not value then
		return L""
	end
	if (SystemData.Settings.Language.type == SystemData.Settings.Language.LANGUAGE_ENU) then
		local str = string.lower(WStringToString(value))
		str = str:gsub("(%a)([%w_']*)", tchelper)

		return StringToWString(str)
	else
		return value
	end
end

function WindowUtils.Commalines(str)
  local t = {}
  local function helper(line) table.insert(t, line) return "" end
  helper((str:gsub("(.-)\n", helper)))
  return t
end

function WindowUtils.ChatPrint(text, channel)
	if (Interface.UseNewChat) then
		local logVal = {text = text, channel = channel, color = ChatSettings.ChannelColors[channel], sourceId = 0, sourceName = "", ignore = false, category = 0, timeStamp = StringToWString(string.format("%02.f", Interface.Clock.h) .. ":" .. string.format("%02.f", Interface.Clock.m) .. ":" .. string.format("%02.f", Interface.Clock.s))}
		table.insert(NewChatWindow.Messages, logVal)
		table.insert(NewChatWindow.Setting.Messages, logVal)
		if (table.getn(NewChatWindow.Setting.Messages) > 200) then
			table.remove(NewChatWindow.Setting.Messages, 1)
		end
		NewChatWindow.UpdateLog()
	else
		PrintWStringToChatWindow(text, channel)
	end
	
end

function WindowUtils.Dec2Hex(nValue)
	if type(nValue) == "string" then
		nValue = String.ToNumber(nValue);
	end
	nHexVal = string.format("%X", nValue);  -- %X returns uppercase hex, %x gives lowercase letters
	sHexVal = nHexVal.."";
	return sHexVal;
end

function IsVendor( merchantId )
	if MobilesOnScreen.IsPet(merchantId) then
		return false
	elseif not IsMobile(merchantId) or mobileId == WindowData.PlayerStatus.PlayerId then
		return false
	end
	if not WindowData.ObjectInfo[merchantId] then
		RegisterWindowData(WindowData.ObjectInfo.Type, merchantId)
	end
	local vendor = WindowData.ObjectInfo[merchantId]~= nil and WindowData.ObjectInfo[merchantId].sellContainerId ~= nil
	UnregisterWindowData(WindowData.ObjectInfo.Type, merchantId)
	return vendor
end

function IsBodDealer( mobileId )
	
	if MobilesOnScreen.IsPet(mobileId) then
		return false
	elseif not IsMobile(mobileId) or mobileId == WindowData.PlayerStatus.PlayerId then
		return false
	end
	if not WindowData.MobileName[mobileId] then
		RegisterWindowData(WindowData.MobileName.Type, mobileId)
	end
	local name = WStringToString(WindowData.MobileName[mobileId].MobName)
	local noto = WindowData.MobileName[mobileId].Notoriety+1
	
	if (name and noto == NameColor.Notoriety.INVULNERABLE) then
		local serverId = WindowData.SkillsCSV[8].ServerId
		local black = WindowData.SkillDynamicData[serverId].RealSkillValue
		
		serverId = WindowData.SkillsCSV[52].ServerId
		local tailor = WindowData.SkillDynamicData[serverId].RealSkillValue

		serverId = WindowData.SkillsCSV[20].ServerId
		local fletcher = WindowData.SkillDynamicData[serverId].RealSkillValue

		serverId = WindowData.SkillsCSV[11].ServerId
		local carpentry = WindowData.SkillDynamicData[serverId].RealSkillValue

		serverId = WindowData.SkillsCSV[55].ServerId
		local tinker = WindowData.SkillDynamicData[serverId].RealSkillValue

		serverId = WindowData.SkillsCSV[14].ServerId
		local cooking = WindowData.SkillDynamicData[serverId].RealSkillValue

		serverId = WindowData.SkillsCSV[1].ServerId
		local alchemy = WindowData.SkillDynamicData[serverId].RealSkillValue

		serverId = WindowData.SkillsCSV[27].ServerId
		local inscription = WindowData.SkillDynamicData[serverId].RealSkillValue
		
		local bodBlack = (string.find(name, "Armourer") or string.find(name, "The Blacksmith") or string.find(name, "The Weaponsmith")) 
		if bodBlack and (string.find(name, "Guildmaster") or string.find(name, "Guildmistress") or  string.find(name, "Instructor")) then
			if MapCommon.AreaDescription == "New Haven" then
				bodBlack = false
			else
				bodBlack = true
			end
		end
		local bodTailor = (string.find(name, "Tailor") or string.find(name, "Weaver"))
		if bodTailor and (string.find(name, "Guildmaster") or string.find(name, "Guildmistress") or  string.find(name, "Instructor")) then
			bodTailor = false
		end
		local bodFletcher = (string.find(name, "Bowyer"))
		if bodFletcher and (string.find(name, "Guildmaster") or string.find(name, "Guildmistress") or  string.find(name, "Instructor")) then
			bodFletcher = false
		end
		local bodCarpenter = (string.find(name, "Carpenter"))
		if bodCarpenter and (string.find(name, "Guildmaster") or string.find(name, "Guildmistress") or  string.find(name, "Instructor")) then
			bodCarpenter = false
		end
		local bodTinker = (string.find(name, "Tinker"))
		if bodTinker and (string.find(name, "Guildmaster") or string.find(name, "Guildmistress") or  string.find(name, "Instructor")) then
			bodTinker = false
		end
		local bodScribe = (string.find(name, "Scribe"))
		if bodScribe and (string.find(name, "Guildmaster") or string.find(name, "Guildmistress") or  string.find(name, "Instructor")) then
			bodScribe = false
		end
		local bodCook = (string.find(name, "Cook") or string.find(name, "Baker") )
		if bodCook and (string.find(name, "Guildmaster") or string.find(name, "Guildmistress") or  string.find(name, "Instructor")) then
			bodCook = false
		end
		local bodAlchemist = (string.find(name, "Alchemist"))
		if bodAlchemist and (string.find(name, "Guildmaster") or string.find(name, "Guildmistress") or  string.find(name, "Instructor")) then
			bodAlchemist = false
		end
		if (bodBlack and black > 0) or (bodTailor and tailor > 0) or (bodFletcher and fletcher > 0) or (bodCarpenter and carpentry > 0) or (bodTinker and tinker > 0) or (bodScribe and inscription > 0) or (bodCook and cooking > 0) or (bodAlchemist and alchemy > 0) then
			return true
		end
	end
	return false
end

function IsOldQuestGiver( mobileId )
	if MobilesOnScreen.IsPet(mobileId) then
		return false
	elseif not IsMobile(mobileId) or mobileId == WindowData.PlayerStatus.PlayerId then
		return false
	end
	if not WindowData.MobileName[mobileId] then
		RegisterWindowData(WindowData.MobileName.Type, mobileId)
	end
	if not WindowData.MobileName[mobileId] then
		return false
	end
	local name = WStringToString(WindowData.MobileName[mobileId].MobName)
	local noto = WindowData.MobileName[mobileId].Notoriety+1
	if (name and noto == NameColor.Notoriety.INVULNERABLE) then
	
			return	string.find(name, "Grizelda The Hag") 
					or string.find(name, "Elwood McCarrin The Well[-]Known Collector")
					or string.find(name, "Alberta Giacco")
					or string.find(name, "Ambitious Solen Queen")
					or string.find(name, "Captain Blackheart The Drunken Pirate")
					or string.find(name, "Gabriel Piete The Renowned Minstrel")
					or string.find(name, "Tomas O'Neerlan The Famed Toymaker")
					or string.find(name, "Zeefzorpul the Imp")
					or string.find(name, "The Solen Matriarch")
					or string.find(name, "The Naturalist")
	end
	return false
end

function IsBanker( mobileId )
	if MobilesOnScreen.IsPet(mobileId) then
		return false
	elseif not IsMobile(mobileId) or mobileId == WindowData.PlayerStatus.PlayerId then
		return false
	end
	if not WindowData.MobileName[mobileId] then
		RegisterWindowData(WindowData.MobileName.Type, mobileId)
	end
	local name = WStringToString(WindowData.MobileName[mobileId].MobName)
	local noto = WindowData.MobileName[mobileId].Notoriety+1
	if (name and noto == NameColor.Notoriety.INVULNERABLE) then
		return string.find(name, "The Banker") or string.find(name, "The Minter") 
	end
	return false
end

function IsPartyMember( mobileId )
	if MobilesOnScreen.IsPet(mobileId) then
		return false
	elseif not IsMobile(mobileId) or WindowData.PlayerStatus and mobileId == WindowData.PlayerStatus.PlayerId then
		return false
	end
	if not WindowData.PartyMember then
		return false
	end
	for i = 1, HealthBarManager.MAX_PARTY_MEMBERS do
		if (mobileId == WindowData.PartyMember[i].memberId) then
			return true
		end
	end
	return false
end

function IsPlayer( mobileId )	
	if MobilesOnScreen.IsPet(mobileId) then		
		return false
	end

	if not IsMobile(mobileId) or mobileId == WindowData.PlayerStatus.PlayerId then
		return false
	end
	if not WindowData.MobileName[mobileId] then
		RegisterWindowData(WindowData.MobileName.Type, mobileId)
	end	
	local name = WStringToString(WindowData.MobileName[mobileId].MobName)
	local noto = WindowData.MobileName[mobileId].Notoriety+1
	local props = ItemProperties.GetObjectPropertiesTid( mobileId, 2, nil, "Isplayer check" )
	if(name == nil or name == "") then
		return false
	end
	if (name and noto == NameColor.Notoriety.INVULNERABLE) then
		return false
	elseif IsVendor( mobileId ) then
		return false
	elseif ItemPropertiesInfo.QuestGiverTid[props] then
		return false
	elseif string.find(name, "The Noble") or string.find(name, "The Miner") or string.find(name, "The Wandering Healer") or string.find(name, "Myrmidex") or string.find(name, "Zipactriotl") or string.find(name, "The Britannian")
		   or string.find(name, "Jukari") or string.find(name, "Kurak") or string.find(name, "Barrab") or string.find(name, "Barako") or string.find(name, "Urali") or string.find(name, "Sakkhra")
		   or string.find(name, "Kotl Automaton") or string.find(name, "Spectral Kotl") then
		return false
	else
		name = CreaturesDB.GetName(WindowData.CurrentTarget.TargetId)
		if CreaturesDB[name] then
			return false
		else
			Interface.RequestContextMenu(mobileId, false)
			local menuItems = ContextMenu.GetMenuItemData()
			if not WindowData.ContextMenu then
				return false
			end
			if not menuItems or WindowData.ContextMenu.objectId ~= WindowData.CurrentTarget.TargetId then 				
				return false
			end
			for i = 1, #menuItems do
				if menuItems[i].returnCode == 810 then					
					return true
				end
				if menuItems[i].returnCode == 819 then					
					return true
				end
			end
		end
	end
	
	return false
end

function IsTamable( mobileId )
	if MobilesOnScreen.IsPet(mobileId) then
		return false
	end
	if not IsMobile(mobileId) or MobilesOnScreen.IsPet(mobileId) then
		return false
	end
	local name = CreaturesDB.GetName(WindowData.CurrentTarget.TargetId)
	local props = ItemProperties.GetObjectPropertiesTid( mobileId, nil, "Istamable check" )
	if not props then
		return false
	end
	for i = 1, #props do
		if ItemPropertiesInfo.TamedTid[props[i]] then
			return false
		end
	end
	if CreaturesDB[name] then
		return CreaturesDB[name].tamable
	else
		
		RequestContextMenu(mobileId, false)
		local menuItems = ContextMenu.GetMenuItemData()
		if not WindowData.ContextMenu then
			return false
		end
		if not menuItems or WindowData.ContextMenu.objectId ~= WindowData.CurrentTarget.TargetId then
			return false
		end
		for i = 1, #menuItems do
			if menuItems[i].returnCode == 301 then
				return true
			end
		end
	end
	return false
end

function IsQuestGiver( mobileId )
	local props = ItemProperties.GetObjectPropertiesTid( mobileId, 2, "Isquestgiver check" )
	if MobilesOnScreen.IsPet(mobileId) then
		return false
	elseif ItemPropertiesInfo.QuestGiverTid[props] then
		return true
	end
	return false
end

function IsMobileVisible(mobileId)
	return GetDistanceFromPlayer(mobileId) < 22
end


function PlayerIsOnWater()
	local currTerrain = LuaGetTerrainType(WindowData.PlayerLocation.x, WindowData.PlayerLocation.y)
	if currTerrain == 5 or currTerrain == 52 then
		return true
	end
	return false
end

function IsRiding()
	local ridingPet
	if WindowData.PlayerEquipmentSlot[EquipmentData.EQPOS_RIDING] then
		ridingPet = WindowData.PlayerEquipmentSlot[EquipmentData.EQPOS_RIDING]
	else
		RegisterWindowData(WindowData.PlayerEquipmentSlot.Type, EquipmentData.EQPOS_RIDING)
		ridingPet = WindowData.PlayerEquipmentSlot[EquipmentData.EQPOS_RIDING]
		UnregisterWindowData(WindowData.PlayerEquipmentSlot.Type, EquipmentData.EQPOS_RIDING)
	end
	if ridingPet.objectId > 0 then
		return ridingPet.objectId
	else
		return false
	end
end

function HasAccessibleInventory(mobileId)
	local mobileData = Interface.GetMobileData(mobileId, true)
	if MobilesOnScreen.IsPet(mobileId) and not mobileData.IsDead then
		local backpackId = 0
		if WindowData.Paperdoll[mobileId] then
			backpackId = WindowData.Paperdoll[mobileId].backpackId
		else
			RegisterWindowData(WindowData.Paperdoll.Type, mobileId)
			if WindowData.Paperdoll[mobileId] then
				backpackId = WindowData.Paperdoll[mobileId].backpackId
			end
			UnregisterWindowData(WindowData.Paperdoll.Type, mobileId)
		end
		--Debug.Print("HasAccessibleInventory(mobileId)")
		if backpackId and backpackId ~= 0 then
			local removeOnComplete = false
			if not WindowData.ContainerWindow[backpackId] then
				RegisterWindowData(WindowData.ContainerWindow.Type, backpackId)
				removeOnComplete = true				
			end			
			if WindowData.ContainerWindow[backpackId] and WindowData.ContainerWindow[backpackId].containerName == L"Backpack" then
				if ContainerWindow.OpenContainers[backpackId] == nil and removeOnComplete then
					UnregisterWindowData(WindowData.ContainerWindow.Type, backpackId)
				end
				return true
			end	
			if ContainerWindow.OpenContainers[backpackId] == nil and removeOnComplete then
				UnregisterWindowData(WindowData.ContainerWindow.Type, backpackId)
			end		
		end

	end
	return false
end

function IsPlayerParalyzed()
	
	return BuffDebuff.BuffWindowId[1037]
end

function IsPlayerInvisible()
	
	return BuffDebuff.BuffWindowId[1036] or BuffDebuff.BuffWindowId[1012]
end

function WindowUtils.DrawObjectIcon(objectType, hueId, elementIcon, w, h, scl)
	if not w or not h then
		w, h = WindowGetDimensions(elementIcon)
	end
	local name, x, y, scale, newWidth, newHeight = RequestTileArt(objectType,w,h)
	
	WindowSetDimensions(elementIcon, newWidth, newHeight)	
	DynamicImageSetTextureDimensions(elementIcon, newWidth, newHeight)
	DynamicImageSetTexture(elementIcon, name, x, y )
	
	DynamicImageSetCustomShader(elementIcon, "UOSpriteUIShader", {hueId, objectType})
	if scl then
		scale = scl
	end
	
	DynamicImageSetTextureScale(elementIcon, scale)
	local hueR,hueG,hueB,hueA = HueRGBAValue(hueId)
	WindowSetTintColor(elementIcon, hueR,hueG,hueB )
	WindowSetAlpha(elementIcon,hueA/255)	
end