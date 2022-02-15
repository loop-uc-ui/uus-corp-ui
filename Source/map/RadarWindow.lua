RadarWindow = ListWindow:new("RadarWindow", false)

RadarWindow.Rotation = 45
RadarWindow.Tilt = false
RadarWindow.Size = 0
RadarWindow.Scale = 1.0

RadarWindow.Locked = false

RadarWindow.MAP_IMAGE = "RadarWindowMap"
local COORD_LABEL = "radarSextant"
local FACET_INFO_LABEL = "RadarWindowFacetInfo"
local AREA_INFO_LABEL = "RadarWindowAreaInfo"

function RadarWindow.Initialize()
	WindowUtils.RestoreWindowPosition(RadarWindow.id)
	RadarWindow.Scale = WindowGetScale("RadarWindow")
	RadarWindow.adapter:addLock():addLabel(COORD_LABEL)
		:addLabel(FACET_INFO_LABEL)
		:addLabel(AREA_INFO_LABEL)

	RadarWindow:registerData(
			Radar.type()
	):registerData(
			WaypointDisplay.type()
	):registerData(
			PlayerLocation.type()
	):registerEventHandler(
			PlayerLocation.event(),
			"RadarWindow.UpdateRadar"
	):registerEventHandler(
			Radar.event(),
			"RadarWindow.UpdateRadar"
	)

	local map = MapImage:new(RadarWindow.MAP_IMAGE)
	RadarWindow.adapter.views[map.id] = map
	local width, height = map:getDimensions()
	RadarApi.setWindowSize(width, height, true, true)
end

function RadarWindow.Shutdown()
	WindowUtils.SaveWindowPosition("RadarWindow")
	
	UnregisterWindowData(WindowData.Radar.Type,0)
	 SnapUtils.SnappableWindows["RadarWindow"] = nil
end

function RadarWindow.OnMouseDrag()
	RadarWindow:onLeftClickDown()
	RadarWindow.UpdateRadar()
end

function RadarWindow.UpdateRadar()
	local map = RadarWindow.adapter.views[RadarWindow.MAP_IMAGE]
	map:update()

	local latStr, longStr, latDir, longDir = map:getFormattedLocation(
			PlayerLocation.xCord(),
			PlayerLocation.yCord()
	)

	RadarWindow.adapter.views[COORD_LABEL]:setText(
			latStr..L"'"..latDir..L" "..longStr..L"'"..longDir
	)

	RadarWindow.adapter.views[FACET_INFO_LABEL]:setText(
			RadarApi.getFacetLabel(RadarApi.getFacet())
	)

	RadarWindow.adapter.views[AREA_INFO_LABEL]:setText(
			RadarApi.getAreaLabel(RadarApi.getFacet(), RadarApi.getArea())
	)
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

function RadarWindow.RadarOnMouseWheel(x, y, delta)
	RadarWindow.adapter.views[RadarWindow.MAP_IMAGE]:onMouseWheel(x, y, delta)
end