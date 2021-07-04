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

function BuffDebuffIcon:anchor(index, orientation)
    if orientation == 1 then

    elseif orientation == 3 then

    elseif orientation == 5 then

    elseif orientation == 8 then

    else
        self:anchor(index, 1)
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
