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

MapWindow.VIEWS = {
	AREA_COMBO = "MapWindowAreaCombo",
	FACET_COMBO = "MapWindowFacetCombo",
	LABEL_CENTER_ON_PLAYER = "MapWindowCenterOnPlayerLabel",
	LABEL_PLAYER_CORDS = "MapWindowPlayerCoordsText",
	LABEL_MAP_CORDS = "MapWindowCoordsText",
	BUTTON_CENTER_ON_PLAYER = "MapWindowCenterOnPlayerButton",
	IMAGE_COMPASS = "MapCompass",
	IMAGE_MAP = "MapWindowMapImage"
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

	local facets = {}

	for i = 0, NUM_FACETS - 1 do
		table.insert(facets, StringFormatter.fromTid(RadarApi.getFacetLabel(i)))
	end

	MapWindow.adapter:addComboBox(
			MapWindow.VIEWS.FACET_COMBO,
			facets,
			RadarApi.getFacet() + 1
	):addComboBox(
			MapWindow.VIEWS.AREA_COMBO,
			updateAreaCombo(),
			RadarApi.getArea() + 1
	):addLabel(
			MapWindow.VIEWS.LABEL_CENTER_ON_PLAYER,
			1112059
	):addCheckBox(
			MapWindow.VIEWS.BUTTON_CENTER_ON_PLAYER,
			true
	):addLabel(
			MapWindow.VIEWS.LABEL_MAP_CORDS
	):addLabel(
			MapWindow.VIEWS.LABEL_PLAYER_CORDS
	):addLock():addDynamicImage(
			MapWindow.VIEWS.IMAGE_COMPASS
	)

	MapWindow.adapter.views[MapWindow.VIEWS.BUTTON_CENTER_ON_PLAYER]:setChecked(true)

	local map = MapImage:new(MapWindow.VIEWS.IMAGE_MAP, false)
	local width, height = map:getDimensions()
	RadarApi.setWindowSize(width, height, true, true)
	MapWindow.adapter.views[MapWindow.VIEWS.IMAGE_MAP] = map

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

	MapWindow.UpdateMap()
end

function MapWindow.OnMouseDrag()
	MapWindow:onLeftClickDown()
end

function MapWindow.UpdateMap()
	MapWindow.adapter.views[MapWindow.VIEWS.IMAGE_MAP]:update()
end

function MapWindow.MapOnMouseWheel(x, y, delta)
	MapWindow.adapter.views[MapWindow.VIEWS.IMAGE_MAP]:onMouseWheel(x, y, delta)
end

function MapWindow.MapMouseDrag(_, deltaX, deltaY)
    if deltaX ~= 0 or deltaY ~= 0 then
		local facet = RadarApi.getFacet()
		local area = RadarApi.getArea()
		local mapCenterX, mapCenterY = RadarApi.getCenter()
		mapCenterX, mapCenterY = RadarApi.worldPosToRadar(mapCenterX, mapCenterY)
		mapCenterX = mapCenterX - deltaX
		mapCenterY = mapCenterY - deltaY
		mapCenterX, mapCenterY = RadarApi.radarPosToWorld(mapCenterX, mapCenterY, false)
		RadarApi.centerOnLocation(mapCenterX, mapCenterY, facet, area, false)
    end
end

function MapWindow.ToggleFacetUpOnLButtonUp()
	local facet = RadarApi.getFacet() + 1

	if (facet >= NUM_FACETS) then
		facet = 0
	end

	RadarApi.setCenterOnPlayer(false)
	MapWindow.adapter.views[MapWindow.VIEWS.BUTTON_CENTER_ON_PLAYER]:setChecked(false)
	MapCommon.ChangeMap(facet, 0)
end

function MapWindow.ToggleFacetDownOnLButtonUp()
	local facet = RadarApi.getFacet() - 1

	if (facet < 0) then
		facet = NUM_FACETS - 1
	end

	RadarApi.setCenterOnPlayer(false)
	MapWindow.adapter.views[MapWindow.VIEWS.BUTTON_CENTER_ON_PLAYER]:setChecked(false)
	MapCommon.ChangeMap(facet, 0)
end

function MapWindow.ToggleAreaUpOnLButtonUp()
	local facet = RadarApi.getFacet()
	local area = RadarApi.getArea() + 1

	if (area >= RadarApi.getAreaCount(facet)) then
		area = 0
	end

	RadarApi.setCenterOnPlayer(false)
	MapWindow.adapter.views[MapWindow.VIEWS.BUTTON_CENTER_ON_PLAYER]:setChecked(false)
	MapCommon.ChangeMap(facet, area)
end

function MapWindow.ToggleAreaDownOnLButtonUp()
	local facet = RadarApi.getFacet()
	local area = RadarApi.getArea() - 1

	if (area < 0) then
		area = RadarApi.getAreaCount(facet) - 1
	end

	RadarApi.setCenterOnPlayer(false)
	MapWindow.adapter.views[MapWindow.VIEWS.BUTTON_CENTER_ON_PLAYER]:setChecked(false)
	MapCommon.ChangeMap(facet, area)
end

function MapWindow.CenterOnPlayerOnLButtonUp()
	MapWindow.CenterOnPlayer = ButtonGetPressedFlag( "MapWindowCenterOnPlayerButton" )
	UORadarSetCenterOnPlayer(MapWindow.CenterOnPlayer)
end

function MapWindow.MapOnLButtonDown()
    MapWindow.adapter.views[MapWindow.VIEWS.BUTTON_CENTER_ON_PLAYER]:setChecked(false)
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

	WindowSetDimensions("MapWindowMapImageMask", windowWidth - MapWindow.MAP_WIDTH_DIFFERENCE, windowHeight - MapWindow.MAP_HEIGHT_DIFFERENCE)
	local _, topHeight = WindowGetDimensions("MapWindow".."Top")
	WindowSetDimensions("MapWindow".."Top",windowWidth+10,topHeight)
	local _, bottomHeight = WindowGetDimensions("MapWindow".."Bottom")
	WindowSetDimensions("MapWindow".."Bottom",windowWidth ,bottomHeight)
end