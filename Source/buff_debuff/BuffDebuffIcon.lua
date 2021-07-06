BuffDebuffIcon = ListWindow:new("BuffDebuffIcon", false)

local function formatTime(time)
    local min = math.floor(time / 60)
    if min > 60 then
        local prefix = ""
        if ((min / 60) - math.floor(min / 60) > 0) then
            prefix = ">"
        end
        local h = math.floor(min / 60)
        return StringToWString(prefix .. tostring(h) .. "h")
    elseif min > 0 then
        local prefix = ""
        if (time - (min * 60) > 0) then
            prefix = ">"
        end
        return StringToWString(prefix .. tostring(min)	.. "m")
    else
        return StringToWString(tostring(time)	.. "s")
    end
end

function BuffDebuffIcon:new(
        index,
        textureId,
        buffId,
        timer,
        hasTimer,
        isBeingRemoved,
        nameVectorSize,
        toolTipVectorSize,
        nameString,
        toolTipString
)
    local this = {}
    this.textureId = textureId
    this.index = index
    this.id = BuffDebuffIcon.id..buffId
    this.buffId = buffId
    this.timer = timer
    this.hasTimer = hasTimer
    this.isBeingRemoved = isBeingRemoved
    this.nameVectorSize = nameVectorSize
    this.toolTipVectorSize = toolTipVectorSize
    this.nameString = nameString
    this.toolTipString = toolTipString
    this.time = TimeApi.getCurrentTime()
    this.expireTime = timer and this.time + timer or timer
    this.adapter = WindowAdapter:new(this.id)
    this.isAnimating = false
    self.__index = self
    return setmetatable(this, self)
end

function BuffDebuffIcon:create()
    WindowApi.createFromTemplate(self.id, "BuffDebuffIcon", "BuffDebuff")
    local texture, x, y = IconApi.getIconData(self.textureId)
    self.adapter:addDynamicImage(self.id.."Texture", texture, x, y)
end

function BuffDebuffIcon:setTimerLabel(time)
    if self.timer > 0 and self.hasTimer then
        self.adapter:addLabel(self.id.."TimerLabel", formatTime(time))
    end
end

function BuffDebuffIcon:getTimerLabel()
    return self.adapter.views[self.id.."TimerLabel"]
end

function BuffDebuffIcon:getIcon()
    return self.adapter.views[self.id.."Texture"]
end

function BuffDebuffIcon:anchor(orientation, previous)
    local timerLabel = self:getTimerLabel()
    if timerLabel ~= nil then
        timerLabel:clearAnchors()
    end
    self:clearAnchors()

    if orientation == 1 then
        if previous == nil then
            self:addAnchor("topright", AdvancedBuff.id, "topright", -20, 5)
        else
           self:addAnchor("topleft", previous.id, "topright", -5, 0)
        end

        if timerLabel ~= nil then
            timerLabel:addAnchor("top", self.id, "bottom", 0, -2)
        end
    elseif orientation == 3 then
        if previous == nil then
           self:addAnchor("bottomleft", AdvancedBuff.id, "bottomleft", 18, -18)
        else
            self:addAnchor("topleft", previous.id , "bottomleft",0 , -5)
        end

        if timerLabel ~= nil then
            timerLabel:addAnchor("right", self.id, "left", 2, 0)
        end
    elseif orientation == 5 then
        if previous == nil then
            self:addAnchor("topleft", AdvancedBuff.id, "topleft", 20, 20)
        else
            self:addAnchor("topright", previous.id, "topleft", 5, 0)
        end

        if timerLabel ~= nil then
            timerLabel:addAnchor("bottom", self.id, "top", 0, 2)
        end
    elseif orientation == 8 then
        if previous == nil then
            self:addAnchor("topright", AdvancedBuff.id, "topright", -20, 20)
        else
            self:addAnchor("bottomleft", previous.id, "topleft",0 , 5)
        end

        if timerLabel ~= nil then
            timerLabel:addAnchor("left", self.id, "right", -2, 0)
        end
    else
        self:anchor(1, previous)
    end
end

function BuffDebuffIcon.mouseOver()
    local buffWindow = AdvancedBuff.adapter.views[ActiveWindow.name()]
    local nameString = L""
    for i = 1, buffWindow.nameVectorSize do
        nameString = buffWindow.nameString[i]
    end

    local tooltipString = L""
    for i = 1, buffWindow.toolTipVectorSize do
        tooltipString = buffWindow.toolTipString[i]
    end

    local bodyText = WindowUtils.translateMarkup(tooltipString)
    local itemData = {
        windowName = buffWindow.id,
        itemId = buffWindow.buffId,
        itemType = WindowData.ItemProperties.TYPE_WSTRINGDATA,
        binding = L"",
        detail = nil,
        title =	WindowUtils.translateMarkup(nameString),
        body = bodyText
    }
    ItemProperties.SetActiveItem(itemData)
end
