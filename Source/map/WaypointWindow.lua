WaypointWindow = BaseWindow:new()

function WaypointWindow:new(name, iconId, parent, pointX, pointY)
    local this = {
        id = name,
        iconId = iconId,
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
    local iconWidth, iconHeight = IconApi.getTextureSize("icon"..this.iconId)

    if iconTexture ~= nil and iconWidth ~=nil and iconHeight ~=nil then
        table:setDimensions(iconWidth, iconHeight)
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