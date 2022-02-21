WaypointWindow = BaseWindow:new()

function WaypointWindow:new(id, name, iconId, parent, pointX, pointY)
    local this = {
        id = id,
        name = name,
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
        table:setDimensions(iconWidth / 3, iconHeight / 3)
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

function WaypointWindow:update(x, y)
    local locX, locY = RadarApi.worldPosToRadar(x or self.pointX, y or self.pointY)
    self:clearAnchors()
    self:addAnchor("topleft", self.parent, "center", locX, locY)
end

function WaypointWindow.WaypointMouseOver()
    local mapId = RadarWindow.MAP_IMAGE
    local parent = RadarWindow

    if MapSettings.isAtlas() then
        mapId = MapWindow.MAP_IMAGE
        parent = MapWindow
    end

    local waypoint = parent.adapter.views[mapId].adapter.views[ActiveWindow.name()]
    if waypoint ~= nil and waypoint.name ~= nil then
        Tooltips.CreateTextOnlyTooltip(ActiveWindow.name(), StringFormatter.toWString(waypoint.name))
        Tooltips.Finalize()
        Tooltips.AnchorTooltip(Tooltips.ANCHOR_WINDOW_TOP)
    end
end