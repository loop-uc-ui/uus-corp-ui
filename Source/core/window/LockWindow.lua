LockWindow = ButtonWindow:new()

local TEXTURE = "UO_Core"

local STATES = {}

function LockWindow:new(id, onLock, onUnlock)
    local this = {
        id = id.."Lock",
        onLock = onLock,
        onUnlock = onUnlock
    }
    this.isLocked = UserInterfaceVariables.LoadBoolean(this.id, false)
    self.__index = self
    this = setmetatable(this, self)
    STATES[this.id] = this
    this:toggleTexture()
    return this
end

function LockWindow:toggleSetting()
    UserInterfaceVariables.SaveBoolean(self.id, not self.isLocked)
    self.isLocked = not self.isLocked
    STATES[self.id] = self
end

function LockWindow:toggleTexture()
    if STATES[self.id].isLocked then
        self:setTexture(InterfaceCore.ButtonStates.STATE_NORMAL, TEXTURE, 69, 341)
        self:setTexture(InterfaceCore.ButtonStates.STATE_NORMAL_HIGHLITE, TEXTURE, 92,341)
        self:setTexture(InterfaceCore.ButtonStates.STATE_PRESSED, TEXTURE, 92,341)
        self:setTexture(InterfaceCore.ButtonStates.STATE_PRESSED_HIGHLITE, TEXTURE, 92,341)
    else
        self:setTexture(InterfaceCore.ButtonStates.STATE_NORMAL, TEXTURE, 117,341)
        self:setTexture(InterfaceCore.ButtonStates.STATE_NORMAL_HIGHLITE, TEXTURE, 142,341)
        self:setTexture(InterfaceCore.ButtonStates.STATE_PRESSED, TEXTURE, 142,341)
        self:setTexture(InterfaceCore.ButtonStates.STATE_PRESSED_HIGHLITE, TEXTURE, 142,341)
    end
end

function LockWindow.toggleLock()
    local window = STATES[SystemData.ActiveWindow.name]
    window:toggleSetting()
    window:toggleTexture()
    if window.isLocked and window.onLock ~= nil then
        window.onLock()
    elseif not window.isLocked and window.onUnlock ~= nil then
        window.onUnlock()
    end
end