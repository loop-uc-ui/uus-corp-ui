----------------------------------------------------------------
-- Global Variables
----------------------------------------------------------------

ResizeWindow = {}

----------------------------------------------------------------
-- Local Variables
----------------------------------------------------------------

ResizeWindow.HANDLE_SIZE = 5
ResizeWindow.IsMoving = false

----------------------------------------------------------------
-- Functions
----------------------------------------------------------------

function ResizeWindow.Initialize()
	WindowRegisterEventHandler( "ResizeWindow", SystemData.Events.VIEWPORT_CHANGED, "ResizeWindow.OnViewportChanged" )
	WindowUtils.RestoreWindowPosition("ResizeWindow", true)
	ResizeWindow.OnResizeEnd()
	ResizeWindow.UpdateWindow()
end

function ResizeWindow.Shutdown()
	WindowUtils.SaveWindowPosition("ResizeWindow", true)
end

function ResizeWindow.Update(timePassed)
	if( ResizeWindow.IsMoving == true or WindowUtils.resizeWindow == "ResizeWindow" ) then
        ResizeWindow.UpdateViewport()
        
        if( WindowGetMoving("ResizeWindow") == false ) then
            ResizeWindow.IsMoving = false
        end
	end
end

function ResizeWindow.UpdateViewport()
    local windowWidth, windowHeight
    if( WindowUtils.resizeWindow == "ResizeWindow" ) then
        windowWidth, windowHeight = WindowGetDimensions("ResizingWindowFrame")				
    else
        windowWidth, windowHeight = WindowGetDimensions("ResizeWindow")
    end
    ResizeWindow.SendViewportData(windowWidth, windowHeight)
end

function ResizeWindow.StartMoving()
	ResizeWindow.IsMoving = true
	WindowSetMoving("ResizeWindow",true)
end

function ResizeWindow.StopMoving()
    ResizeWindow.UpdateViewport()
    
	ResizeWindow.IsMoving = false
	WindowSetMoving("ResizeWindow",false)
end

function ResizeWindow.OnResizeBegin()
	ResizeWindow.UpdateCounter = 0
	WindowSetShowing("ResizeWindow",false)
    WindowUtils.BeginResize( "ResizeWindow", "topleft", 300, 200, false, ResizeWindow.OnResizeEnd )
end

function ResizeWindow.OnResizeEnd()
	local windowWidth, windowHeight = WindowGetDimensions("ResizeWindow")

	WindowSetShowing("ResizeWindow",true)
	ResizeWindow.UpdateHandles(windowWidth,windowHeight)
	ResizeWindow.SendViewportData(windowWidth,windowHeight)	
end

function ResizeWindow.UpdateHandles(windowWidth,windowHeight)
	if( windowWidth == nil or windowHeight == nil ) then
		windowWidth, windowHeight = WindowGetDimensions("ResizeWindow")
	end
	
	WindowSetDimensions("TopHandle",windowWidth,ResizeWindow.HANDLE_SIZE)
	WindowSetDimensions("BottomHandle",windowWidth,ResizeWindow.HANDLE_SIZE)
	WindowSetDimensions("LeftHandle",ResizeWindow.HANDLE_SIZE,windowHeight)
	WindowSetDimensions("RightHandle",ResizeWindow.HANDLE_SIZE,windowHeight)
	
end

function ResizeWindow.SendViewportData(windowWidth, windowHeight)
	local windowPosX, windowPosY = WindowGetOffsetFromParent("ResizeWindow")

    local viewportSizeX = (windowWidth * InterfaceCore.scale) / SystemData.screenResolution.x
	local viewportSizeY = (windowHeight * InterfaceCore.scale) / SystemData.screenResolution.y
	local viewportPosX = (windowPosX  * InterfaceCore.scale) / SystemData.screenResolution.x
	local viewportPosY = (windowPosY * InterfaceCore.scale) / SystemData.screenResolution.y
	
	UpdateViewport(viewportSizeX,viewportSizeY,viewportPosX,viewportPosY)
end

function ResizeWindow.UpdateWindow()
	if( SystemData.Settings.Resolution.viewportEnabled == false ) then
		WindowSetShowing("ResizeWindow",false)
	else
		WindowSetShowing("ResizeWindow",true)
		
		local scaleFactor = 1/InterfaceCore.scale

		local posx = SystemData.Settings.Resolution.viewportPos.x * SystemData.screenResolution.x * scaleFactor
		local posy = SystemData.Settings.Resolution.viewportPos.y * SystemData.screenResolution.y * scaleFactor
		
		WindowClearAnchors("ResizeWindow")
		WindowAddAnchor("ResizeWindow","topleft","Root","topleft",posx,posy)
		
		local windowPercentX = SystemData.Settings.Resolution.viewportSize.x
		local windowPercentY = SystemData.Settings.Resolution.viewportSize.y
		
		local windowWidth = (scaleFactor * windowPercentX * SystemData.screenResolution.x)
		local windowHeight = (scaleFactor * windowPercentY * SystemData.screenResolution.y)	

		WindowSetDimensions("ResizeWindow",windowWidth,windowHeight)
		
		ResizeWindow.UpdateHandles(windowWidth,windowHeight)
	end
end

function ResizeWindow.OnViewportChanged()
	ResizeWindow.UpdateWindow()
end