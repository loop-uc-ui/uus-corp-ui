MapWindow = ListWindow:new("MapWindow")

MapWindow.ComboBCK = false

MapWindow.ZoomScale = 0.1
MapWindow.IsMouseOver = false
MapWindow.TypeEnabled = {}
MapWindow.CenterOnPlayer = true

local WIDTH_SETTING = "MapWindowBigW"
local HEIGHT_SETTING = "MapWindowBigH"
local MAP_WIDTH_DIFFERENCE = 26
local MAP_HEIGHT_DIFFERENCE = 111

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

local function changeMap(facet, area)
	local x1, y1, x2, y2 = RadarApi.getAreaDimensions(facet, area)
	if not x2 then
		return
	end
	local centerX = ( ( x2 - x1 ) / 2 ) + x1
	local centerY = ( ( y2 - y1 ) / 2 ) + y1
	MapWindow.adapter.views[MapWindow.VIEWS.IMAGE_MAP].forceUpdate = true
	RadarApi.centerOnLocation(centerX, centerY, facet, area, false)
end

function MapWindow.Initialize()
	WindowUtils.RestoreWindowPosition(MapWindow.id, true)
	MapWindow:setDimensions(
			UserInterfaceVariables.LoadNumber(WIDTH_SETTING, 400),
			UserInterfaceVariables.LoadNumber(HEIGHT_SETTING, 400)
	)
	MapWindow.OnResizeEnd()

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
	MapWindow.adapter.views[MapWindow.VIEWS.IMAGE_COMPASS]:setRotation(45)

	local map = MapImage:new(MapWindow.VIEWS.IMAGE_MAP, MapSettings.MODES.ATLAS)
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

function MapWindow.UpdateMap(facet, area)
	local map = MapWindow.adapter.views[MapWindow.VIEWS.IMAGE_MAP]
	facet = facet or RadarApi.getFacet()
	area = area or RadarApi.getArea()
	map:update(facet, area)

	local areaCombo = MapWindow.adapter.views[MapWindow.VIEWS.AREA_COMBO]
	areaCombo:clearItems()
	areaCombo:setItems(updateAreaCombo(map.facet))
	areaCombo:setSelectedItem(map.area + 1)

	local facetCombo = MapWindow.adapter.views[MapWindow.VIEWS.FACET_COMBO]
	facetCombo:setSelectedItem(map.facet + 1)

	local latStr, longStr, latDir, longDir = MapCommon.GetSextantLocationStrings(
		PlayerLocation.xCord(),
		PlayerLocation.yCord(),
		map.facet
	)
	local sextant = latStr..L"'"..latDir..L" "..longStr..L"'"..longDir ..
			L"\n" .. PlayerLocation.xCord() .. L", " .. PlayerLocation.yCord()

	MapWindow.adapter.views[MapWindow.VIEWS.LABEL_PLAYER_CORDS]:setText(sextant)
end

function MapWindow.MapOnMouseWheel(_, _, delta)
	local area = MapWindow.adapter.views[MapWindow.VIEWS.AREA_COMBO]:getSelectedItem() - 1
	local facet = MapWindow.adapter.views[MapWindow.VIEWS.FACET_COMBO]:getSelectedItem() - 1
	MapWindow.adapter.views[MapWindow.VIEWS.IMAGE_MAP]:onMouseWheel(delta, facet, area)
end

function MapWindow.MapMouseDrag(_, deltaX, deltaY)
	local facet = RadarApi.getFacet()
	local area = RadarApi.getArea()
	local mapCenterX, mapCenterY = RadarApi.getCenter()
	mapCenterX, mapCenterY = RadarApi.worldPosToRadar(mapCenterX, mapCenterY)
	mapCenterX = mapCenterX - deltaX
	mapCenterY = mapCenterY - deltaY
	mapCenterX, mapCenterY = RadarApi.radarPosToWorld(mapCenterX, mapCenterY, false)
	RadarApi.centerOnLocation(mapCenterX, mapCenterY, facet, area, false)
end

function MapWindow.ToggleFacetUpOnLButtonUp()
	local map = MapWindow.adapter.views[MapWindow.VIEWS.IMAGE_MAP]
	local facet = map.facet + 1

	if (facet >= NUM_FACETS) then
		facet = 0
	end

	MapWindow.adapter.views[MapWindow.VIEWS.BUTTON_CENTER_ON_PLAYER]:setChecked(false)
	map:setCenterOnPlayer(false)
	changeMap(facet, 0)
end

function MapWindow.ToggleFacetDownOnLButtonUp()
	local map = MapWindow.adapter.views[MapWindow.VIEWS.IMAGE_MAP]
	local facet = map.facet - 1

	if (facet < 0) then
		facet = NUM_FACETS - 1
	end

	MapWindow.adapter.views[MapWindow.VIEWS.BUTTON_CENTER_ON_PLAYER]:setChecked(false)
	map:setCenterOnPlayer(false)
	changeMap(facet, 0)
end

function MapWindow.ToggleAreaUpOnLButtonUp()
	local map = MapWindow.adapter.views[MapWindow.VIEWS.IMAGE_MAP]
	local facet = map.facet
	local area = map.area + 1

	if (area >= RadarApi.getAreaCount(facet)) then
		area = 0
	end

	MapWindow.adapter.views[MapWindow.VIEWS.BUTTON_CENTER_ON_PLAYER]:setChecked(false)
	map:setCenterOnPlayer(false)
	changeMap(facet, area)
end

function MapWindow.ToggleAreaDownOnLButtonUp()
	local map = MapWindow.adapter.views[MapWindow.VIEWS.IMAGE_MAP]
	local facet = map.facet
	local area = map.area - 1

	if (area < 0) then
		area = RadarApi.getAreaCount(facet) - 1
	end

	MapWindow.adapter.views[MapWindow.VIEWS.BUTTON_CENTER_ON_PLAYER]:setChecked(false)
	map:setCenterOnPlayer(false)
	changeMap(facet, area)
end

function MapWindow.CenterOnPlayerOnLButtonUp()
	local isChecked = MapWindow.adapter.views[MapWindow.VIEWS.BUTTON_CENTER_ON_PLAYER]:isChecked()
	MapWindow.adapter.views[MapWindow.VIEWS.IMAGE_MAP]:setCenterOnPlayer(isChecked)
end

function MapWindow.MapOnLButtonDown()
    MapWindow.adapter.views[MapWindow.VIEWS.BUTTON_CENTER_ON_PLAYER]:setChecked(false)
	MapWindow.adapter.views[MapWindow.VIEWS.IMAGE_MAP]:setCenterOnPlayer(false)
end

function MapWindow.OnMouseOver()
	MapWindow.IsMouseOver = true
end

function MapWindow.OnMouseOverEnd()
    MapWindow.IsMouseOver = false
end

function MapWindow.SelectArea()
	local map = MapWindow.adapter.views[MapWindow.VIEWS.IMAGE_MAP]
	local facet = map.facet
    local currentArea = map.area
	local area = MapWindow.adapter.views[MapWindow.VIEWS.AREA_COMBO]:getSelectedItem() - 1

	if area ~= currentArea then
		map:setCenterOnPlayer(false)
		MapWindow.adapter.views[MapWindow.VIEWS.BUTTON_CENTER_ON_PLAYER]:setChecked(false)
		changeMap(facet, area)
	end
end

function MapWindow.SelectFacet()
	local map = MapWindow.adapter.views[MapWindow.VIEWS.IMAGE_MAP]
	local currentFacet = map.facet
    local facet = MapWindow.adapter.views[MapWindow.VIEWS.FACET_COMBO]:getSelectedItem() - 1

	if facet ~= currentFacet then
		map:setCenterOnPlayer(false)
		MapWindow.adapter.views[MapWindow.VIEWS.BUTTON_CENTER_ON_PLAYER]:setChecked(false)
        changeMap(facet, 0)
    end
end

function MapWindow.OnUpdate(_)
	if MapWindow.IsMouseOver == true then
		local map = MapWindow.adapter.views[MapWindow.VIEWS.IMAGE_MAP]
		local windowX, windowY = WindowApi.getPosition(map.id)
		local mouseX = MousePosition.x() - windowX
		local mouseY = MousePosition.y() - windowY
		local scale = MapWindow:getScale()
		local x, y = RadarApi.radarPosToWorld(mouseX / scale, mouseY / scale, false)

		local latStr, longStr, latDir, longDir = MapCommon.GetSextantLocationStrings(x, y, map.facet)
		local sextant = latStr..L"'"..latDir..L" "..longStr..L"'"..longDir .. L"\n" .. x .. L", " .. y
		MapWindow.adapter.views[MapWindow.VIEWS.LABEL_MAP_CORDS]:setText(sextant)
	else
		MapWindow.adapter.views[MapWindow.VIEWS.LABEL_MAP_CORDS]:setText("")
	end
end

function MapWindow.OnResizeBegin()
    WindowUtils.BeginResize(MapWindow.id, "topleft", 400, 400, true, MapWindow.OnResizeEnd)
end

function MapWindow.OnResizeEnd(_)
	local windowWidth, windowHeight = MapWindow:getDimensions()
	WindowApi.setDimensions("MapWindowMapImageMask", windowWidth - MAP_WIDTH_DIFFERENCE, windowHeight - MAP_HEIGHT_DIFFERENCE)
	local _, topHeight = WindowApi.getDimensions("MapWindowTop")
	WindowApi.setDimensions("MapWindowTop", windowWidth + 10, topHeight)
	local _, bottomHeight = WindowApi.getDimensions("MapWindowBottom")
	WindowApi.setDimensions("MapWindowBottom",windowWidth ,bottomHeight)
end

function MapWindow.Shutdown()
	local width, height = MapWindow:getDimensions()
	UserInterfaceVariables.SaveNumber(WIDTH_SETTING, width)
	UserInterfaceVariables.SaveNumber(HEIGHT_SETTING, height)
end