UusCorpMiniMapWindow = {}
UusCorpMiniMapWindow.Name = "UusCorpMiniMapWindow"
UusCorpMiniMapWindow.Map = UusCorpMiniMapWindow.Name .. "Map"
UusCorpMiniMapWindow.ScaleVariable = UusCorpMiniMapWindow.Name .. "Scale"

function UusCorpMiniMapWindow.mod()
	UusCorpCore.loadResources(
        "/src/mods/minimap",
        "UusCorpMiniMapWindow.xml"
    )

	function Actions.ToggleMapWindow()
		if WindowApi.destroyWindow(UusCorpMiniMapWindow.Name) and not WindowApi.isShowing("MapWindow") then
			MapWindow.ActivateMap()
		elseif WindowApi.isShowing("MapWindow") then
			MapWindow.CloseMap()
		else
			WindowApi.createWindow(UusCorpMiniMapWindow.Name, true)
		end
	end
end

function UusCorpMiniMapWindow.Initialize()
	local scale = UserInterfaceVariables.LoadNumber(UusCorpMiniMapWindow.ScaleVariable, 1.0)
	WindowUtilsWrapper.restoreWindowPosition(Active.window())
	WindowApi.setScale(Active.window(), scale)
	WindowDataApi.registerData(Radar.type(), 0)
	WindowApi.registerEventHandler(Active.window(), Radar.event(), "UusCorpMiniMapWindow.UpdateRadar")
	UusCorpMiniMapWindow.ActivateRadar()
end

function UusCorpMiniMapWindow.Shutdown()
	WindowUtils.SaveWindowPosition(Active.window())
	WindowDataApi.unregisterData(Radar.type(), 0)
	WindowApi.unregisterEventHandler(Active.window(), Radar.event())
end

function UusCorpMiniMapWindow.onRightClick()
	WindowApi.destroyWindow(Active.window())
end

function UusCorpMiniMapWindow.UpdateRadar()
	local dimen = WindowApi.getDimensions(UusCorpMiniMapWindow.Map)
	local xOffset = dimen / 2
	local yOffset = dimen / 2
	CircleImageApi.setTexture(
		UusCorpMiniMapWindow.Map,
		"radar_texture",
		Radar.textureXCord() + xOffset,
		Radar.textureYCord() + yOffset
	)
	CircleImageApi.setTextureScale(UusCorpMiniMapWindow.Map, Radar.textureScale())
	CircleImageApi.setRotation(UusCorpMiniMapWindow.Map, 45)
end

function UusCorpMiniMapWindow.ActivateRadar()
	local dimen = WindowApi.getDimensions(UusCorpMiniMapWindow.Map)
	RadarApi.setWindowSize(dimen, dimen, true, true)
	RadarApi.setRotation(45)
	RadarApi.setOffset(0, 0)
	MapCommonWrapper.adjustZoom(0)
	UusCorpMiniMapWindow.UpdateRadar()
end

function UusCorpMiniMapWindow.RadarOnMouseWheel(_, _, delta)
    MapCommon.AdjustZoom(-delta)
end

function UusCorpMiniMapWindow.RadarOnLButtonDblClk()
	local scale = WindowApi.getScale(Active.window())

	if scale == 1 then
		scale = 1.25
	else
		scale = 1
	end

	WindowApi.setScale(Active.window(), scale)
	UserInterfaceVariables.SaveNumber(UusCorpMiniMapWindow.ScaleVariable, scale)
	UusCorpMiniMapWindow.UpdateRadar()
end