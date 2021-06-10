KeyBinder = BaseWindow:new("AssignHotkeyInfo")

KeyBinder.BindTypes = SystemData.BindType

function KeyBinder:new(
        callingWindow,
        recordCallback,
        cancelCallback
)
    WindowRegisterEventHandler(
            callingWindow,
            SystemData.Events.INTERFACE_KEY_RECORDED,
            recordCallback
    )
    WindowRegisterEventHandler(
            callingWindow,
            SystemData.Events.INTERFACE_KEY_CANCEL_RECORD,
            cancelCallback
    )
    local this = {}
    self.__index = self
    return setmetatable(this, self)
end

local function isRecording(newValue)
    if newValue ~= nil then
        SystemData.IsRecordingSettings = newValue
    end
    return SystemData.IsRecordingSettings
end

function KeyBinder.recordedKey()
    return SystemData.RecordedKey
end

function KeyBinder:onKeyPicked(
        anchorTop,
        anchorWindow,
        anchorBottom,
        topPos,
        bottomPos
)
    self:clearAnchors():setShowing(true):addAnchor(anchorTop, anchorWindow, anchorBottom, topPos, bottomPos)
    isRecording(true)
    EventApi.broadcast(SystemData.Events.INTERFACE_RECORD_KEY)
end

function KeyBinder:onKeyRecorded(
        bindType,
        keyBindings,
        keyBindingRequest,
        windowRoot,
        windowBody,
        bindCallback
)
    isRecording(false)
    if self.recordedKey() ~= L"" then
        self:setShowing(false)

        local conflictIndex = -1
        local conflictType = KeyBinder.BindTypes.BINDTYPE_NONE
        local keyIndex = keyBindingRequest.index

        for i = 1, #keyBindings do
            if keyIndex ~= i and keyBindings[i].value == self.recordedKey() then
                conflictIndex = i
                conflictType = bindType
                break
            elseif keyIndex == i and keyBindings[i].value == self.recordedKey() then
                self:onKeyCanceled()
                return
            end
        end

        self:onKeyBind(
                conflictIndex,
                conflictType,
                windowRoot,
                windowBody,
                bindCallback
        )
    else
        self:onKeyCanceled()
    end
end

function KeyBinder:onKeyBind(
        conflictIndex,
        conflictType,
        windowRoot,
        windowBody,
        bindCallback
)
    --TODO add this callback to the Yes button
    local thisCallback = function()
        EventApi.broadcast(SystemData.Events.KEYBINDINGS_UPDATED)
        bindCallback()
    end

    if conflictIndex ~= -1 and conflictType ~= KeyBinder.BindTypes.BINDTYPE_NONE then
        --local yesButton = {
        --    textTid = TextIds.YES
        --    callback = thisCallback
        --}
        --local noButton = {
        --    textTid = TextIds.NO
        --}
        local windowData = {
            windowName = windowRoot,
            titleTid = 1079169,
            body = windowBody
        }
        UO_StandardDialog.CreateDialog(windowData)
    else
        thisCallback()
    end
end

function KeyBinder:onKeyCanceled()
    self:setShowing(false)
    isRecording(false)
end

