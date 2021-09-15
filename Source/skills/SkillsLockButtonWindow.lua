SkillsLockButtonWindow = ButtonWindow:new("SkillsLockButtonWindow")

SkillsLockButtonWindow.STATE_UP = 0
SkillsLockButtonWindow.STATE_DOWN = 1
SkillsLockButtonWindow.STATE_LOCKED = 2

local ARROW_UP = "arrowup"
local ARROW_DOWN = "arrowdown"
local LOCK_BUTTON = "Lock_Button"

function SkillsLockButtonWindow:new(
        id,
        state,
        onStateChange
)
    local this = {}
    this.state = state
    this.id = id
    this.onStateChange = onStateChange
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
            InterfaceCore.ButtonStates.STATE_NORMAL,
            texture,
            0,
            0
    ):setTexture(
            InterfaceCore.ButtonStates.STATE_PRESSED,
            texture,
            0,
            0
    ):setTexture(
            InterfaceCore.ButtonStates.STATE_PRESSED_HIGHLITE,
            texture,
            24,
            0
    ):setTexture(
            InterfaceCore.ButtonStates.STATE_NORMAL_HIGHLITE,
            texture,
            24,
            0
    ):setShowing(true)
end

function SkillsLockButtonWindow.OnToggleSort()
    local window = SystemData.ActiveWindow.name
    local button = SkillsWindow.adapter.views[window]
    if button.state == SkillsLockButtonWindow.STATE_UP then
        button.state = SkillsLockButtonWindow.STATE_DOWN
    elseif button.state == SkillsLockButtonWindow.STATE_DOWN and button.canLock then
        button.state = SkillsLockButtonWindow.STATE_LOCKED
    else
        button.state = SkillsLockButtonWindow.STATE_UP
    end
    button:setButtonTexture()
    button:onStateChange()
end