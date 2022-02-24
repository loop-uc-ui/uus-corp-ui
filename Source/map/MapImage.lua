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

function MapImage:new(id, mode, facet, area)
    local this = {
        id = id,
        texture = "radar_texture",
        centerOnPlayer = true,
        facet = facet,
        area = area
    }
    MapSettings.setMode(mode)
    self.__index = self
    return setmetatable(this, self)
end

function MapImage:setTexture(xCord, yCord)
    if MapSettings.isRadar() then
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
    if MapSettings.isRadar() then
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
    if MapSettings.isRadar() then
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

function MapImage:addWaypoint(id, name, iconId, x, y)
    local waypoint = WaypointWindow:new(
            id,
            name,
            iconId,
            self.id,
            x,
            y
    )
    self.adapter.views[waypoint.id] = waypoint
    return waypoint
end

function MapImage:update(facet, area)
    if facet == nil or area == nil then
        return
    end

    self:setRotation(45)
    self:setTextureScale(Radar.textureScale())

    local width, height = WindowApi.getDimensions(self.id)

    if MapSettings.isRadar() then
        width = width / 2
        height = height / 2
    else
        width = 0
        height = 0
    end

    local drawWaypoints = area ~= self.area or facet ~= self.facet or #self.adapter.views == 0
    self.area = area
    self.facet = facet

    if drawWaypoints then
        self:clearWaypoints()
    end

    self:setTexture(Radar.textureXCord() + width, Radar.textureYCord() + height)

    if drawWaypoints and not WindowApi.doesExist("WaypointIconPlayer") and area == RadarApi.getArea() and facet == RadarApi.getFacet() then
        self:addWaypoint(
                "WaypointIconPlayer",
                nil,
                WaypointDisplay.getTypeIconId(MapSettings.getMapMode(), WaypointDisplay.TYPE_PLAYER),
                PlayerLocation.xCord(),
                PlayerLocation.yCord()
        )
    end

    if drawWaypoints then
        for i = 0, #Waypoints.Facet - 1 do
            if i == facet then
                for _, value in pairs(Waypoints.Facet[i]) do
                    local id = "Waypoint"..value.Name.."_"..RadarApi.getFacetLabel(i).."_"..RadarApi.getAreaLabel(i, area).."_"..value.Icon
                    if not WindowApi.doesExist(id) then
                        self:addWaypoint(
                                id,
                                value.Name,
                                tonumber(value.Icon),
                                tonumber(value.x),
                                tonumber(value.y)
                        )
                    end
                end
                break
            end
        end
    end

    for key, value in pairs(self.adapter.views) do
        if key == "WaypointIconPlayer" then
            value:update(
                    PlayerLocation.xCord(),
                    PlayerLocation.yCord()
            )
        else
            value:update()
        end
    end
end

function MapImage:clearWaypoints()
    for key, value in pairs(self.adapter.views) do
        if string.find(key, "Waypoint") and WindowApi.doesExist(key) then
            value:destroy()
            self.adapter.views[key] = nil
        end
    end
end

function MapImage:onMouseWheel(delta, facet, area)
    local zoom = MapSettings.getZoom() - (delta * 0.2)
    local maxZoom = RadarApi.getMaxZoom(facet or self.facet, area or self.area)

    if zoom < -2 then
        zoom = -2
    elseif zoom > maxZoom then
        zoom = maxZoom
    end

    RadarApi.setZoom(zoom)
    MapSettings.setZoom(zoom)
end

function MapImage:getFormattedLocation(x, y, facet)
    --Old function
    local minutesX, minutesY = convertToMinutes(x, y, facet or self.facet)
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

function MapImage:setCenterOnPlayer(isCenter)
    self.centerOnPlayer = isCenter
    RadarApi.setCenterOnPlayer(isCenter)
end
