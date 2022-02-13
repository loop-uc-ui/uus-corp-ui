WaypointWindow = BaseWindow:new()

function WaypointWindow:new(waypointId, parent, x, y)
    local this = {
        id = "WaypointIcon"..waypointId,
        waypointId = waypointId,
        parent = parent,
        x = x,
        y = y
    }
    self.__index = self
    local table = setmetatable(this, self)

    WindowApi.createFromTemplate(
            this.id,
            "WaypointIcon",
            this.parent
    )
    table:clearAnchors()
    local locX, locY = RadarApi.worldPosToRadar(this.x, this.y)
    table:addAnchor("topleft", this.parent, "center", locX, locY)
    MapCommon.UpdateWaypointIcon(WaypointDisplay.getIconId(MapSettings.getMapMode(), 14),this.id,MapSettings.getMapMode())
    return table
end