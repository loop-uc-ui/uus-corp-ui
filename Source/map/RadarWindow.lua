RadarWindow = ListWindow:new("RadarWindow", false)

RadarWindow.MAP_IMAGE = "RadarWindowMap"

local COORD_LABEL = "radarSextant"

function RadarWindow.Initialize()
	WindowUtils.RestoreWindowPosition(RadarWindow.id)
	RadarWindow.adapter:addLock():addLabel(COORD_LABEL)

	RadarWindow:registerData(
			Radar.type()
	):registerEventHandler(
			Radar.event(),
			"RadarWindow.UpdateRadar"
	)

	local map = MapImage:new(
			RadarWindow.MAP_IMAGE,
			MapSettings.MODES.RADAR
	)
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
	map:update(RadarApi.getFacet(), RadarApi.getArea())

	local latStr, longStr, latDir, longDir = MapCommon.GetSextantLocationStrings(
			PlayerLocation.xCord(),
			PlayerLocation.yCord(),
			map.facet
	)

	RadarWindow.adapter.views[COORD_LABEL]:setText(
			latStr..L"'"..latDir..L" "..longStr..L"'"..longDir
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

function RadarWindow.RadarOnMouseWheel(_, _, delta)
	RadarWindow.adapter.views[RadarWindow.MAP_IMAGE]:onMouseWheel(delta)
end

function RadarWindow.Close()
	RadarWindow:destroy()
end