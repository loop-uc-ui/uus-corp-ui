MapImage = ListWindow:new()

local function getSextantCenter(x, y, facet)
    --Old, hardcoded logic
    if ((facet == 0 or facet == 1) and (x >= 5120) and (y >= 2304)) then
        --Lost lands apparently.
        return 6144, 3112
    else
        return 1323, 1624
    end
end

local function convertToMinutes(x, y, facet)
    --Another old, terrible function.
    local sectCenterX, sectCenterY = getSextantCenter(x,y,facet)
    local minutesX = 21600 * (x - sectCenterX) / 5120
    local minutesY = 21600 * (y - sectCenterY) / 4096

    if minutesX > 10800 then
        minutesX = minutesX - 21600
    end
    if minutesX <= -10800 then
        minutesX = minutesX + 21600
    end
    if minutesY > 10800 then
        minutesY = minutesY - 21600
    end
    if minutesY <= -10800 then
        minutesY = minutesY + 21600
    end

    return minutesX, minutesY
end

function MapImage:new(id, isCircular, facet, area, rotation)
    local this = {
        id = id,
        isCircular = isCircular or true,
        texture = "radar_texture",
        centerOnPlayer = true,
        facet = facet or RadarApi.getFacet(),
        area = area or RadarApi.getArea(),
        zoom = MapSettings.getZoom(),
        rotation = rotation or 45,
        adapter = WindowAdapter:new(id),
        drawPlayerWaypoint = true
    }

    if this.isCircular then
        MapSettings.setMode(MapSettings.MODES.RADAR)
    else
        MapSettings.setMode(MapSettings.MODES.ATLAS)
    end

    this.maxZoom = RadarApi.getMaxZoom(this.facet, this.area)

    self.__index = self
    return setmetatable(this, self)
end

function MapImage:setTexture(xCord, yCord)
    if self.isCircular then
        CircleImageApi.setTexture(
                self.id,
                self.texture,
                xCord,
                yCord
        )
    else
        DynamicImageApi.setTexture(
                self.id,
                self.texture,
                xCord,
                yCord
        )
    end
end

function MapImage:setTextureScale(scale)
    if self.isCircular then
        CircleImageApi.setTextureScale(
                self.id,
                scale
        )
    else
        DynamicImageApi.setTextureScale(
                self.id,
                scale
        )
    end
end

function MapImage:setRotation(rotation)
    if self.isCircular then
        CircleImageApi.setRotation(
                self.id,
                rotation
        )
    else
        DynamicImageApi.setRotation(
                self.id,
                rotation
        )
    end
    RadarApi.setRotation(rotation)
end

function MapImage:addWaypoint(name, iconId, x, y)
    local waypoint = WaypointWindow:new(
            name,
            iconId,
            self.id,
            x,
            y
    )
    self.adapter.views[waypoint.id] = waypoint
    return waypoint
end

local doAdd = true

function MapImage:update()
    self:setRotation(self.rotation)
    self:setTextureScale(Radar.textureScale())
    local width, height = WindowApi.getDimensions(self.id)
    self:setTexture(Radar.textureXCord() + width / 2, Radar.textureYCord() + height / 2)

    local area = RadarApi.getArea()
    self.area = area
    local facet = RadarApi.getFacet()
    self.facet = facet
    self.zoom = MapSettings.getZoom()
    self.maxZoom = RadarApi.getMaxZoom(facet, area)

    if self.drawPlayerWaypoint then
        self:addWaypoint(
                "WaypointIconPlayer",
                WaypointDisplay.getTypeIconId(MapSettings.getMapMode(), WaypointDisplay.TYPE_PLAYER),
                PlayerLocation.xCord(),
                PlayerLocation.yCord()
        )
        self.drawPlayerWaypoint = false
    end

    if not doAdd then
        return
    end

    for i = 0, #Waypoints.Facet - 1 do
        if i == self.facet then
            for _, value in pairs(Waypoints.Facet[i]) do
                self:addWaypoint(
                        value.Name.."_"..RadarApi.getFacetLabel(i).."_"..value.Icon,
                        tonumber(value.Icon),
                        tonumber(value.x),
                        tonumber(value.y)
                )
            end
            break
        end
    end
    doAdd = false
end

function MapImage:onMouseWheel(_, _, delta)
    local zoom = self.zoom - (delta * 0.2)

    if zoom < -2 then
        zoom = -2
    elseif zoom > self.maxZoom then
        zoom = self.maxZoom
    end

    RadarApi.setZoom(zoom)
    MapSettings.setZoom(zoom)
    self.zoom = zoom
end

function MapImage:getFormattedLocation(x, y)
    --Old function
    local minutesX, minutesY = convertToMinutes(x, y, self.facet)
    local latDir = L"S"
    local longDir = L"E"

    if minutesY < 0 then
        latDir = L"N"
        minutesY = -minutesY
    end
    if minutesX < 0 then
        longDir = L"W"
        minutesX = -minutesX
    end

    local latString = StringFormatter.toWString(string.format( "%d", (minutesY/60)))..L"."..StringFormatter.toWString(string.format( "%02d", (minutesY%60)))
    local longString = StringFormatter.toWString(string.format( "%d", (minutesX/60)))..L"."..StringFormatter.toWString(string.format( "%02d", (minutesX%60)))

    return latString, longString, latDir, longDir
end
