
----------------------------------------------------------------
-- Global Variables
----------------------------------------------------------------

MapFind = {}
MapFind.Items = {}
MapFind.TotalItems = 0
MapFind.InSearch = false

function MapFind.Initialize()
	local windowName = "MapFindWindow"
	SnapUtils.SnappableWindows[windowName] = true
	WindowUtils.RestoreWindowPosition("MapFindWindow")
	LabelSetText(windowName .. "InfoText", GetStringFromTid(1154869))	
end

function MapFind.Shutdown()
	WindowUtils.SaveWindowPosition("MapFindWindow")
	SnapUtils.SnappableWindows["MapFindWindow"] = nil
	MapFind.Close()
end

function MapFind.Close()
	MapFind.Reset()
	WindowSetShowing("MapFindWindow", false)
end

function MapFind.Toggle()
	if(WindowGetShowing("MapFindWindow")) then
		MapFind.Close()
	else
		WindowSetShowing("MapFindWindow", true)
		MapFind.Restart()
	end
end

function MapFind.ClearItemList()
	for i = MapFind.TotalItems, 1, -1  do
		local dialog = "MapFindSW"
		local parent = dialog.. "ScrollChild"
		local slotName = parent.."Item"..i
		if DoesWindowNameExist(slotName) then
			DestroyWindow(slotName)
		end
	end
end

function MapFind.Reset()	
	MapFind.ClearItemList()
	MapFind.Items = {}
	MapFind.TotalItems = 0
	MapFind.InSearch = false
	TextEditBoxSetText("MapFindWindowSearchBox", L"")
	LabelSetText("MapFindWindowTotal", L"" )
	ScrollWindowUpdateScrollRect( "MapFindSW" )   	
	local listOffset = ScrollWindowGetOffset("MapFindSW")
	local maxOffset = VerticalScrollbarGetMaxScrollPosition("MapFindSWScrollbar")
	if( listOffset > maxOffset ) then
		listOffset = maxOffset
	end	
	ScrollWindowSetOffset("MapFindSW",listOffset)	
end

function MapFind.OnLButtonUpSearch()
	MapFind.SearchText(nil, TextEditBoxGetText("MapFindWindowSearchBox"))
end

function MapFind.SearchTooltip()
	Tooltips.CreateTextOnlyTooltip(SystemData.ActiveWindow.name,  GetStringFromTid(1154641))	
	Tooltips.Finalize()
	Tooltips.AnchorTooltip( Tooltips.ANCHOR_WINDOW_TOP )
end

function MapFind.OnLButtonUpSearch()
	MapFind.SearchText(nil, TextEditBoxGetText("MapFindWindowSearchBox"))
end

function MapFind.RemoveFiltersTooltip()
	Tooltips.CreateTextOnlyTooltip(SystemData.ActiveWindow.name,  GetStringFromTid(1154792))
	Tooltips.Finalize()
	Tooltips.AnchorTooltip( Tooltips.ANCHOR_WINDOW_TOP )
end

function MapFind.MagnifyTooltip()
	Tooltips.CreateTextOnlyTooltip(SystemData.ActiveWindow.name,  GetStringFromTid(1154869))	
	Tooltips.Finalize()
	Tooltips.AnchorTooltip( Tooltips.ANCHOR_WINDOW_TOP )
end

function MapFind.SearchText(null, text)
	
	if (not text or text == L"" or text == "") then
		return
	end
	MapFind.Reset()	
	text = wstring.lower(text)
	local wtext = text
	text = tostring(text)
	MapFind.InSearch = true
	MapFind.ClearItemList()
	
	local tabelIdx = 1
	local dialog = "MapFindSW"
	local parent = dialog.. "ScrollChild"
	for map, array in pairs(Waypoints.Facet) do

		for i = 1, #array do
			if string.find(string.lower(array[i].Name), text) then
				array[i].Map = map
				table.insert(MapFind.Items, array[i])
			end
		end
	end
	for waypointId = 1,WindowData.WaypointList.waypointCount do	
		local wtype, wflags, wname, wfacet, wx, wy, wz = UOGetWaypointInfo(waypointId) 
		if wtype == 15 then
			local data = MapCommon.GetWPDataFromString(wname, wtype, wfacet, facet, area)
			if not data then
				continue
			end
			local wp = {x=wx, y=wy, z=wz, type=data.type, Name=data.name, Icon=data.icon, Scale=tonumber(data.scale), Map= data.facet};
			if wstring.find(wstring.lower(wp.Name), wtext) then
				table.insert(MapFind.Items, wp)
			end
		end
	end	
	for i = 1, table.getn(MapFind.Items) do
		local slotName = parent.."Item"..i
		local elementIcon = parent.."Item"..i.."Icon"
		local elementName = parent.."Item"..i.."Name"
		CreateWindowFromTemplate(slotName, "ItemTemplateMF", parent)
		
		if i == 1 then
			WindowAddAnchor(slotName, "topleft", parent, "topleft", 0, 5)
			WindowAddAnchor(slotName, "topright", dialog, "topright", -ContainerWindow.List.LabelPaddingRight, 0)
		else
			WindowAddAnchor(slotName, "bottomleft", parent.."Item"..i-1, "topleft", 0, 0)
			WindowAddAnchor(slotName, "bottomright", dialog, "topright", -ContainerWindow.List.LabelPaddingRight, 0)
		end

		if (tonumber(MapFind.Items[i].Icon) == nil) then
			local iconWidth, iconHeight = UOGetTextureSize(MapFind.Items[i].Icon)
			DynamicImageSetTexture(elementIcon, MapFind.Items[i].Icon, 0, 0)
			DynamicImageSetTextureDimensions(elementIcon, iconWidth * MapFind.Items[i].Scale, iconHeight * MapFind.Items[i].Scale)
			DynamicImageSetTextureScale(elementIcon, MapFind.Items[i].Scale)
		else
			local iconTexture, x, y = GetIconData(tonumber(MapFind.Items[i].Icon))
			local iconWidth, iconHeight = UOGetTextureSize("icon" .. tonumber(MapFind.Items[i].Icon))
			DynamicImageSetTextureDimensions(elementIcon, iconWidth * MapFind.Items[i].Scale, iconHeight * MapFind.Items[i].Scale)
			DynamicImageSetTexture(elementIcon, iconTexture, x, y)
			DynamicImageSetTextureScale(elementIcon, MapFind.Items[i].Scale)
		end
		
		WindowSetId(slotName,i)
		WindowSetId(elementIcon, i)
		local mapName = "[Felucca]"
		if (MapFind.Items[i].Map == 1) then
			mapName = "[Trammel]"
		elseif (MapFind.Items[i].Map == 2) then
			mapName = "[Ilshenar]"
		elseif (MapFind.Items[i].Map == 3) then
			mapName = "[Malas]"
		elseif (MapFind.Items[i].Map == 4) then
			mapName = "[Tokuno]"
		elseif (MapFind.Items[i].Map == 5) then
			mapName = "[Ter Mur]"
		end
		LabelSetText(elementName, towstring(mapName .. " " .. tostring(MapFind.Items[i].Name)))
		tabelIdx = tabelIdx + 1
	end	
	
	MapFind.TotalItems = tabelIdx - 1
	LabelSetText("MapFindWindowTotal", ReplaceTokens(GetStringFromTid(1154870), {towstring(tabelIdx - 1 )}))
	ScrollWindowUpdateScrollRect( "MapFindSW" )   	
	local listOffset = ScrollWindowGetOffset("MapFindSW")
	local maxOffset = VerticalScrollbarGetMaxScrollPosition("MapFindSWScrollbar")
	if( listOffset > maxOffset ) then
	    listOffset = maxOffset
	end	
	ScrollWindowSetOffset("MapFindSW",listOffset)
end


function MapFind.Restart()
	MapFind.Reset()	
	ScrollWindowUpdateScrollRect( "MapFindSW" )   	
	local listOffset = ScrollWindowGetOffset("MapFindSW")
	local maxOffset = VerticalScrollbarGetMaxScrollPosition("MapFindSWScrollbar")
	if( listOffset > maxOffset ) then
	    listOffset = maxOffset
	end	
	ScrollWindowSetOffset("MapFindSW",listOffset)
end

function MapFind.Locate()
	local i = WindowGetId(SystemData.ActiveWindow.name)
	local x = tonumber(MapFind.Items[i].x)
	local y = tonumber(MapFind.Items[i].y)
	for areaIndex = UORadarGetAreaCount(MapFind.Items[i].Map), 0, -1  do
		if( UORadarIsLocationInArea(x, y, MapFind.Items[i].Map, areaIndex) ) then
			UOCenterRadarOnLocation(x, y, MapFind.Items[i].Map, areaIndex, false)
			MapWindow.CenterOnPlayer = false
			ButtonSetPressedFlag( "MapWindowCenterOnPlayerButton", MapWindow.CenterOnPlayer )
			UORadarSetCenterOnPlayer(MapWindow.CenterOnPlayer)	
			return
		end	
	end	
end

function MapFind.ItemMouseOver()
	local i = WindowGetId(SystemData.ActiveWindow.name)
	local mapName = "Felucca"
	if (MapFind.Items[i].Map == 1) then
		mapName = "Trammel"
	elseif (MapFind.Items[i].Map == 2) then
		mapName = "Ilshenar"
	elseif (MapFind.Items[i].Map == 3) then
		mapName = "Malas"
	elseif (MapFind.Items[i].Map == 4) then
		mapName = "Tokuno"
	elseif (MapFind.Items[i].Map == 5) then
		mapName = "Ter Mur"
	end
	local descriptionStr = mapName .. " x: " .. MapFind.Items[i].x .. " y: " .. MapFind.Items[i].y .. " z: " .. MapFind.Items[i].z
	itemData = { windowName = this,
						itemId = i,
						itemType = WindowData.ItemProperties.TYPE_WSTRINGDATA,
						title =	towstring(MapFind.Items[i].Name),
						body = towstring(descriptionStr)}
						
	ItemProperties.SetActiveItem(itemData)	
end