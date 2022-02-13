WaypointWindow = BaseWindow:new()

function WaypointWindow:new(waypointId, parent, pointX, pointY)
    local this = {
        id = "WaypointIcon"..waypointId,
        waypointId = waypointId,
        iconId = WaypointDisplay.getTypeIconId(MapSettings.getMapMode(), waypointId),
        parent = parent,
        pointX = pointX,
        pointY = pointY
    }
    self.__index = self
    local table = setmetatable(this, self)

    WindowApi.createFromTemplate(
            this.id,
            "WaypointIcon",
            this.parent
    )
    table:clearAnchors()
    local locX, locY = RadarApi.worldPosToRadar(this.pointX, this.pointY)
    table:addAnchor("topleft", this.parent, "center", locX, locY)

    local iconTexture, x, y = IconApi.getIconData(this.iconId)
    local iconWidth, iconHeight = UOGetTextureSize("icon"..this.iconId)

    if iconTexture ~= nil and iconWidth ~=nil and iconHeight ~=nil then
        table:setDimensions(iconWidth / 2, iconHeight / 2)
        DynamicImageApi.setTexture(
                this.id,
                iconTexture,
                iconWidth,
                iconHeight
        )
        DynamicImageApi.setTextureDimensions(
                this.id,
                iconTexture,
                x,
                y
        )
    end

    return table
end