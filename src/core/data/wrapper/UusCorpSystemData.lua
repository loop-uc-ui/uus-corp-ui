---@class SystemData.TrackingPointer
---@field PointerX number
---@field PointerY number
---@field PointerType number

---@class SystemData.PlayState
---@field isConnected boolean

---@class SystemData.Window
---@field name string

---@class SystemData.UpdateProcessedTime
---@field Time number

---@class SystemData.PaperdollTexture
---@field IsLegacy boolean
---@field xOffset number
---@field Height number
---@field yOffset number
---@field Width number

---@class SystemData.Profanity
---@field IgnoreListFilter boolean
---@field BadWordFilter boolean
---@field IgnoreConfListFilter boolean

---@class SystemData.Settings
---@field Resolution SystemData.Settings.Resolution
---@field Keybindings table<string, string>
---@field ObjectHandleFilter table<string, number>
---@field Chat SystemData.Settings.Chat
---@field Sound SystemData.Settings.Sound
---@field Optimization SystemData.Settings.Optimization

---@class SystemData.Settings.Resolution
---@field framerateMax number
---@field useFullScreen boolean
---@field enableVSync boolean
---@field particleLOD number
---@field viewportPos SystemData.Position
---@field gamma number
---@field showWindowFrame boolean
---@field fullScreen SystemData.Size
---@field showShadows boolean
---@field useHardwareDeathEffect boolean
---@field viewportSize SystemData.Position
---@field particleFilter number
---@field displayFoliage boolean

---@class SystemData.Position
---@field x number
---@field y number

---@class SystemData.Size
---@field height number
---@field width number

---@class SystemData.Settings.Chat
---@field scrollLimit number
---@field visibleTime number
---@field numWindows number
---@field fadeText boolean

---@class SystemData.Settings.Sound
---@field music SystemData.Volume
---@field master SystemData.Volume
---@field footsteps SystemData.Volume
---@field effects SystemData.Volume

---@class SystemData.Volume
---@field enabled boolean
---@field volume number?

---@class SystemData.Settings.Optimization
---@field bDisplayAllHouseContents boolean
---@field idleAnimation boolean
---@field cacheSize number
---@field bEnableFlyingAnimation boolean
---@field frameSetRestriction number

---@class SystemData.RequestInfo
---@field ObjectId number

---@class SystemData.ActiveMobile
---@field Id number

---@class SystemData.ActiveContainer
---@field SlotsWide number
---@field NumSlots number
---@field SlotsHigh number

---@class SystemData.InputProcessed
---@field LButtonUp boolean
---@field MButtonUp boolean
---@field LButtonDown boolean
---@field GamepadInput boolean
---@field RButtonDown boolean
---@field RButtonUp boolean
---@field EnterKey boolean
---@field EscapeKey boolean
---@field MButtonDown boolean

---@class SystemData.AvailableResolutions
---@field heights number[]
---@field widths number[]

---@class SystemData.FreeformInventory
---@field Scale number

---@class SystemData.ActiveObject
---@field GirdIndex number
---@field Id number
---@field DropSourceType number
---@field PickUpSourceType number
---@field Quantity number
---@field ForceOpenPaperdoll boolean
---@field SourcePos SystemData.Position
---@field ObjectType number
---@field TargetType number
---@field SourceId number

---@class SystemData.Waypoint
---@field TypeIsCustomizable boolean[]

---@class SystemData.Paperdoll
---@field Id number
---@field Name string

---@return SystemData
UusCorpSystemData = function ()
    ---@class SystemData
    ---@field TrackingPointer SystemData.TrackingPointer
    ---@field BindingActionString string
    ---@field RecordedKey string
    ---@field PlayState SystemData.PlayState
    ---@field ActiveWindowSet number
    ---@field TextChannelId number
    ---@field MouseOverWindow SystemData.Window
    ---@field ActiveWindow SystemData.Window
    ---@field IsRecordingSettings false
    ---@field SourceName string
    ---@field TextLogUpdate table<string, number>
    ---@field UpdateProcessedTime SystemData.UpdateProcessedTime
    ---@field PaperdollTexture table<number, SystemData.PaperdollTexture>
    ---@field RecordedKeySmallDisplay string
    ---@field Events table<string, number>
    ---@field Settings SystemData.Settings
    ---@field RequestInfo SystemData.RequestInfo
    ---@field ActiveMobile SystemData.ActiveMobile
    ---@field IsInternalBuild boolean
    ---@field TextAlwaysShow boolean
    ---@field TextColor number
    ---@field TextEntryUnicodeId number
    ---@field ActiveContainer SystemData.ActiveContainer
    ---@field ChatLogFilters table<string, number>
    ---@field screenResolution SystemData.Position
    ---@field InputProcessed SystemData.InputProcessed
    ---@field TextEntryUnicodeSender number
    ---@field AvailableResolutions SystemData.AvailableResolutions
    ---@field BindType table<string, number>
    ---@field DragSource table<string, number>
    ---@field DragItem table<string, number>
    ---@field FreeformInventory SystemData.FreeformInventory
    ---@field TextID number
    ---@field UserAction table<string, number>
    ---@field ActiveObject SystemData.ActiveObject
    ---@field DynamicWindowId number
    ---@field UiLogFilters table<string, number>
    ---@field BindingConflictItemIndex number
    ---@field Waypoint SystemData.Waypoint
    ---@field Text string
    ---@field MousePosition SystemData.Position
    ---@field TextSourceID number
    ---@field ButtonFlags table<string, number>
    ---@field BindingConflictType number
    ---@field BindingConflictHotbarId number
    ---@field CustomUIList string[]
    ---@field TextEntryUnicodeCode number
    ---@field Paperdoll SystemData.Paperdoll
    return SystemData
end