KeyBinder = {}
KeyBinder.__index = KeyBinder

KeyBinder.BindTypes = SystemData.BindType

function KeyBinder:register(
        callingWindow,
        recordCallback,
        cancelCallback
)
    WindowRegisterEventHandler(
            callingWindow,
            Broadcast.Events.INTERFACE_KEY_RECORDED,
            recordCallback
    )
    WindowRegisterEventHandler(
            callingWindow,
            Broadcast.Events.INTERFACE_KEY_CANCEL_RECORD,
            cancelCallback
    )
    local this = {}
    setmetatable(this, self)
    return this
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
    self.adapter = ViewAdapter:new("AssignHotkeyInfo", "AssignHotkeyInfo")
               :clearAnchors()
               :setShowing(true)
               :addAnchor(anchorTop, anchorWindow, anchorBottom, topPos, bottomPos)
    isRecording(true)
    Broadcast.Event(Broadcast.Events.INTERFACE_RECORD_KEY)
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
        self.adapter:setShowing(false)

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
        Broadcast.Event(Broadcast.Events.KEYBINDINGS_UPDATED)
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
    self.adapter:setShowing(false)
    isRecording(false)
end

