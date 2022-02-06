SkillsLockButtonWindow = DynamicImageWindow:new("SkillsLockButtonWindow")

SkillsLockButtonWindow.STATE_UP = 0
SkillsLockButtonWindow.STATE_DOWN = 1
SkillsLockButtonWindow.STATE_LOCKED = 2

local ARROW_UP = "arrowup"
local ARROW_DOWN = "arrowdown"
local LOCK_BUTTON = "Lock_Button"

function SkillsLockButtonWindow:new(
        id,
        state,
        onClick
)
    local this = {}
    this.state = state
    this.id = id
    this.onClick = onClick
    this.canLock = true
    self.__index = self
    return setmetatable(this, self)
end

function SkillsLockButtonWindow:setButtonTexture()
    local texture = ARROW_UP
    if self.state == SkillsLockButtonWindow.STATE_UP then
        texture = ARROW_UP
    elseif self.state == SkillsLockButtonWindow.STATE_DOWN then
        texture = ARROW_DOWN
    else
        texture = LOCK_BUTTON
    end

    self:setTexture(
            texture,
            0,
            0
    ):setTexture(
            texture,
            0,
            0
    ):setTexture(
            texture,
            24,
            0
    ):setTexture(
            texture,
            24,
            0
    ):setColor(
            {
                r = 220,
                g = 220,
                b = 220
            }
    )
end

local function findButton(id)
    for key, value in pairs(SkillsWindow.adapter.views) do
        if key.."LockButton" == id then
            return value.adapter.views[id]
        end
    end
end

function SkillsLockButtonWindow.OnClick()
    local window = SystemData.ActiveWindow.name
    local button = findButton(window)
    if button.state == SkillsLockButtonWindow.STATE_UP then
        button.state = SkillsLockButtonWindow.STATE_DOWN
    elseif button.state == SkillsLockButtonWindow.STATE_DOWN and button.canLock then
        button.state = SkillsLockButtonWindow.STATE_LOCKED
    else
        button.state = SkillsLockButtonWindow.STATE_UP
    end
    button:setButtonTexture()
    button:onClick()
end