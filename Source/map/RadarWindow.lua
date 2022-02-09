----------------------------------------------------------------
-- Global Variables
----------------------------------------------------------------

RadarWindow = {}

----------------------------------------------------------------
-- Local Variables
----------------------------------------------------------------

RadarWindow.Rotation = 45
RadarWindow.Tilt = false
RadarWindow.Size = 0
RadarWindow.Scale = 1.0

RadarWindow.Locked = false

-----------------------------------------------------------------
-- MapCommon Helper Functions
-----------------------------------------------------------------

----------------------------------------------------------------
-- Functions
----------------------------------------------------------------

function RadarWindow.Initialize()
	--Debug.Print("RadarWindow.Initialize(): "..SystemData.Settings.Interface.mapMode)
	WindowUtils.RestoreWindowPosition("RadarWindow")
	RadarWindow.Scale = WindowGetScale("RadarWindow")
		
	WindowClearAnchors("RadarBigButton")
	WindowAddAnchor("RadarBigButton", "left", "RadarWindowRing", "center", 31, -20)
	WindowSetLayer("RadarBigButton", Window.Layers.OVERLAY)
	WindowSetTintColor("RadarBigButton" , 255, 0, 0)
	
	WindowClearAnchors("RadarTinyButton")
	WindowAddAnchor("RadarTinyButton", "left", "RadarWindowRing", "center", 31, 20)
	WindowSetLayer("RadarTinyButton", Window.Layers.OVERLAY)
	WindowSetTintColor("RadarTinyButton" , 255, 0, 0)
	
	WindowClearAnchors("RadarRotate")
	WindowAddAnchor("RadarRotate", "bottom", "RadarWindowRing", "center", 5, -26)
	WindowSetLayer("RadarRotate", Window.Layers.OVERLAY)
	
	WindowClearAnchors("RadarWP")
	WindowAddAnchor("RadarWP", "right", "RadarWindowRing", "center", -20, 0)
	WindowSetLayer("RadarWP", Window.Layers.OVERLAY)
	WindowSetTintColor("RadarWP" , 255, 0, 0)
	
	WindowClearAnchors("RadarLock")
	ButtonSetTexture("RadarLock", InterfaceCore.ButtonStates.STATE_NORMAL, "UO_Core", 68, 338)
	ButtonSetTexture("RadarLock",InterfaceCore.ButtonStates.STATE_PRESSED, "UO_Core", 68, 338)
	ButtonSetTexture("RadarLock", InterfaceCore.ButtonStates.STATE_NORMAL_HIGHLITE, "UO_Core", 92, 338) -- 248
	ButtonSetTexture("RadarLock", InterfaceCore.ButtonStates.STATE_PRESSED_HIGHLITE, "UO_Core", 92, 338) -- 248
	WindowAddAnchor("RadarLock", "top", "RadarWindowRing", "center", 5, 20)
	WindowSetLayer("RadarLock", Window.Layers.OVERLAY)
	
	RadarWindow.Size = WindowGetDimensions("RadarWindowMap")

    -- Update registration
    RegisterWindowData(WindowData.Radar.Type,0)
    RegisterWindowData(WindowData.WaypointList.Type,0)
    
    --WindowRegisterEventHandler("RadarWindow", WindowData.Radar.Event, "RadarWindow.UpdateRadar")	
    --WindowRegisterEventHandler("RadarWindow", WindowData.WaypointList.Event, "RadarWindow.UpdateWaypoints")
    SnapUtils.SnappableWindows["RadarWindow"] = true
    
    RadarWindow.ToggleMap()
    WindowSetShowing("RadarWindow", false) 
end

function RadarWindow.LockTooltip()
	if ( RadarWindow.Locked ) then
		Tooltips.CreateTextOnlyTooltip(SystemData.ActiveWindow.name, L"Unlock Radar")
	else
		Tooltips.CreateTextOnlyTooltip(SystemData.ActiveWindow.name, L"Lock Radar")
	end
	
	Tooltips.Finalize()
	Tooltips.AnchorTooltip( Tooltips.ANCHOR_WINDOW_TOP )
end

function RadarWindow.Lock()
	RadarWindow.Locked = not RadarWindow.Locked 
	Interface.SaveBoolean( "RadarWindowLocked", RadarWindow.Locked  )
end

function RadarWindow.Shutdown()
	WindowUtils.SaveWindowPosition("RadarWindow")
	
	UnregisterWindowData(WindowData.Radar.Type,0)
	UnregisterWindowData(WindowData.WaypointList.Type,0)
	 SnapUtils.SnappableWindows["RadarWindow"] = nil
end

function RadarWindow.OnMouseDrag()
	if (not RadarWindow.Locked ) then
		SnapUtils.StartWindowSnap("RadarWindow")
		WindowSetMoving("RadarWindow",true)
	else
		WindowSetMoving("RadarWindow",false)
	end

end

function RadarWindow.UpdateRadar() 
    if( MapCommon.ActiveView == MapCommon.RADAR_MODE_NAME ) then 
		RadarWindow.SetRadarCoords()
		 WindowSetScale("RadarWindow", RadarWindow.Scale) 
        local xOffset = RadarWindow.Size / 2
        local yOffset = RadarWindow.Size / 2
        
        CircleImageSetTexture("RadarWindowMap","radar_texture", WindowData.Radar.TexCoordX + xOffset, WindowData.Radar.TexCoordY + yOffset)
        CircleImageSetTextureScale("RadarWindowMap", WindowData.Radar.TexScale)
        
        CircleImageSetRotation("RadarWindowMap", RadarWindow.Rotation)
        
        MapCommon.WaypointsDirty = true
 
    end
end

function RadarWindow.UpdateWaypoints()
    if( MapCommon.ActiveView == MapCommon.RADAR_MODE_NAME ) then
        MapCommon.WaypointsDirty = true
    end    
end

function RadarWindow.ActivateRadar()
    if( MapCommon.ActiveView ~= MapCommon.RADAR_MODE_NAME ) then
	    UORadarSetWindowSize(RadarWindow.Size, RadarWindow.Size, true, true)
	    UOSetRadarRotation(RadarWindow.Rotation)
	    UORadarSetWindowOffset(0, 0)
    	
	    WindowSetShowing("MapWindow", false)
	    WindowSetShowing("RadarWindow", true)
	    
	    MapCommon.ActiveView = MapCommon.RADAR_MODE_NAME
	    UOSetWaypointDisplayMode(MapCommon.RADAR_MODE_NAME)
		
		SystemData.Settings.Interface.mapMode = MapCommon.MAP_RADAR
	    
	    MapCommon.AdjustZoom(0)
		
	    RadarWindow.UpdateRadar()
	end
end

function RadarWindow.ToggleMap()
	MapWindow.ActivateMap()
end

function RadarWindow.ToggleMapOnMouseOver()
	Tooltips.CreateTextOnlyTooltip(SystemData.ActiveWindow.name, GetStringFromTid(MapCommon.TID.ShowAtlas))
	Tooltips.Finalize()
	Tooltips.AnchorTooltip( Tooltips.ANCHOR_WINDOW_BOTTOM )
end

function RadarWindow.CloseMap()
	WindowSetShowing("MapWindow", false)
	WindowSetShowing("RadarWindow", false) 	
	MapCommon.ActiveView = nil
	
	SystemData.Settings.Interface.mapMode = MapCommon.MAP_HIDDEN
end

function RadarWindow.WPLButtonUp()
	local params = {x=WindowData.PlayerLocation.x, y=WindowData.PlayerLocation.y, facetId=UOGetRadarFacet()} 
	UserWaypointWindow.InitializeCreateWaypointData(params)
end

function RadarWindow.WPButtonMouseOver()
	Tooltips.CreateTextOnlyTooltip(SystemData.ActiveWindow.name, L"Create Waypoint")
	Tooltips.Finalize()
	Tooltips.AnchorTooltip( Tooltips.ANCHOR_WINDOW_BOTTOM )
end

function RadarWindow.CloseMapOnMouseOver()
	Tooltips.CreateTextOnlyTooltip(SystemData.ActiveWindow.name, GetStringFromTid(MapCommon.TID.Close))
	Tooltips.Finalize()
	Tooltips.AnchorTooltip( Tooltips.ANCHOR_WINDOW_BOTTOM )
end

function RadarWindow.ZoomOutOnMouseOver()
	Tooltips.CreateTextOnlyTooltip(SystemData.ActiveWindow.name, GetStringFromTid(MapCommon.TID.ZoomOut))
	Tooltips.Finalize()
	Tooltips.AnchorTooltip( Tooltips.ANCHOR_WINDOW_BOTTOM )
end
function RadarWindow.BigOnMouseOver()
	Tooltips.CreateTextOnlyTooltip(SystemData.ActiveWindow.name, L"Increase the map size")
	Tooltips.Finalize()
	Tooltips.AnchorTooltip( Tooltips.ANCHOR_WINDOW_BOTTOM )
end

function RadarWindow.BigOnLButtonUp()
	RadarWindow.Scale = RadarWindow.Scale + 0.1
	Interface.SaveNumber( "RadarWindowScale", RadarWindow.Scale )
	RadarWindow.UpdateRadar() 
end

function RadarWindow.TinyOnMouseOver()
	Tooltips.CreateTextOnlyTooltip(SystemData.ActiveWindow.name, L"Decrease the map size")
	Tooltips.Finalize()
	Tooltips.AnchorTooltip( Tooltips.ANCHOR_WINDOW_BOTTOM )
end

function RadarWindow.TinyOnLButtonUp()
	RadarWindow.Scale = RadarWindow.Scale - 0.1
	Interface.SaveNumber( "RadarWindowScale", RadarWindow.Scale )
	RadarWindow.UpdateRadar() 
end

function RadarWindow.RotateButtonMouseOver()
	Tooltips.CreateTextOnlyTooltip(SystemData.ActiveWindow.name, GetStringFromTid(1154867))
	Tooltips.Finalize()
	Tooltips.AnchorTooltip( Tooltips.ANCHOR_WINDOW_BOTTOM )
end

function RadarWindow.RotateLButtonUp()
	RadarWindow.Tilt = not RadarWindow.Tilt
	if (RadarWindow.Tilt) then
		RadarWindow.Rotation = 0
	else
		RadarWindow.Rotation = 45
	end

	RadarWindow.UpdateRadar() 
end


function RadarWindow.ZoomInOnMouseOver()
	Tooltips.CreateTextOnlyTooltip(SystemData.ActiveWindow.name, GetStringFromTid(MapCommon.TID.ZoomIn))
	Tooltips.Finalize()
	Tooltips.AnchorTooltip( Tooltips.ANCHOR_WINDOW_BOTTOM )
end

function RadarWindow.RadarOnMouseWheel(x, y, delta)
    MapCommon.AdjustZoom(-delta)
end

function RadarWindow.RadarOnLButtonDblClk(flags,x,y)
	local useScale = true
    local worldX, worldY = UOGetRadarPosToWorld(x, y, useScale)
	local facet = UOGetRadarFacet()
	local area = UOGetRadarArea()
	
	if( UORadarIsLocationInArea(worldX, worldY, facet, area) ) then
		UOCenterRadarOnLocation(worldX, worldY, facet, area, true)
	end
end

function RadarWindow.SetRadarCoords()
	waypointName = GetStringFromTid(MapCommon.TID.YourLocation)
	waypointX = WindowData.PlayerLocation.x
	waypointY = WindowData.PlayerLocation.y
	waypointFacet = WindowData.PlayerLocation.facet

	local latStr, longStr, latDir, longDir = MapCommon.GetSextantLocationStrings(waypointX, waypointY, waypointFacet)
	        
	LabelSetText("radarSextant", latStr..L"'"..latDir..L" "..longStr..L"'"..longDir)
	        
	if( MapCommon.ActiveView == MapCommon.MAP_MODE_NAME ) then
		LabelSetText("radarSextant", latStr..L"'"..latDir..L" "..longStr..L"'"..longDir)
	end	
end