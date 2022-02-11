RadarWindow = ListWindow:new("RadarWindow", false)

RadarWindow.Rotation = 45
RadarWindow.Tilt = false
RadarWindow.Size = 0
RadarWindow.Scale = 1.0

RadarWindow.Locked = false

function RadarWindow.Initialize()
	WindowUtils.RestoreWindowPosition(RadarWindow.id)
	RadarWindow.Scale = WindowGetScale("RadarWindow")
	RadarWindow.adapter:addLock()
	
	RadarWindow.Size = WindowGetDimensions("RadarWindowMap")

    -- Update registration
    RegisterWindowData(WindowData.Radar.Type,0)
    RegisterWindowData(WindowData.WaypointList.Type,0)
	RegisterWindowData(WindowData.PlayerLocation.Type,0)
	WindowRegisterEventHandler("RadarWindow", WindowData.PlayerLocation.Event, "RadarWindow.UpdateRadar")
	WindowRegisterEventHandler("RadarWindow", WindowData.Radar.Event, "RadarWindow.UpdateRadar")
	WindowRegisterEventHandler("RadarWindow", WindowData.WaypointList.Event, "RadarWindow.UpdateWaypoints")
    SnapUtils.SnappableWindows["RadarWindow"] = true
    
    RadarWindow.ToggleMap()
    WindowSetShowing("RadarWindow", false) 
end

function RadarWindow.Shutdown()
	WindowUtils.SaveWindowPosition("RadarWindow")
	
	UnregisterWindowData(WindowData.Radar.Type,0)
	UnregisterWindowData(WindowData.WaypointList.Type,0)
	 SnapUtils.SnappableWindows["RadarWindow"] = nil
end

function RadarWindow.OnMouseDrag()
	RadarWindow:onLeftClickDown()
end

function RadarWindow.UpdateRadar()
	RadarWindow.SetRadarCoords()
	WindowSetScale("RadarWindow", RadarWindow.Scale)

	CircleImageSetTexture("RadarWindowMap","radar_texture", WindowData.Radar.TexCoordX + 550, WindowData.Radar.TexCoordY + 550)
	CircleImageSetTextureScale("RadarWindowMap", WindowData.Radar.TexScale)
        
	CircleImageSetRotation("RadarWindowMap", RadarWindow.Rotation)
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
	MapCommon.ActiveView = nil
	SystemData.Settings.Interface.mapMode = MapCommon.MAP_HIDDEN
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