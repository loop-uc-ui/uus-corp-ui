LockWindow = ButtonWindow:new()

local TEXTURE = "UO_Core"

local STATES = {}

local function toggleTexture(lockWindow)
    if STATES[lockWindow.id].isLocked then
        lockWindow:setTexture(InterfaceCore.ButtonStates.STATE_NORMAL, TEXTURE, 69, 341)
        lockWindow:setTexture(InterfaceCore.ButtonStates.STATE_NORMAL_HIGHLITE, TEXTURE, 92,341)
        lockWindow:setTexture(InterfaceCore.ButtonStates.STATE_PRESSED, TEXTURE, 92,341)
        lockWindow:setTexture(InterfaceCore.ButtonStates.STATE_PRESSED_HIGHLITE, TEXTURE, 92,341)
    else
        lockWindow:setTexture(InterfaceCore.ButtonStates.STATE_NORMAL, TEXTURE, 117,341)
        lockWindow:setTexture(InterfaceCore.ButtonStates.STATE_NORMAL_HIGHLITE, TEXTURE, 142,341)
        lockWindow:setTexture(InterfaceCore.ButtonStates.STATE_PRESSED, TEXTURE, 142,341)
        lockWindow:setTexture(InterfaceCore.ButtonStates.STATE_PRESSED_HIGHLITE, TEXTURE, 142,341)
    end
end

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
    toggleTexture(this)
    return this
end

local function toggleSetting(window)
    UserInterfaceVariables.SaveBoolean(window.id, not window.isLocked)
    window.isLocked = not window.isLocked
    STATES[window.id] = window
end

function LockWindow.toggleLock()
    local window = STATES[SystemData.ActiveWindow.name]
    toggleSetting(window)
    toggleTexture(window)
    if window.isLocked and window.onLock ~= nil then
        window.onLock()
    elseif not window.isLocked and window.onUnlock ~= nil then
        window.onUnlock()
    end
end