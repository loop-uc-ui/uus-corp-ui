MapWindow = ListWindow:new("MapWindow")

MapWindow.ComboBCK = false

MapWindow.ZoomScale = 0.1
MapWindow.IsMouseOver = false
MapWindow.TypeEnabled = {}
MapWindow.CenterOnPlayer = true

MapWindow.WINDOW_WIDTH_MAX = 716
MapWindow.WINDOW_HEIGHT_MAX = 776
MapWindow.MAP_WIDTH_DIFFERENCE = 26
MapWindow.MAP_HEIGHT_DIFFERENCE = 111

local NUM_FACETS = 6

local VIEWS = {
	AREA_COMBO = "MapWindowAreaCombo",
	FACET_COMBO = "MapWindowFacetCombo",
	LABEL_CENTER_ON_PLAYER = "MapWindowCenterOnPlayerLabel",
	LABEL_PLAYER_CORDS = "MapWindowPlayerCoordsText",
	LABEL_MAP_CORDS = "MapWindowCoordsText",
	BUTTON_CENTER_ON_PLAYER = "MapWindowCenterOnPlayerButton",
	IMAGE_COMPASS = "MapCompass",
	IMAGE_MAP = "MapImage"
}

local function updateAreaCombo(facet)
	local areas = {}
	local targetFacet = facet or RadarApi.getFacet()
	for i = 0, RadarApi.getAreaCount(targetFacet) - 1 do
		table.insert(areas, StringFormatter.fromTid(RadarApi.getAreaLabel(
				targetFacet,
				i
		)))
	end
	return areas
end

function MapWindow.Initialize()
	WindowUtils.RestoreWindowPosition("MapWindow", true)
	
	MapWindow.OnResizeEnd("MapWindow")

	MapWindow:registerData(
			Radar.type()
	):registerData(
			WaypointDisplay.type()
	):registerData(
			WaypointList.type()
	):registerData(
			PlayerLocation.type()
	):registerEventHandler(
			Radar.event(),
			"MapWindow.UpdateMap"
	):registerEventHandler(
			PlayerLocation.event(),
			"MapWindow.UpdateMap"
	):registerEventHandler(
			WaypointList.event(),
			"MapWindow.UpdateMap"
	)

	local facets = {}

	for i = 0, NUM_FACETS - 1 do
		table.insert(facets, StringFormatter.fromTid(RadarApi.getFacetLabel(i)))
	end

	MapWindow.adapter:addComboBox(
			VIEWS.FACET_COMBO,
			facets,
			RadarApi.getFacet() + 1
	):addComboBox(
			VIEWS.AREA_COMBO,
			updateAreaCombo(),
			RadarApi.getArea() + 1
	):addLabel(
			VIEWS.LABEL_CENTER_ON_PLAYER,
			1112059
	):addCheckBox(
			VIEWS.BUTTON_CENTER_ON_PLAYER,
			true
	):addLabel(
			VIEWS.LABEL_MAP_CORDS
	):addLabel(
			VIEWS.LABEL_PLAYER_CORDS
	):addLock():addDynamicImage(
			VIEWS.IMAGE_COMPASS
	)

	MapWindow.adapter.views[VIEWS.BUTTON_CENTER_ON_PLAYER]:setChecked(true)
	MapWindow.adapter.views[VIEWS.IMAGE_COMPASS]:setRotation(45)

	local map = MapImage:new(VIEWS.IMAGE_MAP, false)
	local width, height = map:getDimensions()
	RadarApi.setWindowSize(width, height, true, true)
	MapWindow.adapter.views[VIEWS.IMAGE_MAP] = map

	MapWindow.UpdateMap()
	MapWindow.UpdateWaypoints()
end

function MapWindow.OnMouseDrag()
	MapWindow:onLeftClickDown()
end

function MapWindow.UpdateMap()
	local oldArea = ( ComboBoxGetSelectedMenuItem( "MapWindowAreaCombo" ) - 1 )
	local oldFacet = ( ComboBoxGetSelectedMenuItem( "MapWindowFacetCombo" ) - 1 )
	local facet = UOGetRadarFacet()
	if (facet ~= nil) then
		ComboBoxSetSelectedMenuItem( "MapWindowFacetCombo", (facet + 1) )
		ComboBoxClearMenuItems( "MapWindowAreaCombo" )
		for areaIndex = 0, (UORadarGetAreaCount(facet) - 1) do
			ComboBoxAddMenuItem( "MapWindowAreaCombo", GetStringFromTid(UORadarGetAreaLabel(facet, areaIndex)) )
		end
		local area = UOGetRadarArea()
		ComboBoxSetSelectedMenuItem( "MapWindowAreaCombo", (area + 1) )
		DynamicImageSetTextureScale("MapImage", WindowData.Radar.TexScale)
		DynamicImageSetTexture("MapImage","radar_texture", WindowData.Radar.TexCoordX, WindowData.Radar.TexCoordY)
		DynamicImageSetRotation("MapImage", WindowData.Radar.TexRotation)

		MapCommon.ForcedUpdate = (oldArea ~= area) or (oldFacet ~= facet)
		if (MapCommon.ForcedUpdate) then
			for waypointId, value in pairs(MapCommon.WaypointsIconFacet) do
				local windowName = "Waypoint"..waypointId..MapCommon.ActiveView
				if (value ~= facet) then
					if (DoesWindowNameExist(windowName)) then
						MapCommon.WaypointViewInfo[MapCommon.ActiveView].Windows[waypointId] = nil
						DestroyWindow(windowName)
					end
				end
			end
		end
		MapWindow.UpdateWaypoints()
	end
end

function MapWindow.UpdateWaypoints()
    if(WindowGetShowing("MapWindow") == true and MapCommon.ActiveView == MapCommon.MAP_MODE_NAME ) then
        MapCommon.WaypointsDirty = true
    end
end

function MapWindow.MapOnMouseWheel(x, y, delta)
	MapWindow.adapter.views[VIEWS.IMAGE_MAP]:onMouseWheel(x, y, delta)
end

function MapWindow.MapMouseDrag(_, deltaX, deltaY)
    if deltaX ~= 0 or deltaY ~= 0 then
		local facet = UOGetRadarFacet()
		local area = UOGetRadarArea()
		local mapCenterX, mapCenterY = UOGetRadarCenter()
		local winCenterX, winCenterY = UOGetWorldPosToRadar(mapCenterX,mapCenterY)
		local offsetX = winCenterX - deltaX
		local offsetY = winCenterY - deltaY
		local useScale = false
		local newCenterX, newCenterY = UOGetRadarPosToWorld(offsetX,offsetY,useScale)
		if (area == 0) then
			if (newCenterX >=MapCommon.sextantMaximumX- 50) then
				newCenterX=MapCommon.sextantMaximumX - 50
			end
			
			if (newCenterX <= 0) then
				newCenterX=50
			end
			
			if (newCenterY >=MapCommon.sextantMaximumY- 50) then
				newCenterY=MapCommon.sextantMaximumY- 50
			end
			
			if (newCenterY <= 0) then
				newCenterY=50
			end
		else
			if (newCenterX >=7670- 50) then
				newCenterX=7670 - 50
			end
			
			if (newCenterX <= 0) then
				newCenterX=MapCommon.sextantMaximumX
			end
			
			if (newCenterY >=MapCommon.sextantMaximumY- 50) then
				newCenterY=MapCommon.sextantMaximumY- 50
			end
			
			if (newCenterY <= 0) then
				newCenterY=50
			end
		end
		UOCenterRadarOnLocation(newCenterX, newCenterY, facet, area, false)
	    MapCommon.ForcedUpdate = true
		MapWindow.UpdateWaypoints()
    end
end

function MapWindow.ToggleFacetUpOnLButtonUp()
	local facet = RadarApi.getFacet() + 1

	if (facet >= NUM_FACETS) then
		facet = 0
	end

	RadarApi.setCenterOnPlayer(false)
	MapWindow.adapter.views[VIEWS.BUTTON_CENTER_ON_PLAYER]:setChecked(false)
	MapCommon.ChangeMap(facet, 0)
end

function MapWindow.ToggleFacetDownOnLButtonUp()
	local facet = RadarApi.getFacet() - 1
	
	if (facet < 0) then
		facet = NUM_FACETS - 1
	end

	RadarApi.setCenterOnPlayer(false)
	MapWindow.adapter.views[VIEWS.BUTTON_CENTER_ON_PLAYER]:setChecked(false)
	MapCommon.ChangeMap(facet, 0)
end

function MapWindow.ToggleAreaUpOnLButtonUp()
	local facet = RadarApi.getFacet()
	local area = RadarApi.getArea() + 1
	
	if (area >= RadarApi.getAreaCount(facet)) then
		area = 0
	end

	RadarApi.setCenterOnPlayer(false)
	MapWindow.adapter.views[VIEWS.BUTTON_CENTER_ON_PLAYER]:setChecked(false)
	MapCommon.ChangeMap(facet, area)
end

function MapWindow.ToggleAreaDownOnLButtonUp()
	local facet = RadarApi.getFacet()
	local area = RadarApi.getArea() - 1
	
	if (area < 0) then
		area = RadarApi.getAreaCount(facet) - 1
	end

	RadarApi.setCenterOnPlayer(false)
	MapWindow.adapter.views[VIEWS.BUTTON_CENTER_ON_PLAYER]:setChecked(false)
	MapCommon.ChangeMap(facet, area)
end

function MapWindow.CenterOnPlayerOnLButtonUp()
	MapWindow.CenterOnPlayer = ButtonGetPressedFlag( "MapWindowCenterOnPlayerButton" )
	UORadarSetCenterOnPlayer(MapWindow.CenterOnPlayer)
	for waypointId, value in pairs(MapCommon.WaypointsIconFacet) do
		local windowName = "Waypoint"..waypointId..MapCommon.ActiveView
		if (value ~= facet) then
			if (DoesWindowNameExist(windowName)) then
				MapCommon.WaypointViewInfo[MapCommon.ActiveView].Windows[waypointId] = nil
				DestroyWindow(windowName)
			end
		end
	end
	MapCommon.ForcedUpdate = true
	MapWindow.UpdateWaypoints()
end

function MapWindow.MapOnLButtonDown()
    MapWindow.adapter.views[VIEWS.BUTTON_CENTER_ON_PLAYER]:setChecked(false)
	RadarApi.setCenterOnPlayer(false)
end

function MapWindow.OnMouseOver()
	MapWindow.IsMouseOver = true
end

function MapWindow.OnMouseOverEnd()
    MapWindow.IsMouseOver = false
end

function MapWindow.SelectArea()
	local facet = UOGetRadarFacet()
    local area = ( ComboBoxGetSelectedMenuItem( "MapWindowAreaCombo" ) - 1 )
    
    if( area ~= UOGetRadarArea() ) then
		MapWindow.CenterOnPlayer = false
        ButtonSetPressedFlag( "MapWindowCenterOnPlayerButton", MapWindow.CenterOnPlayer )
        UORadarSetCenterOnPlayer(MapWindow.CenterOnPlayer)
        MapCommon.ChangeMap(facet, area )
    end
end

function MapWindow.SelectFacet()
    local facet = ( ComboBoxGetSelectedMenuItem( "MapWindowFacetCombo" ) - 1 )

	if( facet ~= UOGetRadarFacet() ) then
		MapWindow.CenterOnPlayer = false
        ButtonSetPressedFlag( "MapWindowCenterOnPlayerButton", MapWindow.CenterOnPlayer )
        UORadarSetCenterOnPlayer(MapWindow.CenterOnPlayer)
        MapCommon.ChangeMap(facet, 0 )
    end
end

function MapWindow.OnUpdate(_)
	if( DoesWindowNameExist("MapWindow") == true and WindowGetShowing("MapWindow") == true and MapWindow.IsMouseOver == true) then
		local windowX, windowY = WindowGetScreenPosition("MapImage")
		local mouseX = SystemData.MousePosition.x - windowX
		local mouseY = SystemData.MousePosition.y - windowY
	    local useScale = false
		local scale = WindowGetScale("MapWindow")
		local x, y = UOGetRadarPosToWorld(mouseX/scale, mouseY/scale, useScale)

		local facet = UOGetRadarFacet()
		local area = UOGetRadarArea()	    
	    local x1, y1, x2, y2 = UORadarGetAreaDimensions(facet, area)
		if (x1 < x and y1 < y and x2 > x and y2 > y) then
			local latStr, longStr, latDir, longDir = MapCommon.GetSextantLocationStrings(x, y, facet)
			local Sextant = latStr..L"'"..latDir..L" "..longStr..L"'"..longDir .. L"\n" .. x .. L", " .. y
			
	
			LabelSetText("MapWindowCoordsText", Sextant)
		else
			LabelSetText("MapWindowCoordsText", L"")
		end
	end
end

function MapWindow.CloseMap()
	WindowSetShowing("MapWindow", false)
	MapCommon.ActiveView = nil
end

function MapWindow.OnResizeBegin()
	local windowName = WindowUtils.GetActiveDialog()
	local widthMin = 400
	local heightMin = 400
    WindowUtils.BeginResize( windowName, "topleft", widthMin, heightMin, false, MapWindow.OnResizeEnd)
end

function MapWindow.OnResizeEnd(_)
	local windowWidth, windowHeight = WindowGetDimensions("MapWindow")
	--Debug.Print("MapWindow.OnResizeEnd("..curWindow..") width = "..windowWidth.." height = "..windowHeight)
	
	if(windowWidth > MapWindow.WINDOW_WIDTH_MAX) then
		windowWidth = MapWindow.WINDOW_WIDTH_MAX
	end
	
	if(windowHeight > MapWindow.WINDOW_HEIGHT_MAX) then
		windowHeight = MapWindow.WINDOW_HEIGHT_MAX
	end
	
	local legendScale = windowHeight / MapWindow.WINDOW_HEIGHT_MAX
	if (DoesWindowNameExist("LegendWindow")) then
		WindowSetScale("LegendWindow", legendScale * InterfaceCore.scale)
	end
	
	WindowSetDimensions("MapWindow", windowWidth, windowHeight)
	Interface.SaveNumber( "MapWindowBigW" , windowWidth)
	Interface.SaveNumber( "MapWindowBigH" , windowHeight )
	
	WindowSetDimensions("Map", windowWidth - MapWindow.MAP_WIDTH_DIFFERENCE, windowHeight - MapWindow.MAP_HEIGHT_DIFFERENCE)
	local _, topHeight = WindowGetDimensions("MapWindow".."Top")
	WindowSetDimensions("MapWindow".."Top",windowWidth+10,topHeight)
	local _, bottomHeight = WindowGetDimensions("MapWindow".."Bottom")
	WindowSetDimensions("MapWindow".."Bottom",windowWidth ,bottomHeight)
	MapCommon.ForcedUpdate = true
	MapWindow.UpdateWaypoints()
end