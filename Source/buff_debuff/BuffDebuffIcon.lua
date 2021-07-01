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
    WindowApi.createFromTemplate(this.id, "BuffDebuffIcon", "BuffDebuff")
    local texture, x, y = GetIconData(textureId)
    this.adapter:addDynamicImage(this.id.."Texture", texture, x, y)
    self.__index = self
    local meta = setmetatable(this, self)
    meta:addTimerLabel()
    return meta
end

function BuffDebuffIcon:addTimerLabel()
    if self.timer ~= 0 then
        self.adapter:addLabel(self.id.."TimerLabel", formatTime(self.expireTime - self.time))
    end
end