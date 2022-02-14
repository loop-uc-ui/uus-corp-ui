RadarWindow = ListWindow:new("RadarWindow", false)

RadarWindow.Rotation = 45
RadarWindow.Tilt = false
RadarWindow.Size = 0
RadarWindow.Scale = 1.0

RadarWindow.Locked = false

local MAP_IMAGE = "RadarWindowMap"
local COORD_LABEL = "radarSextant"

function RadarWindow.Initialize()
	WindowUtils.RestoreWindowPosition(RadarWindow.id)
	RadarWindow.Scale = WindowGetScale("RadarWindow")
	RadarWindow.adapter:addLock():addLabel(COORD_LABEL)

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

	local map = MapImage:new(MAP_IMAGE)
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
	local map = RadarWindow.adapter.views[MAP_IMAGE]
	map:update()

	local latStr, longStr, latDir, longDir = map:getFormattedLocation(
			PlayerLocation.xCord(),
			PlayerLocation.yCord()
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

function RadarWindow.ZoomInOnMouseOver()
	Tooltips.CreateTextOnlyTooltip(SystemData.ActiveWindow.name, GetStringFromTid(MapCommon.TID.ZoomIn))
	Tooltips.Finalize()
	Tooltips.AnchorTooltip( Tooltips.ANCHOR_WINDOW_BOTTOM )
end

function RadarWindow.RadarOnMouseWheel(x, y, delta)
	RadarWindow.adapter.views[MAP_IMAGE]:onMouseWheel(x, y, delta)
end