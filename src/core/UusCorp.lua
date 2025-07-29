---@class Event:number
---@class Type:number

---@class Object
---@field objectId number
---@field objectType number

---@class SkillAllSkillsOther

---@class AllSkillsSelf

---@class PlayerStat
---@field tid number
---@field name string
---@field warningIconId number
---@field detailTid number
---@field hasDivider boolean
---@field objectId number
---@field iconId number

---@class CustomHouseInfo

---@class GG_Core
---@field localizedDataCount number
---@field stringDataCount number
---@field GumpId number
---@field descCount number
---@field ObjectId number
---@field textHueDataCount number
---@field gumppicNumDataCount number

---@class WaypointDisplay
---@field currentDisplayMode string
---@field typeNames string[]
---@field displayTypes table<string, WaypointDisplayType>
---@field iconNames string[]
---@field iconIds number[]
---@field effectNames string[]

---@class WaypointDisplayType
---@field displayIndex number
---@field isDisplayed boolean

---@class WaypointList
---@field waypointCount number

---@class Skill
---@field IconId number
---@field ServerId number
---@field Entitlement number
---@field DescriptionTid number
---@field NameTid number
---@field SkillName string
---@field DragIcon number

---@class BuffDebuffSystem
---@field CurrentBuffId number

---@class StaticTextWindow
---@field ObjectType number
---@field XPos number
---@field YPos number

---@class PlayerItemProperty
---@field DescriptionTID number
---@field Cumulative number
---@field TID number
---@field MatchExact number
---@field ID number
---@field Name string

---@class Buff
---@field ID number
---@field ServerId number
---@field IconId number
---@field Define string

---@class ResourceType
---@field Category number
---@field ObjectType number

---@class CloseGG
---@field RetId number
---@field ButtonId number

---@class Paperdoll
---@field iconName string
---@field hueId number
---@field iconScale number
---@field newHeight number
---@field hue Color
---@field objectType number
---@field slotId number
---@field newWidth number

---@class Color
---@field a number
---@field b number
---@field g number
---@field r number

---@class Radar
---@field TexCoordX number
---@field TexCoordY number
---@field TexScale number
---@field TexRotation number

---@class BuffDebuff
---@field NameVectorSize number
---@field TimerSeconds number
---@field IsBeingRemoved boolean
---@field HasTimer boolean
---@field ToolTipWStringVector string[]
---@field ToolTipVectorSize number
---@field NameWSringVector string[]

---@class SkillDynamicData
---@field TempSkillValue number
---@field SkillState number
---@field RealSkillValue number
---@field SkillCap number

---@class GChat
---@field GC_SHOW_CHAT boolean
---@field GC_SHOW_UNAVAILABLE boolean

---@class WindowData.ObjectInfo
---@field iconName string
---@field iconScale number
---@field shopQuantity number
---@field quantity number
---@field shopName string
---@field containerId number
---@field newWidth number
---@field hueId number
---@field name string
---@field hue Color
---@field objectType number
---@field shopValue number
---@field iconId number

---@class WindowData.Container
---@field isSnooped boolean
---@field containerName string
---@field numItems number
---@field ContainedItems WindowData.Container.Item[]
---@field gumpNumb number
---@field isCorpse false

---@class WindowData.Container.Item
---@field objectId number
---@field gridIndex number


---@class SkillDefinition
---@field hasEntitlement boolean
---@field skillName string
---@field skillDescription string
---@field CSVId number
---@field iconId number

---@class MobileName
---@field MobName string
---@field Notoriety number

---@class ItemProperties
---@field TYPE_WSTRINGDATA number
---@field CustomeColorBody CustomColorBody
---@field WorldObject number
---@field CustomColorBody2 CustomColorBody
---@field TYPE_ITEM number
---@field CurrentHover number
---@field numLabels number
---@field TYPE_NONE number
---@field TYPE_ACTION number
---@field CustomColorTitle CustomColorTitle
---@field CurrentType number

---@class CustomColorBody
---@field Enable boolean
---@field LabelIndex number?
---@field Color Color?

---@class CustomColorTitle
---@field NotorietyIndex number
---@field Enable boolean
---@field LabelIndex number
---@field NotorietyEnable boolean

---@class SystemData.TrackingPointer
---@field PointerX number
---@field PointerY number
---@field PointerType number

---@class SystemData.PlayState
---@field isConnected boolean

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

---@class WindowData
---@field Cursor WindowData.Cursor
---@field RecentChatPlayerNameList string[]
---@field SkillAllSkillsOther SkillAllSkillsOther
---@field PlayerEquipmentSlot Object[]
---@field HealthBarColor table<number, WindowData.HealthBarColor>
---@field BadWordList string[]
---@field PlayerStatsDataCSV PlayerStat[]
---@field AllSkillsSelf AllSkillsSelf
---@field IgnoreListCount number
---@field CustomHouseInfo CustomHouseInfo
---@field GG_Core GG_Core
---@field PlayerStatus WindowData.PlayerStatus
---@field WaypointDisplay WaypointDisplay
---@field SkillsCSV Skill[]
---@field MountedObjId number
---@field BuffDebuffSystem BuffDebuffSystem
---@field StaticTextWindow StaticTextWindow
---@field PlayerItemPropCSV PlayerItemProperty[]
---@field BuffDataCSV Buff[]
---@field ResourceTypeDataCSV ResourceType[]
---@field RecentChatPlayerListCounter number
---@field WaypointList WaypointList
---@field CloseGG CloseGG
---@field RecentChatPlayerIdList number[]
---@field Paperdoll table<number, Paperdoll[]>
---@field RemoveGChatIndex number
---@field Radar Radar
---@field GChatMyPresence number
---@field BuffDebuff BuffDebuff
---@field UpdateInstanceId number
---@field ChannelList string[]
---@field SkillDynamicData SkillDynamicData[]
---@field MobileStatus table<number, WindowData.MobileStatus>
---@field ChannelListCount number
---@field GChat GChat
---@field CurrentTarget WindowData.CurrentTarget
---@field CurrentChannel string
---@field SkillList SkillDefinition[]
---@field MobileName table<number, MobileName>
---@field GChatCount number
---@field ItemProperties ItemProperties
---@field ObjectInfo table<number, WindowData.ObjectInfo>
---@field ContainerWindow table<number, WindowData.Container>
---@field ObjectHandle WindowData.ObjectHandle


local DefaultUIClasses = {
    ---@class AbilitiesInfo
    ---@field Data table[] Table of ability data (name, Mana)
    ---@field MessageToID table Mapping from message TID to ability ID
    ---@field isPrimary fun(abilityId: integer): boolean Returns true if the ability is the primary weapon ability
    ---@field RequiresBushido fun(abilityId: integer): boolean Returns true if the ability requires Bushido
    ---@field RequiresNinjitsu fun(abilityId: integer): boolean Returns true if the ability requires Ninjitsu
    ---@field RequiresBushidoOrNinjitsu fun(abilityId: integer): boolean Returns true if the ability requires Bushido or Ninjitsu
    ---@field CanUse fun(abilityId: integer): boolean|nil Returns true if the ability can be used, false or nil otherwise
    ---@field GetManaCost fun(abilityId: integer): integer|nil Gets the mana cost for the ability

    ---@class ActionEditWindow
    ---@field CurEditItem table|nil Current item being edited
    ---@field CurEditMacroItem table|nil Current macro item being edited
    ---@field CurRequestInfoItem table|nil Current request info item
    ---@field CurActionId integer|nil Current action ID
    ---@field TID_OK integer TID for OK button
    ---@field TID_ADDEQUIPPED integer TID for Add Equipped button
    ---@field Equip table Equip-related data (NumItemsCreated, RegisteredObjects)
    ---@field ArmDisarmMaxLength integer Max length for arm/disarm
    ---@field UnEquip table UnEquip-related data (Slots, selected)
    ---@field ResourceRegisteredObject integer Registered resource object
    ---@field ResourceType table Resource type definitions
    ---@field ResourceCategory table Resource category definitions
    ---@field RESOURCE_TID integer TID for resource selection
    ---@field Initialize fun() Initializes the action edit window
    ---@field Shutdown fun() Shuts down the action edit window
    ---@field UpdateTextEdit fun(editWindow: string, hotbarId: integer, itemIndex: integer, subIndex: integer, actionId: integer) Updates the text edit box
    ---@field UpdateSliderEdit fun(editWindow: string, hotbarId: integer, itemIndex: integer, subIndex: integer) Updates the slider edit box
    ---@field OpenEditWindow fun(actionType: integer, anchorWindow: string, hotbarId: integer, itemIndex: integer, subIndex: integer|nil, actionId: integer|nil) Opens the edit window
    ---@field CustomDelay fun(param: table, text: string) Handles custom delay input
    ---@field TextEditOK fun() Handles OK for text edit
    ---@field SliderEditOK fun() Handles OK for slider edit
    ---@field SliderUpdate fun() Handles slider update
    ---@field UpdateEquipItemEdit fun(windowName: string, hotbarId: integer, itemIndex: integer, subIndex: integer) Updates equip item edit
    ---@field EquipUpdateObject fun() Updates equip object
    ---@field GetActionInfo fun(windowName: string): integer, integer, integer Gets action info
    ---@field EquipLButtonUp fun() Handles left button up for equip
    ---@field UpdateEquipIcon fun(windowName: string, objectId: integer) Updates equip icon
    ---@field EquipRButtonUp fun() Handles right button up for equip
    ---@field Equip_ContextMenuCallback fun(returnCode: any, param: any) Handles context menu callback for equip
    ---@field EquipMouseOver fun() Handles mouse over for equip
    ---@field UnregisterEquipItems fun() Unregisters equip items
    ---@field EquipItemOK fun() Handles OK for equip item
    ---@field EquipClearEquipped fun() Clears equipped items
    ---@field EquipItemAddEquipped fun() Adds equipped items
    ---@field CreateUnequipSlots fun(windowName: string) Creates unequip slots
    ---@field UpdateUnequipEdit fun(windowName: string, hotbarId: integer, itemIndex: integer, subIndex: integer) Updates unequip edit
    ---@field UnequipPosSelected fun() Handles unequip position selection
    ---@field UnEquipOK fun() Handles OK for unequip
    ---@field CreateArmDisarmSlots fun(windowName: string) Creates arm/disarm slots
    ---@field UpdateArmDisarmEdit fun(windowName: string, hotbarId: integer, itemIndex: integer, subIndex: integer) Updates arm/disarm edit
    ---@field ArmDisarmSelectSlot fun() Selects arm/disarm slot
    ---@field ArmDisarmOK fun() Handles OK for arm/disarm
    ---@field TargetByResourceUpdateObject fun() Updates target by resource object
    ---@field UpdateTargetByResourceIcon fun(windowName: string, objectId: integer) Updates target by resource icon
    ---@field UpdateTargetByResourceEdit fun(windowName: string, hotbarId: integer, itemIndex: integer, subIndex: integer) Updates target by resource edit
    ---@field TargetByResourceLButtonUp fun() Handles left button up for target by resource
    ---@field TargetByResourceResetComboBox fun(windowName: string, resourceTypeSelected: integer, currentCategory: integer) Resets resource combo box
    ---@field TargetByResourceMouseOver fun() Handles mouse over for target by resource
    ---@field TargetByResourceOK fun() Handles OK for target by resource
    ---@field UpdateTargetByObjectId fun(windowName: string, hotbarId: integer, itemIndex: integer, subIndex: integer) Updates target by object ID
    ---@field TargetByObjectIdOK fun() Handles OK for target by object ID
    ---@field RequestTargetInfoReceived fun() Handles received target info

    ---@class Actions
    ---@field WarMode integer War mode state
    ---@field nxt integer Next target index
    ---@field MassOrganize boolean Whether mass organize is active
    ---@field VacuumObjects table|nil Objects to vacuum for mass organize
    ---@field DefaultRecordID integer|nil Default record ID for targeting
    ---@field AutoLoadShurikens boolean Whether auto-load shurikens is active
    ---@field BeltMenuRequest integer|nil Belt menu request ID
    ---@field Nextshuri number Next shuriken timer
    ---@field Undress boolean Whether undress is active
    ---@field OrganizeBag integer|nil Organize bag ID
    ---@field OrganizeParent integer|nil Organize parent ID
    ---@field UndressItems table|nil Items to undress
    ---@field itemQuantities table|nil Item quantities by type
    ---@field AllItems table|nil All item IDs
    ---@field ActionEditRequest table|nil Action edit request data
    ---@field InjuredFollower fun() Targets the most injured follower
    ---@field InjuredParty fun() Targets the most injured party member
    ---@field InjuredMobile fun() Targets the most injured mobile
    ---@field MassOrganizerStart fun() Starts mass organizer
    ---@field MassOrganizer fun(timePassed: number) Handles mass organizer logic
    ---@field AutoLoadShuri fun() Auto-loads shuriken
    ---@field Shuriken fun(timePassed: number) Handles shuriken logic
    ---@field DressHolding fun() Dresses holding item
    ---@field DropHolding fun() Drops holding item
    ---@field ToggleTrapBox fun() Toggles trap box
    ---@field TrapboxTargetReceived fun() Handles trap box target received
    ---@field ToggleLootbag fun() Toggles loot bag
    ---@field LootbagTargetReceived fun() Handles loot bag target received
    ---@field ToggleAlphaMode fun() Toggles alpha mode
    ---@field ToggleScaleMode fun() Toggles scale mode
    ---@field ObjectHandleContextMenu fun() Opens object handle context menu
    ---@field ObjectHandleContextMenuCallback fun(returnCode: any, param: any) Handles object handle context menu callback
    ---@field ObjectHandleSetFilter fun(j: integer, newval: any) Sets object handle filter
    ---@field GetHealthbar fun() Gets health bar
    ---@field GetTypeID fun() Gets type ID
    ---@field ItemIDRequestTargetInfoReceived fun() Handles item ID request target info received
    ---@field GetHueID fun() Gets hue ID
    ---@field ColorRequestTargetInfoReceived fun() Handles color request target info received
    ---@field IgnoreTargettedItem fun() Ignores targeted item
    ---@field IgnoreItemRequestTargetInfoReceived fun() Handles ignore item request target info received
    ---@field ClearIgnoreList fun() Clears ignore list
    ---@field ToggleBlockPaperdolls fun() Toggles block paperdolls
    ---@field UndressMe fun() Initiates undress
    ---@field UndressTargetInfoReceived fun() Handles undress target info received
    ---@field UndressAgent fun(timePassed: number) Handles undress agent logic
    ---@field ImbueLast fun() Imbues last item
    ---@field UnravelItem fun() Unravels item
    ---@field EnhanceItem fun() Enhances item
    ---@field SmeltItem fun() Smelts item
    ---@field AlterItem fun() Alters item
    ---@field MakeLast fun() Makes last item
    ---@field RepairItem fun() Repairs item

    ---@class ActionsWindow
    ---@field DefaultTypes integer Number of default action types
    ---@field ActionData table Table of action data
    ---@field Groups table Table of action groups
    ---@field OFFSET_FROM_TOP integer Offset from top
    ---@field OFFSET_FROM_BOTTOM integer Offset from bottom
    ---@field SIDE_OFFSET integer Side offset
    ---@field ITEM_WIDTH integer Item width
    ---@field ITEM_HEIGHT integer Item height
    ---@field CurrentGroup integer Current group index
    ---@field Initialize fun() Initializes the actions window
    ---@field Shutdown fun() Shuts down the actions window
    ---@field CustomEdit fun(actionId: integer): boolean Returns true if the action is custom
    ---@field RefreshList fun(modifier: integer) Refreshes the action list
    ---@field SetGroupLabel fun() Sets the group label
    ---@field ItemLButtonDown fun(flags: integer) Handles left button down on item
    ---@field ItemMouseOver fun() Handles mouse over on item
    ---@field GetActionDataForType fun(actionType: integer): table Gets action data for type
    ---@field GetActionDataForID fun(actionId: integer): table Gets action data for ID
    ---@field LeftArrowPressed fun() Handles left arrow pressed
    ---@field RightArrowPressed fun() Handles right arrow pressed
    ---@field UpdateCurrentGroup fun(modifier: integer) Updates current group
    ---@field HideAllGroups fun() Hides all groups
    ---@field ShowActiveGroup fun() Shows active group
    ---@field Context fun() Opens context menu
    ---@field ContextMenuCallback fun(returnCode: integer, param: any) Handles context menu callback
    ---@field ContextTooltip fun() Shows context tooltip
    ---@field GetIdByType fun(type: integer): integer|nil Gets ID by type
    ---@field isAction fun(type: integer): boolean Returns true if type is an action

    ---@class AdvancedBuff
    ---@field WindowNameGood string Name of the good buff window
    ---@field WindowNameEvil string Name of the evil buff window
    ---@field GoodLocked boolean Whether the good window is locked
    ---@field EvilLocked boolean Whether the evil window is locked
    ---@field GoodDirection integer Good window direction
    ---@field EvilDirection integer Evil window direction
    ---@field ReverseOrderGood table Reverse order for good buffs
    ---@field ReverseOrderEvil table Reverse order for evil buffs
    ---@field TableOrderGood table Table order for good buffs
    ---@field TableOrderEvil table Table order for evil buffs
    ---@field PrevIconsGood integer Previous icons for good buffs
    ---@field PrevIconsEvil integer Previous icons for evil buffs
    ---@field Initialize fun() Initializes the advanced buff window
    ---@field Shutdown fun() Shuts down the advanced buff window
    ---@field UpdateDirections fun(isRotating: integer|nil) Updates directions
    ---@field Rotate fun() Rotates the buff window
    ---@field LockTooltip fun() Shows lock tooltip
    ---@field LockMe fun() Locks the window
    ---@field ContextToolsTooltip fun() Shows context tools tooltip
    ---@field OnLButtonDown fun() Handles left button down
    ---@field HandleReAnchorBuffGood fun(position: integer) Handles re-anchoring good buffs
    ---@field HandleReAnchorBuffEvil fun(position: integer) Handles re-anchoring evil buffs

    ---@class BookTemplate
    ---@field OpenBooks table Table of open books
    ---@field bDebug integer Debug flag
    ---@field Initialize fun() Initializes the book template window
    ---@field Shutdown fun() Shuts down the book template window
    ---@field CloseBook fun() Closes the book window
    ---@field PageUp fun() Goes to the next page
    ---@field PageDown fun() Goes to the previous page
    ---@field UpdatePageText fun() Updates the page text
    ---@field UpdatePageNumbers fun() Updates the page numbers
    ---@field EnterTitle fun() Enters the book title
    ---@field StoreText fun() Stores the book text

    ---@class BuffDebuff
    ---@field BuffData table Table of buff data
    ---@field Timers table Table of buff timers
    ---@field BuffWindowId table Table of buff window IDs
    ---@field TableOrder table Table order for buffs
    ---@field ReverseOrder table Reverse order for buffs
    ---@field MaxLength integer Maximum length of buffs
    ---@field Gap integer Gap between buffs
    ---@field DeltaTime number Delta time for updates
    ---@field Fade table Fade settings
    ---@field TID table Table of TID values
    ---@field IconSize integer Icon size
    ---@field ActiveBuffs table Table of active buffs
    ---@field Good table Table of good buff IDs
    ---@field Neutral table Table of neutral buff IDs
    ---@field Update fun(timePassed: number) Updates the buff window
    ---@field retrieveBuffData fun(buffData: table): boolean Retrieves buff data
    ---@field Initialize fun() Initializes the buff window
    ---@field ShouldCreateNewBuff fun() Determines if a new buff should be created
    ---@field HandleBuffRemoved fun(buffId: integer) Handles buff removal
    ---@field UpdateTimer fun(timePassed: number|nil) Updates the timer
    ---@field CreateNewBuff fun() Creates a new buff
    ---@field ResizeOuterWindow fun(windowName: string, numIcons: integer) Resizes the outer window
    ---@field MouseOver fun() Handles mouse over
    ---@field Shutdown fun() Shuts down the buff window
    ---@field UpdateStatus fun(iconId: integer) Updates the status

    ---@class CenterScreenText
    ---@field EnableIgnoreSummons boolean Whether to ignore summons
    ---@field LowHPPercDisabled boolean Whether low HP percent is disabled
    ---@field LowHPPETPercDisabled boolean Whether low HP percent for pets is disabled
    ---@field LOWHPMEStarted boolean Whether low HP for self started
    ---@field LOWHPPetStarted boolean Whether low HP for pet started
    ---@field LowHPPerc integer Low HP percent threshold
    ---@field LowPETHPPerc integer Low pet HP percent threshold
    ---@field SendCenterScreenTexture fun(message: string) Sends a center screen texture
    ---@field OnUpdate fun(timePassed: number) Handles update

    ---@class ChannelWindow
    ---@field currentSelection integer Current selected channel index
    ---@field TID table Table of TID values
    ---@field Initialize fun() Initializes the channel window
    ---@field Shutdown fun() Shuts down the channel window
    ---@field CreateWindowInitialize fun() Initializes the create channel window
    ---@field ToggleChannel fun() Toggles the selected channel
    ---@field UpdateCurrentChannel fun() Updates the current channel label
    ---@field Join_OnLButtonUp fun() Handles join button click
    ---@field Leave_OnLButtonUp fun() Handles leave button click
    ---@field Create_OnLButtonUp fun() Handles create button click
    ---@field CreateCancel_OnLButtonUp fun() Handles create cancel button click
    ---@field CreateChannel fun() Handles channel creation

    ---@class CharacterAbilities
    ---@field TID table Table of TID values
    ---@field WEAPONABILITY_OFFSET integer Offset for weapon abilities
    ---@field RACIALABILITY_OFFSET integer Offset for racial abilities
    ---@field WEAPONABILITY_MAX integer Maximum number of weapon abilities
    ---@field MaxRacialAbilities integer Maximum number of racial abilities
    ---@field Initialize fun() Initializes the character abilities window
    ---@field Shutdown fun() Shuts down the character abilities window
    ---@field OnShown fun() Handles window shown event
    ---@field OnHidden fun() Handles window hidden event
    ---@field ToggleTab fun() Toggles tab
    ---@field UnselectAllTabs fun(parent: string, numTabs: integer) Unselects all tabs
    ---@field SelectTab fun(parent: string, tabNum: integer) Selects a tab
    ---@field InitWeaponTab fun() Initializes weapon tab
    ---@field ShutdownWeaponTab fun() Shuts down weapon tab
    ---@field UpdateWeaponAbilities fun() Updates weapon abilities
    ---@field ActivateWeaponAbility fun() Activates weapon ability
    ---@field ResetWeaponAbility fun() Resets weapon ability
    ---@field InitRacialTab fun() Initializes racial tab
    ---@field ShutdownRacialTab fun() Shuts down racial tab
    ---@field UpdateRacialTab fun() Updates racial tab
    ---@field ItemMouseOver fun() Handles item mouse over
    ---@field ItemLButtonDown fun() Handles item left button down
    ---@field ItemLButtonUp fun() Handles item left button up

    ---@class CharacterSheet
    ---@field StatsSize integer Number of stats
    ---@field Stats string[] List of stat names
    ---@field Caps table Table of stat caps
    ---@field CapsBonus table Table of stat cap bonuses
    ---@field Groups table Table of stat groups
    ---@field CurrentGroup integer Current group index
    ---@field TID table Table of TID values
    ---@field Separators table Table of separators for stats
    ---@field Attributes table Table of attribute indices
    ---@field Initialize fun() Initializes the character sheet window
    ---@field Shutdown fun() Shuts down the character sheet window
    ---@field SetMiniIconStats fun(iconWindow: string, iconId: integer) Sets mini icon stats
    ---@field OnShown fun() Handles window shown event
    ---@field OnHidden fun() Handles window hidden event
    ---@field UpdateStatus fun() Updates status
    ---@field SetStatLock fun(stat: string) Sets stat lock
    ---@field ClickStatLock fun() Handles stat lock click
    ---@field StatLButtonDown fun(flags: integer) Handles stat left button down
    ---@field UpdateSpecialStats fun() Updates special stats
    ---@field HealthStaminaManaBonus fun(which: string): string Gets health/stamina/mana bonus
    ---@field StrDexIntBonus fun(which: string): string Gets str/dex/int bonus
    ---@field HideAllButFirstGroups fun() Hides all but first groups
    ---@field ShowActiveAndFirstGroups fun() Shows active and first groups
    ---@field LeftArrowPressed fun() Handles left arrow pressed
    ---@field RightArrowPressed fun() Handles right arrow pressed
    ---@field SetGroupLabel fun() Sets group label
    ---@field ValidateGroup fun() Validates group
    ---@field StatMouseOver fun() Handles stat mouse over
    ---@field LockMouseOver fun() Handles lock mouse over

    ---@class ColorPickerWindow
    ---@field numColorsPerRow integer Number of colors per row
    ---@field swatchSize integer Swatch size
    ---@field colorTables table Table of color tables
    ---@field colorSelected table Table of selected colors
    ---@field frameEnabled boolean Whether frame is enabled
    ---@field closeButtonEnabled boolean Whether close button is enabled
    ---@field xPadding integer X padding
    ---@field yPadding integer Y padding
    ---@field Initialize fun() Initializes the color picker window
    ---@field SetColorTable fun(colorTable: table, parent: string) Sets color table
    ---@field SetNumColorsPerRow fun(numColorsPerRow: integer) Sets number of colors per row
    ---@field SetSwatchSize fun(newSize: integer) Sets swatch size
    ---@field SetWindowPadding fun(x: integer, y: integer) Sets window padding
    ---@field SetFrameEnabled fun(enabled: boolean) Sets frame enabled
    ---@field SetCloseButtonEnabled fun(enabled: boolean) Sets close button enabled
    ---@field DrawColorTable fun(parent: string) Draws color table
    ---@field SelectColor fun(win: string, hue: integer) Selects color
    ---@field SetColor fun() Sets color
    ---@field AfterColorSelectionFunction fun(parent: string) Function after color selection
    ---@field SetAfterColorSelectionFunction fun(funcCall: function) Sets after color selection function
    ---@field ClearWindow fun(parent: string) Clears window
    ---@field SetHue fun(hueNumber: integer, parent: string) Sets hue

    ---@class Compass
    ---@field WindowName string Name of the compass window
    ---@field Needle string Name of the needle
    ---@field Label string Name of the label
    ---@field MagnetPoint table Magnet point data
    ---@field delta number Delta value
    ---@field Initialize fun() Initializes the compass window
    ---@field Shutdown fun() Shuts down the compass window
    ---@field Close fun() Closes the compass window
    ---@field Magnetize fun(timepassed: number) Handles magnetize logic

    ---@class ContainersInfo
    ---@field DefaultGump integer Default gump ID for containers
    ---@field DefaultCorpse integer Default gump ID for corpses
    ---@field Data table Table of container data (name, ItemsId, GumpId, Texture)
    ---@field LegacyContentLabelLocation table Table of legacy content label locations
    ---@field GetGump fun(id: integer, defaultGump: integer): integer, string|nil, string|nil Gets the gump ID, name, and texture for a container

    ---@class ContainerWindow
    ---@field OpenContainers table Table of open containers
    ---@field RegisteredItems table Table of registered items
    ---@field ViewModes table Table of view modes
    ---@field DEFAULT_START_POSITION table Default start position
    ---@field MAX_VALUES table Maximum values
    ---@field POSITION_OFFSET integer Position offset
    ---@field TimePassedSincePickUp number Time since last pickup
    ---@field CanPickUp boolean Whether items can be picked up
    ---@field TID_GRID_MODE integer TID for grid mode
    ---@field TID_FREEFORM_MODE integer TID for freeform mode
    ---@field TID_LIST_MODE integer TID for list mode
    ---@field ScrollbarWidth integer Scrollbar width
    ---@field Grid table Grid settings
    ---@field List table List settings
    ---@field MAX_INVENTORY_SLOTS integer Max inventory slots
    ---@field MAX_BANK_SLOTS integer Max bank slots
    ---@field CHESS_GUMP integer Chess gump ID
    ---@field BACKGAMMON_GUMP integer Backgammon gump ID
    ---@field PLAGUE_BEAST_GUMP integer Plague beast gump ID
    ---@field Cascade table Cascade settings
    ---@field PlayerBackpack integer Player backpack ID
    ---@field PlayerBank integer Player bank ID
    ---@field IgnoreItems table Items to ignore
    ---@field OpenedCorpse integer Opened corpse ID
    ---@field DeltaRefresh number Delta refresh value
    ---@field delta number Delta value
    ---@field Locked boolean Whether the window is locked
    ---@field BaseGridColor table Base grid color
    ---@field AlternateBackpack table Alternate backpack color
    ---@field LastUsesDelta table Last uses delta
    ---@field CurrentUses table Current uses
    ---@field ItemContainerMap table Item container map
    ---@field ShortUsesDelta number Short uses delta
    ---@field TODO table TODO items
    ---@field EnableAutoIgnoreCorpses boolean Whether to auto-ignore corpses
    ---@field RefreshRate number Refresh rate
    ---@field MaxSlotsPerGrid integer Max slots per grid
    ---@field PickupWaitTime number Pickup wait time
    ---@field LootAll table Loot all settings
    ---@field SUEDE_BACKPACK integer Suede backpack ID
    ---@field POLAR_BEAR_BACKPACK integer Polar bear backpack ID
    ---@field GHOUL_SKIN_BACKPACK integer Ghoul skin backpack ID
    ---@field ReleaseRegisteredObjects fun(id: integer) Releases registered objects for a container
    ---@field ReleaseRegisteredObjectsByID fun(id: integer, containerID: integer) Releases registered objects by ID
    ---@field SetLegacyContainer fun(gumpID: integer, windowID: integer) Sets legacy container art
    ---@field Initialize fun() Initializes the container window
    ---@field Shutdown fun() Shuts down the container window
    ---@field LegacyGridDock fun(this: string) Docks the grid for legacy containers
    ---@field SearchItem fun() Initiates a search in the container
    ---@field SearchAllTooltip fun() Shows tooltip for search all
    ---@field LootAllBtn fun() Handles loot all button
    ---@field LootAllTooltip fun() Shows tooltip for loot all
    ---@field LockTooltip fun() Shows tooltip for lock
    ---@field OrganizerContext fun() Shows organizer context menu
    ---@field ContextMenuCallback fun(returnCode: any, param: any) Handles context menu callback
    ---@field Organizes fun() Handles organize action
    ---@field OrganizeTargetInfoReceived fun() Handles target info for organize
    ---@field OrganizeTooltip fun() Shows tooltip for organize
    ---@field RestockContext fun() Shows restock context menu
    ---@field RestockContextMenuCallback fun(returnCode: any, param: any) Handles restock context menu callback
    ---@field RestockTooltip fun() Shows tooltip for restock
    ---@field Restocks fun() Handles restock action
    ---@field RestockTargetInfoReceived fun() Handles target info for restock
    ---@field Lock fun() Toggles the locked state
    ---@field OnSetMoving fun(isMoving: boolean) Handles moving the window
    ---@field SetInventoryButtonPressed fun(pressed: boolean) Sets inventory button pressed state
    ---@field HideAllContents fun(parent: string, numItems: integer) Hides all contents
    ---@field CreateListViewSlots fun(dialog: string, low: integer, high: integer) Creates list view slots
    ---@field MiniModelUpdate fun() Updates mini model
    ---@field BackpackItemsCheck fun() Checks backpack items
    ---@field UpdateContents fun(id: integer, forceUpdate: boolean) Updates container contents
    ---@field GetContent fun(contId: integer): string Gets content description
    ---@field ScanSubCont fun(id: integer, allItems: table, itemsOnly: boolean): table, integer, integer Scans subcontainers
    ---@field ScanQuantities fun(backpackId: integer, itemsOnly: boolean): table, integer, integer Scans item quantities
    ---@field HandleUpdateObjectEvent fun() Handles update object event
    ---@field UpdateObject fun(windowName: string, updateId: integer) Updates an object in the container
    ---@field UpdateUses fun(id: integer) Updates uses for items
    ---@field UpdateUsesByID fun(objectId: integer) Updates uses by object ID
    ---@field GetUses fun(objectId: integer, contId: integer): any Gets uses for an object
    ---@field ToggleView fun() Toggles between grid and list view
    ---@field GetSlotNumFromGridIndex fun(containerId: integer, gridIndex: integer): integer Gets slot number from grid index
    ---@field OnItemClicked fun(flags: integer) Handles item click
    ---@field OnItemRelease fun() Handles item release

    ---@class CraftingWindow
    ---@field index table Index table for recipes and categories
    ---@field MainGump integer Main gump ID
    ---@field InfoGump integer Info gump ID
    ---@field MaterialBase1 integer Material base 1
    ---@field MaterialBase2 integer Material base 2
    ---@field MakeLastButtonID integer Make last button ID
    ---@field MakeCancelButtonID integer Make cancel button ID
    ---@field InfoBackButtonID integer Info back button ID
    ---@field EnhanceButtonID integer Enhance button ID
    ---@field MaterialUseColor1Toggle integer Material use color 1 toggle
    ---@field MaterialUseColor2Toggle integer Material use color 2 toggle
    ---@field MarkButtonID integer Mark button ID
    ---@field MarkItemButtonToggle integer Mark item button toggle
    ---@field QuestMarkButtonToggle integer Quest mark button toggle
    ---@field MakeLastButtonToggle integer Make last button toggle
    ---@field MakeOneButtonToggle integer Make one button toggle
    ---@field MakeMaxButtonToggle integer Make max button toggle
    ---@field MakeNumButtonToggle integer Make num button toggle
    ---@field MaxMakeNum integer Max number allowed in make number box
    ---@field RecycleButtonID integer Recycle button ID
    ---@field RepairButtonID integer Repair button ID
    ---@field AlterItemButtonID integer Alter item button ID
    ---@field numRecipes integer Number of recipes
    ---@field numCategories integer Number of categories
    ---@field itemList table Item list
    ---@field numItems integer Number of items
    ---@field selectedRecipe integer Selected recipe
    ---@field MaterialSelection boolean Material selection
    ---@field CraftingType integer Crafting type
    ---@field lastRecipeTID integer Last recipe TID
    ---@field statusValues table Status values
    ---@field buttonFlags table Button flags
    ---@field buttonText table Button text
    ---@field ActionButtonsInRow integer Action buttons in row
    ---@field previousRecipe any Previous recipe
    ---@field MaterialItemIndex table Material item index
    ---@field firstMaterial1 table First material 1
    ---@field lastMaterial1 table Last material 1
    ---@field firstMaterial2 table First material 2
    ---@field lastMaterial2 table Last material 2
    ---@field MenuTitleTID table Menu title TIDs
    ---@field CSVFilenames table CSV filenames
    ---@field categoriesPerCraft table Categories per craft
    ---@field categoryButtonIds table Category button IDs
    ---@field RequestedTileArt table Requested tile art
    ---@field windowName string|nil Name of the crafting window
    ---@field descData table|nil Description data from the server
    ---@field descDataCount integer|nil Count of description data
    ---@field buttonIDs table|nil Button IDs
    ---@field buttonCount integer|nil Button count
    ---@field stringData table|nil String data
    ---@field StringDataCount integer|nil String data count
    ---@field localizedData table|nil Localized data
    ---@field localizedDataCount integer|nil Localized data count
    ---@field gumpID integer|nil Gump ID
    ---@field Initialize fun() Initializes the crafting window
    ---@field InitializeMainWindow fun() Initializes the main crafting window
    ---@field SetIcon fun(window: string, obj: integer, hue: integer) Sets the icon for a window
    ---@field AddRecipe fun(text: any, recipeNum: integer, iconNum: integer) Adds a recipe to the window
    ---@field SetupMaterialSelection fun(matType: integer) Sets up material selection UI
    ---@field AddCategory fun(text: any) Adds a category to the window
    ---@field Show fun() Shows the crafting window
    ---@field parseItems fun() Parses items from button IDs
    ---@field parseStatusTIDs fun() Parses status TIDs from description data
    ---@field OnItemClicked fun() Handles item click events
    ---@field OnItemDblClicked fun() Handles item double-click events
    ---@field OnCategoryClicked fun() Handles category click events
    ---@field OnActionClicked fun() Handles action button click events
    ---@field SendServerButtonInfo fun(buttonNumber: integer, window: any) Sends button info to the server
    ---@field OnDefaultClicked fun(buttonNum: integer) Handles default button click
    ---@field Shutdown fun() Shuts down the crafting window
    ---@field DestroyWindow fun(myWindowName: string|nil) Destroys the crafting window
    ---@field ItemMouseOver fun() Handles mouse over on an item
    ---@field ApplyFilter fun() Applies a filter to the recipe list
    ---@field ToggleCheckBox fun() Toggles a checkbox in the UI
    ---@field SelectMaterial fun() Handles material selection
    ---@field InitializeInfoWindow fun() Initializes the info window
    ---@field ClearInfoWindow fun() Clears the info window
    ---@field RefreshInfoWindow fun() Refreshes the info window
    ---@field SetInfoLabel fun(num: number) Sets the info label text
    ---@field OnMakeNumTextChanged fun() Handles changes to the make number text box

    ---@class CraftingWindow2
    ---@field parsedText table Parsed text for the crafting window
    ---@field recipeRec table Recipe record for the current recipe
    ---@field recipeID integer Current recipe ID
    ---@field colorable boolean Whether the item is colorable
    ---@field skillTIDs table Skill TID mappings
    ---@field RequestedTileArt table Requested tile art
    ---@field windowName string|nil Name of the crafting info window
    ---@field descData table|nil Description data from the server
    ---@field descDataCount integer|nil Count of description data
    ---@field buttonIDs table|nil Button IDs
    ---@field buttonCount integer|nil Button count
    ---@field stringData table|nil String data
    ---@field stringDataCount integer|nil String data count
    ---@field gumpID integer|nil Gump ID
    ---@field Initialize fun() Initializes the crafting info window
    ---@field SetIcon fun(window: string, obj: integer) Sets the icon for a window
    ---@field findRecipeRecord fun() Finds the recipe record for the current recipe
    ---@field MakeMaterialString fun(matIdx: integer): string, string Creates a material string for the given index
    ---@field parseTIDs fun() Parses TIDs for the crafting window
    ---@field OnActionClicked fun() Handles action button click events
    ---@field SendServerButtonInfo fun(buttonNumber: integer, window: any) Sends button info to the server
    ---@field OnDefaultClicked fun(buttonNum: integer) Handles default button click
    ---@field Shutdown fun() Shuts down the crafting info window
    ---@field DestroyWindow fun(myWindowName: string) Destroys the crafting info window

    ---@class CreaturesDB
    ---@field [string] table Table of creature data indexed by creature name. Each entry is a table with properties such as slayers, oppositeslayers, barddiff, resistances, stats, skills, and other attributes.

    ---@class CSVUtilities
    ---@field getNumRows fun(CSVTable: table): integer Gets the number of rows in a CSV table
    ---@field getRowIdWithColumnValue fun(CSVTable: table, columnName: string, columnValue: any): integer|nil Gets the row ID with a column value

    ---@class CrystalPortal
    ---@field WindowName string Name of the crystal portal window
    ---@field Trammel table Trammel facet data (dungeons, moongates, banks)
    ---@field Felucca table Felucca facet data (dungeons, moongates, banks)
    ---@field NoWind boolean Whether wind is disabled
    ---@field LastSelection integer Last selection index
    ---@field LastMap integer Last map index
    ---@field LastArea integer Last area index
    ---@field currentBase table Current base data
    ---@field Initialize fun() Initializes the crystal portal window
    ---@field Shutdown fun() Shuts down the crystal portal window
    ---@field OnShown fun() Handles the window being shown
    ---@field CheckEnable fun() Checks and enables UI elements based on state
    ---@field GO fun() Handles the "Go" action for the portal
    ---@field LabelOnMouseOver fun() Handles mouse over on labels
    ---@field Toggle fun() Toggles the crystal portal window

    ---@class Debug
    ---@field Stringable table Table of stringable types
    ---@field PrintToChat fun(text: string) Prints text to chat
    ---@field PrintToDebugConsole fun(text: string) Prints text to debug console
    ---@field Print fun(text: any) Prints text to debug console or dumps table
    ---@field DumpToConsole fun(name: string, value: any, memo: table|nil) Dumps a value to the debug console
    ---@field Dump fun(name: string, value: any, memo: table|nil) Dumps a value (alias for DumpToConsole)

    ---@class DebugWindow
    ---@field logging boolean Whether logging is enabled
    ---@field Initialize fun() Initializes the debug window
    ---@field Shutdown fun() Shuts down the debug window
    ---@field ToggleLogging fun() Toggles logging
    ---@field OnResizeBegin fun() Handles resize begin event
    ---@field ToggleOptions fun() Toggles the options window
    ---@field UpdateDisplayFilter fun() Updates the display filter
    ---@field UpdateLuaErrorHandling fun() Updates Lua error handling
    ---@field UpdateCodeErrorHandling fun() Updates code error handling
    ---@field UpdateLoadLuaDebugLibrary fun() Updates loading of Lua debug library
    ---@field ReloadUIHover fun() Shows tooltip for reload UI button

    ---@class DamageWindow
    ---@field AttachedId table Table of attached IDs
    ---@field OverheadAlive integer Y position before disappearing
    ---@field OverheadMove integer Y movement per update
    ---@field FadeStart integer Fade start value
    ---@field FadeDiff number Fade difference per update
    ---@field DefaultAnchorY integer Default Y anchor
    ---@field ShiftYAmount integer Amount to shift Y
    ---@field MaxAnchorYOverlap integer Max Y overlap
    ---@field AnchorY table Table of Y anchors
    ---@field DamageArray table Table of damage values
    ---@field LastDamaged integer Last damaged ID
    ---@field waitSpecialDamage any Waiting special damage
    ---@field lastSpecialWaiting any Last special waiting
    ---@field OTHERGETDAMAGE_COLOR table Color for other damage
    ---@field YOUGETAMAGE_COLOR table Color for player damage
    ---@field PETGETDAMAGE_COLOR table Color for pet damage
    ---@field Initialize fun() Initializes the damage window
    ---@field Init fun() Creates a new window for a mobile ID and sets label text
    ---@field GetNextId fun() Gets the next available window ID
    ---@field AddText fun(mobileId: integer, text: any) Adds text to the damage window
    ---@field ShiftYWindowUp fun() Shifts previous damage numbers up
    ---@field IsOverlap fun() Checks if damage numbers overlap
    ---@field UpdateTime fun(UpdateInterfaceTime: any) Updates the time and position of damage numbers

    ---@class DragWindow
    ---@field CurrentItem table Current item being dragged
    ---@field Initialize fun() Initializes the drag window
    ---@field Shutdown fun() Shuts down the drag window
    ---@field Update fun() Updates the drag window position and state

    ---@class FaceSelectionWindow
    ---@field TID table Table of TID values
    ---@field faceStyles table Table of face styles
    ---@field faceStyle any Current face style
    ---@field FaceIndex integer Current face index
    ---@field maxFaceTypes integer|nil Maximum number of face types
    ---@field paperdollWindowWasShown boolean Whether the paperdoll window was shown
    ---@field paperdollId integer|nil Paperdoll ID
    ---@field paperdollWindowName string|nil Paperdoll window name
    ---@field HUMAN integer Constant for human race
    ---@field ELF integer Constant for elf race
    ---@field GARGOYLE integer Constant for gargoyle race
    ---@field Initialize fun() Initializes the face selection window
    ---@field Shutdown fun() Shuts down the face selection window
    ---@field ToggleFaceUp fun() Toggles face up
    ---@field ToggleFaceDown fun() Toggles face down
    ---@field UpdateFaceLabel fun() Updates the face label
    ---@field OK fun() Confirms face selection
    ---@field Cancel fun() Cancels face selection
    ---@field createWearableTable fun(CSVTable: table): table Creates a wearable table from CSV
    ---@field revertPaperdollWindowViewState fun() Reverts the paperdoll window view state

    ---@class FontSelector
    ---@field Selection string Current font selection
    ---@field RunicFontItem string Runic font item
    ---@field Fonts table Table of available fonts
    ---@field Initialize fun() Initializes the font selector
    ---@field OnShown fun() Handles the font selector being shown
    ---@field Shutdown fun() Shuts down the font selector
    ---@field SetFontToSelection fun() Sets the font to the current selection
    ---@field CloseFontWindow fun() Closes the font window
    ---@field ItemMouseOver fun() Handles mouse over on a font item
    ---@field ClearMouseOverItem fun() Clears mouse over on a font item

    ---@class GenericQuantity
    ---@field maxAmount integer Maximum amount allowed
    ---@field Initialize fun() Initializes the generic quantity window
    ---@field HandleAnchorWindow fun(genericWindow: string) Handles window anchoring
    ---@field Shutdown fun() Shuts down the generic quantity window
    ---@field OnKeyEscape fun() Handles escape key
    ---@field OnKeyEnter fun() Handles enter key
    ---@field OnTextChanged fun() Handles text change
    ---@field UpdateQuantity fun() Updates the quantity
    ---@field OnOkay fun() Handles okay action
    ---@field OnCancel fun() Handles cancel action

    ---@class GChatRoster
    ---@field RemoveGChatIndex integer Remove GChat index
    ---@field TID table Table of TID values
    ---@field GC_SHOW_UNAVAILABLE integer Constant for unavailable status
    ---@field GC_SHOW_CHAT integer Constant for chat status
    ---@field Presence table Table of presence statuses
    ---@field NUM_PRESENCE integer Number of presence statuses
    ---@field DEFAULT_START_POSITION table Default start position
    ---@field Initialize fun() Initializes the GChat roster
    ---@field Shutdown fun() Shuts down the GChat roster
    ---@field OnGChatRosterUpdate fun() Handles GChat roster update
    ---@field OnGChatPresenceUpdate fun() Handles GChat presence update
    ---@field RemoveTooltip fun() Shows remove tooltip
    ---@field OnlineTooltip fun() Shows online tooltip
    ---@field OfflineTooltip fun() Shows offline tooltip
    ---@field SelectActiveFriend fun(override: any) Selects the active friend
    ---@field UpdateFriendPresence fun() Updates friend presence
    ---@field RemoveFriend fun() Removes a friend
    ---@field OnAddFriend fun() Handles add friend action
    ---@field OnPresenceChange fun() Handles presence change

    ---@class Cooldown
    ---@field Frames integer Number of cooldown frames
    ---@field Initialize fun() Initializes the cooldown window

    ---@class CourseMapWindow
    ---@field X_PADDING integer X padding for the window
    ---@field Y_PADDING integer Y padding for the window
    ---@field X_MAPPOINT_PADDING integer X padding for map points
    ---@field Y_MAPPOINT_PADDING integer Y padding for map points
    ---@field NumPointsCreated table Table tracking number of points created per map
    ---@field MapPoints table Table of map points per map
    ---@field DragMapPoint string Name of the map point being dragged
    ---@field WINDOWSCALE number Window scale factor
    ---@field TID table Table of TID values
    ---@field TreasureMaps table Table of treasure map TIDs
    ---@field isTmap boolean Whether the map is a treasure map
    ---@field Initialize fun() Initializes the course map window
    ---@field Shutdown fun() Shuts down the course map window
    ---@field OnUpdate fun() Handles update events for the window
    ---@field UpdatePoints fun() Updates the map points
    ---@field UpdateState fun() Updates the plotting state
    ---@field Map_OnLButtonDown fun() Handles left button down on the map
    ---@field Map_OnLButtonUp fun(flags: any, x: number, y: number) Handles left button up on the map
    ---@field PlotToggle_OnLButtonUp fun() Handles plot toggle button click
    ---@field ClearCourse_OnLButtonUp fun() Handles clear course button click
    ---@field MapPoint_OnLButtonDown fun() Handles left button down on a map point

    ---@class EquipmentData
    ---@field EQPOS_DRAG integer Drag position constant
    ---@field EQPOS_RIGHTHAND integer Right hand position constant
    ---@field EQPOS_LEFTHAND integer Left hand position constant
    ---@field EQPOS_FEET integer Feet position constant
    ---@field EQPOS_LEGS integer Legs position constant
    ---@field EQPOS_TORSO integer Torso position constant
    ---@field EQPOS_HEAD integer Head position constant
    ---@field EQPOS_HANDS integer Hands position constant
    ---@field EQPOS_FINGER1 integer Finger1 position constant
    ---@field EQPOS_TALISMAN integer Talisman position constant
    ---@field EQPOS_NECK integer Neck position constant
    ---@field EQPOS_HAIR integer Hair position constant
    ---@field EQPOS_WAIST integer Waist position constant
    ---@field EQPOS_CHEST integer Chest position constant
    ---@field EQPOS_LWRIST integer Left wrist position constant
    ---@field EQPOS_RWRIST integer Right wrist position constant
    ---@field EQPOS_FACIALHAIR integer Facial hair position constant
    ---@field EQPOS_ABOVECHEST integer Above chest position constant
    ---@field EQPOS_EARS integer Ears position constant
    ---@field EQPOS_ARMS integer Arms position constant
    ---@field EQPOS_CAPE integer Cape position constant
    ---@field EQPOS_BACKPACK integer Backpack position constant
    ---@field EQPOS_DRESS integer Dress position constant
    ---@field EQPOS_SKIRT integer Skirt position constant
    ---@field EQPOS_FEETLEGS integer Feet/legs position constant
    ---@field EQPOS_RIDING integer Riding position constant
    ---@field EQPOS_MAX integer Max position constant
    ---@field EQPOS_SELLS integer Sells position constant
    ---@field EQPOS_INVENT integer Inventory position constant
    ---@field EQPOS_BUYS integer Buys position constant
    ---@field EQPOS_BANK integer Bank position constant
    ---@field EQPOS_SHOP_MAX integer Shop max position constant
    ---@field WEAPONABILITY_PRIMARY integer Primary weapon ability constant
    ---@field WEAPONABILITY_SECONDARY integer Secondary weapon ability constant
    ---@field WEAPONABILITY_ABILITYOFFSET integer Weapon ability offset constant
    ---@field RegisteredAbilityIcons table Table of registered ability icons
    ---@field CurrentWeaponAbilities table Table of current weapon abilities
    ---@field Initialize fun() Initializes equipment data
    ---@field Shutdown fun() Shuts down equipment data
    ---@field UpdateAbilityIcon fun(iconWindow: string, moveId: integer) Updates the ability icon
    ---@field RegisterWeaponAbilitySlot fun(iconWindow: string, type: integer) Registers a weapon ability slot
    ---@field UnregisterWeaponAbilitySlot fun(iconWindow: string) Unregisters a weapon ability slot
    ---@field UpdateWeaponAbilities fun(initialize: boolean|nil) Updates weapon abilities
    ---@field ActivateAbility fun() Activates a weapon ability
    ---@field ResetAbility fun() Resets weapon abilities
    ---@field UpdateItemIcon fun(elementIcon: string, item: table) Updates an item icon
    ---@field GetWeaponAbilityId fun(index: integer): integer Gets the weapon ability ID

    ---@class HealthBarColor
    ---@field HealthVisualState table Table of health visual states
    ---@field BarColor table Table of bar colors
    ---@field UpdateHealthBarColor fun(windowTintName: string, visualStateId: integer) Updates the health bar color

    ---@class CustomizeHouseWindow
    ---@field currentWindowNum integer Current window number for dynamic icon names
    ---@field currentStory integer Current story being edited
    ---@field doors any Doors data
    ---@field floors any Floors data
    ---@field misc any Miscellaneous data
    ---@field roofs any Roofs data
    ---@field stairs any Stairs data
    ---@field walls any Walls data
    ---@field teleporters any Teleporters data
    ---@field multiID table Table of multi tile IDs
    ---@field entitlements table Table of entitlements
    ---@field entitlementTIDs table Table of entitlement TIDs
    ---@field roofZOffset integer Roof Z offset
    ---@field MIN_NUM_OF_STORIES integer Minimum number of stories
    ---@field MAX_NUM_OF_STORIES integer Maximum number of stories
    ---@field MIN_ROOF_Z_OFFSET integer Minimum roof Z offset
    ---@field MAX_ROOF_Z_OFFSET integer Maximum roof Z offset
    ---@field TILE_PLACEMENT_MODE integer Tile placement mode
    ---@field ERASE_MODE integer Erase mode
    ---@field EYE_DROPPER_MODE integer Eye dropper mode
    ---@field TILE_TYPE_NONE integer Tile type none
    ---@field TILE_TYPE_STAIRS integer Tile type stairs
    ---@field TILE_TYPE_ROOF integer Tile type roof
    ---@field TILE_TYPE_DOOR integer Tile type door
    ---@field TILE_TYPE_FLOOR integer Tile type floor
    ---@field TILE_TYPE_WALL integer Tile type wall
    ---@field TILE_TYPE_TELEPORTERS integer Tile type teleporters
    ---@field TILE_TYPE_MISC integer Tile type misc
    ---@field NUM_OF_TILE_TYPE integer Number of tile types
    ---@field SYS_MSG_BACKUP integer System message backup
    ---@field SYS_MSG_RESTORE integer System message restore
    ---@field SYS_MSG_SYNC integer System message sync
    ---@field SYS_MSG_CLEAR integer System message clear
    ---@field SYS_MSG_COMMIT integer System message commit
    ---@field SYS_MSG_REVERT integer System message revert
    ---@field BUTTON_TID_BACKUP integer Button TID backup
    ---@field BUTTON_TID_COMMIT integer Button TID commit
    ---@field BUTTON_TID_RESTORE integer Button TID restore
    ---@field BUTTON_TID_SYNCH integer Button TID synch
    ---@field BUTTON_TID_CLEAR integer Button TID clear
    ---@field BUTTON_TID_REVERT integer Button TID revert
    ---@field DOOR_SWING_DIRECTION_ICONS table Table of door swing direction icons
    ---@field TOOLTIP_TID_WALLS integer Tooltip TID for walls
    ---@field TOOLTIP_TID_DOORS integer Tooltip TID for doors
    ---@field TOOLTIP_TID_FLOORS integer Tooltip TID for floors
    ---@field TOOLTIP_TID_STAIRS integer Tooltip TID for stairs
    ---@field TOOLTIP_TID_TELEPORTERS integer Tooltip TID for teleporters
    ---@field TOOLTIP_TID_ROOFS integer Tooltip TID for roofs
    ---@field TOOLTIP_TID_MISC integer Tooltip TID for misc
    ---@field TOOLTIP_TID_ERASE integer Tooltip TID for erase
    ---@field TOOLTIP_TID_EYEDROP integer Tooltip TID for eyedropper
    ---@field TOOLTIP_TID_SYSTEM integer Tooltip TID for system
    ---@field TOOLTIP_TID_CATEGORY integer Tooltip TID for category
    ---@field TOOLTIP_TID_WINDOWS integer Tooltip TID for windows
    ---@field TOOLTIP_TID_VISIBILITY integer Tooltip TID for visibility
    ---@field TOOLTIP_TID_STORY_VIS1 integer Tooltip TID for story visibility 1
    ---@field TOOLTIP_TID_STORY_VIS2 integer Tooltip TID for story visibility 2
    ---@field TOOLTIP_TID_STORY_VIS3 integer Tooltip TID for story visibility 3
    ---@field TOOLTIP_TID_STORY_VIS4 integer Tooltip TID for story visibility 4
    ---@field TOOLTIP_TID_STORY1 integer Tooltip TID for story 1
    ---@field TOOLTIP_TID_STORY2 integer Tooltip TID for story 2
    ---@field TOOLTIP_TID_STORY3 integer Tooltip TID for story 3
    ---@field TOOLTIP_TID_STORY4 integer Tooltip TID for story 4
    ---@field TOOLTIP_TID_HELP integer Tooltip TID for help
    ---@field TOOLTIP_TID_PRICE integer Tooltip TID for price
    ---@field TOOLTIP_TID_COMPONENTS integer Tooltip TID for components
    ---@field TOOLTIP_TID_FIXTURES integer Tooltip TID for fixtures
    ---@field TOOLTIP_TID_ROOF_LEVEL integer Tooltip TID for roof level
    ---@field TOOLTIP_TID_BACKUP integer Tooltip TID for backup
    ---@field TOOLTIP_TID_COMMIT integer Tooltip TID for commit
    ---@field TOOLTIP_TID_RESTORE integer Tooltip TID for restore
    ---@field TOOLTIP_TID_SYNCH integer Tooltip TID for synch
    ---@field TOOLTIP_TID_CLEAR integer Tooltip TID for clear
    ---@field TOOLTIP_TID_REVERT integer Tooltip TID for revert
    ---@field TOOLTIP_TID_ROOF integer Tooltip TID for roof
    ---@field TOOLTIP_TID_RAISE_ROOF_LEVEL integer Tooltip TID for raise roof level
    ---@field TOOLTIP_TID_LOWER_ROOF_LEVEL integer Tooltip TID for lower roof level
    ---@field NOT_ENTITLED table Color for not entitled
    ---@field Initialize fun() Initializes the customize house window
    ---@field getDoorSwingDirectionIcon fun(categoryID: integer, iconIndex: integer): string, string, integer Gets the door swing direction icon
    ---@field displayRoofButtons fun(shouldDisplay: boolean) Displays roof buttons
    ---@field Update fun() Updates the customize house window
    ---@field ForceTileSelection fun() Forces tile selection
    ---@field readAllTileData fun() Reads all tile data
    ---@field insertIcon fun(tileTable: table, iconIndex: integer, iconID: integer) Inserts an icon
    ---@field createTileStruct fun(tileType: integer): table Creates a tile structure
    ---@field OnIconSelected fun() Handles icon selection
    ---@field displayCategory fun(categoryID: integer) Displays a category
    ---@field placeTile fun(tileID: integer) Places a tile
    ---@field HandlePreviousButton fun() Handles previous button
    ---@field HandleTileTypeButton fun(tileType: integer) Handles tile type button
    ---@field HandleWallsButton fun() Handles walls button
    ---@field HandleDoorsButton fun() Handles doors button
    ---@field HandleFloorsButton fun() Handles floors button
    ---@field HandleStairsButton fun() Handles stairs button
    ---@field HandleRoofsButton fun() Handles roofs button
    ---@field HandleMiscButton fun() Handles misc button
    ---@field HandleTeleportersButton fun() Handles teleporters button
    ---@field HandleEraseButton fun() Handles erase button
    ---@field HandleEyeDropperButton fun() Handles eyedropper button
    ---@field HandleBackupButton fun() Handles backup button
    ---@field HandleRestoreButton fun() Handles restore button
    ---@field HandleSynchButton fun() Handles synch button
    ---@field HandleClearButton fun() Handles clear button
    ---@field HandleCommitButton fun() Handles commit button
    ---@field HandleRevertButton fun() Handles revert button
    ---@field SetStoryButtonPressed fun(storyNum: integer, isPressed: boolean) Sets story button pressed
    ---@field HandleChangeStoryButton fun() Handles change story button
    ---@field ToggleVisibilityWindow fun() Toggles visibility window
    ---@field HandleRoofUpButton fun() Handles roof up button
    ---@field HandleRoofDownButton fun() Handles roof down button
    ---@field insertDynamicImage fun(dynamicImage: string, portraitNum: integer, forceScale: number|nil): string, integer, integer Inserts a dynamic image
    ---@field findMaxScale fun(icons: table): number Finds the maximum scale
    ---@field displayIcons fun(category: table): table Displays icons
    ---@field ScrollToIconInHorizontalScrollWindow fun(iconID: integer) Scrolls to icon in horizontal scroll window
    ---@field turnOnFrameAroundWindow fun(icon: string) Turns on frame around window
    ---@field turnOffFrameAroundWindow fun(icon: string) Turns off frame around window
    ---@field OnMouseOver fun() Handles mouse over
    ---@field deleteIcons fun(windowNames: table) Deletes icons
    ---@field OnCloseWindow fun() Handles close window
    ---@field Shutdown fun() Shuts down the customize house window

    ---@class CustomizeHouseVisibility
    ---@field SHOWING integer Constant for showing
    ---@field TRANSLUCENT integer Constant for translucent
    ---@field HIDDEN integer Constant for hidden
    ---@field NUM_OF_VISIBILITY_OPTIONS integer Number of visibility options
    ---@field TILE_TYPE_NAMES table Table of tile type names
    ---@field TILE_TYPE_TIDS table Table of tile type TIDs
    ---@field OPTION_NAMES table Table of option names
    ---@field OPTION_TIDS table Table of option TIDs
    ---@field STORY_TID table Table of story TIDs
    ---@field windowName string|nil Name of the visibility window
    ---@field numOfStories integer Number of stories
    ---@field story table Table of story visibility data
    ---@field displayedStory integer Currently displayed story
    ---@field Initialize fun() Initializes the visibility window
    ---@field SetNumOfStories fun(numOfStories: integer) Sets the number of stories
    ---@field SetCurrentStory fun(storyNum: integer) Sets the current story
    ---@field SetVisibility fun(storyNum: integer, tileType: integer, visibilityChoice: integer) Sets visibility
    ---@field HandleStoryChanged fun() Handles story changed
    ---@field HandleVisibilityChange fun() Handles visibility change
    ---@field Shutdown fun() Shuts down the visibility window

    ---@class GenericGump
    ---@field LastGump string Name of the last gump window
    ---@field LastGumpLabels table Table of last gump labels
    ---@field GumpsList table Table of gumps list
    ---@field Initialize fun() Initializes the generic gump
    ---@field OnLabelInit fun() Handles label initialization
    ---@field Shutdown fun() Shuts down the generic gump
    ---@field OnClicked fun() Handles gump click
    ---@field OnDoubleClicked fun() Handles gump double click
    ---@field OnRClicked fun() Handles gump right click
    ---@field OnMouseOver fun() Handles mouse over on gump
    ---@field OnHyperLinkClicked fun(link: any) Handles hyperlink click

    ---@class ContextMenu
    ---@field GREYEDOUT integer Flag for greyed out menu items
    ---@field SECONDTIER integer Flag for second tier menu items
    ---@field HIGHLIGHTED integer Flag for highlighted menu items
    ---@field HighlightColor table Color for highlighted items
    ---@field DisabledColor table Color for disabled items
    ---@field NormalColor table Color for normal items
    ---@field WINDOW_WIDTH integer Window width
    ---@field ITEM_WINDOW_WIDTH integer Item window width
    ---@field ITEM_WINDOW_HEIGHT integer Item window height
    ---@field ITEM_WINDOW_SPACING integer Item window spacing
    ---@field NumItemsCreated table Table tracking number of items created per menu
    ---@field IsLuaDriven boolean Whether the context menu is Lua-driven
    ---@field LuaMenuOptions table Table of Lua menu options
    ---@field LuaCallback fun(returnCode: any, param: any)|nil Callback for Lua-driven menu
    ---@field SubMenuDelayTimer number|nil Timer for submenu delay
    ---@field DefaultValues table Table of default context menu values
    ---@field CreateLuaContextMenuItem fun(tid: integer, flags: integer, returnCode: any, param: any, pressed: boolean, subMenuOptions: table|nil, subMenuDelay: number|nil, textColor: any|nil) Creates a Lua context menu item
    ---@field CreateLuaContextMenuItemWithString fun(str: string, flags: integer, returnCode: any, param: any, pressed: boolean, subMenuOptions: table|nil, subMenuDelay: number|nil, textColor: any|nil) Creates a Lua context menu item with a string
    ---@field ActivateLuaContextMenu fun(callback: fun(returnCode: any, param: any)) Activates a Lua-driven context menu
    ---@field GetMenuItemData fun(): table Gets the menu item data
    ---@field ExecuteMenuItem fun(returnCode: any, param: any) Executes a menu item
    ---@field Initialize fun() Initializes the context menu
    ---@field Show fun() Shows the context menu
    ---@field Hide fun() Hides the context menu
    ---@field CreateMenuItems fun(numItemsNeeded: integer, menuWindow: string) Creates menu items
    ---@field FillMenuItems fun(menuItems: table, menuWindow: string, submenuIndex: integer|nil): integer, integer Fills menu items and returns width and height
    ---@field HideAllItems fun(menuWindow: string) Hides all items in a menu
    ---@field MenuItemLButtonUp fun() Handles left button up on a menu item
    ---@field MenuItemLButtonDown fun() Handles left button down on a menu item
    ---@field Update fun(timePassed: number) Updates the context menu (for submenu delay)
    ---@field MenuItemMouseOver fun() Handles mouse over on a menu item
    ---@field MenuItemMouseLeave fun() Handles mouse leave on a menu item
    ---@field RequestContextAction fun(ownerId: any, actionId: any) Requests a context action

    ---@class GGManager
    ---@field NumOfGumps integer Number of gumps managed
    ---@field knownWindows table Map of window names to window data
    ---@field onCreateCallback table Map of window names to onCreate callback functions
    ---@field WindowName table Map of gump IDs to window names
    ---@field GumpName table Map of gump IDs to gump names
    ---@field WindowPositionGroup table Map of gump IDs to position groups
    ---@field DISPLAY_GUMPNOTFOUND boolean Whether to display missing gump debug info
    ---@field ASK_BETA_TESTERS_FOR_HELP boolean Whether to ask beta testers for help
    ---@field TELL_BETA_TESTERS_WE_KNOW boolean Whether to tell beta testers about known issues
    ---@field OKAY_TID integer TID for OK button
    ---@field CANCEL_TID integer TID for Cancel button
    ---@field ACCEPT_TID integer TID for Accept button
    ---@field REFUSE_TID integer TID for Refuse button
    ---@field RESIGN_TID integer TID for Resign button
    ---@field QUIT_TID integer TID for Quit button
    ---@field CLOSE_TID integer TID for Close button
    ---@field BACK_TID integer TID for Back button
    ---@field NEW_GUMP_HAS_BEEN_HANDLED boolean Constant for handled gump
    ---@field DELETE_DATA boolean Constant for deleting data
    ---@field DONT_DELETE_DATA_YET boolean Constant for not deleting data yet
    ---@field Initialize fun() Initializes the GGManager
    ---@field getAllKnownWindows fun(): table Returns all known windows
    ---@field getAllWindowsForID fun(gumpID: integer, objectID: integer|nil): table Returns all windows for a given gump ID and optional object ID
    ---@field registerWindow fun(windowName: string, windowData: table) Registers a window
    ---@field unregisterWindow fun(windowName: string) Unregisters a window
    ---@field unregisterActiveWindow fun() Unregisters the active window
    ---@field destroyWindow fun(windowName: string, shouldUnregister: boolean|nil) Destroys a window
    ---@field destroyActiveWindow fun(shouldUnregister: boolean|nil) Destroys the active window
    ---@field GGClose fun() Handles GG close event
    ---@field registerOnCreateCallback fun(windowName: string, fn: fun(): boolean) Registers an onCreate callback
    ---@field unregisterOnCreateCallback fun(windowName: string) Unregisters an onCreate callback
    ---@field GGArrived fun() Handles GG arrived event
    ---@field ConcatStringFromTID fun(TIDTable: table, spacer: any, beginIdx: integer, endIdx: integer): any Concatenates strings from TID table
    ---@field stripMarkup fun(str: any, replaceEmptyString: boolean): any Strips markup from a string
    ---@field translateTID fun(tid: any): any Translates a TID to a string
    ---@field BetaTesterHelpMessage fun(): any Returns the beta tester help message
    ---@field tableToString fun(data: table, spacing: any|nil): any Converts a table to a string for debugging
    ---@field convertToWString fun(value: any): any Converts a value to a wstring
    ---@field printTable fun(data: table, name: any) Prints a table for debugging
    ---@field GGParseData fun() Parses GG data

    ---@class GumpsParsing
    ---@field ParsedGumps table Table of parsed gumps
    ---@field ToShow table Table of gumps to show/hide
    ---@field SOSTids table Table of SOS TIDs
    ---@field GumpMaps table Table of gump mappings
    ---@field CheckGumpType fun(timePassed: any) Checks the gump type and processes gumps
    ---@field MainParsingCheck fun(timePassed: any) Main parsing check for gumps
    ---@field DestroyGump fun(gumpID: integer) Destroys a gump window
    ---@field PressButton fun(gumpID: integer, buttonID: integer) Presses a button on a gump
    ---@field TextentryGetText fun(gumpID: integer, TextentryID: integer): any Gets text from a text entry
    ---@field ShowHide fun(timePassed: any) Shows or hides gumps based on ToShow
    ---@field SixMonthsRewardGump fun() Handles the six months reward gump
    ---@field SOSGump fun(data: table) Handles SOS gump logic
    ---@field CreateSOSWaypoint fun(sosID: any, map: any, x: any, y: any) Creates a SOS waypoint
    ---@field GetSOSCoords fun(coords: any): number, any, number, any Gets SOS coordinates from a string

    ---@class HealthBarManager
    ---@field partyMemberIndex integer[] Indexes of party members
    ---@field MAX_PARTY_MEMBERS integer Maximum number of party members
    ---@field SpellSchools table Spell school IDs (MAGERY, CHIVALRY)
    ---@field UseSchool integer Currently used spell school
    ---@field CappedNumServerHealthBars integer Maximum number of server health bars
    ---@field NumHealthBars integer Current number of health bars
    ---@field LastHandledHealthBar integer Last handled health bar index
    ---@field Initialize fun() Initializes the health bar manager
    ---@field OnBeginDragHealthBar fun(id: integer) Handles the beginning of a health bar drag
    ---@field OnEndDragHealthBar fun() Handles the end of a health bar drag
    ---@field HandlePartyMemberUpdate fun() Updates party member health bars
    ---@field IsPartyMember fun(mobileId: integer): boolean Checks if a mobile is a party member
    ---@field GetMemberIndex fun(mobileId: integer): integer Gets the index of a party member by mobile ID
    ---@field SkillUpdate fun() Updates the spell school in use
    ---@field UpdateRemovedHealthBarCount fun(mobileId: integer) Updates the count when a health bar is removed

    ---@class HighlightEffect
    ---@field timer number Timer for highlight animation
    ---@field animStarted boolean Whether the animation has started
    ---@field windowName string Name of the window to highlight
    ---@field Initialize fun() Initializes a new highlight effect window
    ---@field new fun(NewWindow: table): HighlightEffect Creates a new HighlightEffect instance
    ---@field Init fun(self: HighlightEffect) Initializes the instance and registers window data
    ---@field Update fun(timePassed: number) Updates the highlight effect animation and logic
    ---@field OnCloseWindow fun() Handles closing the highlight effect window
    ---@field OnShutdown fun() Handles shutdown and cleanup of highlight effect data

    ---@class Hotbar
    ---@field NUM_BUTTONS integer Number of buttons on the hotbar
    ---@field CurrentUseSlot integer Currently used slot
    ---@field CurrentUseHotbar integer Currently used hotbar
    ---@field DarkItemLabel table Color for dark item label
    ---@field LightItemLabel table Color for light item label
    ---@field RecordingKey boolean Whether a key is being recorded
    ---@field RecordingSlot integer Slot being recorded
    ---@field RecordingHotbar integer Hotbar being recorded
    ---@field HANDLE_OFFSET integer Offset for the handle
    ---@field BUTTON_SIZE integer Size of each button
    ---@field TID_BINDING_CONFLICT_TITLE integer TID for binding conflict title
    ---@field TID_BINDING_CONFLICT_BODY integer TID for binding conflict body
    ---@field TID_BINDING_CONFLICT_QUESTION integer TID for binding conflict question
    ---@field TID_YES integer TID for 'Yes' button
    ---@field TID_NO integer TID for 'No' button
    ---@field TID_TARGET integer TID for 'Target:'
    ---@field TID_BINDING integer TID for 'Binding:'
    ---@field TID_HOTBAR integer TID for 'Hotbar'
    ---@field TID_SLOT integer TID for 'Slot'
    ---@field InMovement table Tracks hotbars in movement
    ---@field CurrentChangeColorWindow string|nil Window currently changing color
    ---@field SetHotbarItem fun(hotbarId: integer, slot: integer) Sets a hotbar item
    ---@field ClearHotbarItem fun(hotbarId: integer, slot: integer, bUnregister: boolean) Clears a hotbar item
    ---@field ReloadHotbar fun(hotbarId: integer) Reloads the hotbar
    ---@field SetLocked fun(hotbarId: integer, locked: boolean) Sets the locked state of a hotbar
    ---@field UseSlot fun(hotbarId: integer, slot: integer) Uses a slot on the hotbar
    ---@field Initialize fun() Initializes the hotbar
    ---@field Shutdown fun() Shuts down the hotbar
    ---@field FindHotbarMovingBlock fun(CurWindow: string) Finds and moves hotbar blocks
    ---@field FindHotbarShrinkBlock fun(CurWindow: string) Finds and shrinks hotbar blocks
    ---@field FindHotbarEnlargeBlock fun(CurWindow: string) Finds and enlarges hotbar blocks
    ---@field FindHotbarGroup fun(CurWindow: string, group?: table): table, integer Finds a group of hotbars
    ---@field ItemLButtonDown fun(flags: integer) Handles left button down on an item
    ---@field ItemLButtonUp fun(flags: integer) Handles left button up on an item
    ---@field ContextMenuCallback fun(returnCode: string, param: table) Handles context menu callback
    ---@field ItemRButtonUp fun() Handles right button up on an item
    ---@field ItemMouseOver fun() Handles mouse over on an item
    ---@field KeyRecorded fun() Handles key recorded event
    ---@field KeyCancelRecord fun() Cancels key recording
    ---@field OnResizeBegin fun() Begins resizing the hotbar
    ---@field OnResizeEnd fun(curWindow: string) Ends resizing the hotbar
    ---@field OnHandleLButDown fun(flags: integer, x: number, y: number) Handles left button down on handle
    ---@field OnHandleLButUp fun(flags: integer, x: number, y: number) Handles left button up on handle
    ---@field ShrinkTooltip fun() Shows shrink tooltip
    ---@field ShowBar fun(windowName: string) Shows the hotbar
    ---@field ItemMouseOverEnd fun() Handles end of mouse over on an item
    ---@field HandleMouseOver fun() Handles mouse over event
    ---@field HideBar fun(windowName: string) Hides the hotbar
    ---@field LockTooltip fun() Shows lock tooltip
    ---@field Lock fun() Locks the hotbar
    ---@field SpecialLock fun() Shows special lock context menu
    ---@field ContextMenuCallbackLock fun(returnCode: string, param: table) Handles lock context menu callback
    ---@field CreateNew fun(_, text: any) Creates a new hotbar
    ---@field SetText fun(windowname: string, text: any) Sets the text for a hotbar
    ---@field PickColor fun(color: any, windowname: string) Picks a color for the hotbar
    ---@field ColorPicked fun() Handles color picked event
    ---@field ShrinkBDown fun(flags: integer) Handles shrink button down
    ---@field Shrink fun(hotbar: string) Shrinks the hotbar
    ---@field Enlarge fun(hotbar: string) Enlarges the hotbar
    ---@field IsShrunken fun(hotbarId: integer): boolean Checks if a hotbar is shrunken

    ---@class HotbarSystem
    ---@field RegisteredSpellIcons table Registered spell icons
    ---@field CurRequestInfoItem table|nil Current request info item
    ---@field HighlightSpellIconInput table Input for highlighting spell icons
    ---@field ContextReturnCodes table Context menu return codes
    ---@field TID_CLEAR_ITEM integer TID for 'Clear Item'
    ---@field TID_ASSIGN_HOTKEY integer TID for 'Assign Hotkey'
    ---@field TID_NEW_HOTBAR integer TID for 'New Hotbar'
    ---@field TID_DESTROY_HOTBAR integer TID for 'Destroy Hotbar'
    ---@field TID_DESTROY_CONFIRM integer TID for destroy confirmation
    ---@field TID_CURSOR integer TID for 'Cursor'
    ---@field TID_SELF integer TID for 'Self'
    ---@field TID_CURRENT integer TID for 'Current'
    ---@field TID_OBJECT_ID integer TID for 'Object ID'
    ---@field TID_TARGET integer TID for 'Target'
    ---@field TID_EDIT_ITEM integer TID for 'Edit Item'
    ---@field TID_ENABLE_REPEAT integer TID for 'Enable Repeat'
    ---@field TID_DISABLE_REPEAT integer TID for 'Disable Repeat'
    ---@field TID_LOCK_HOTBAR integer TID for 'Lock Hotbar'
    ---@field TID_UNLOCK_HOTBAR integer TID for 'Unlock Hotbar'
    ---@field Spells table Spell slots
    ---@field Skills table Skill slots
    ---@field Specials table Special slots
    ---@field Virtues table Virtue slots
    ---@field SpecialActions table Special action slots
    ---@field Delta number Delta time
    ---@field STATIC_HOTBAR_ID integer Static hotbar ID
    ---@field MAX_HOTBAR_ID integer Maximum hotbar ID
    ---@field TID_ASSIGN_HOTKEY_DESC integer TID for assign hotkey description
    ---@field TID_REQUEST_TARGET_ID_DESC integer TID for request target ID description
    ---@field OffsetX integer X offset for hotbar placement
    ---@field OffsetY integer Y offset for hotbar placement
    ---@field OffsetIncrement integer Offset increment for hotbar placement
    ---@field ReflectionCooldown number Cooldown for Reflection
    ---@field EtherealVoyageCooldown number Cooldown for Ethereal Voyage
    ---@field AttunementCooldown number Cooldown for Attunement
    ---@field EvasionCooldown number Cooldown for Evasion
    ---@field StunTime number Stun time
    ---@field GrapeDelayTime number Delay for Grapes of Wrath
    ---@field AppleDelayTime number Delay for Enchanted Apple
    ---@field HealPotDelayTime number Delay for Healing Potion
    ---@field BandageDelayTime number Delay for Bandages
    ---@field SkillDelayTimeMax number Maximum skill delay time
    ---@field SkillDelayTime number Skill delay time
    ---@field RegisteredGenericObjectType table Registered generic object types
    ---@field RegisteredObjects table Registered objects
    ---@field ReferencedTextures table Referenced textures
    ---@field ObjectSlots table Object slots
    ---@field ObjectSlotsSize table Object slot sizes
    ---@field MacroReferenceSlots table Macro reference slots
    ---@field PlayerStatsElements table Player stats elements
    ---@field DarkItemLabel table Color for dark item label
    ---@field LightItemLabel table Color for light item label
    ---@field Plain table Color for plain key
    ---@field Control table Color for control key
    ---@field Alt table Color for alt key
    ---@field Shift table Color for shift key
    ---@field ControlAlt table Color for control+alt
    ---@field AltShift table Color for alt+shift
    ---@field ControlShift table Color for control+shift
    ---@field ControlAltShift table Color for control+alt+shift
    ---@field CountdownTimer table Color for countdown timer
    ---@field WARNINGLEVEL integer Warning level for stats
    ---@field TalismanTimers table Timers for talismans
    ---@field TargetTypeTintColors table Tint colors for target types
    ---@field OldQTA number Old quantity
    ---@field QTA number Current quantity
    ---@field BindingsBackup table Backup of key bindings
    ---@field Initialize fun() Initializes the hotbar system
    ---@field Shutdown fun() Shuts down the hotbar system
    ---@field DestroyHotbar fun(hotbarId: integer) Destroys a hotbar
    ---@field DestroyHotbarGroup fun(windowName: string) Destroys a group of hotbars
    ---@field SpawnNewHotbar fun(hotbarId?: integer, slots?: integer): integer Spawns a new hotbar
    ---@field GetNextHotbarId fun(): integer Gets the next available hotbar ID
    ---@field RegisterAction fun(element: string, hotbarId: integer, itemIndex: integer, subIndex: integer) Registers an action
    ---@field UpdateActionButton fun(element: string, type: integer, id: integer, iconId: integer, disabled: boolean) Updates an action button
    ---@field UpdateTargetTypeIndicator fun(element: string, hotbarId: integer, itemIndex: integer, subIndex: integer) Updates the target type indicator
    ---@field ClearActionIcon fun(element: string, hotbarId: integer, itemIndex: integer, subIndex: integer, bUnregister: boolean) Clears an action icon
    ---@field UpdateItemSlot fun() Updates an item slot
    ---@field SetHotbarIcon fun(element: string, iconId: integer) Sets the icon for a hotbar slot
    ---@field UpdatePlayerStatLabel fun(element: string, id: integer) Updates the player stat label
    ---@field UpdatePlayerStat fun() Updates player stats on the hotbar
    ---@field UpdateQuantityForOneSlot fun(element: string) Updates quantity for one slot
    ---@field UpdateCooldownSlot fun(element: string, cooldownTimer: number, alphaMod?: number, cooldownLabel?: any) Updates the cooldown slot
    ---@field UpdateQuantity fun() Updates item quantities
    ---@field HandleUpdateActionItem fun() Handles update of an action item
    ---@field Update fun(timePassed: number) Updates the hotbar system
    ---@field UpdateMacroReferenceSlot fun(macroIndex: integer) Updates a macro reference slot
    ---@field CreateUserActionContextMenuOptions fun(hotbarId: integer, itemIndex: integer, subIndex: integer, slotWindow: string) Creates context menu options for a user action
    ---@field ContextMenuCallback fun(returnCode: any, param: any): boolean Handles context menu callback
    ---@field RegisterSpellIcon fun(iconWindow: string, spellId: integer) Registers a spell icon
    ---@field UnregisterSpellIcon fun(iconWindow: string) Unregisters a spell icon
    ---@field HighlightSpellIcon fun() Highlights a spell icon
    ---@field UnhighlightSpellIcon fun() Unhighlights a spell icon
    ---@field RequestTargetInfo fun(windowName: string, hotbarId: integer, itemIndex: integer, subIndex: integer) Requests target info
    ---@field RequestTargetInfoReceived fun() Handles received target info
    ---@field ReplaceKey fun(oldHotbarId: integer, oldItemIndex: integer, oldType: integer, hotbarId: integer, itemIndex: integer, type: integer, key: any, shortKey: any) Replaces a key binding
    ---@field BindKey fun(hotbarId: integer, itemIndex: integer, type: integer, key: any, shortKey: any) Binds a key
    ---@field UpdateBinding fun(element: string, key: any, key2?: any) Updates a key binding
    ---@field UnbindKey fun(hotbarId: integer, itemIndex: integer, type: integer) Unbinds a key
    ---@field GetKeyName fun(hotbarId: integer, itemIndex: integer, type: integer): any Gets the name of a key binding
    ---@field SetActionOnHotbar fun(actionType: integer, actionId: integer, actionIcon: integer, hotbarNum: integer, buttonNum: integer) Sets an action on a hotbar

    ---@class HuePickerWindow
    ---@field NUM_COLORS integer Number of colors in the picker
    ---@field COLORS_PER_ROW integer Number of colors per row
    ---@field SWATCH_SIZE integer Size of each color swatch
    ---@field Initialize fun() Initializes the hue picker window
    ---@field Shutdown fun() Shuts down the hue picker window
    ---@field OnSlide fun() Handles slider movement for brightness
    ---@field UpdateHueTable fun(this: string, id: integer, newBrightness: number) Updates the hue table display
    ---@field PickColorTarget fun() Initiates color picking for a target
    ---@field Color2Up fun() Handles click on color 2
    ---@field Color3Up fun() Handles click on color 3
    ---@field Color4Up fun() Handles click on color 4
    ---@field Color5Up fun() Handles click on color 5
    ---@field Color6Up fun() Handles click on color 6
    ---@field Color7Up fun() Handles click on color 7
    ---@field Color8Up fun() Handles click on color 8
    ---@field Color10Up fun() Handles click on color 10
    ---@field Color11Up fun() Handles click on color 11
    ---@field Color12Up fun() Handles click on color 12
    ---@field Color13Up fun() Handles click on color 13
    ---@field Color14Up fun() Handles click on color 14
    ---@field Color15Up fun() Handles click on color 15
    ---@field Color16Up fun() Handles click on color 16
    ---@field Color17Up fun() Handles click on color 17
    ---@field Color18Up fun() Handles click on color 18
    ---@field PickColor fun(id: integer, huePicked: integer, this: string) Picks a color and closes the window
    ---@field RequestTargetInfo fun() Requests target info for color picking
    ---@field RequestTargetInfoReceived fun() Handles received target info for color picking
    ---@field ColorPicked fun(windowName: string) Handles color picked from the color picker

    ---@class HuesInfo
    ---@field Data table Table mapping hue IDs to their string descriptions

    ---@class IgnoreWindow
    ---@field currentSelection integer Currently selected player ID
    ---@field TID table Table of TIDs for UI text
    ---@field Initialize fun() Initializes the ignore window
    ---@field SelectPlayer fun() Handles player selection in the ignore window
    ---@field Add_OnLButtonUp fun() Handles the add button click
    ---@field Cancel_OnLButtonUp fun() Handles the cancel button click

    ---@class ItemProperties
    ---@field DETAIL_SHORT integer Short detail level
    ---@field DETAIL_LONG integer Long detail level
    ---@field CurrentItemData table Current item data being displayed
    ---@field TITLE_COLOR table Color for title text
    ---@field BODY_COLOR table Color for body text
    ---@field VirtueData table Data for virtues (iconId, nameTid, detailTid)
    ---@field Initialize fun() Initializes the item properties window
    ---@field Shutdown fun() Shuts down the item properties window
    ---@field UpdateItemPropertiesData fun() Updates the item properties data
    ---@field SetActiveItem fun(itemData: table) Sets the active item for display
    ---@field CreatePropsLabels fun(numLabelsNeeded: integer) Creates property labels
    ---@field HideAllPropsLabels fun() Hides all property labels
    ---@field ClearMouseOverItem fun() Clears the current mouse over item
    ---@field GetCurrentWindow fun(): string|nil Gets the current window name
    ---@field OnPlayerBackpackMouseover fun() Handles mouseover on the player backpack
    ---@field GetObjectPropertiesArray fun(objectId: integer, caller?: string): table Gets object properties array
    ---@field GetObjectProperties fun(objectId: integer, number?: any, caller?: string): any Gets object properties
    ---@field GetObjectPropertiesTid fun(objectId: integer, number?: any, caller?: string): any Gets object property TIDs
    ---@field GetObjectPropertiesTidParams fun(objectId: integer, number?: any, caller?: string): any Gets object property TID params
    ---@field GetObjectPropertiesParamsForTid fun(objectId: integer, tid: integer, caller?: string): any Gets params for a specific TID
    ---@field BuildParamsArray fun(propertiesData: table): table Builds params array from properties data
    ---@field GetActiveProperties fun(): table Gets active properties for the player
    ---@field GetCharges fun(objectId: integer): table Gets charges for an object

    ---@class ItemPropertiesInfo
    ---@field ChargesTid table Table mapping TIDs to token indices for charges
    ---@field WeightTid table Table mapping TIDs to token indices for weight
    ---@field WeightONLYTid table Table mapping TIDs to token indices for weight-only
    ---@field QuantityTid table Table mapping TIDs to token indices for quantity
    ---@field LostItemTid table Table mapping TIDs for lost items
    ---@field QuestGiverTid table Table mapping TIDs for quest givers
    ---@field LifeSpanTid table Table mapping TIDs to token indices for lifespan
    ---@field TamedTid table Table mapping TIDs for tamed status
    ---@field NinjaBeltTid table Table mapping TIDs for ninja belts

    ---@class ItemsInfo
    ---@field Data table Table of item data (name, types, hues, coolDown)
    ---@field Reagents table Table mapping reagent type IDs to TIDs

    ---@class KnownAreas
    -- @field [string] table Each key is an area name, value is a table with MainAreas, Guarded, and SubAreas

    ---@class LegacyRunebook
    ---@field knownWindows table Table of known runebook windows
    ---@field selectRuneType table Table of selected rune types per window
    ---@field NumActiveRunes table Table of number of active runes per window
    ---@field NUM_DEFAULT_LABELS integer Number of default labels
    ---@field CHARGE_LABEL integer Index for charge label
    ---@field KeymapTID integer[] Array of TIDs for keymap labels
    ---@field TID_LegacyRunebook integer TID for the legacy runebook
    ---@field KeymapLabel string[] Array of keymap label names
    ---@field ButtonIdLoc integer[] Array of button ID locations
    ---@field Hues table Table of hue values for different facets
    ---@field RuneColor table Table of rune color templates
    ---@field LegacyLabelColors table Table of label colors for facets
    ---@field DefaultNum table Table of default button indices
    ---@field CHARGES_STRING integer Index for charges string
    ---@field MAXCHARGES_STRING integer Index for max charges string
    ---@field SelectItemLabel table Color for selected item label
    ---@field DefaultItemLabel table Color for default item label
    ---@field BlackItemLabel table Color for black item label
    ---@field DefaultRuneLabel table Color for default rune label
    ---@field DisabledAlpha number Alpha value for disabled state
    ---@field EnableAlpha number Alpha value for enabled state
    ---@field CurrentSelection integer Currently selected rune
    ---@field CreateRuneButton fun(parent: string, number: integer, color: integer) Creates a rune button
    ---@field CreateRuneWindows fun(data: table) Creates rune windows
    ---@field ResetRuneDefaultIconText fun(data: table) Resets rune default icon text
    ---@field EnableDefaultButtons fun(windowName: string) Enables default buttons
    ---@field DisableDefaultButtons fun(windowName: string) Disables default buttons
    ---@field SelectedRuneLocation fun(windowData: table, runeNum: integer) Selects a rune location
    ---@field ResetDefaultIconText fun(data: table) Resets default icon text
    ---@field Initialize fun() Initializes the legacy runebook window
    ---@field ResetData fun(windowName: string) Resets data for a window
    ---@field DestroyWindow fun(myWindowName: string) Destroys a runebook window
    ---@field Shutdown fun() Shuts down the legacy runebook window
    ---@field UpdateCoordTextandLoc fun(runeData: table) Updates coordinate text and location
    ---@field OnRuneClicked fun() Handles rune button click
    ---@field OnKeyTab fun() Handles tab key event
    ---@field SendServerButtonInfo fun(buttonNumber: integer, runeData: table) Sends button info to the server
    ---@field OnDefaultClicked fun() Handles default button click

    ---@class LegacyRunebookLoader
    ---@field Initialize fun() Initializes the legacy runebook loader
    ---@field ReloadSettings fun() Reloads settings for the legacy runebook loader

    ---@class LuaUtils
    ---@field stripBeginEndSpace fun(inString: any): any Strips leading and trailing spaces from a wstring
    ---@field stripHTML fun(inString: any): any Strips HTML tags from a wstring

    ---@class MacroEditWindow
    ---@field TID_EDIT_MACRO integer TID for 'Edit Macro'
    ---@field TID_REPEAT integer TID for 'Enable Repeating'
    ---@field TID_REPEAT_TIMES integer TID for 'Repeat this many times:'
    ---@field TID_MACRO_ICON_TOOLTIP integer TID for macro icon tooltip
    ---@field TID_MACRO_DRAG_TOOLTIP integer TID for macro drag tooltip
    ---@field TID_MACRO_DRAG_EQUIP_TOOLTIP integer TID for macro drag equip tooltip
    ---@field TID_MACRO_DRAG_TARGET_BY_RESOURCE_TOOLTIP integer TID for macro drag target by resource tooltip
    ---@field MACRO_SCROLLWINDOW_WIDTH integer Width of the macro scroll window
    ---@field MACRO_ACTION_WIDTH integer Width of a macro action
    ---@field Macro table Macro data (NumActionsCreated)
    ---@field Initialize fun() Initializes the macro edit window
    ---@field Shutdown fun() Shuts down the macro edit window
    ---@field UpdateMacroActionList fun(editWindow: string, hotbarId: integer, itemIndex: integer) Updates the macro action list
    ---@field UpdateMacroEdit fun(editWindow: string, hotbarId: integer, itemIndex: integer) Updates the macro edit window
    ---@field UpdateTextEdit fun(editWindow: string, hotbarId: integer, itemIndex: integer, subIndex: integer) Updates the text edit box
    ---@field MacroEditOK fun() Handles OK button for macro edit
    ---@field MacroActionLButtonDown fun() Handles left button down on a macro action
    ---@field MacroActionLButtonUp fun() Handles left button up on a macro action
    ---@field MacroActionRButtonUp fun() Handles right button up on a macro action
    ---@field ContextMenuCallback fun(returnCode: any, param: any) Handles context menu callback
    ---@field MacroActionMouseOver fun() Handles mouse over on a macro action
    ---@field MacroActionMouseOverEnd fun() Handles mouse over end on a macro action
    ---@field MacroEditIcon fun() Handles macro icon selection
    ---@field MacroEditIconCallback fun(newIconId: integer) Callback for macro icon selection
    ---@field EmptyButtonMouseOver fun() Handles mouse over on the empty button
    ---@field MacroIconMouseOver fun() Handles mouse over on the macro icon
    ---@field UpdateSliderBar fun() Updates the slider bar for repeat count

    ---@class MacroPickerWindow
    ---@field numMacrosPerRow integer Number of macros per row
    ---@field MacroSelected integer|nil Currently selected macro icon ID
    ---@field MacroIcons integer[] Array of macro icon IDs
    ---@field Initialize fun() Initializes the macro picker window
    ---@field SetNumMacrosPerRow fun(numMacrosPerRow: integer) Sets the number of macros per row
    ---@field DrawMacroTable fun(parent: string) Draws the macro icon table
    ---@field SetMacro fun() Sets the selected macro icon
    ---@field AfterMacroSelectionFunction fun() Function called after macro selection
    ---@field SetAfterMacroSelectionFunction fun(funcCall: fun()) Sets the function to call after macro selection
    ---@field SetMacroId fun(macroId: integer, parent: string) Sets the macro ID and closes the window

    ---@class MacroWindow
    ---@field MacroSelected integer|nil Currently selected macro
    ---@field NumItemsCreated integer Number of macro items created
    ---@field RecordingIndex integer Index of the macro being recorded
    ---@field RecordingKey boolean Whether a key is being recorded
    ---@field TID_MACRO integer TID for 'Macro'
    ---@field TID_MACROS integer TID for 'Macros'
    ---@field TID_NOMACRO integer TID for 'No Macro'
    ---@field TID_MACROCOLON integer TID for 'Macro:'
    ---@field TID_CREATE integer TID for 'Create'
    ---@field TID_DESTROY_MACRO integer TID for 'Destroy Macro'
    ---@field TID_NO_KEYBINDING integer TID for 'No Keybinding'
    ---@field TID_BINDING_CONFLICT_TITLE integer TID for binding conflict title
    ---@field TID_BINDING_CONFLICT_BODY integer TID for binding conflict body
    ---@field TID_BINDING_CONFLICT_QUESTION integer TID for binding conflict question
    ---@field TID_YES integer TID for 'Yes'
    ---@field TID_NO integer TID for 'No'
    ---@field Initialize fun() Initializes the macro window
    ---@field Shutdown fun() Shuts down the macro window
    ---@field OnShown fun() Handles the window being shown
    ---@field AddMacro fun() Adds a new macro
    ---@field DisplayMacroList fun() Displays the macro list
    ---@field PickupMacro fun(flags: integer) Handles picking up a macro
    ---@field OnItemRButtonUp fun() Handles right button up on a macro item
    ---@field ContextMenuCallback fun(returnCode: any, param: any) Handles context menu callback
    ---@field KeyRecorded fun() Handles key recorded event
    ---@field KeyCancelRecord fun() Cancels key recording

    ---@class MapCommon
    ---@field ForcedUpdate boolean Whether a forced update is needed
    ---@field ActiveView string|nil The current active map view
    ---@field MAP_MODE_NAME string Name for atlas mode
    ---@field RADAR_MODE_NAME string Name for radar mode
    ---@field MAP_HIDDEN string Hidden map mode
    ---@field MAP_RADAR string Radar map mode
    ---@field MAP_ATLAS string Atlas map mode
    ---@field TID table Table of TIDs for map UI
    ---@field NumFacets integer Number of map facets
    ---@field ZoomLevel table Table of zoom level settings for each mode
    ---@field WaypointViewInfo table Table of waypoint view info for each mode
    ---@field WaypointsIcon table Table of waypoint icons
    ---@field WaypointsTypes table Table of waypoint types
    ---@field WaypointsIconScale table Table of waypoint icon scales
    ---@field WaypointsIconFacet table Table of waypoint icon facets
    ---@field WaypointMaxId integer Maximum waypoint ID
    ---@field WaypointsDirty boolean Whether waypoints are dirty
    ---@field WaypointCustomType integer Custom waypoint type
    ---@field WaypointPlayerVisible boolean Whether the player waypoint is visible
    ---@field WaypointPlayerType integer Player waypoint type
    ---@field WaypointPlayerId integer Player waypoint ID
    ---@field WaypointIsMouseOver boolean Whether a waypoint is being moused over
    ---@field WaypointUpdateRequest boolean Whether a waypoint update is requested
    ---@field RefreshDelay number Delay between refreshes
    ---@field ContextReturnCodes table Table of context menu return codes
    ---@field MapBorder table Table of map border values
    ---@field sextantDefaultCenterX integer Default sextant center X
    ---@field sextantDefaultCenterY integer Default sextant center Y
    ---@field sextantLostLandCenterX integer Lost lands sextant center X
    ---@field sextantLostLandCenterY integer Lost lands sextant center Y
    ---@field sextantLostLandTopLeftX integer Lost lands top left X
    ---@field sextantLostLandTopLeftY integer Lost lands top left Y
    ---@field sextantMaximumX integer Maximum X for sextant
    ---@field sextantMaximumY integer Maximum Y for sextant
    ---@field sextantFeluccaLostLands integer Felucca lost lands area
    ---@field sextantTrammelLostLands integer Trammel lost lands area
    ---@field RefreshDelta number Refresh delta
    ---@field CurrentArea string Current area name
    ---@field CurrentSubArea string Current subarea name
    ---@field AreaDescription string Description of the current area
    ---@field OnWater boolean Whether the player is on water
    ---@field PlayerLocation table Player location data
    ---@field AreaDelta number Area update delta
    ---@field Initialize fun() Initializes the map common system
    ---@field Shutdown fun() Shuts down the map common system
    ---@field Update fun() Updates the map common system
    ---@field AdjustZoom fun(zoomDelta: number) Adjusts the map zoom
    ---@field ChangeMap fun(facet: integer, area: integer) Changes the map to a new facet/area
    ---@field UpdateZoomValues fun(facet: integer, area: integer) Updates zoom values for a facet/area
    ---@field GetWaypointScale fun(displayMode: string): number Gets the scale for a waypoint icon
    ---@field UpdateWaypointIcon fun(iconId: integer, windowName: string, displayMode: string, waypointId?: integer, color?: table) Updates a waypoint icon
    ---@field IgnoreWaypoint fun(scale: number, type?: integer): boolean Determines if a waypoint should be ignored
    ---@field ClearWaypoints fun(displayMode: string) Clears waypoints for a display mode
    ---@field DrawPlayer fun(displayMode: string, visibleFunc: fun(wtype: integer, wx: number, wy: number): boolean, parentWindow: string) Draws the player on the map
    ---@field GetWPDataFromString fun(wname: any, wtype: any, wfacet: any, facet: any, area: any): table Gets waypoint data from a string
    ---@field CreateWPOnLocation fun(wname: any, wtype: any, wfacet: any, wx: any, wy: any, displayMode: any, waypointId: any, windowName: any, parentWindow: any) Creates a waypoint at a location
    ---@field UpdateWaypoints fun(displayMode: string) Updates waypoints for a display mode
    ---@field SetWaypointsEnabled fun(displayMode: string, isEnabled: boolean) Enables or disables waypoints for a display mode
    ---@field GetSextantCenterByArea fun(facet: integer, area: integer): integer, integer Gets the sextant center for a facet/area
    ---@field ConvertToXYMinutes fun(latVal: number, longVal: number, latDir: any, longDir: any, facet: integer, area: integer): number, number Converts lat/long to XY minutes
    ---@field GetSextantCenter fun(x: number, y: number, facet: integer): integer, integer Gets the sextant center for coordinates
    ---@field ConvertToMinutesXY fun(x: number, y: number, facet: integer): number, number Converts XY to minutes
    ---@field GetSextantLocationStrings fun(x: number, y: number, facet: integer): any, any, any, any Gets sextant location strings
    ---@field WaypointMouseOver fun() Handles mouse over on a waypoint
    ---@field WaypointMouseOverEnd fun() Handles mouse over end on a waypoint
    ---@field WaypointOnRButtonUp fun() Handles right button up on a waypoint
    ---@field ContextMenuCallback fun(returnCode: any, params: any) Handles context menu callback
    ---@field GetRadarBorders fun(facet: integer, area: integer): integer, integer, integer, integer Gets radar borders
    ---@field isChampionSpawn fun(name: string): boolean Checks if an area is a champion spawn
    ---@field UpdateAreaInfo fun(timePassed: number) Updates area info
    ---@field CheckSquareTable fun(x: number, y: number, z: number, map: number, region: table): boolean Checks if a point is in a square region
    ---@field CheckCircle fun(x: number, y: number, map: number, x1: number, y1: number, r: number, map2: number): boolean Checks if a point is in a circle
    ---@field CheckSquareByCenter fun(x: number, y: number, map: number, x1: number, y1: number, center: number, map2: number): boolean Checks if a point is in a square by center
    ---@field CheckSquare fun(x: number, y: number, map: number, x1: number, y1: number, x2: number, y2: number, map2: number): boolean Checks if a point is in a square

    ---@class MapFind
    ---@field Items table List of found map items
    ---@field TotalItems integer Total number of found items
    ---@field InSearch boolean Whether a search is in progress
    ---@field Initialize fun() Initializes the map find window
    ---@field Shutdown fun() Shuts down the map find window
    ---@field Close fun() Closes the map find window
    ---@field Toggle fun() Toggles the map find window
    ---@field ClearItemList fun() Clears the item list
    ---@field Reset fun() Resets the map find state
    ---@field OnLButtonUpSearch fun() Handles search button click
    ---@field SearchTooltip fun() Shows the search tooltip
    ---@field RemoveFiltersTooltip fun() Shows the remove filters tooltip
    ---@field MagnifyTooltip fun() Shows the magnify tooltip
    ---@field SearchText fun(null: any, text: any) Performs a search for the given text
    ---@field Restart fun() Restarts the map find window
    ---@field Locate fun() Locates the selected item on the map
    ---@field ItemMouseOver fun() Handles mouse over on an item

    ---@class MiniTexturePack
    ---@field Current integer Index of the current texture pack
    ---@field DB table[] Array of texture pack definitions (name, texture, PaperdollLabelColor, StatLabelColor)
    ---@field Overlays table[] Array of overlay definitions (name, texture)

    ---@class MobileHealthBar
    ---@field hasWindow table Table tracking which mobile IDs have health bar windows
    ---@field windowDisabled table Table tracking which mobile IDs have disabled health bar windows
    ---@field mouseOverId integer ID of the mobile currently under the mouse
    ---@field Changelings table Table tracking changeling mobiles
    ---@field Irks table Table tracking irk mobiles
    ---@field Guiles table Table tracking guile mobiles
    ---@field Spites table Table tracking spite mobiles
    ---@field Travestys table Table tracking travesty mobiles
    ---@field Handled table Table tracking handled mobile IDs
    ---@field SummonTimer table Table tracking summon timers per mobile
    ---@field CreateTime table Table tracking creation times per mobile
    ---@field CheckStatus table Table tracking status checks per mobile
    ---@field RegisterTime table Table tracking registration times per mobile
    ---@field LegacyCloseStyle boolean Whether legacy close style is enabled for regular mobiles
    ---@field PetLegacyCloseStyle boolean Whether legacy close style is enabled for pets
    ---@field Forced boolean|nil Whether forced mode is enabled
    ---@field CreateHealthBar fun(mobileId: integer) Creates a health bar window for a mobile
    ---@field HandleAnchorWindow fun(healthWindow: string) Handles anchoring the health bar window
    ---@field HandleBackGround fun() Handles background highlighting for all health bars
    ---@field RegisterHealthBar fun(windowName: string) Registers a health bar window for status events
    ---@field UnregisterHealthBar fun(windowName: string) Unregisters a health bar window from status events
    ---@field HasWindow fun(mobileId: integer): boolean Returns true if a health bar window exists for the mobile
    ---@field GetWindowName fun(mobileId: integer): string Gets the window name for a mobile's health bar
    ---@field HandleMobileStatusUpdate fun() Handles mobile status update events
    ---@field UpdateStatus fun(mobileId: integer) Updates the status display for a mobile
    ---@field ExtractWindow fun(windowName: string) Extracts a health bar window for repositioning
    ---@field HandleMobileNameUpdate fun() Handles mobile name update events
    ---@field UpdateName fun(mobileId: integer) Updates the name label for a mobile
    ---@field HandleHealthBarColorUpdate fun() Handles health bar color update events
    ---@field UpdateHealthBarColor fun(mobileId: integer) Updates the health bar color for a mobile
    ---@field HandleHealthBarStateUpdate fun() Handles health bar state update events
    ---@field UpdateHealthBarState fun(mobileId: integer) Updates the enabled/disabled state of a health bar
    ---@field CloseWindow fun() Closes the currently active health bar window
    ---@field CloseWindowByMobileId fun(mobileId: integer): boolean Closes the health bar window for a specific mobile
    ---@field HealthbarCloseWindow fun() Handles closing a health bar window with legacy/modern logic
    ---@field CloseAllHealthbars fun(avoidHandled: boolean) Closes all health bar windows, optionally avoiding handled ones
    ---@field OnShutdown fun() Handles shutdown and cleanup of a health bar window
    ---@field OnMouseDrag fun() Handles mouse drag events for window snapping
    ---@field OnLButtonDown fun(flags: integer, x: number, y: number) Handles left mouse button down events
    ---@field OnLButtonUp fun() Handles left mouse button up events (e.g., for drag/drop)
    ---@field OnLButtonDblClk fun() Handles double-click events on a health bar
    ---@field OnRButtonUp fun() Handles right mouse button up events (context menu/close)
    ---@field CloseButton_OnMouseOver fun() Shows tooltip for the close button
    ---@field Extract_OnMouseOver fun() Shows tooltip for the extract button
    ---@field OnMouseOver fun() Handles mouse over events for tooltips and highlighting
    ---@field OnMouseOverEnd fun() Handles mouse leaving a health bar window
    ---@field Null fun() No-op function for confirmations
    ---@field kill fun(mobileId: integer) Casts a spell to kill the mobile
    ---@field WodButton_OnLButtonUp fun() Handles left button up on the WoD button
    ---@field WodButton_OnMouseOver fun() Handles mouse over on the WoD button
    ---@field OnBPackLButtonUp fun() Handles left button up on the backpack icon
    ---@field OnBodLButtonUp fun() Handles left button up on the BOD icon
    ---@field OnTalkLButtonUp fun() Handles left button up on the talk icon
    ---@field OnBankLButtonUp fun() Handles left button up on the bank icon

    ---@class MobilesOnScreen
    ---@field IsInTable table Table tracking mobiles in the table
    ---@field MobilesSort integer[] Array of mobile IDs sorted for display
    ---@field MobilesSortReverse table Reverse mapping of mobile IDs to their sort index
    ---@field NeedsUpdate boolean Whether an update is needed
    ---@field DeltaClean number Time since last clean
    ---@field STRFilter string String filter for mobile names
    ---@field DistanceSort boolean Whether to sort mobiles by distance
    ---@field locked boolean Whether the window is locked
    ---@field isDirty boolean Whether the state is dirty and needs update
    ---@field CappedNumServerHealthBars integer Maximum number of server health bars
    ---@field CurrentHandledCount integer Current count of handled mobiles
    ---@field ManagedMobilesList integer[] List of managed mobile IDs
    ---@field ManagedMobilesMap table Mapping of mobile IDs to their index in ManagedMobilesList
    ---@field QueuedMobilesForDelete table Mobiles queued for deletion
    ---@field QueuedDelta number Time since last queued delta
    ---@field QueuedDeltaLimit number Limit for queued delta
    ---@field Mobiles table Table of all mobiles on screen
    ---@field BarsY number Y offset for bars
    ---@field BarScale number Scale for bars
    ---@field windowOffset number Offset for window positioning
    ---@field Hidden boolean Whether the window is hidden
    ---@field Filter table Array of filter strings
    ---@field SavedFilter table Array of saved filter states
    ---@field PetUpdateTime number Last pet update time
    ---@field PetUpdateFreq number Frequency of pet updates
    ---@field ReversePet table Table for reverse pet lookup
    ---@field YellowEnabled boolean Whether yellow dockspot is enabled
    ---@field GreyEnabled boolean Whether grey dockspot is enabled
    ---@field BlueEnabled boolean Whether blue dockspot is enabled
    ---@field RedEnabled boolean Whether red dockspot is enabled
    ---@field GreenEnabled boolean Whether green dockspot is enabled
    ---@field OrangeEnabled boolean Whether orange dockspot is enabled
    ---@field UnsortedWindows integer Number of unsorted windows
    ---@field YellowWindows integer Number of yellow windows
    ---@field GreyWindows integer Number of grey windows
    ---@field BlueWindows integer Number of blue windows
    ---@field RedWindows integer Number of red windows
    ---@field GreenWindows integer Number of green windows
    ---@field OrangeWindows integer Number of orange windows
    ---@field UnSorted table Table of unsorted mobile IDs
    ---@field MobilesYellow table Table of yellow mobile IDs
    ---@field MobilesGrey table Table of grey mobile IDs
    ---@field MobilesBlue table Table of blue mobile IDs
    ---@field MobilesRed table Table of red mobile IDs
    ---@field MobilesGreen table Table of green mobile IDs
    ---@field MobilesOrange table Table of orange mobile IDs
    ---@field Dockspotlocked boolean Whether dockspot is locked
    ---@field AnchorUpdateRequest boolean Whether an anchor update is requested
    ---@field delta number Time delta for updates
    ---@field InUpdate boolean Whether an update is in progress
    ---@field UpdateLimit number Limit for update frequency
    ---@field FarmNames table Table of farm animal names
    ---@field Summons table Table of summon names
    ---@field CloseLeft boolean Whether the close button is on the left
    ---@field Initialize fun() Initializes the MobilesOnScreen window
    ---@field GetVisible fun(ignoreMain: boolean): boolean Returns true if the window or any dockspot is visible
    ---@field OnMouseDrag fun() Handles mouse drag events for window snapping
    ---@field Shutdown fun() Shuts down the MobilesOnScreen window and saves settings
    ---@field OnSlide fun(curPos: number) Handles slider movement for settings
    ---@field ReloadFilterSettings fun() Reloads filter settings from saved state
    ---@field UpdateFilterSettings fun() Updates filter settings in the UI
    ---@field SaveFilterSettings fun() Saves current filter settings
    ---@field OnFilterOkayButton fun() Handles OK button for filter window
    ---@field OnFilterHidden fun() Handles hiding of the filter window
    ---@field Refilter fun() Re-applies filters and updates anchors
    ---@field Sort fun() Cleans the mobile sort cache
    ---@field Clear fun() Clears all mobiles and resets state
    ---@field ShowPetToolTip fun() Shows tooltip for pet
    ---@field ShowPetToolTipEnd fun() Ends pet tooltip
    ---@field HidePetToolTip fun() Shows tooltip for hiding pet
    ---@field HidePetToolTipEnd fun() Ends hide pet tooltip
    ---@field IsPet fun(mobileId: integer): boolean Returns true if the mobile is a pet
    ---@field IsFarm fun(name: string): boolean Returns true if the name is a farm animal
    ---@field IgnoredMobile fun(name: string): boolean Returns true if the mobile should be ignored
    ---@field IsSummon fun(name: string, mobileId: integer): boolean Returns true if the mobile is a summon
    ---@field AddHealthbar fun(mobileId: integer): boolean Adds a health bar for a mobile
    ---@field RemoveHealthBar fun(mobileId: integer) Removes a health bar for a mobile
    ---@field RemoveFromMobilesSort fun(mobileId: integer) Removes a mobile from the sort list
    ---@field SlowUpdate fun(timePassed: number) Performs a slow update for queued operations
    ---@field HandleAnchorsForCategory fun(categoryWindows: integer, categoryMobList: table, categoryLimit: integer, parent: string) Handles anchoring for a category of mobiles
    ---@field HandleAnchors fun() Handles anchoring for all categories
    ---@field SortByDistance fun() Sorts mobiles by distance
    ---@field UpdateAnchors fun() Updates anchors for all mobiles
    ---@field Dockspot_OnLButtonUp fun() Handles left button up on dockspot
    ---@field Dockspot_OnLButtonDown fun() Handles left button down on dockspot
    ---@field HidePet fun() Hides the pet window
    ---@field ShowPet fun() Shows the pet window
    ---@field HideAll fun() Hides all windows
    ---@field ShowWindow fun() Shows the main window
    ---@field LockTooltip fun() Shows tooltip for lock button
    ---@field LockMe fun() Toggles lock state for the window
    ---@field Lock fun() Handles context menu lock actions
    ---@field ContextMenuCallback fun(returnCode: string, param: any) Handles context menu callbacks
    ---@field ButtonRotation fun() Handles button rotation for show/hide
    ---@field SetFilter fun(j: integer, newval: string) Sets the filter string
    ---@field ReloadSettings fun() Reloads settings from saved state
    ---@field CanAddMobileOnScreen fun(noto: integer, mobileId: integer, data: table): boolean Determines if a mobile can be added
    ---@field AddMobileOnScreenCount fun(mobileId: integer) Adds a mobile to the managed list
    ---@field RemoveMobileOnScreenCount fun(mobileId: integer) Removes a mobile from the managed list
    ---@field IsManagedMobileOnScreen fun(mobileId: integer): boolean Returns true if a mobile is managed
    ---@field MarkHealthBarForDeletion fun(mobileId: integer) Marks a health bar for deletion
    ---@field UnMarkHealthBarForDeletion fun(mobileId: integer) Unmarks a health bar for deletion
    ---@field IsMarkedHealthBarForDeletion fun(mobileId: integer): boolean Returns true if a health bar is marked for deletion
    ---@field CleanMobileSortCache fun() Cleans the mobile sort cache

    ---@class NameColor
    ---@field Notoriety table Table of notoriety types (NONE, INNOCENT, FRIEND, CANATTACK, CRIMINAL, ENEMY, MURDERER, INVULNERABLE)
    ---@field TextColors table Table mapping notoriety to text color (r, g, b)
    ---@field AuraColors table Table mapping notoriety to aura color (r, g, b)
    ---@field UpdateLabelNameColor fun(windowTextName: string, visualStateId: integer) Sets the label text color based on notoriety
    ---@field UpdateEditBoxNameColor fun(windowTextName: string, visualStateId: integer) Sets the edit box text color based on notoriety

    ---@class ChatOptionsWindow
    ---@field TID table Table of TIDs for UI text (Accept, CustomColor, Red, Green, Blue, TextColorHelp, TextColors)
    ---@field channelListData table[] Array of channel list data (channelName, color, logName, channelID)
    ---@field channelListOrder integer[] Array of indices for channel list display order
    ---@field SelectedMessageTypeIndex integer Currently selected message type index
    ---@field SelectedMessageTypeWindowIndex integer Currently selected message type window index
    ---@field channelListCurrentStatus table[] Array of status for each channel (hasChanged)
    ---@field SpeechHueIndex integer Index for the speech hue channel
    ---@field Initialize fun() Initializes the chat options window and sets up UI
    ---@field Shutdown fun() Shuts down the chat options window
    ---@field Hide fun() Hides the chat options window and related UI
    ---@field ClearSelectionImage fun() Hides the channel selection image
    ---@field OnShown fun() Handles the window being shown and updates the channel list
    ---@field OnHidden fun() Handles the window being hidden
    ---@field UpdateChatOptionRow fun() Updates the display of each chat option row
    ---@field OnLButtonUpChannelLabel fun() Handles clicking a channel label to select it for color editing
    ---@field OnLButtonUpColorPicker fun(flags: any, x: number, y: number) Handles clicking a color in the color picker
    ---@field OnSetCustomColor fun() Sets a custom color for the selected channel
    ---@field SetAllColorChanges fun() Applies all color changes and hides the window
    ---@field SetChannelColor fun(channelIndex: integer) Sets the color for a specific channel

    ---@class NewChatWindow
    ---@field Messages table[] Array of chat messages
    ---@field Setting table|nil Current user/shard chat settings
    ---@field Settings table|nil All chat settings by shard/user
    ---@field Initialized boolean Whether the chat window is initialized
    ---@field WindowName string Name of the main chat window
    ---@field WINDOW_WIDTH_MAX integer Maximum window width
    ---@field WINDOW_HEIGHT_MAX integer Maximum window height
    ---@field minTotDmg integer Minimum total damage for display
    ---@field NormalColor table Default color for normal state
    ---@field ActiveColor table Color for active tab
    ---@field HighlightColor table Color for highlighted tab
    ---@field maxTabs integer Maximum number of chat tabs
    ---@field messagesBuffCap integer Message buffer cap per tab
    ---@field deltaUpd number Time since last update
    ---@field UpdateReq boolean Whether an update is requested
    ---@field firstStart boolean Whether this is the first start
    ---@field blockUpdate boolean Whether updates are blocked
    ---@field LastMsg table Table of last message indices per tab
    ---@field LastVis table Table of last visible message indices per tab
    ---@field totalHeight table Table of total heights per tab
    ---@field Labels table Table of label counts per tab
    ---@field PrevLabels table Table of previous label counts per tab
    ---@field BaseAlpha number Base alpha for window transparency
    ---@field autoHide boolean Whether auto-hide is enabled
    ---@field waitTime number Time to wait before hiding
    ---@field delta number Time since last hide
    ---@field hidden boolean Whether the window is hidden
    ---@field showMouseOver boolean Whether to show on mouse over
    ---@field waithide boolean Whether waiting to hide
    ---@field Locked boolean Whether the window is locked
    ---@field TextFade boolean Whether text fade is enabled
    ---@field TimeStamp boolean Whether timestamps are shown
    ---@field hideTag boolean Whether to hide channel tags
    ---@field TabCount integer Number of chat tabs
    ---@field TabStatus table Table of tab status (extracted, etc.)
    ---@field LastDock integer Last docked tab index
    ---@field ActiveTab integer Currently active tab
    ---@field ChannelsEnabled table Table of enabled channels per tab
    ---@field DefaultFont integer Default font index
    ---@field ChannelsFonts table Table of font indices per channel
    ---@field DefaultFontSize integer Default font size
    ---@field ChannelsFontsSize table Table of font sizes per channel
    ---@field curChannel integer|nil Current channel index
    ---@field prevChannel integer|nil Previous channel index
    ---@field MinUpdateRate number Minimum update rate
    ---@field Filter table Array of filter strings
    ---@field SavedFilter table Array of saved filter states
    ---@field ShowSpells boolean Whether to show spell messages
    ---@field ShowSpellsCasting boolean Whether to show spell casting messages
    ---@field ShowPerfection boolean Whether to show perfection messages
    ---@field ShowMultiple boolean Whether to show multiple messages
    ---@field SwitchOrder table Array of channel switch order
    ---@field SwitchID integer Current switch order index
    ---@field PlayerName string Player's name
    ---@field over string Name of the currently hovered element
    ---@field SetVisible fun() Sets the visibility of the chat window and tabs
    ---@field HideChannelSelectionMenu fun() Hides the channel selection menu
    ---@field OnKeyTab fun() Handles tab key to switch channels
    ---@field SwitchToSelectedChannel fun() Switches to the selected channel
    ---@field DragBar fun() Handles drag bar events
    ---@field UpdateCurrentChannel fun(icurChannel: integer) Updates the current channel
    ---@field MenuItemMouseLeave fun() Handles mouse leave on menu items
    ---@field SwitchToChatChannel fun(ichannelIdx: integer, ichannelPrompt: string, iexistingText?: string) Switches to a chat channel
    ---@field DoChatTextReplacement fun() Handles slash command text replacement
    ---@field Initialize fun() Initializes the chat window
    ---@field LoadTabs fun() Loads chat tabs
    ---@field Shutdown fun() Shuts down the chat window
    ---@field BookmarkContext fun() Opens the context menu for a bookmark
    ---@field BookmarkContextMenuCallback fun(returnCode: string, param: any) Handles context menu actions for bookmarks
    ---@field BookmarkRename fun(id: integer, text: string) Renames a bookmark tab
    ---@field LabelOnMouseOver fun() Handles mouse over on labels
    ---@field OnResizeBegin fun() Begins window resize
    ---@field OnResizeEnd fun(curWindow: string, forced?: boolean) Ends window resize
    ---@field SwitchTab fun() Switches to a different tab
    ---@field ClearAll fun() Clears all chat messages and labels
    ---@field OnOpenChannelMenu fun() Opens the channel selection menu
    ---@field UpdateLog fun() Updates the chat log display
    ---@field UpdateLogR fun() Internal function to update the chat log
    ---@field ShowAgain fun(bypass?: boolean) Shows the chat window again
    ---@field Rubber fun() Clears all messages and resets state
    ---@field RubberToolTip fun() Shows tooltip for the rubber (clear) button
    ---@field Font fun() Opens the font selection menu
    ---@field FontContextMenuCallback fun(returnCode: integer, param: any) Handles font context menu actions
    ---@field FontToolTip fun() Shows tooltip for font selection
    ---@field FontSize fun() Opens the font size selection menu
    ---@field FontSizeContextMenuCallback fun(returnCode: integer, param: any) Handles font size context menu actions
    ---@field SetFontSize fun(id: integer, px: integer) Sets the font size for a channel
    ---@field FontSizeToolTip fun() Shows tooltip for font size selection
    ---@field FontColor fun() Opens the font color selection window
    ---@field FontColorToolTip fun() Shows tooltip for font color selection
    ---@field ChatSettingsToolTip fun() Shows tooltip for chat settings
    ---@field UpdateSettings fun() Updates chat window settings from UI
    ---@field OnSettingsHidden fun() Handles hiding of the settings window
    ---@field BookmarkToolTip fun() Shows tooltip for bookmarks
    ---@field OnMouseOverEnd fun() Handles mouse over end for bookmarks
    ---@field OnLButtonDown fun() Handles left button down for moving the window
    ---@field OnLButtonDownJW fun() Handles left button down for moving journal window
    ---@field OnLButtonUpJW fun() Handles left button up for journal window
    ---@field OnLButtonUp fun() Handles left button up for main window
    ---@field OnUpdate fun(timePassed: number) Handles periodic update logic

    ---@class NewPlayerGuide
    ---@field SetText fun() Sets the next section of guide text or closes the window if finished
    ---@field Initialize fun() Initializes the new player guide window and starts at the first step
    ---@field Shutdown fun() Shuts down the new player guide and resets the step

    ---@class ObjectHandle
    ---@field DestroyObjectWindow fun(objectId: integer) Destroys the object handle window for a given object ID

    ---@class OrganizerWindow
    ---@field VisibleItems integer Number of visible items in the organizer list
    ---@field Combo table Array of agent combo names
    ---@field ComboCustomName table Array of custom names for agents
    ---@field Initialize fun() Initializes the organizer window
    ---@field UpdateCombo fun() Updates the agent combo box with available agents
    ---@field AgentPlus fun() Opens the context menu to add a new agent
    ---@field EditAmount fun(j: integer, amount: number) Edits the amount for a restock/buy/sell item
    ---@field ContextMenuCallback fun(returnCode: string, param: any) Handles context menu actions for agents
    ---@field AddRemDefCont fun() Adds or removes the default container for the selected agent
    ---@field AddDefCont fun() Adds a default container for the selected agent
    ---@field AgentRename fun() Opens the rename dialog for an agent
    ---@field renameAgent fun(id: integer, name: string) Renames an agent
    ---@field AgentMinus fun() Opens the dialog to remove an agent
    ---@field removeAgent fun() Removes the selected agent
    ---@field OnAddTypeButton fun() Handles the add type button click
    ---@field AddTypeRequestTargetInfoReceived fun(obj?: integer, qta?: number) Handles the result of a type target info request
    ---@field OnAddIDButton fun() Handles the add ID button click
    ---@field AddIDRequestTargetInfoReceived fun() Handles the result of an ID target info request
    ---@field AutoClose fun() Handles the auto-close checkbox for containers
    ---@field OnSelChanged fun() Handles selection change in the agent combo box
    ---@field UpdateList fun() Updates the list of items for the selected agent
    ---@field RemoveItem fun() Handles removing an item from the agent
    ---@field ExeRemoveItem fun(windowName: string) Executes the removal of an item
    ---@field ClearList fun() Clears the list of items in the organizer window
    ---@field Shutdown fun() Shuts down the organizer window and saves position
    ---@field PlusItemMouseOver fun() Handles mouse over on the plus item button
    ---@field ItemMouseOver fun() Handles mouse over on an item
    ---@field ClearMouseOverItem fun() Handles mouse over end on an item
    ---@field DefaultButtonMouseOver fun() Shows tooltip for the default button
    ---@field SetDefault fun() Sets the selected agent as the default

    ---@class Organizer
    ---@field Organizers integer Number of organizer agents
    ---@field Undresses integer Number of undress agents
    ---@field Restocks integer Number of restock agents
    ---@field Buys integer Number of buy agents
    ---@field Sells integer Number of sell agents
    ---@field Scavengers integer Number of scavenger agents
    ---@field ActiveOrganizer integer Index of the active organizer
    ---@field ActiveUndress integer Index of the active undress agent
    ---@field ActiveRestock integer Index of the active restock agent
    ---@field ActiveBuy integer Index of the active buy agent
    ---@field ActiveSell integer Index of the active sell agent
    ---@field ActiveScavenger integer Index of the active scavenger agent
    ---@field Organizers_Items table Number of items for each organizer
    ---@field Undresses_Items table Number of items for each undress agent
    ---@field Restocks_Items table Number of items for each restock agent
    ---@field Buys_Items table Number of items for each buy agent
    ---@field Sells_Items table Number of items for each sell agent
    ---@field Scavengers_Items table Number of items for each scavenger agent
    ---@field Organizers_Desc table Custom names for organizers
    ---@field Undresses_Desc table Custom names for undress agents
    ---@field Restocks_Desc table Custom names for restock agents
    ---@field Buys_Desc table Custom names for buy agents
    ---@field Sells_Desc table Custom names for sell agents
    ---@field Scavengers_Desc table Custom names for scavenger agents
    ---@field Organizers_Cont table Default containers for organizers
    ---@field Organizers_CloseCont table Close container flags for organizers
    ---@field Undresses_Cont table Default containers for undress agents
    ---@field Restocks_Cont table Default containers for restock agents
    ---@field Scavengers_Cont table Default containers for scavenger agents
    ---@field Organizer table Table of organizer item lists
    ---@field Undress table Table of undress item lists
    ---@field Restock table Table of restock item lists
    ---@field Buy table Table of buy item lists
    ---@field Sell table Table of sell item lists
    ---@field Scavenger table Table of scavenger item lists
    ---@field GetOrganizerName fun(i: integer): string Gets the name of an organizer by index
    ---@field Initialize fun() Initializes the Organizer data from saved settings

    ---@class OverheadText
    ---@field QuestMarkers table Table of quest marker windows by mobile ID
    ---@field ActiveIdList table Table of active mobile IDs with overhead text
    ---@field FadeTimeId table Table of fade timers for each mobile ID
    ---@field TimePassed table Table of time passed for each mobile ID
    ---@field AlphaStart number Starting alpha value for fade
    ---@field AlphaDiff number Alpha difference per fade step
    ---@field FadeStartTime number Time before fade starts
    ---@field FontIndex integer Font index for overhead text
    ---@field NameFontIndex integer Font index for names
    ---@field SpellsFontIndex integer Font index for spells
    ---@field DamageFontIndex integer Font index for damage
    ---@field OverhedTextSize number Scale for overhead text
    ---@field clickableNames boolean Whether names are clickable
    ---@field ChatData table Table of chat data per mobile ID
    ---@field OverheadAlive number How long overhead text stays on screen
    ---@field MaxOverheadHeight number Maximum height for overhead text
    ---@field LastSeeName table Table tracking last seen names
    ---@field mouseOverId integer ID of the mobile currently under the mouse
    ---@field GetsOverhead boolean[] Array indicating which channels get overhead text
    ---@field NameParsed table Table tracking if a name has been parsed
    ---@field QuestMarkerDelta number Timer for quest marker updates
    ---@field InitializeEvents fun() Registers event handlers for overhead text
    ---@field Initialize fun() Initializes overhead text for a mobile
    ---@field Shutdown fun() Shuts down overhead text for a mobile
    ---@field HandleMobileNameUpdate fun() Handles mobile name update events
    ---@field HandleSettingsUpdate fun() Handles settings update events
    ---@field HandleFlashTempNames fun() Handles temporary name flashes
    ---@field UpdateSettings fun() Updates overhead text settings
    ---@field UpdateName fun(mobileId: integer) Updates the name label for a mobile
    ---@field ChangelingNameCheck fun(data: table, windowName: string, mobileId: integer) Checks and updates changeling names
    ---@field Update fun(timePassed: number) Periodic update for overhead text and quest markers
    ---@field ShowName fun(mobileId: integer) Shows the name label for a mobile
    ---@field HideName fun(mobileId: integer) Hides the name label for a mobile
    ---@field UpdateOverheadAnchors fun(mobileId: integer) Updates window anchors for overhead text
    ---@field OnShown fun() Handles window shown event
    ---@field NameOnLClick fun() Handles left click on a name label
    ---@field OnLButtonUp fun() Handles left button up event
    ---@field NameOnDblClick fun() Handles double click on a name label
    ---@field NameOnMouseOver fun() Handles mouse over on a name label
    ---@field NameOnMouseOverEnd fun() Handles mouse leaving a name label
    ---@field ShowOverheadText fun() Shows overhead chat text for a message
    ---@field OnOverheadChatShutdown fun() Handles shutdown of overhead chat window

    ---@class PaperdollWindow
    ---@field MenuRequest integer ID of the item for which a context menu is requested
    ---@field CurrentBG string Current background texture
    ---@field TID table Table of TIDs for UI text (CLOTHING, ARMOR, PAPERDOLL, PROFILE)
    ---@field PAPERDOLLSLOTID table Table of slot IDs for paperdoll slots
    ---@field HUMAN integer Constant for human race
    ---@field ELF integer Constant for elf race
    ---@field GARGOYLE integer Constant for gargoyle race
    ---@field WINDOWSCALE number Scale for the paperdoll window
    ---@field Organize boolean Whether organize mode is active
    ---@field OrganizeBag integer|nil ID of the organize bag
    ---@field OrganizeParent integer|nil ID of the organize parent
    ---@field CanPickUp boolean Whether items can be picked up
    ---@field TimePassedSincePickUp number Time since last item pickup
    ---@field BlockClosing boolean Whether closing is blocked
    ---@field OpenPaperdolls table Table tracking open paperdoll windows
    ---@field ActivePaperdollImage integer ID of the active paperdoll image
    ---@field ActivePaperdollObject integer ID of the active paperdoll object
    ---@field ArmorSlots integer Number of armor slots
    ---@field Locked boolean Whether the window is locked
    ---@field BlankSlot table Table of blank slot info (name and description TIDs)
    ---@field RefreshPlayer boolean Whether the player paperdoll needs refresh
    ---@field GotDamage boolean Whether an item has taken damage
    ---@field Initialize fun() Initializes the paperdoll window
    ---@field LockTooltip fun() Shows tooltip for the lock button
    ---@field Lock fun() Toggles the lock state of the window
    ---@field CloseWindow fun() Closes the paperdoll window
    ---@field Shutdown fun() Shuts down the paperdoll window and saves position
    ---@field OnMouseDrag fun() Handles mouse drag events for window snapping
    ---@field HandleUpdatePaperdollEvent fun() Handles paperdoll update events
    ---@field UpdatePaperdoll fun(windowName: string, paperdollId: integer) Updates the paperdoll display
    ---@field GetMouseSlotId fun(): integer, integer Gets the paperdoll and slot ID under the mouse
    ---@field OnPaperdollTextureLButtonDown fun(flags: integer) Handles left button down on the paperdoll texture
    ---@field OnPaperdollTextureLButtonUp fun() Handles left button up on the paperdoll texture
    ---@field OnPaperdollTextureLButtonDblClk fun() Handles double click on the paperdoll texture
    ---@field OnPaperdollTextureRButtonDown fun() Handles right button down on the paperdoll texture
    ---@field OnPaperdollTextureMouseOver fun() Handles mouse over on the paperdoll texture
    ---@field OnPaperdollTextureMouseEnd fun() Handles mouse leaving the paperdoll texture
    ---@field SlotLButtonDown fun(flags: integer) Handles left button down on a slot
    ---@field SlotLButtonUp fun() Handles left button up on a slot
    ---@field SlotLButtonDblClk fun() Handles double click on a slot
    ---@field SlotRButtonDown fun() Handles right button down on a slot
    ---@field ItemMouseOver fun() Handles mouse over on an item slot
    ---@field BlockPaperdolls fun(timePassed: number) Handles blocking of paperdoll windows
    ---@field OnUpdate fun(timePassed: number) Periodic update for paperdoll logic
    ---@field ToggleInventoryWindow fun() Toggles the inventory window
    ---@field ToggleProfile fun() Toggles the profile window
    ---@field OnMouseOverToggleCharacterAbilities fun() Shows tooltip for the character abilities button
    ---@field OnMouseOverToggleCharacterSheet fun() Shows tooltip for the character sheet button
    ---@field ToggleCharacterSheet fun() Toggles the character sheet window
    ---@field ToggleCharacterAbilities fun() Toggles the character abilities window
    ---@field ToggleProfileTooltip fun() Shows tooltip for the profile button
    ---@field UpdateCharProfile fun() Updates the character profile display
    ---@field OnMouseOverToggleInventory fun() Shows tooltip for the inventory button
    ---@field UpdateDurabilities fun(timePassed: number) Updates item durabilities
    ---@field OnItemDamaged fun(id: integer, slotId: integer, durabilityLost: number) Handles item damage events
    ---@field OnItemSeverelyDamaged fun(id: integer, slotId: integer, MAXdurabilityLost: number) Handles severe item damage events

    ---@class ItemSlot
    ---@field NUM_BUTTONS integer Number of item slot buttons
    ---@field BUTTONSTATE_EMPTY integer State for empty button
    ---@field BUTTONSTATE_NORMAL integer State for normal button
    ---@field BUTTONSTATE_ACTIVE integer State for active button
    ---@field BUTTONSTATE_DISABLED integer State for disabled button
    ---@field ItemIds table Table of item IDs for each slot
    ---@field ObjectTypes table Table of object types for each slot
    ---@field ButtonStates table Table of button states for each slot

    ---@class PartyHealthBar
    ---@field PartyMembers table Table of party member data (health, name, etc.)
    ---@field hasWindow table Table tracking which mobile IDs have party health bar windows
    ---@field windowDisabled table Table tracking which mobile IDs have disabled party health bar windows
    ---@field mouseOverId integer ID of the mobile currently under the mouse
    ---@field DEFAULT_WINDOW_START_X integer Default X position for windows
    ---@field DEFAULT_WINDOW_START_Y integer Default Y position for windows
    ---@field WINDOW_WIDTH integer Width of the party health bar window
    ---@field WINDOW_HEIGHT integer Height of the party health bar window
    ---@field Spells table Table of spell IDs (Heal, Cure, GreaterCure, Cleanse, CloseWounds)
    ---@field SpellsTID table Table of spell TIDs (Heal, Cure, Cleanse, CloseWounds)
    ---@field hasPortrait boolean Whether the party health bar has a portrait
    ---@field CrownMouseOver fun() Shows tooltip for the party leader crown
    ---@field CreateHealthBar fun(mobileId: integer, useDefaultPos: boolean) Creates a party health bar window for a mobile
    ---@field RefreshHealthBar fun(windowIndex: integer, mobileId: integer) Refreshes a party health bar window
    ---@field OnShutdown fun() Handles shutdown and cleanup of a party health bar window
    ---@field HandleAnchorWindow fun(windowName: string, useDefaultPos: boolean) Handles anchoring the health bar window
    ---@field RegisterHealthBar fun(windowName: string) Registers a health bar window for status events
    ---@field UnregisterHealthBar fun(windowName: string) Unregisters a health bar window from status events
    ---@field HasWindow fun(mobileId: integer): boolean Returns true if a health bar window exists for the mobile
    ---@field HasWindowByIndex fun(windowIndex: integer): boolean Returns true if a health bar window exists by index
    ---@field GetWindowName fun(mobileId: integer): string Gets the window name for a mobile's health bar
    ---@field HandleMobileStatusUpdate fun() Handles mobile status update events
    ---@field UpdateStatus fun(mobileId: integer) Updates the status display for a mobile
    ---@field HandleMobileNameUpdate fun() Handles mobile name update events
    ---@field UpdateName fun(mobileId: integer) Updates the name label for a mobile
    ---@field HandleHealthBarColorUpdate fun() Handles health bar color update events
    ---@field UpdateHealthBarColor fun(mobileId: integer) Updates the health bar color for a mobile
    ---@field HandleHealthBarStateUpdate fun() Handles health bar state update events
    ---@field UpdateHealthBarState fun(mobileId: integer) Updates the enabled/disabled state of a health bar
    ---@field CloseWindow fun() Closes the currently active health bar window
    ---@field CloseWindowByIndex fun(windowIndex: integer) Closes the health bar window by index
    ---@field CloseWindowByMobileId fun(mobileId: integer) Closes the health bar window for a specific mobile
    ---@field OnMouseDrag fun() Handles mouse drag events for window snapping
    ---@field OnLButtonDown fun() Handles left mouse button down events
    ---@field OnLButtonUp fun() Handles left mouse button up events (e.g., for drag/drop)
    ---@field OnLButtonDblClk fun() Handles double-click events on a health bar
    ---@field OnRButtonUp fun() Handles right mouse button up events (context menu)
    ---@field OnMouseOver fun() Handles mouse over events for tooltips and highlighting
    ---@field OnMouseOverEnd fun() Handles mouse leaving a health bar window
    ---@field RedButton_OnLButtonUp fun() Handles left button up on the red button
    ---@field RedButton_OnMouseOver fun() Handles mouse over on the red button
    ---@field GreenButton_OnLButtonUp fun() Handles left button up on the green button
    ---@field GreenButton_OnMouseOver fun() Handles mouse over on the green button
    ---@field BlueButton_OnLButtonUp fun() Handles left button up on the blue button
    ---@field BlueButton_OnMouseOver fun() Handles mouse over on the blue button
    ---@field Button_OnRButtonUp fun() Handles right button up on a spell button (context menu)
    ---@field ContextMenuCallback fun(returnCode: string, param: any) Handles context menu callbacks for spell buttons

    ---@class PartyInviteWindow
    ---@field TID table Table of TIDs for UI text (Title, Accept, Decline, Dialog, DoNotShow)
    ---@field checkboxFlag boolean State of the 'Do Not Show Again' checkbox
    ---@field Initialize fun() Initializes the party invite window
    ---@field Shutdown fun() Shuts down the party invite window and handles pending invites
    ---@field CloseWindow fun() Closes the party invite window
    ---@field Accept_OnLButtonUp fun() Handles accepting a party invite
    ---@field Decline_OnLButtonUp fun() Handles declining a party invite
    ---@field Check_OnLButtonUp fun() Handles toggling the 'Do Not Show Again' checkbox

    ---@class PetWindow
    ---@field tid table Table of TIDs for UI text (PET)
    ---@field OffetSize integer Offset size for window positioning
    ---@field windowX integer Window X dimension
    ---@field windowY integer Window Y dimension
    ---@field windowOffset integer Offset between windows
    ---@field Locked boolean Whether the window is locked
    ---@field CheckTime number Time interval for checking pets
    ---@field Delta number Time delta for updates
    ---@field PetWindowHidden boolean Whether the pet window is hidden
    ---@field SortedPet table Array of sorted pet mobile IDs
    ---@field CloseLeft boolean Whether the close button is on the left
    ---@field Initialize fun() Initializes the pet window
    ---@field Shutdown fun() Shuts down the pet window and saves position
    ---@field HideAll fun() Hides the pet window
    ---@field ShowWindow fun() Shows the pet window
    ---@field LockTooltip fun() Shows tooltip for the lock button
    ---@field LockMe fun() Toggles the lock state of the window
    ---@field Lock fun() Handles context menu lock actions
    ---@field ContextMenuCallback fun(returnCode: string, param: any) Handles context menu callbacks
    ---@field OnLButtonUp fun() Handles left button up events
    ---@field Update fun(timePassed: number) Periodic update for pet window logic
    ---@field ButtonRotation fun() Handles button rotation for show/hide
    ---@field UpdatePet fun() Updates the pet list and health bars
    ---@field ShowPetToolTip fun() Shows tooltip for showing pets
    ---@field ShowPetToolTipEnd fun() Ends show pet tooltip
    ---@field HidePetToolTip fun() Shows tooltip for hiding pets
    ---@field HidePetToolTipEnd fun() Ends hide pet tooltip
    ---@field UpdateAnchors fun() Updates anchors for pet health bars
    ---@field OnMouseDrag fun() Handles mouse drag events for window snapping
    ---@field HidePet fun() Hides the pet window and closes pet health bars
    ---@field ShowPet fun() Shows the pet window and updates pets

    ---@class ProfileWindow
    ---@field WindowName string Name of the profile window
    ---@field ProfileLoaded boolean Whether the profile is loaded
    ---@field ProfileId integer ID of the profile being viewed/edited
    ---@field delta number Time delta for updates
    ---@field Retries integer Number of profile load retries
    ---@field Initialize fun() Initializes the profile window
    ---@field Shutdown fun() Shuts down the profile window and saves data
    ---@field TextChange fun() Handles text change events in the profile editor
    ---@field Close fun() Closes the profile window and saves data
    ---@field UpdateProfile fun() Requests and updates the character profile

    ---@class PropertiesInfo
    ---@field Items table Table of property items
    ---@field ITEMPROPERTY_OFFSET integer Offset for item property IDs
    ---@field ITEMPROPICON integer Icon ID for item properties
    ---@field TotalItems integer Total number of property items
    ---@field InSearch boolean Whether a search is in progress
    ---@field Initialize fun() Initializes the properties info window
    ---@field Shutdown fun() Shuts down the properties info window and saves position
    ---@field Close fun() Closes the properties info window
    ---@field Toggle fun() Toggles the properties info window
    ---@field ClearItemList fun() Clears the list of property items
    ---@field Reset fun() Resets the properties info state
    ---@field OnLButtonUpSearch fun() Handles left button up on the search box
    ---@field SearchTooltip fun() Shows tooltip for the search box
    ---@field RemoveFiltersTooltip fun() Shows tooltip for removing filters
    ---@field MoreInfoOnMouseOver fun() Shows tooltip for more info
    ---@field SearchText fun(null: any, text: string) Searches for property items by text
    ---@field RemoveAfterSymbol fun(currentString: string, symbol: string): string Removes text after a symbol
    ---@field Restart fun() Restarts the properties info search and display
    ---@field ItemMouseOver fun() Handles mouse over on a property item

    ---@class QueryWindow
    ---@field lastWindowAnchor string Name of the last window anchor
    ---@field xDimensions integer X dimension of the main query window
    ---@field yDimensions integer Y dimension of the main query window
    ---@field TID table Table of TIDs for UI text (Title, Header, Okay, etc.)
    ---@field Initialize fun() Initializes the query window and registers event handlers
    ---@field CheckQueries fun() Checks and processes pending queries
    ---@field CreateQueryWindow fun() Creates the main query window
    ---@field CheckScannedLegacyMacros fun() Checks for scanned legacy macros and shows options
    ---@field CheckQueriedLegacySettings fun() Checks for queried legacy settings and shows options
    ---@field ScannedLegacyMacros_OptionOne_OnLButtonUp fun() Handles selection of option one for legacy macros
    ---@field ScannedLegacyMacros_OptionTwo_OnLButtonUp fun() Handles selection of option two for legacy macros
    ---@field QueriedLegacySettings_OptionOne_OnLButtonUp fun() Handles selection of option one for legacy settings
    ---@field QueriedLegacySettings_OptionTwo_OnLButtonUp fun() Handles selection of option two for legacy settings
    ---@field QueriedLegacySettings_OptionThree_OnLButtonUp fun() Handles selection of option three for legacy settings
    ---@field Okay_OnLButtonUp fun() Handles clicking the OK button and processes selections

    ---@class QuickStats
    ---@field Settings table Table of quick stat settings
    ---@field Initialized boolean Whether QuickStats is initialized
    ---@field LabelsRefreshRate number Refresh rate for updating labels
    ---@field Labels table Table of quick stat label data
    ---@field Max integer Maximum number of quick stat labels
    ---@field Delta number Time delta for updates
    ---@field InMovement table Table tracking which labels are being moved
    ---@field PickingColor table|nil Current color picking state
    ---@field Initialize fun() Initializes all quick stat labels
    ---@field Shutdown fun() Shuts down QuickStats and saves label data
    ---@field GetId fun() Gets the next available label ID
    ---@field Save fun(label: string) Saves the settings for a label
    ---@field Load fun(label: string): table Loads the settings for a label
    ---@field DeleteSettings fun(label: string) Deletes the settings for a label
    ---@field DoesLabelExist fun(attributeId: integer, isObject: boolean): integer Checks if a label exists for an attribute or object type
    ---@field UpdateLabel fun(label: string) Updates the display of a quick stat label
    ---@field OnUpdate fun(timePassed: number) Periodic update for refreshing labels
    ---@field StatLButtonDown fun(flags: integer) Handles left button down on a stat label
    ---@field StatOnLButtonUp fun() Handles left button up on a stat label
    ---@field FindQuickStatMovingBlock fun(CurWindow: string) Recursively finds and moves connected quick stat labels
    ---@field Context fun() Opens the context menu for a quick stat label
    ---@field ContextMenuCallback fun(returnCode: string, label: string) Handles context menu actions for a label
    ---@field AmountSettings fun(id: integer, amount: number) Sets the minimum quantity warning for a label
    ---@field Destroy fun(windowname: string) Deletes a quick stat label
    ---@field PickColor fun(color: string, windowname: string) Opens the color picker for a label
    ---@field ColorPicked fun() Handles color selection from the color picker

    ---@class RaceChangeWindow
    ---@field TID table Table of TIDs for UI text and labels
    ---@field WindowName string|integer Name or ID of the active window
    ---@field Initialize fun() Initializes the race change window and sets up UI and data
    ---@field HandleOkButton fun() Handles the OK button click, sending selected race/appearance
    ---@field UserClosedWindow fun() Handles user closing the window, sends default values
    ---@field createWearableTable fun(CSVTable: table): table Creates a table of wearable options from a CSV table
    ---@field updateWearableItemIndex fun(appearanceTable: table, appearanceLabel: string, appearanceStyle: integer, increment: boolean|nil): integer Updates the index for a wearable item and label
    ---@field ToggleAppearanceItemUp fun() Handles incrementing appearance item (hair/facial hair) selection
    ---@field ToggleAppearanceItemDown fun() Handles decrementing appearance item (hair/facial hair) selection
    ---@field ShowColorPicker fun() Shows the appropriate color picker window
    ---@field ColorSkin fun() Applies the selected skin color
    ---@field ColorHair fun() Applies the selected hair color
    ---@field ColorFacialHair fun() Applies the selected facial hair color
    ---@field HideColorPickerWindows fun() Hides all color picker windows
    ---@field UpdatePaperdollTextureSize fun() Updates the paperdoll texture size and position
    ---@field UpdateCharacterPaperdoll fun() Updates the character paperdoll with current selections
    ---@field Shutdown fun() Unloads CSV tables and destroys color picker windows
    ---@field OnCloseWindow fun() Handles closing the race change window and cleanup

    ---@class RadarWindow
    ---@field Rotation integer Current rotation angle of the radar
    ---@field Tilt boolean Whether the radar is tilted (rotated)
    ---@field Size integer Size of the radar window
    ---@field Scale number Scale factor for the radar window
    ---@field Locked boolean Whether the radar window is locked
    ---@field Initialize fun() Initializes the radar window and sets up UI and data
    ---@field LockTooltip fun() Shows a tooltip for the lock/unlock button
    ---@field Lock fun() Toggles the locked state of the radar window
    ---@field Shutdown fun() Shuts down the radar window and unregisters data
    ---@field OnMouseDrag fun() Handles mouse drag for moving the radar window
    ---@field UpdateRadar fun() Updates the radar display and waypoints
    ---@field UpdateWaypoints fun() Updates waypoints on the radar
    ---@field ActivateRadar fun() Activates the radar view and updates display
    ---@field ToggleMap fun() Switches to the main map view
    ---@field ToggleMapOnMouseOver fun() Shows tooltip for toggling the map
    ---@field CloseMap fun() Closes the radar and map windows
    ---@field WPLButtonUp fun() Handles left button up on the waypoint button
    ---@field WPButtonMouseOver fun() Shows tooltip for the waypoint button
    ---@field CloseMapOnMouseOver fun() Shows tooltip for closing the map
    ---@field ZoomOutOnMouseOver fun() Shows tooltip for zooming out
    ---@field BigOnMouseOver fun() Shows tooltip for increasing map size
    ---@field BigOnLButtonUp fun() Increases the radar scale
    ---@field TinyOnMouseOver fun() Shows tooltip for decreasing map size
    ---@field TinyOnLButtonUp fun() Decreases the radar scale
    ---@field RotateButtonMouseOver fun() Shows tooltip for the rotate button
    ---@field RotateLButtonUp fun() Toggles radar tilt/rotation
    ---@field ZoomInOnMouseOver fun() Shows tooltip for zooming in
    ---@field RadarOnMouseWheel fun(x: number, y: number, delta: number) Handles mouse wheel for zooming
    ---@field RadarOnLButtonDblClk fun(flags: any, x: number, y: number) Handles double-click to center radar
    ---@field SetRadarCoords fun() Sets the radar coordinates and sextant label

    ---@class RenameWindow
    ---@field TextEntered string|nil The text entered by the user
    ---@field id any ID associated with the rename operation
    ---@field max any Maximum value or constraint for the rename
    ---@field min any Minimum value or constraint for the rename
    ---@field Callfunction fun(id: any, text: string, max: any, min: any)|nil Callback function to call after submit
    ---@field Initialize fun() Initializes the rename window and sets up UI
    ---@field Create fun(rdata: table) Creates and configures the rename window with provided data
    ---@field OnClear fun() Clears the text entry box
    ---@field OnKeyCancel fun() Handles cancel key press
    ---@field OnCancel fun() Cancels and hides the rename window
    ---@field OnSubmit fun() Handles submit action, validates input, and calls callback
    ---@field OnTextChanged fun(text: string) Handles text change events and enforces max length
    ---@field Shutdown fun() Shuts down and hides the rename window

    ---@class SettingsWindow
    ---@field IGNORE_LIST_ALL integer Constant for all ignore list
    ---@field IGNORE_LIST_CONF integer Constant for confirmed ignore list
    ---@field ignoreListType integer Current ignore list type
    ---@field Modes table Table of mode constants and window names
    ---@field LegacyBackpackStyle table[] Array of legacy backpack style options
    ---@field NUM_LEGACYBACKPACKSTYLES integer Number of legacy backpack styles
    ---@field FontSizes integer[] Array of available font sizes
    ---@field NUM_FONT_SIZES integer Number of font sizes
    ---@field ChatFadeTime integer[] Array of chat fade times
    ---@field NUM_FADE_TIMES integer Number of fade times
    ---@field Languages table[] Array of language options
    ---@field NUM_LANGUAGES integer Number of languages
    ---@field ShowNames table[] Array of show name options
    ---@field NUM_SHOWNAMES integer Number of show name options
    ---@field ScrollWheelBehaviors table[] Array of scroll wheel behavior options
    ---@field NUM_SCROLLWHEELBEHAVIORS integer Number of scroll wheel behaviors
    ---@field ScrollWheelBehaviors_Legacy table[] Array of legacy scroll wheel behaviors
    ---@field NUM_SCROLLWHEELBEHAVIORS_LEGACY integer Number of legacy scroll wheel behaviors
    ---@field DelayValues integer[] Array of delay TIDs
    ---@field NUM_DELAY_VALUES integer Number of delay values
    ---@field ContainerViewOptions table[] Array of container view options
    ---@field ObjectHandles table[] Array of object handle filter options
    ---@field NUM_OBJHANDLE_FILTERS integer Number of object handle filters
    ---@field ObjectHandleSizes integer[] Array of object handle sizes
    ---@field Keybindings table[] Array of keybinding definitions
    ---@field NON_LEGACY_BINDING_MIN integer Minimum index for non-legacy keybindings
    ---@field NON_LEGACY_BINDING_MAX integer Maximum index for non-legacy keybindings
    ---@field TID table Table of TIDs for UI text and labels
    ---@field DetailTID table Table of detail TIDs for UI elements
    ---@field TID_BINDING_CONFLICT_TITLE integer TID for binding conflict title
    ---@field TID_BINDING_CONFLICT_BODY integer TID for binding conflict body
    ---@field TID_BINDING_CONFLICT_QUESTION integer TID for binding conflict question
    ---@field TID_YES integer TID for 'Yes'
    ---@field TID_NO integer TID for 'No'
    ---@field TID_INFO integer TID for 'Info'
    ---@field TID_RESETLEGACYBINDINGS_CHAT integer TID for resetting legacy bindings (chat)
    ---@field TID_RESETDEFAULTBINDINGS integer TID for resetting default bindings
    ---@field TID_RESETCHATSETTINGS integer TID for resetting chat settings
    ---@field TID_FRAMERATE integer[] Array of framerate TIDs
    ---@field TID_DETAILS integer[] Array of detail TIDs
    ---@field TID_FILTERS integer[] Array of filter TIDs
    ---@field TID_ANIMATION integer[] Array of animation TIDs
    ---@field RecordingKey boolean Whether a key is being recorded
    ---@field PreviousBadWordCount integer Previous count of bad words
    ---@field PreviousIgnoreListCount integer Previous count of ignore list
    ---@field CurIgnoreListIdx integer Current index in ignore list
    ---@field PreviousIgnoreConfListCount integer Previous count of confirmed ignore list
    ---@field CurIgnoreConfListIdx integer Current index in confirmed ignore list
    ---@field Initialize fun() Initializes the settings window and sets up UI and data
    ---@field ResetScrollWheelOptions fun() Resets scroll wheel options to default
    ---@field RefreshScrollWheelComboBoxes fun() Refreshes the scroll wheel combo boxes
    ---@field ToggleSettingsWindow fun() Toggles the settings window
    ---@field UpdateVolumeSliderSettings fun() Updates the volume slider UI
    ---@field UpdateSliderSettings fun(curPos: number) Updates slider settings for various options
    ---@field UpdateSettings fun() Updates the settings UI to reflect current values
    ---@field UpdateKeyBindings fun() Updates the key bindings UI
    ---@field OnDefaultKeyPressed fun() Handles default key pressed for keybindings
    ---@field ResetLegacyKeyBindings fun() Resets keybindings to legacy defaults
    ---@field ResetMMOKeyBindings fun() Resets keybindings to MMO defaults
    ---@field UpdateLegacyTargetBindingsText fun() Updates legacy target bindings text
    ---@field OnOkayButton fun() Handles the OK button click
    ---@field OnApplyButton fun() Handles the Apply button click

    ---@class Shopkeeper
    ---@field TID table Table of TIDs for UI text and labels
    ---@field REFRESH_DELAY number Delay between refreshes
    ---@field QUANTITY_DELAY number Delay for quantity updates
    ---@field LEFT_SIDE_ID integer Constant for left side ID
    ---@field RIGHT_SIDE_ID integer Constant for right side ID
    ---@field CurrentAmountArray table Table tracking current item amounts by type/hue
    ---@field Buying table Table tracking current buying state
    ---@field Patterns table Array of search patterns
    ---@field stripFirstNumber fun(wStr: string|wstring): wstring Strips the first number from a string
    ---@field GetItemIndexById fun(merchantId: any, itemId: any): integer|nil Gets the item index by ID
    ---@field Initialize fun() Initializes the shopkeeper window and sets up UI/data
    ---@field OnUpdate fun(timePassed: number) Updates timers and refreshes lists
    ---@field UpdateSellItems fun(this: string, merchantId: any) Updates the list of sellable items
    ---@field HandleUpdateBuyItemsEvent fun() Handles event for updating buy items
    ---@field UpdateBuyItems fun(this: string, merchantId: any) Updates the list of buyable items
    ---@field HandleUpdateObjectEvent fun() Handles event for updating object info
    ---@field HandleUpdateObjectNameEvent fun() Handles event for updating object name
    ---@field UpdateBuyObject fun(this: string, merchantId: any, objectId: any) Updates a buyable object's data
    ---@field UpdateItemIcon fun(merchantId: any, elementIcon: string, itemData: table) Updates the item icon
    ---@field RemoveFiltersTooltip fun() Shows tooltip for removing filters
    ---@field Restart fun() Restarts the shopkeeper search and refreshes lists
    ---@field SearchTooltip fun() Shows tooltip for search box
    ---@field OnLButtonUpSearch fun() Handles search box submit
    ---@field RefreshLists fun(window: string, merchantId: any) Refreshes the item lists
    ---@field BuyContext fun() Opens the buy context menu
    ---@field ContextMenuCallback fun(returnCode: any, param: any) Handles buy context menu selection
    ---@field BuyTooltip fun() Shows tooltip for buy agent
    ---@field OnItemClicked fun() Handles item click for targeting
    ---@field BuyAgent fun() Handles automated buying via agent
    ---@field SellContext fun() Opens the sell context menu
    ---@field ContextSellMenuCallback fun(returnCode: any, param: any) Handles sell context menu selection
    ---@field SellTooltip fun() Shows tooltip for sell agent
    ---@field SellAgent fun() Handles automated selling via agent
    ---@field ItemMouseOver fun() Handles mouse over for item properties
    ---@field OnBuyOne fun() Handles buying a single item (with quantity dialog)
    ---@field BuyHowMuch fun(j: any, amt: any) Handles quantity input for buying
    ---@field OnBuyMore fun() Increases quantity for an item
    ---@field OnBuyLess fun() Decreases quantity for an item
    ---@field OnStopUpdating fun() Stops quantity updating
    ---@field OnBuyAll fun() Buys all available quantity for an item
    ---@field UpdateItemRightQuantity fun(this: string, merchantId: any, itemIndex: integer, amount: integer) Updates right quantity for an item
    ---@field Shutdown fun() Shuts down the shopkeeper window and unregisters data
    ---@field UpdatePlayersGold fun(merchantId: any) Updates the player's gold display
    ---@field PurchaseItems fun() Finalizes the purchase of selected items
    ---@field CancelPurchase fun() Cancels the current purchase and resets quantities

    ---@class SkillsInfo
    ---@field DisplaySkill integer Currently displayed skill index
    ---@field Initialize fun() Initializes the skills info window and sets up UI
    ---@field Shutdown fun() Saves the window position and performs cleanup
    ---@field ClearGump fun() Clears the skill info gump and destroys dynamic windows
    ---@field UpdateGump fun(DisplaySkill: integer) Updates the skill info gump for the given skill

    ---@class SkillsTracker
    ---@field Created boolean Whether the skills tracker has been created
    ---@field Init boolean Whether the skills tracker has been initialized
    ---@field ShowAllMySkills boolean Whether to show all skills or only custom skills
    ---@field Initialize fun() Initializes the skills tracker window and sets up UI
    ---@field Shutdown fun() Shuts down the skills tracker and cleans up
    ---@field Context fun() Opens the context menu for skill tracking options
    ---@field ContextMenuCallback fun(returnCode: string, param: any) Handles context menu selection
    ---@field Update fun() Updates the skills tracker display and tracked skills
    ---@field UpdateSkill fun(index: integer, skillId?: integer) Updates the display for a specific skill

    ---@class SkillsWindow
    ---@field CUSTOM_TAB_NUM integer Index for the custom skills tab
    ---@field ContextReturnCodes table Table of context menu return codes
    ---@field TID_ADD_TO_CUSTOM integer TID for 'Add to Custom'
    ---@field TID_REMOVE_CUSTOM integer TID for 'Remove from Custom'
    ---@field TID_CUSTOM_HELP integer TID for custom help
    ---@field NUM_SKILLS_PER_TAB integer Number of skills per tab
    ---@field SessionGains table Table tracking session skill gains
    ---@field SkillDataMode integer 0 = real skill value, 1 = skill with mods
    ---@field SkillCapMode integer 0 = don't show skill caps, 1 = show skill caps
    ---@field SkillsTrackerMode integer 0 = don't show tracker, 1 = show tracker
    ---@field Delta number Time delta for updates
    ---@field SkillTargetVals table Table of skill target values
    ---@field Initialize fun() Initializes the skills window and sets up UI/data
    ---@field UpdateTotalSkillPoints fun() Updates the total skill points display
    ---@field DoNothing fun() Dummy function
    ---@field ToggleSkillsWindow fun() Toggles the skills window
    ---@field OnUpdate fun(timepassed: number) Handles periodic updates
    ---@field EnableAllTabs fun(parent: string) Enables all tab buttons
    ---@field DisableTab fun(parent: string, tabNum: integer) Disables a specific tab button
    ---@field UpdateAllSkills fun() Updates all skills and redraws the window
    ---@field UpdateSkill fun() Updates a specific skill based on event
    ---@field ForceActiveTabSetting fun(tabnum: integer) Forces the active tab setting
    ---@field ShowTab fun(tabnum: integer) Shows the specified tab and updates its contents
    ---@field Shutdown fun() Shuts down the skills window and unregisters data
    ---@field SkillLButtonDown fun(flags: integer) Handles left button down on a skill
    ---@field SkillsLockLButtonUp fun() Handles lock all skills button up
    ---@field SkillsDownLButtonUp fun() Handles down all skills button up
    ---@field LockSkills fun() Locks all skills
    ---@field DownSkills fun() Sets all skills to down state
    ---@field SkillLButtonUp fun() Handles left button up on a skill (use skill)
    ---@field UseSkill fun(skillId: integer) Uses a skill by server ID
    ---@field SkillMouseOver fun() Handles mouse over on a skill for tooltip
    ---@field ToggleTab fun() Handles tab toggle
    ---@field SetStateButton fun(button: string, val: integer) Sets the state button graphic
    ---@field CycleLButtonUp fun() Cycles the skill state button
    ---@field CycleMouseOver fun() Shows tooltip for cycle button
    ---@field FormatSkillValue fun(skillLevel: integer): wstring Formats a skill value as a percentage string
    ---@field GetSkillTitle fun(skillLevel: integer): wstring Gets the skill title string based on value
    ---@field SkillValueTypeToggleLButtonUp fun() Toggles between real and modified skill values
    ---@field UpdateSkillValueTypeToggleButtonText fun() Updates the skill value type toggle button text
    ---@field SkillCapToggleLButtonUp fun() Toggles skill cap display
    ---@field UpdateSkillCapToggleButtonText fun() Updates the skill cap toggle button text
    ---@field SkillsTrackerToggleLButtonUp fun() Toggles the skills tracker window
    ---@field UpdateSkillsTrackerToggleButtonText fun() Updates the skills tracker toggle button text
    ---@field CheckSkillForUpdate fun(skill: integer): integer Checks if a skill needs updating
    ---@field CheckAllSkillsForUpdate fun() Checks all skills for updates
    ---@field SaveCurrentSkillValue fun(skill: integer) Saves the current value of a skill
    ---@field SaveCurrentSkillValues fun() Saves current values for all skills
    ---@field ContextMenuCallback fun(returnCode: any, param: any) Handles context menu actions
    ---@field SetAutoLock fun(id: integer, value: any, max: any, min: any) Sets an auto-lock value for a skill
    ---@field SkillRButtonUp fun() Handles right button up on a skill for context menu
    ---@field ToggleHelpButton fun() Shows the help window for a skill
    ---@field MoreInfoOnMouseOver fun() Shows tooltip for more info button

    ---@class Spellbook
    ---@field uniqueOrdinals wstring[] Array of ordinal suffixes ("st", "nd", "rd", etc.)
    ---@field bardMasteries wstring[] Array of bard mastery names
    ---@field TID table Table of TIDs for UI text and labels
    ---@field TID_MASTERY_DISCORD integer TID for Discordance mastery
    ---@field TID_MASTERY_PROVOCATION integer TID for Provocation mastery
    ---@field TID_MASTERY_PEACEMAKING integer TID for Peacemaking mastery
    ---@field TID_MASTERY_MAGERY integer TID for Magery mastery
    ---@field TID_MASTERY_MYSTICISM integer TID for Mysticism mastery
    ---@field TID_MASTERY_NECRO integer TID for Necromancy mastery
    ---@field TID_MASTERY_SPELLWEAVING integer TID for Spellweaving mastery
    ---@field TID_MASTERY_BUSHIDO integer TID for Bushido mastery
    ---@field TID_MASTERY_CHIVALRY integer TID for Chivalry mastery
    ---@field TID_MASTERY_NINJITSU integer TID for Ninjitsu mastery
    ---@field TID_MASTERY_FENCING integer TID for Fencing mastery
    ---@field TID_MASTERY_MACE integer TID for Mace mastery
    ---@field TID_MASTERY_SWORDS integer TID for Swords mastery
    ---@field TID_MASTERY_THROWING integer TID for Throwing mastery
    ---@field TID_MASTERY_PARRY integer TID for Parry mastery
    ---@field TID_MASTERY_POISON integer TID for Poison mastery
    ---@field TID_MASTERY_WRESTILING integer TID for Wrestling mastery
    ---@field TID_MASTERY_ANIMAL_TAMING integer TID for Animal Taming mastery
    ---@field TID_MASTERY_ARCHERY integer TID for Archery mastery
    ---@field MASTERY_COUNT integer Number of masteries
    ---@field ActiveMastery integer Currently active mastery TID
    ---@field MasteryBookTIDs integer[] Array of mastery book TIDs
    ---@field MAX_MASTERY_SPELL_COUNT integer Maximum number of mastery spells per mastery
    ---@field ActiveMasteryIndex table Table mapping mastery TIDs to spell indices
    ---@field UpdateMasteryBook integer Flag for updating mastery book
    ---@field baseTid integer Base TID for spellbook
    ---@field numSpellsPerTab table Table mapping first spell number to number of spells per tab
    ---@field MAX_SPELLS_PER_TAB integer Maximum number of spells per tab
    ---@field tithId integer Tithing stat ID
    ---@field OpenSpellbooks table Table tracking open spellbook windows
    ---@field Init boolean Whether the spellbook is initialized
    ---@field AnimWin string Name of the animated window
    ---@field startStart boolean Animation start flag
    ---@field endStart boolean Animation end flag
    ---@field delta number Animation delta timer
    ---@field Initialize fun() Initializes the spellbook window and sets up UI/data
    ---@field OnShown fun() Handles the spellbook window being shown
    ---@field SpellContext fun() Opens the context menu for a spell
    ---@field OnKeyHide fun() Handles key press to hide the spellbook
    ---@field Hide fun() Hides the spellbook window
    ---@field OnUpdate fun(timePassed: number) Handles periodic updates and animation
    ---@field UpdateTithing fun() Updates the tithing points display
    ---@field CreateTabs fun(parent: string, numTabs: integer) Creates spellbook tabs
    ---@field CreateTabsLarge fun(parent: string, numTabs: integer) Creates large spellbook tabs
    ---@field UnselectAllTabs fun(parent: string, numTabs: integer) Unselects all tabs
    ---@field SelectTab fun(parent: string, tabNum: integer) Selects a specific tab
    ---@field UpdateSpells fun() Updates the spells displayed in the spellbook
    ---@field ShowTab fun(tabnum: integer) Shows the specified tab and updates its contents
    ---@field InitMasteryIndexTab fun() Initializes the mastery index tab
    ---@field Shutdown fun() Shuts down the spellbook window and unregisters data
    ---@field SpellLButtonDown fun(flags: integer) Handles left button down on a spell
    ---@field SpellLButtonUp fun() Handles left button up on a spell (cast spell)
    ---@field SpellMouseOver fun() Handles mouse over on a spell for tooltip
    ---@field ToggleTab fun() Handles tab toggle
    ---@field RegisterSpellIcon fun(spellbookId: integer, buttonId: integer, serverId: integer) Registers a spell icon for hotbar
    ---@field ShutdownSpellIcon fun() Unregisters a spell icon
    ---@field TithLButtonDown fun(flags: integer) Handles left button down on tithing stat
    ---@field SetMiniIconStats fun(iconWindow: string, iconId: integer) Sets the mini icon for stats
    ---@field TithMouseOver fun() Shows tooltip for tithing stat
    ---@field IsMasteryBook fun(id: integer): boolean Checks if the spellbook is a mastery book
    ---@field OnMasteryUpdate fun(windowName: string) Handles updates for mastery books

    ---@class SpellsInfo
    ---@field PHYSICAL table Color for physical spells (r, g, b)
    ---@field FIRE table Color for fire spells (r, g, b)
    ---@field COLD table Color for cold spells (r, g, b)
    ---@field POISON table Color for poison spells (r, g, b)
    ---@field ENERGY table Color for energy spells (r, g, b)
    ---@field Chaos table Color for chaos spells (r, g, b)
    ---@field Initialize fun() Initializes the SpellsInfo data and spell definitions
    ---@field GetMinSkill fun(spellId: integer): number Gets the minimum skill required for a spell
    ---@field GetMaxSkill fun(minSkill: number, spellId: integer): number Gets the maximum skill for a spell
    ---@field GetVariation fun(spellId: integer): number Gets the skill variation for a spell
    ---@field GetSkillID fun(spellId: integer): integer Gets the skill ID associated with a spell
    ---@field GetSpellDamage fun(spellId: integer): wstring Gets the spell damage string for a spell
    ---@field GetRecoverySpeed fun(): number Gets the spell recovery speed
    ---@field GetSpellSpeed fun(spellId: integer): number Gets the spell casting speed
    ---@field SumonFamiliarSkillRequirements fun(animalTid: integer): integer Checks if the player meets requirements for summoning a familiar
    ---@field AnimalFormSkillRequirements fun(animalTid: integer): integer Checks if the player meets requirements for animal form
    ---@field GetButtonIDST fun(buttonId: integer): integer Gets the spell trigger button ID
    ---@field GetButtonID fun(animalTid: integer): integer Gets the animal form button ID

    ---@class StartMenu
    ---@field StartData table Table containing start menu button data
    ---@field GetData fun(): table Gets the data for the current start menu button
    ---@field Initialize fun() Initializes the start menu button
    ---@field Shutdown fun() Handles shutdown for the start menu
    ---@field ToggleStartMenu fun() Toggles the start menu window
    ---@field OnMouseoverStartMenuBtn fun() Shows tooltip for the start menu button

    ---@class StaticTextWindow
    ---@field FadeTimeId table Table tracking fade times for each static text window
    ---@field TimePassed table Table tracking time passed for each static text window
    ---@field AlphaStart number Starting alpha value for fade
    ---@field AlphaDiff number Alpha difference per fade step
    ---@field FadeStartTime number Time before fade starts
    ---@field numWindow integer Number of static text windows created
    ---@field Gray table Color for static text (r, g, b)
    ---@field Initialize fun() Initializes the static text window system and registers event handlers
    ---@field CreateWindow fun() Creates a new static text window
    ---@field DestroyAllWindows fun() Destroys all static text windows
    ---@field HandleAnchorWindow fun(windowName: string, xPosition: number, yPosition: number) Anchors a window at the specified position
    ---@field Shutdown fun() Handles shutdown for a static text window
    ---@field Update fun(timePassed: number) Updates fade and removal of static text windows

    ---@class StringUtils
    ---@field SORT_ORDER_UP integer Constant for ascending sort order
    ---@field SORT_ORDER_DOWN integer Constant for descending sort order
    ---@field FormatNumberWString fun(number: number): wstring Formats a number as a wstring with commas
    ---@field SortByString fun(string1: string, string2: string, order: integer): boolean Sorts two strings by order

    ---@class TextParsing
    ---@field OverHeadError table Color for overhead error text (r, g, b)
    ---@field SpecialColor table Color for special text (r, g, b)
    ---@field PHYSICAL table Color for physical text (r, g, b)
    ---@field FIRE table Color for fire text (r, g, b)
    ---@field COLD table Color for cold text (r, g, b)
    ---@field POISON table Color for poison text (r, g, b)
    ---@field ENERGY table Color for energy text (r, g, b)
    ---@field Chaos table Color for chaos text (r, g, b)
    ---@field Heal table Color for heal text (r, g, b)
    ---@field Curse table Color for curse text (r, g, b)
    ---@field Paralyze table Color for paralyze text (r, g, b)
    ---@field Neutral table Color for neutral text (r, g, b)
    ---@field Green table Color for green text (r, g, b)
    ---@field SpecialColorsString table Table of special color strings
    ---@field SpecialColors table Table of special color TIDs
    ---@field Specials table Table of special TIDs and their colors
    ---@field OverHeadErrorsString table Table of overhead error strings
    ---@field OverHeadErrors table Table of overhead error TIDs
    ---@field PoisonMessages table Table of poison message TIDs
    ---@field TauntsTable table Table mapping taunt strings to sound IDs
    ---@field Fame table Table of fame TIDs
    ---@field Karma table Table of karma TIDs
    ---@field Emotize fun(string: wstring): wstring Formats a string as an emote
    ---@field ColorizeText fun() Determines the color and channel for a given text
    ---@field CenterScreenText fun() Handles center screen text events
    ---@field TimersNbuff fun() Handles timers and buffs based on text events
    ---@field SpellCasting fun() Handles spell casting related text events
    ---@field SpecialTexts fun() Handles special text events and formatting
    ---@field IgnoreTextManager fun(): boolean Determines if a text should be ignored
    ---@field ForceOverhead fun() Forces certain text to display as overhead text
    ---@field Taunts fun() Handles taunt sound effects based on text

    ---@class TipoftheDayWindow
    ---@field tipIndex integer Current index of the displayed tip
    ---@field saveOnClose boolean Whether to save settings on close
    ---@field TID table Table of TIDs for UI text (TipoftheDay, DoNotShow, Next, Close)
    ---@field Initialize fun() Initializes the Tip of the Day window and displays a random tip
    ---@field Shutdown fun() Shuts down the Tip of the Day window and saves settings
    ---@field GetRandomTip fun() Selects and displays a random tip
    ---@field ButtonUpNext fun() Advances to the next tip and updates the display
    ---@field ButtonUpClose fun() Closes the Tip of the Day window
    ---@field ButtonUpShowOption fun() Toggles the 'Show Tip of the Day' option and updates the button state

    ---@class Tooltips
    ---@field ANCHOR_WINDOW_LEFT table Anchor position for window left
    ---@field ANCHOR_WINDOW_RIGHT table Anchor position for window right
    ---@field ANCHOR_WINDOW_TOP table Anchor position for window top
    ---@field ANCHOR_WINDOW_BOTTOM table Anchor position for window bottom
    ---@field ANCHOR_SCREEN_BOTTOM_RIGHT integer Anchor constant for screen bottom right
    ---@field NUM_ROWS integer Number of rows in the tooltip
    ---@field NUM_COLUMNS integer Number of columns in the tooltip
    ---@field ROW_SPACING integer Spacing between rows
    ---@field BORDER_SIZE integer Size of the tooltip border
    ---@field MAX_WIDTH integer Maximum width of the tooltip
    ---@field Initialize fun() Initializes the tooltip system and creates the default tooltip window
    ---@field Update fun(timePassed: number) Updates the tooltip display and handles mouseover changes
    ---@field ClearTooltip fun() Clears the current tooltip and hides the window
    ---@field AnchorTooltipManual fun(anchorPoint: string, anchorToWindow: string, anchorRelativePoint: string, anchorOffsetX: integer, anchorOffsetY: integer) Manually anchors the tooltip window
    ---@field AnchorTooltip fun(anchor: table) Anchors the tooltip window using a predefined anchor table
    ---@field CreateTextOnlyTooltip fun(mouseOverWindow: string, text: wstring) Creates a text-only tooltip for a window
    ---@field CreateCustomTooltip fun(mouseOverWindow: string, tooltipWindow: string) Creates a custom tooltip window
    ---@field SetUpdateCallback fun(callbackFunction: fun(timePassed: number)) Sets a callback function for updating the tooltip
    ---@field SetTooltipAlpha fun(alpha: number) Sets the alpha transparency of the tooltip window
    ---@field SetTooltipText fun(row: integer, column: integer, text: wstring) Sets the text for a specific row and column in the tooltip
    ---@field SetTooltipFont fun(row: integer, column: integer, font: string, linespacing: number) Sets the font for a specific row and column
    ---@field SetTooltipColor fun(row: integer, column: integer, red: integer, green: integer, blue: integer) Sets the text color for a specific row and column
    ---@field Finalize fun() Finalizes the tooltip layout and dimensions

    ---@class TrackingPointer
    ---@field TrackWaypoints table Table of tracking pointer waypoint data by window ID
    ---@field OnInitialize fun() Initializes the tracking pointer window and registers event handlers
    ---@field OnShutdown fun() Shuts down the tracking pointer window and unregisters event handlers
    ---@field UpdateAll fun(timePassed: number) Updates all tracking pointers for waypoints
    ---@field Update fun() Updates the tracking pointer for the current window

    ---@class TradeWindow
    ---@field TradeInfo table Table of trade information for each window (container IDs, player/trade names, gold/platinum amounts, etc.)
    ---@field RegisteredItems table Table of registered item IDs by container
    ---@field OpenContainers table Table tracking open trade containers by window
    ---@field NumCreatedSlots table Table tracking number of created slots by window and container
    ---@field StringText integer[] Array of TIDs for trade window UI text
    ---@field OnCloseDialog fun() Handles closing the trade dialog and broadcasts the close event
    ---@field Initialize fun() Initializes the trade window and sets up UI and event handlers
    ---@field UpdateBalance fun() Updates the displayed gold and platinum balances
    ---@field ModifyTheirGold fun() Updates the displayed gold and platinum amounts for the other party
    ---@field ReleaseRegisteredInfo fun() Releases registered window and container data
    ---@field Shutdown fun() Shuts down the trade window and clears registered info
    ---@field ReleaseRegisteredObjects fun(parentWindow: string, containerId: integer) Releases registered object data for a container
    ---@field HideAllContents fun(parent: string, amount: integer) Hides all item slots in a container
    ---@field CreateSlots fun(parentWindow: string, nextWindow: string, low: integer, high: integer) Creates item slots for a container
    ---@field UpdateContents fun(contId: integer, win?: string, force?: boolean) Updates the contents of a trade container
    ---@field DropObjectInContainer fun(currWindow: string, playerWindow: string, parentWindow: string) Handles dropping an object into a container
    ---@field IsPlayerContainer fun(currWindow: string, parentWindow: string): boolean Checks if a window is the player's container
    ---@field IsTraderContainer fun(currWindow: string, parentWindow: string): boolean Checks if a window is the trader's container
    ---@field OnContainerRelease fun() Handles releasing an item into a container
    ---@field OnItemRelease fun() Handles releasing an item in the trade window
    ---@field OnItemDblClicked fun() Handles double-clicking an item in the trade window
    ---@field ItemMouseOver fun() Handles mouseover events for trade items
    ---@field OnAccept fun() Handles accepting the trade offer
    ---@field CloseWindow fun() Closes the trade window
    ---@field AcceptMessage fun() Updates the accept/cancel state and UI
    ---@field MiniModelUpdate fun() Handles updates to the container model
    ---@field HandleUpdateObjectEvent fun() Handles updates to object data
    ---@field UpdateObject fun(window: string, updateId: integer) Updates the display for a specific object in the trade window
    ---@field DangerMouseOver fun() Shows a tooltip for dangerous trades
    ---@field MyTradeTotalGoldMouseOver fun() Shows a tooltip for the player's total gold
    ---@field MyTradeTotalPlatMouseOver fun() Shows a tooltip for the player's total platinum
    ---@field TheirTradeTotalGoldMouseOver fun() Shows a tooltip for the other party's total gold
    ---@field TheirTradeTotalPlatMouseOver fun() Shows a tooltip for the other party's total platinum
    ---@field BalanceGoldMouseOver fun() Shows a tooltip for the gold balance
    ---@field BalancePlatMouseOver fun() Shows a tooltip for the platinum balance
    ---@field OnKeyDown fun() Handles key down events for gold/platinum input
    ---@field OnKeyEnter fun() Handles enter key events for input fields
    ---@field OnKeyTab fun() Handles tab key events for input fields
    ---@field OnLButtonDown fun() Handles left mouse button down events for input fields
    ---@field OnTextChanged fun() Handles text change events for input fields
    ---@field OnUpdate fun() Handles periodic updates for the trade window

    ---@class UO_DefaultWindow
    ---@field WindowDestroyQueue table Queue of windows to be destroyed
    ---@field Initialize fun() Initializes the default window and sets background alpha
    ---@field CloseDialog fun() Handles closing the default dialog window, including callbacks and destruction
    ---@field CloseTooltip fun() Shows a tooltip for the close button
    ---@field CloseParent fun() Hides the parent window of the current window
    ---@class UO_StandardDialog
    ---@field DialogData table Table of dialog data for each open dialog window
    ---@field DIALOG_EDGE_PADDING integer Edge padding for dialog windows
    ---@field Y_PADDING integer Vertical padding for dialog windows
    ---@field MIN_HEIGHT integer Minimum height for dialog windows
    ---@field TID_OKAY integer TID for the OKAY button
    ---@field TID_CANCEL integer TID for the CANCEL button
    ---@field DefaultButtons table Default button configuration for dialogs
    ---@field CreateDialog fun(dialogData: table): string|boolean Creates a new standard dialog window
    ---@field Initialize fun() Initializes a standard dialog window and sets up UI
    ---@field Shutdown fun() Shuts down a standard dialog window and clears dialog data
    ---@field OnLButtonUp fun() Handles left mouse button up events for dialog buttons

    ---@class UserWaypointWindow
    ---@field TID table Table of TIDs for UI text and labels
    ---@field Params table|nil Parameters for the current waypoint operation
    ---@field XYcoords boolean Whether the window is using X/Y coordinates (true) or latitude/longitude (false)
    ---@field Icons table[] Array of icon definitions (id, name)
    ---@field IconScaleUp fun() Increases the scale of the waypoint icon
    ---@field ScaleUpOnMouseOver fun() Shows a tooltip for scaling up the icon
    ---@field IconScaleDown fun() Decreases the scale of the waypoint icon
    ---@field ScaleDownOnMouseOver fun() Shows a tooltip for scaling down the icon
    ---@field Initialize fun() Initializes the user waypoint window and sets up UI
    ---@field Shutdown fun() Shuts down the user waypoint window and unregisters data
    ---@field InitializeCreateWaypointData fun(params: table) Initializes the window for creating a new waypoint
    ---@field OnKeyTab fun() Handles tab key events for input fields
    ---@field InitializeViewWaypointData fun(params: table) Initializes the window for viewing a waypoint
    ---@field ToggleCoord fun() Toggles between X/Y and latitude/longitude coordinate input
    ---@field ToggleCoordMouseOver fun() Shows a tooltip for the coordinate toggle button
    ---@field UpdateCoordInfo fun(x: number, y: number, facet: integer) Updates the coordinate display fields
    ---@field OnOkay fun() Handles the OK button click to create or update a waypoint
    ---@field OnKeyCancel fun() Handles the cancel key press
    ---@field OnCancel fun() Handles the cancel button click
    ---@field OnSelChanged fun() Handles changes to the selected icon

    ---@class VendorSearch
    ---@field WindowName string Name of the vendor search window
    ---@field HoldOn boolean Whether to prevent the window from closing during reload
    ---@field PriceSortSet integer Current price sort state
    ---@field TotalCriteriaExpected integer Number of expected search criteria
    ---@field SearchGumpId integer Gump ID for vendor search
    ---@field NumberOfCatagories integer Number of search categories
    ---@field Initialize fun() Initializes the vendor search window and sets up UI
    ---@field Shutdown fun() Shuts down the vendor search window and saves state
    ---@field CountCriteria fun(): integer Counts the number of current search criteria
    ---@field GetError fun(): integer|nil Gets the current error TID if present
    ---@field UpdateButtonsMap fun() Updates the mapping of search criteria buttons
    ---@field RemoveCriteriaTooltip fun() Shows a tooltip for removing a search criteria
    ---@field LowHighButtonTooltip fun() Shows a tooltip for the price sort button
    ---@field LowHighButton fun() Toggles the price sort order
    ---@field ToggleAuctionButtonTooltip fun() Shows a tooltip for the auction toggle button
    ---@field ToggleAuctionButton fun() Toggles the auction search state
    ---@field OnItemNameTextChanged fun(text: wstring) Handles changes to the item name text box
    ---@field SearchName fun() Initiates a search by item name
    ---@field ADDButtonTooltip fun() Shows a tooltip for the add button
    ---@field OnMinPriceTextChanged fun(text: wstring) Handles changes to the minimum price text box
    ---@field OnMaxPriceTextChanged fun(text: wstring) Handles changes to the maximum price text box
    ---@field SearchPrice fun() Initiates a search by price range
    ---@field OnTextChanged fun(text: wstring) Handles changes to generic text boxes
    ---@field SearchCombo fun() Initiates a search using a combo box selection
    ---@field OnComboSelChanged fun(selectedIndex: integer) Handles changes to combo box selections
    ---@field ClearAll fun() Clears all search criteria
    ---@field SearchThis fun() Initiates the vendor search
    ---@field OnUpdate fun(timePassed: number) Periodic update for the vendor search window
    ---@field SetLoading fun(load: boolean) Sets the loading state for the window

    ---@class WarShield
    ---@field ShieldHandle boolean Whether the shield handle is currently shown
    ---@field OnInitialize fun() Initializes the WarShield window and hides the handle
    ---@field Shutdown fun() Saves the WarShield window position
    ---@field ShieldOver fun() Shows the shield handle when hovered
    ---@field ShieldOnLButtonDown fun() Starts window snapping when the shield handle is clicked
    ---@field ShieldOverend fun() Hides the shield handle when hover ends

    ---@class Waypoints
    ---@field Facet table[] Array of facet waypoint tables, each containing waypoint data (x, y, z, type, Name, Icon, Scale, etc.)

    ---@class WindowUtils
    ---@field resizing boolean Whether a window is currently being resized
    ---@field resizeWindow string|nil Name of the window being resized
    ---@field resizeAnchor string Anchor point for resizing
    ---@field resizeEndCallback fun(windowName: string)|nil Callback for when resizing ends
    ---@field resizeMin table Minimum dimensions for resizing (x, y)
    ---@field DRAG_PICKUP_TIME integer Time in seconds to pick up a drag
    ---@field DRAG_DISTANCE integer Distance in pixels to start a drag
    ---@field dragging boolean Whether a window is currently being dragged
    ---@field dragCallback fun(data: any)|nil Callback for when dragging ends
    ---@field dragData any Data associated with the drag
    ---@field dragTime number Time remaining for drag pickup
    ---@field dragX number|nil X position where drag started
    ---@field dragY number|nil Y position where drag started
    ---@field openWindows table Table of currently open windows
    ---@field trackSize table Table tracking which windows track their size
    ---@field FONT_DEFAULT_TEXT_LINESPACING integer Default line spacing for text
    ---@field FONT_DEFAULT_SUB_HEADING_LINESPACING integer Default line spacing for subheadings
    ---@field Initialize fun() Initializes the WindowUtils system and creates utility windows
    ---@field Update fun(timePassed: number) Updates resizing and dragging state
    ---@field BeginResize fun(windowName: string, anchorCorner: string, minX: integer, minY: integer, lockRatio: boolean, endCallback: fun(windowName: string)) Begins resizing a window
    ---@field BeginDrag fun(callback: fun(data: any), data: any) Begins dragging a window
    ---@field EndDrag fun() Ends the current drag operation
    ---@field OnLButtonUp fun(flags: any, x: number, y: number) Handles left mouse button up events for resizing and dragging
    ---@field GetTopmostDialog fun(wndName: string): string Gets the topmost dialog window for a given window name
    ---@field GetActiveDialog fun(): string Gets the currently active dialog window
    ---@field SetActiveDialogTitle fun(title: wstring) Sets the title of the active dialog window
    ---@field SetWindowTitle fun(window: string, title: wstring) Sets the title of a window
    ---@field RetrieveWindowSettings fun() Restores positions for all open windows
    ---@field ForceResetWindowPositions fun() Resets positions for all open windows
    ---@field SendWindowSettings fun() Saves positions for all open windows
    ---@field CanRestorePosition fun(window: string): boolean Checks if a window's position can be restored
    ---@field RestoreWindowPosition fun(window: string, trackSize?: boolean, alias?: string, ignoreBounds?: boolean) Restores a window's position
    ---@field ForceResetWindowPosition fun(window: string) Resets a window's position to default
    ---@field SaveWindowPosition fun(window: string, closing?: boolean, alias?: string) Saves a window's position
    ---@field ClearWindowPosition fun(window: string) Clears a window's saved position
    ---@field translateMarkup fun(str: wstring): wstring Translates HTML markup in a string to plain text
    ---@field translateLinkTag fun(str: wstring): wstring Translates legacy link tags to new format
    ---@field AddCommasToNumber fun(str: wstring): wstring Adds commas to a number string
    ---@field ProcessLink fun(linkParam: wstring) Processes a link (e.g., opens a browser)
    ---@field ScrollToElementInScrollWindow fun(element: string, scrollWindow: string, scrollChild: string) Scrolls to an element in a scroll window
    ---@field ScrollToElementInHorizontalScrollWindow fun(element: string, scrollWindow: string, scrollChild: string) Scrolls to an element in a horizontal scroll window
    ---@field FitTextToLabel fun(labelName: string, labelText: wstring, isTitle: boolean) Fits text to a label, adding ellipsis if needed
    ---@field CopyAnchors fun(sourceWindow: string, destWindow: string, xOffset: number, yOffset: number) Copies anchors from one window to another
    ---@field CopyScreenPosition fun(sourceWindow: string, destWindow: string, xOffset: number, yOffset: number) Copies screen position from one window to another
    ---@field CopySize fun(sourceWindow: string, destWindow: string, xOffset: number, yOffset: number, offsetInDestCoords: boolean) Copies size from one window to another
    ---@field GetScaledScreenPosition fun(sourceWindow: string): (number, number) Gets the scaled screen position of a window
    ---@field CreateWindowOutline fun(windowName: string) Creates a visible outline for a window (for debugging)
    ---@field DestroyWindowOutline fun(windowName: string) Destroys a window outline
    ---@field TrapClick fun() Placeholder for trapping clicks
    ---@field LastMessage wstring Last overhead message sent
    ---@field SendOverheadText fun(message: wstring, hue: integer, chat: boolean, ignoreLast?: boolean) Sends overhead text to the UI
    ---@field Aplpha fun(x: number, y: number, delta: number) Adjusts window alpha (transparency)
    ---@field Scale fun(x: number, y: number, delta: number) Adjusts window scale
    ---@field LoadAlpha fun(windowname: string) Loads and applies saved alpha for a window
    ---@field LoadScale fun(windowname: string, default: number) Loads and applies saved scale for a window
    ---@field ChatPrint fun(text: wstring, channel: integer) Prints text to the chat window
    ---@field Decapitalizing fun(value: wstring): wstring Decapitalizes a string for display
    ---@field Commalines fun(str: string): string[] Splits a string into lines by commas
    ---@field Dec2Hex fun(nValue: string|number): string Converts a decimal value to hexadecimal
    ---@field DrawObjectIcon fun(objectType: integer, hueId: integer, elementIcon: string, w?: integer, h?: integer, scl?: number) Draws an object icon in the UI

    ---@class ChatFiltersWindow
    ---@field TID table Table of TIDs for UI text (ChatFilters, Accept)
    ---@field channelListData table[] Array of channel list data (channelName, color, logName, channelID)
    ---@field channelListOrder integer[] Array of indices for channel list display order
    ---@field channelFiltersState boolean[] Array of filter states for each channel
    ---@field Initialize fun() Initializes the chat filters window and sets up UI
    ---@field Hide fun() Hides the chat filters window
    ---@field OnShown fun() Handles the window being shown and updates the channel list
    ---@field OnHidden fun() Handles the window being hidden
    ---@field Shutdown fun() Shuts down the chat filters window
    ---@field SetDefaultFilters fun() Sets the default filter states for all channels
    ---@field TabChanged fun() Handles tab changes (placeholder)
    ---@field UpdateChatOptionRow fun() Updates the display of each chat option row
    ---@field SetAllFiltersChanges fun() Applies all filter changes and hides the window
    ---@field OnToggleChannel fun() Toggles the filter state for a channel when its checkbox is clicked

    ---@class ChatFontWindow
    ---@field TID table Table of TIDs for UI text (ChatFont, Close)
    ---@field Initialize fun() Initializes the chat font window and sets up font options
    ---@field Shutdown fun() Shuts down the chat font window
    ---@field SetFontToSelection fun() Sets the selected font for the current chat tab
    ---@field CloseFontWindow fun() Closes the chat font window
    ---@field ItemMouseOver fun() Highlights the font label on mouse over
    ---@field ClearMouseOverItem fun() Clears the highlight from the font label on mouse out

    ---@class ChatSettings
    ---@field Channels table Table of chat channel definitions
    ---@field ChannelSwitches table Table of channel switch command definitions
    ---@field ChannelColors table Table mapping channel IDs to their color tables
    ---@field Fonts table[] Array of font definitions (fontName, id, isDefault, shownName)
    ---@field Ordering integer[] Array of channel IDs in display order
    ---@field Colors table[] Array of color definitions (r, g, b, id)
    ---@field SetupChannels fun() Sets up the available chat channels and their properties
    ---@field SetupChannelColorDefaults fun(resetAll: boolean) Sets up default channel colors
    ---@field SetupFontDefaults fun() Sets up default chat fonts

    ---@class ChatWindow
    ---@field Settings table Table of saved chat window settings
    ---@field history any|nil Chat history (wstring or nil)
    ---@field SelectedTabNumber integer Currently selected tab number
    ---@field BaseVersion number Base version of the chat window
    ---@field CurrentVersion number Current version of the chat window
    ---@field FADE_OUT_DELAY number Delay before fading out the chat window
    ---@field FADE_IN_DELAY number Delay before fading in the chat window
    ---@field SAVE_DELAY number Delay before saving chat window settings
    ---@field ALPHA_FADE_TIMER integer Timer ID for alpha fade
    ---@field dockableWindowData table Table holding state for each dockable chat window
    ---@field windowLocked boolean Whether the chat window is locked
    ---@field autohide boolean Whether the chat window auto-hides
    ---@field topWindow string Name of the top chat window
    ---@field firstGChatSelect boolean Whether the first global chat selection is active
    ---@field TID table Table of TIDs for UI text and labels
    ---@field Windows table[] Array of chat window definitions (Tabs, activeTab, wndName, etc.)
    ---@field Initialize fun() Initializes the chat window and sets up event handlers
    ---@field OnSetTopDockWindow fun(newTopWindowName: string) Handles setting the top dock window
    ---@field OnMouseOver fun() Handles mouse over event for the chat window
    ---@field OnMouseOverEnd fun() Handles mouse out event for the chat window
    ---@field PerformFadeIn fun(rootWindowIndex: integer) Fades in the chat window group
    ---@field PerformFadeOut fun(rootWindowIndex?: integer) Fades out the chat window group
    ---@field OnUpdate fun(elapsedTime: number) Updates the chat window state
    ---@field LoadSettings fun() Loads chat window settings
    ---@field SaveSettings fun() Saves chat window settings
    ---@field Shutdown fun() Shuts down the chat window and saves state
    ---@field SpawnFontSelectionMenu fun() Spawns the font selection context menu
    ---@field HideFontSelectionMenu fun() Hides the font selection context menu
    ---@field OnSelectTab fun() Handles tab selection
    ---@field SetActiveWindow fun() Sets the active chat window
    ---@field ShowTab fun(wndNum: integer, tabNum: integer) Shows the specified tab
    ---@field Print fun(text: wstring, channelId?: integer) Prints text to the chat window
    ---@field SwitchChannelWithExistingText fun(existingText: wstring) Switches chat channel with existing text
    ---@field OnEnterChatText fun() Handles entering chat text
    ---@field OnKeyEnter fun() Handles Enter key in chat input
    ---@field OnKeyEscape fun() Handles Escape key in chat input
    ---@field OnKeyTab fun() Handles Tab key in chat input
    ---@field ResetTextBox fun() Resets the chat input box
    ---@field UpdateCurrentChannel fun(icurChannel: integer|nil) Updates the current chat channel
    ---@field OnLock fun() Locks the chat window
    ---@field OnUnlock fun() Unlocks the chat window
    ---@field UpdateResizeButtons fun() Updates the resize buttons for all chat windows
    ---@field InitializeChannelMenuSelectionWindow fun() Initializes the channel selection menu
    ---@field UpdateAllChannelColors fun() Updates all channel button colors
    ---@field OnOpenChannelMenu fun() Opens the channel selection menu
    ---@field OnOpenTabMenu fun() Opens the tab context menu
    ---@field OnTabSelected fun(param: integer) Handles tab selection from context menu
    ---@field UpdateMenuSelection fun() Updates the menu selection highlight
    ---@field HideChannelSelectionMenu fun() Hides the channel selection menu
    ---@field SwitchToSelectedChannel fun() Switches to the selected chat channel
    ---@field SwitchToGChatSelectedChannel fun(existingText?: wstring) Switches to the selected global chat channel
    ---@field ToggleInputText fun() Toggles the chat input box
    ---@field UpdateNewTextAlert fun(wndNum: integer) Updates the new text alert
    ---@field ScrollToBottom fun(windowId: integer) Scrolls the chat log to the bottom
    ---@field OnResizeBegin fun(flags: any, x: number, y: number) Begins resizing the chat window
    ---@field OnHotSpotMouseOver fun(hotSpotText: any, type: any, value: any) Handles mouse over on a hotspot
    ---@field UpdateChatSettings fun() Updates chat settings (fade, etc.)
    ---@field ResetScrollLimits fun() Resets scroll limits for all tabs
    ---@field DoChatTextReplacement fun() Handles slash command replacement in chat input
    ---@field HandleTellCommand fun(itext: wstring, ifirstWord: wstring, ispaceIdx: integer, iexistingText: wstring) Handles /tell and /reply commands
    ---@field FormatWhisperPrompt fun(iwhisperTarget: wstring): wstring Formats the whisper prompt
    ---@field SwitchToChatChannel fun(ichannelIdx: integer, ichannelPrompt: wstring, iexistingText?: wstring) Switches to a chat channel
    ---@field OnOpenChatMenu fun() Opens the chat menu
    ---@field ShowMenu fun(tabName: string) Shows the chat menu
    ---@field OnLButtonDownProcessed fun() Handles left button down processed event
    ---@field OnRButtonDownProcessed fun() Handles right button down processed event
    ---@field HideMenu fun() Hides the chat menu
    ---@field GetCurrentTabName fun(): string Gets the current tab name
    ---@field GetCurrentTabID fun(): integer Gets the current tab ID
    ---@field GetMenuTab fun(): table Gets the current menu tab
    ---@field OnViewChatOptions fun() Opens the chat options window
    ---@field OnViewChatFilters fun() Opens the chat filters window
    ---@field OnViewChatFonts fun() Opens the chat fonts window
    ---@field OnRenameTab fun() Opens the rename tab dialog
    ---@field OnRename fun() Renames the current tab
    ---@field OnCancelRename fun() Cancels tab renaming
    ---@field OnRenameTextChanged fun(text: wstring) Handles text change in rename dialog
    ---@field AddSizeToFontSizeMenu fun(fontSize: integer, fontName: string) Adds a font size to the font size menu
    ---@field AddFontToFontMenu fun(fontName: string, fontDefinition: string) Adds a font to the font menu
    ---@field OnSizeButton fun() Handles font size button click
    ---@field OnSelectFontNameButton fun() Handles font name button click
    ---@field OnNewWindow fun(defaultLogOrNil?: any) Creates a new chat window
    ---@field GetAvailableWindowName fun(): string Gets an available window name
    ---@field GetAvailableTabLogNames fun(): (string, string) Gets available tab and log display names
    ---@field CreateNewTab fun(wndNum: integer, givenName?: string): table Creates a new tab
    ---@field SetupNewTab fun(wndNum: integer, defaultLog: any, tabNum: integer, labelName: wstring, tabName: string, logDisplayName: string) Sets up a new tab
    ---@field ToggleTimestamp fun() Toggles timestamp display
    ---@field ToggleAutoHide fun() Toggles auto-hide for the chat window
    ---@field SetFontToSelection fun() Sets the font to the selected font
    ---@field OnRemoveTab fun() Handles removing a tab
    ---@field RemoveTab fun(wndNum: integer, tabNum: integer) Removes a tab
    ---@field RemoveWindow fun(wndNum: integer) Removes a chat window
    ---@field AddDockableWindow fun(rootWindowName?: string): string Adds a dockable window
    ---@field InitRootChatTab fun() Initializes the root chat tab
    ---@field LoadChatWindowSettings fun(windowName: string, savedWindowName: string, saveWnd: table): boolean Loads chat window settings
    ---@field IsMainWindowGroup fun(wndName: string): boolean Checks if a window is in the main group
    ---@field SaveChatWindowToSlot fun(iIndex: integer) Saves chat window to a slot
    ---@field LoadChatWindowFromSlot fun(iIndex: integer) Loads chat window from a slot
    ---@field ClearChatSaveSlot fun(iIndex: integer) Clears a chat save slot
    ---@field OnDock fun(parentWindowName: string, childWindowName: string) Handles docking a window
    ---@field OnUnDock fun(parentWindowName: string, childWindowName: string) Handles undocking a window
    ---@field ResetRootDockableWindowDataVariables fun() Resets root dockable window data variables
    ---@field OnSizeUpdated fun(width: number, height: number) Handles window size update
    ---@field OnSetMoving fun(bMoving: boolean) Handles window moving event
    ---@field OnWindowOptionsSetAlpha fun() Opens the window opacity options
    ---@field OnSlideWindowOptionsMinAlpha fun(slidePos: number) Handles min alpha slider
    ---@field OnSlideWindowOptionsMaxAlpha fun(slidePos: number) Handles max alpha slider
    ---@field CloseSetOpacityWindow fun() Closes the opacity options window
    ---@field LockWindow fun(isLocked: boolean) Locks or unlocks the chat window
    ---@field OnLockButtonClicked fun() Handles lock button click
    ---@field OnInputTextButtonMouseOver fun() Handles mouse over on input text button
    ---@field OnGChatRosterUpdate fun() Updates the global chat roster

    ---@class Interface
    ---@field DebugMode boolean Whether debug mode is enabled
    ---@field TID table Table of TIDs for UI text (accept, cancel)
    ---@field LoadedSettings boolean Whether settings have been loaded
    ---@field SpellweavingID integer Spellweaving spell ID
    ---@field ArcaneFocusLevel integer Arcane focus level
    ---@field PLAYWINDOWSET integer Play window set constant
    ---@field TimeSinceLogin number Time since login in seconds
    ---@field OpeningBpk number Time since last backpack open
    ---@field DeltaTime number Delta time for update loops
    ---@field CurrentHonor integer Current honored mobile ID
    ---@field LastItem integer Last used item ID
    ---@field MenuId integer Current menu ID
    ---@field AlacrityStart number Alacrity start time
    ---@field CurrentSpell table Table holding current spell data
    ---@field Latency table Table holding latency and packet loss
    ---@field LatencyDelta number Delta time for latency update
    ---@field BlockThisPaperdoll table Table of blocked paperdoll IDs
    ---@field Clock table Table holding clock data (DD, MM, YYYY, Timestamp, h, m, s)
    ---@field LastTarget integer Last target ID
    ---@field LastSpell integer Last spell ID
    ---@field LastSpecialMove integer Last special move ID
    ---@field IsFighting boolean Whether the player is fighting
    ---@field IsFightingLastTime number Last time fighting state was checked
    ---@field CanLogout number Time until logout is allowed
    ---@field MenuBar integer|nil Menu bar hotbar ID
    ---@field FirstImprovement boolean|nil Whether first improvement has been applied
    ---@field InitialPositions boolean|nil Whether initial window positions have been set
    ---@field NewPlayerInventoryToggled boolean Whether new player inventory is toggled
    ---@field NewPlayerPaperdollToggled boolean Whether new player paperdoll is toggled
    ---@field NewPlayerMapToggled boolean Whether new player map is toggled
    ---@field NewPlayerWarToggled boolean Whether new player war is toggled
    ---@field LastSpecialMoveTime number Time remaining for special move cooldown
    ---@field ItemsCooldown table Table of item cooldowns
    ---@field SkillsCooldown table Table of skill cooldowns
    ---@field SpellsCooldown table Table of spell cooldowns
    ---@field SpecialsCooldown table Table of special move cooldowns
    ---@field VirtuesCooldown table Table of virtue cooldowns
    ---@field ArteReceived number Number of received artifacts
    ---@field ResReceived number Number of received resources
    ---@field AirReceived number Number of received air items
    ---@field SeedsReceived number Number of received seeds
    ---@field TokensReceived number Number of received tokens
    ---@field PaperdollOpen boolean Whether the paperdoll window is open
    ---@field BackpackOpen boolean Whether the backpack window is open
    ---@field TrapBoxID integer Trap box item ID
    ---@field LootBoxID integer Loot box item ID
    ---@field MobileArrowOver integer Mobile ID currently under the mobile arrow
    ---@field UnpackTransferCrate boolean Whether to unpack transfer crate
    ---@field ForceEnchant number Force enchantment value
    ---@field ForceAnimal number Force animal value
    ---@field ForceSpellTrigger number Force spell trigger value
    ---@field ForcePolymorph number Force polymorph value
    ---@field ForceFamiliar number Force familiar value
    ---@field RedButtonSpells table[] Array of red button spell definitions
    ---@field GreenButtonSpells table[] Array of green button spell definitions
    ---@field BlueButtonSpells table[] Array of blue button spell definitions
    ---@field BackPackItems table Table of backpack items
    ---@field SOSWaypoints table Table of SOS waypoints
    ---@field AllowTrades boolean Whether trades are allowed
    ---@field BardMastery boolean Whether bard mastery is enabled
    ---@field ToggleContentsInfo boolean Whether to toggle contents info
    ---@field GridLegacy boolean Whether to use legacy grid
    ---@field EnableContainerGrid boolean Whether container grid is enabled
    ---@field AlternateGrid boolean Whether alternate grid is enabled
    ---@field ExtraBrightContainers boolean Whether extra bright containers are enabled
    ---@field ShowMapCombos boolean Whether to show map combos
    ---@field StatusWindowStyle integer Status window style (0 = classic, 1 = advanced)
    ---@field StatusButtons boolean Whether status buttons are shown
    ---@field AuraEnabled boolean Whether aura is enabled
    ---@field EnableMobileArrow boolean Whether mobile arrow is enabled
    ---@field HeartBeat boolean Whether heartbeat is enabled
    ---@field ShowCloseExtract boolean Whether to show close extract button
    ---@field HealthBarWod boolean Whether health bar WoD is enabled
    ---@field RedDef integer Red default button index
    ---@field RedButton integer Red button index
    ---@field RedButton2 integer Red button 2 index
    ---@field RedButton3 integer Red button 3 index
    ---@field GreenDef integer Green default button index
    ---@field GreenButton integer Green button index
    ---@field GreenButton2 integer Green button 2 index
    ---@field GreenButton3 integer Green button 3 index
    ---@field BlueDef integer Blue default button index
    ---@field BlueButton integer Blue button index
    ---@field BlueButton2 integer Blue button 2 index
    ---@field BlueButton3 integer Blue button 3 index
    ---@field UseNewChat boolean Whether to use the new chat window
    ---@field LockChatLine boolean Whether the chat line is locked
    ---@field DisableSpells boolean Whether spells are disabled
    ---@field ShowSpellName boolean Whether to show spell names
    ---@field noPoisonOthers boolean Whether to prevent poisoning others
    ---@field OverhedTextSize number Overhead text size
    ---@field BlockOthersPaperdoll boolean Whether to block others' paperdolls
    ---@field EnableSnapping boolean Whether window snapping is enabled
    ---@field WarShield boolean Whether the war shield is enabled
    ---@field chatFixed boolean Whether chat has been fixed for new chat window
    ---@field SOSWaypointsCleanerDelta number Delta for SOS waypoints cleaner
    ---@field SpellRecovery number Spell recovery timer
    ---@field BeatSlow boolean Whether slow heartbeat is active
    ---@field BeatMed boolean Whether medium heartbeat is active
    ---@field BeatFast boolean Whether fast heartbeat is active
    ---@field Beat boolean Whether heartbeat is active
    ---@field BeatSoundStartDelta number Heartbeat sound start delta
    ---@field BeatSoundLength number Heartbeat sound length
    ---@field org_RegisterWindowData function|nil Original RegisterWindowData function (for override)
    ---@field org_RequestContextMenu function|nil Original RequestContextMenu function (for override)
    ---@field org_DragSlotQuantityRequestResult function|nil Original DragSlotQuantityRequestResult function (for override)
    ---@field org_HandleSingleLeftClkTarget function|nil Original HandleSingleLeftClkTarget function (for override)
    ---@field org_WindowRegisterEventHandler function|nil Original WindowRegisterEventHandler function (for override)
    ---@field CreatePlayWindowSet fun() Creates the play window set
    ---@field RegisterEvents fun() Registers interface event handlers
    ---@field LoadVariables fun() Loads interface variables
    ---@field CreateWindows fun() Creates interface windows
    ---@field CreateTCTools fun() Creates test center tools window
    ---@field InitializeWindows fun() Initializes interface windows
    ---@field InitializeSOSWaypoints fun() Initializes SOS waypoints
    ---@field CreateOverrides fun() Creates function overrides
    ---@field InterfaceInitialize fun() Initializes the interface
    ---@field InitBugReport fun() Initializes the bug report window
    ---@field Update fun(timePassed: number) Updates the interface and all windows
    ---@field SOSWaypointsCleaner fun(timePassed: number) Cleans up SOS waypoints
    ---@field PropsCacheClear fun(timePassed: number) Clears the item properties cache
    ---@field UpdateWarButton fun(timePassed: number) Updates the war button state
    ---@field MobileArrowManager fun(timePassed: number) Manages the mobile arrow window
    ---@field SpecialMovesManaCooldown fun(timePassed: number) Updates special move mana cooldown
    ---@field LoginTimeoutCheck fun(timePassed: number) Checks for login timeout
    ---@field UpdateLatency fun(timePassed: number) Updates latency information
    ---@field Cooldowns fun(timePassed: number) Updates cooldown timers
    ---@field SpellsTimer fun(timePassed: number) Updates spell timers
    ---@field ChatFixer fun(timePassed: number) Fixes chat window for new chat
    ---@field ClockUpdater fun(timePassed: number) Updates the interface clock
    ---@field CheckLastTargetChanged fun(timePassed: number) Checks if the last target has changed
    ---@field PaperdollCheck fun(timePassed: number) Checks and manages the paperdoll window
    ---@field BackpackCheck fun(timePassed: number) Checks and manages the backpack window
    ---@field MapRefresh fun(timePassed: number) Refreshes the map window
    ---@field SkillsTrackerUpdate fun(timePassed: number) Updates the skills tracker window
    ---@field SummonsManager fun(timePassed: number) Manages summoned creatures
    ---@field UpdateHealthbarStatus fun(timePassed: number) Updates health bar status
    ---@field SkillLocker fun(timePassed: number) Locks and manages skills
    ---@field LowHPManager fun(timePassed: number) Manages low HP warnings and heartbeat
    ---@field ClearWindowData fun(timePassed: number) Clears window data for mobiles
    ---@field ReloadSettings fun() Reloads interface settings
    ---@field TogglePaperdollWindow fun() Toggles the paperdoll window
    ---@field OnDebugPrint fun() Handles debug print events
    ---@field RetrieveCharacterSettings fun() Retrieves character settings
    ---@field UpdateWindowsSettings fun() Updates window settings
    ---@field ShowCriminalNotificationGump fun() Shows the criminal notification dialog
    ---@field ShowPartyInvite fun() Shows the party invite window
    ---@field AcceptCriminalNotification fun() Accepts the criminal notification
    ---@field HonorMobileConfirm fun(mobileId: integer) Confirms honoring a mobile
    ---@field ItemUseRequest fun() Handles item use requests
    ---@field SpellUseRequest fun() Handles spell use requests
    ---@field SkillUseRequest fun() Handles skill use requests
    ---@field VirtueUseRequest fun() Handles virtue use requests
    ---@field SpecialMoveUseRequest fun() Handles special move use requests
    ---@field OnTarget fun(lastTarget: integer, newTarget: integer) Handles targeting events
    ---@field OnSpellCastedSuccessfully fun(id: integer) Handles successful spell casts
    ---@field OnSpellCastFailed fun(id: integer) Handles failed spell casts
    ---@field OnSpecialMoveUsedSuccessfully fun(id: integer, targetId: integer) Handles successful special move use
    ---@field OnSpecialMoveDamageReceived fun(id: integer) Handles special move damage received
    ---@field OnMouseOverItemChanged fun(id: integer) Handles mouse over item changes
    ---@field OnMobileMouseOver fun(id: integer) Handles mouse over mobile
    ---@field OnObjectMouseOver fun(id: integer) Handles mouse over object
    ---@field OnActionMouseOver fun(id: integer) Handles mouse over action
    ---@field GetMobileData fun(mobileId: integer, forceRegister?: boolean): table Gets mobile data
    ---@field Shutdown fun() Shuts down the interface and all windows
    ---@field ErrorTracker fun(success: boolean, error: any) Tracks errors
    ---@field TotalUnregister fun() Unregisters all window data
    ---@field CountWinData fun() Counts all window data
    ---@field CountNamesData fun(): integer Counts name data
    ---@field CountObjectData fun(): integer Counts object data
    ---@field CountContainersData fun(): integer Counts container data
    ---@field CountPropsData fun(): integer Counts property data
    ---@field CountMobileStatusData fun(): integer Counts mobile status data
    ---@field CountPaperdollData fun(): integer Counts paperdoll data
    ---@field ToggleWindowByName fun(wndName: string, btnName: string, toggleFunction?: fun(), onOpenFunction?: fun(), onCloseFunction?: fun()) Toggles a window by name
    ---@field SaveBoolean fun(settingName: string, settingValue: boolean) Saves a boolean setting
    ---@field SaveNumber fun(settingName: string, settingValue: number) Saves a numeric setting
    ---@field SaveColor fun(settingName: string, settingValue: table) Saves a color setting
    ---@field SaveString fun(settingName: string, settingValue: string) Saves a string setting
    ---@field SaveWString fun(settingName: string, settingValue: wstring) Saves a wstring setting
    ---@field DeleteSetting fun(settingName: string) Deletes a setting
    ---@field CheckColor fun(color: table, rootFunction?: string): boolean Checks if a table is a valid color
    ---@field LoadBoolean fun(settingName: string, defaultValue: boolean): boolean Loads a boolean setting
    ---@field LoadNumber fun(settingName: string, defaultValue: number): number Loads a numeric setting
    ---@field LoadColor fun(settingName: string, defaultValue: table): table Loads a color setting
    ---@field LoadString fun(settingName: string, defaultValue: string): string Loads a string setting
    ---@field LoadWString fun(settingName: string, defaultValue: wstring): wstring Loads a wstring setting

    ---@class EA_Window_ContextMenu
    ---@field activeWindow string|nil The currently active window for the context menu
    ---@field contextMenus table[] Array of context menu definitions (numMenuItems, numActiveMenuItems, name, anchorWindow, functionTable, greatestWidth, numUserDefinedMenuItems, userDefinedMenuItems)
    ---@field numContextMenus integer Number of context menus created
    ---@field CONTEXT_MENU_1 integer Constant for context menu 1
    ---@field CONTEXT_MENU_2 integer Constant for context menu 2
    ---@field CONTEXT_MENU_3 integer Constant for context menu 3
    ---@field MIN_WIDTH integer Minimum width for context menus
    ---@field MINIMUM_X_OFFSET integer Minimum X offset for context menus
    ---@field Initialize fun() Initializes the context menu system
    ---@field Shutdown fun() Shuts down the context menu system
    ---@field Show fun(contextMenuNumber?: integer) Shows the specified context menu
    ---@field Hide fun(contextMenuNumber?: integer) Hides the specified context menu
    ---@field HideAll fun() Hides all context menus
    ---@field CreateContextMenu fun(windowNameToActUpon: string, contextMenuNumber?: integer) Creates a new context menu for a window
    ---@field AddMenuItem fun(buttonText: wstring, callbackFunction: fun(param?: any), bDisabled: boolean, bCloseAfterClick: boolean, contextMenuNumber?: integer, param?: any) Adds a menu item to the context menu
    ---@field AddUserDefinedMenuItem fun(windowName: string, contextMenuNumber?: integer) Adds a user-defined menu item to the context menu
    ---@field Finalize fun(contextMenuNumber?: integer, anchor?: table) Finalizes and displays the context menu
    ---@field CreateDefaultContextMenu fun(windowNameToActUpon: string) Creates a default context menu for a window
    ---@field CreateOpacityOnlyContextMenu fun(windowNameToActUpon: string) Creates an opacity-only context menu for a window
    ---@field OnLButtonDownMenuItem fun() Handles left button down on a menu item
    ---@field OnLButtonProcessed fun() Handles left button processed event for context menus
    ---@field OnRButtonProcessed fun() Handles right button processed event for context menus
    ---@field OnLock fun() Locks the active window
    ---@field OnUnlock fun() Unlocks the active window
    ---@field OnWindowOptionsSetAlpha fun() Opens the window opacity options
    ---@field OnSlideWindowOptionsAlpha fun(slidePos: number) Handles alpha slider for window opacity
    ---@field CloseSetOpacityWindow fun() Closes the opacity options window
    ---@field TrapClick fun() Handles trap click events

    ---@class HighlightEffectManager
    ---@field knownWindows table Table mapping window names to HighlightEffect instances
}

---@class Api
local Api = {}

---@class Constants
local Constants = {}

---@class Views
local Views = {}

---@class Data
local Data = {}

---@class Utils
local Utils = {}

---@class Context
---@field Api Api
---@field Data Data
---@field Utils Utils
---@field Constants Constants
---@field Views Views
local Context = {
    Api = Api,
    Data = Data,
    Utils = Utils,
    Constants = Constants,
    Views = Views
}

-- ========================================================================== --
-- Api - Ability
-- ========================================================================== --


Api.Ability = {}

---
--- Returns the maximum number of racial abilities.
---@return number The maximum number of racial abilities.
function Api.Ability.GetMaxRacialAbilities()
    return GetMaxRacialAbilities()
end

---
--- Gets the racial ability ID for a given index.
---@param index number The index of the racial ability.
---@return number The racial ability ID.
function Api.Ability.GetRacialAbilityId(index)
    return GetRacialAbilityId(index) + 3000
end

---
--- Gets the ability data for a given ID.
---@param id number The ID of the ability.
---@return any The ability data.
function Api.Ability.GetAbilityData(id)
    return GetAbilityData(id)
end

---
--- Gets the weapon ability ID for a given index.
---@param index number The index of the weapon ability.
---@return number The weapon ability ID.
function Api.Ability.GetWeapnAbilityId(index)
    return GetWeaponAbilityId(index) + 1000
end

-- ========================================================================== --
-- Api - Animated Image
-- ========================================================================== --

Api.AnimatedImage = {}

---
--- Sets the texture for an animated image.
---@param imageName string The name of the animated image.
---@param texture string The texture to set.
function Api.AnimatedImage.SetTexture(imageName, texture)
    AnimatedImageSetTexture(imageName, texture)
end

---
--- Starts the animation for an animated image.
---@param imageName string The name of the animated image.
---@param startFrame number The frame to start the animation from.
---@param loop boolean Whether the animation should loop.
---@param hideWhenDone boolean Whether the image should be hidden when the animation is done.
---@param delay number The delay before the animation starts.
function Api.AnimatedImage.StartAnimation(imageName, startFrame, loop, hideWhenDone, delay)
    AnimatedImageStartAnimation(imageName, startFrame, loop, hideWhenDone, delay)
end

---
--- Stops the animation for an animated image.
---@param imageName string The name of the animated image.
function Api.AnimatedImage.StopAnimaton(imageName)
    AnimatedImageStopAnimation(imageName)
end

---
--- Sets the play speed of an animated image.
---@param imageName string The name of the animated image.
---@param fps number The frames per second.
function Api.AnimatedImage.SetPlaySpeed(imageName, fps)
    AnimatedImageSetPlaySpeed(imageName, fps)
end

-- ========================================================================== --
-- Api - Button
-- ========================================================================== --

Api.Button = {}

---
--- Gets the text dimensions of a button.
---@param id string The ID of the button.
---@return number, number The width and height of the button text.
function Api.Button.GetTextDimensions(id)
    return ButtonGetTextDimensions(id)
end

---
--- Sets the text of a button.
---@param id string The ID of the button.
---@param text string The text to set.
function Api.Button.SetText(id, text)
    ButtonSetText(id, text)
end

---
--- Gets the text of a button.
---@param id string The ID of the button.
---@return string The text of the button.
function Api.Button.GetText(id)
    return ButtonGetText(id)
end

---
--- Sets the disabled flag of a button.
---@param id string The ID of the button.
---@param isDisabled boolean Whether the button is disabled.
function Api.Button.SetDisabled(id, isDisabled)
    ButtonSetDisabledFlag(id, isDisabled)
end

---
--- Gets the disabled flag of a button.
---@param id string The ID of the button.
---@return boolean Whether the button is disabled.
function Api.Button.IsDisabled(id)
    return ButtonGetDisabledFlag(id)
end

---
--- Sets the enabled flag of a button.
---@param id string The ID of the button.
---@param isEnabled boolean Whether the button is enabled.
function Api.Button.SetEnabled(id, isEnabled)
    ButtonSetCheckButtonFlag(id, isEnabled)
end

---
--- Sets the pressed flag of a button.
---@param id string The ID of the button.
---@param isChecked boolean Whether the button is pressed.
function Api.Button.SetChecked(id, isChecked)
    ButtonSetPressedFlag(id, isChecked)
end

---
--- Gets the pressed flag of a button.
---@param id string The ID of the button.
---@return boolean Whether the button is pressed.
function Api.Button.IsChecked(id)
    return ButtonGetPressedFlag(id)
end

---
--- Sets the texture of a button.
---@param id string The ID of the button.
---@param state number The state of the button.
---@param texture string The texture to set.
---@param x number The x-coordinate of the texture.
---@param y number The y-coordinate of the texture.
function Api.Button.SetTexture(id, state, texture, x, y)
    ButtonSetTexture(id, state, texture, x, y)
end

---
--- Sets the highlight flag of a button.
---@param id string The ID of the button.
---@param doHighlight boolean Whether to highlight the button.
function Api.Button.SetHighlight(id, doHighlight)
    ButtonSetHighlightFlag(id, doHighlight)
end

---
--- Sets the stay down flag of a button.
---@param id string The ID of the button.
---@param stayDown boolean Whether the button should stay down.
function Api.Button.SetStayDown(id, stayDown)
    ButtonSetStayDownFlag(id, stayDown)
end

---
--- Gets the stay down flag of a button.
---@param id string The ID of the button.
---@return boolean Whether the button stays down.
function Api.Button.IsStayDown(id)
    return ButtonGetStayDownFlag(id)
end

---
--- Sets the text color of a button.
---@param id string The ID of the button.
---@param r number The red component of the color.
---@param g number The green component of the color.
---@param b number The blue component of the color.
---@param a number The alpha component of the color.
function Api.Button.SetTextColor(id, r, g, b, a)
    ButtonSetTextColor(id, r, g, b, a)
end

-- ========================================================================== --
-- Api - Chat
-- ========================================================================== --

Api.Chat = {}

---
--- Sends a chat message.
---@param channel string The channel to send the message to.
---@param text string The message to send.
function Api.Chat.SendChat(channel, text)
    SendChat(channel, text)
end

---
--- Prints a message to the chat window.
---@param wString string The message to print.
---@param filter string The filter to use.
function Api.Chat.PrintToChatWindow(wString, filter)
    PrintWStringToChatWindow(wString, filter)
end

-- ========================================================================== --
-- Api - Circle Image
-- ========================================================================== --

Api.CircleImage = {}

---
--- Sets the texture for a circle image.
---@param id string The ID of the circle image.
---@param texture string The texture to set.
---@param xCord number The x-coordinate of the texture.
---@param yCord number The y-coordinate of the texture.
function Api.CircleImage.SetTexture(id, texture, xCord, yCord)
    CircleImageSetTexture(id, texture, xCord, yCord)
end

---
--- Sets the texture scale for a circle image.
---@param id string The ID of the circle image.
---@param scale number The scale to set.
function Api.CircleImage.SetTextureScale(id, scale)
    CircleImageSetTextureScale(id, scale)
end

---
--- Sets the rotation for a circle image.
---@param id string The ID of the circle image.
---@param rotation number The rotation to set.
function Api.CircleImage.SetRotation(id, rotation)
    CircleImageSetRotation(id, rotation)
end

-- ========================================================================== --
-- Api - ComboBox
-- ========================================================================== --


Api.ComboBox = {}

---
--- Adds an item to a combo box.
---@param id string The ID of the combo box.
---@param item string The item to add.
function Api.ComboBox.AddItem(id, item)
    ComboBoxAddMenuItem(id, item)
end

---
--- Clears the items from a combo box.
---@param id string The ID of the combo box.
function Api.ComboBox.ClearItems(id)
    ComboBoxClearMenuItems(id)
end

---
--- Sets the selected item in a combo box.
---@param id string The ID of the combo box.
---@param item string The item to select.
function Api.ComboBox.SetSelectedItem(id, item)
    ComboBoxSetSelectedMenuItem(id, item)
end

---
--- Gets the selected item from a combo box.
---@param id string The ID of the combo box.
---@return string The selected item.
function Api.ComboBox.GetSelectedItem(id)
    return ComboBoxGetSelectedMenuItem(id)
end

-- ========================================================================== --
-- Api - Context Menu
-- ========================================================================== --


Api.ContextMenu = {}

---
--- Requests a context menu.
---@param id number The ID of the context menu.
function Api.ContextMenu.RequestMenu(id)
    RequestContextMenu(id)
end

-- ========================================================================== --
-- Api - CSV
-- ========================================================================== --


Api.CSV = {}

---
--- Loads a CSV file.
---@param path string The path to the CSV file.
---@param name string The name to give the loaded data.
function Api.CSV.Load(path, name)
    UOBuildTableFromCSV(path, name)
end

---
--- Unloads a CSV file.
---@param name string The name of the CSV data to unload.
function Api.CSV.Unload(name)
    UOUnloadCSVTable(name)
end

-- ========================================================================== --
-- Api - Drag
-- ========================================================================== --

Api.Drag = {}

---
--- Drags an object to another object.
---@param id number The ID of the object to drag to.
function Api.Drag.DragToObject(id)
    DragSlotDropObjectToObject(id)
end

---
--- Sets the mouse click data for a user action.
---@param userAction string The user action.
---@param actionId number The action ID.
---@param iconId number The icon ID.
function Api.Drag.SetActionMouseClickData(userAction, actionId, iconId)
    DragSlotSetActionMouseClickData(userAction, actionId, iconId)
end

---
--- Sets the mouse click data for an object.
---@param objectId number The object ID.
---@param dragSource string The drag source.
function Api.Drag.SetObjectMouseClickData(objectId, dragSource)
    DragSlotSetObjectMouseClickData(objectId, dragSource)
end

---
--- Drops an object on the paperdoll equipment.
---@param objectId number The object ID.
function Api.Drag.DropOnPaperdollEquipment(objectId)
    DragSlotDropObjectToPaperdollEquipment(objectId)
end

---
--- Drops an object on the paperdoll.
---@param paperdollId number The paperdoll ID.
function Api.Drag.DropOnPaperdoll(paperdollId)
    DragSlotDropObjectToPaperdoll(paperdollId)
end

---
--- Drops an object on an object at a given index.
---@param objectId number The object ID.
---@param gridIndex number The grid index.
function Api.Drag.DropOnObjectAtIndex(objectId, gridIndex)
    DragSlotDropObjectToObjectAtIndex(objectId, gridIndex)
end

---
--- Drops an object on a container.
---@param containerId number The container ID.
---@param gridIndex number The grid index.
function Api.Drag.DropOnContainer(containerId, gridIndex)
    DragSlotDropObjectToContainer(containerId, gridIndex)
end

---
--- Automatically picks up an object.
---@param objectId number The object ID.
function Api.Drag.AutoPickupObject(objectId)
    DragSlotAutoPickupObject(objectId)
end

-- ========================================================================== --
-- Api - Dynamic Image
-- ========================================================================== --

Api.DynamicImage = {}

---
--- Sets the texture for a dynamic image.
---@param dynamicImageName string The name of the dynamic image.
---@param texture string The texture to set.
---@param x number The x-coordinate of the texture.
---@param y number The y-coordinate of the texture.
function Api.DynamicImage.SetTexture(dynamicImageName, texture, x, y)
    DynamicImageSetTexture(dynamicImageName, texture or "", x or 0, y or 0)
end

---
--- Sets the texture scale for a dynamic image.
---@param dynamicImageName string The name of the dynamic image.
---@param textureScale number The scale to set.
function Api.DynamicImage.SetTextureScale(dynamicImageName, textureScale)
    DynamicImageSetTextureScale(dynamicImageName, textureScale)
end

---
--- Sets the texture dimensions for a dynamic image.
---@param dynamicImageName string The name of the dynamic image.
---@param x number The width of the texture.
---@param y number The height of the texture.
function Api.DynamicImage.SetTextureDimensions(dynamicImageName, x, y)
    DynamicImageSetTextureDimensions(dynamicImageName, x, y)
end

---
--- Sets the texture orientation for a dynamic image.
---@param dynamicImageName string The name of the dynamic image.
---@param mirrored boolean Whether the texture is mirrored.
function Api.DynamicImage.SetTextureOrientation(dynamicImageName, mirrored)
    DynamicImageSetTextureOrientation(dynamicImageName, mirrored)
end

---
--- Sets the texture slice for a dynamic image.
---@param dynamicImageName string The name of the dynamic image.
---@param sliceName string The name of the slice.
function Api.DynamicImage.SetTextureSlice(dynamicImageName, sliceName)
    DynamicImageSetTextureSlice(dynamicImageName, sliceName)
end

---
--- Sets the rotation for a dynamic image.
---@param dynamicImageName string The name of the dynamic image.
---@param rotation number The rotation to set.
function Api.DynamicImage.SetRotation(dynamicImageName, rotation)
    DynamicImageSetRotation(dynamicImageName, rotation)
end

---
--- Checks if a dynamic image has a texture.
---@param dynamicImageName string The name of the dynamic image.
---@return boolean Whether the dynamic image has a texture.
function Api.DynamicImage.HasTexture(dynamicImageName)
    return DynamicImageHasTexture(dynamicImageName)
end

---
--- Sets a custom shader for a dynamic image.
---@param dynamicImageName string The name of the dynamic image.
---@param shader string The shader to set.
---@param hue number The hue to use.
function Api.DynamicImage.SetCustomShader(dynamicImageName, shader, hue)
    DynamicImageSetCustomShader(dynamicImageName, shader, hue)
end

-- ========================================================================== --
-- Api - Edit Text Box
-- ========================================================================== --


Api.EditTextBox = {}

---
--- Sets the text of an edit box.
---@param editBoxName string The name of the edit box.
---@param text string The text to set.
function Api.EditTextBox.SetText(editBoxName, text)
    TextEditBoxSetText(editBoxName, text or L"")
end

---
--- Gets the text of an edit box.
---@param editBoxName string The name of the edit box.
---@return string The text of the edit box.
function Api.EditTextBox.GetText(editBoxName)
    return TextEditBoxGetText(editBoxName)
end

---
--- Gets the text lines of an edit box.
---@param editBoxName string The name of the edit box.
---@return table The text lines of the edit box.
function Api.EditTextBox.GetTextLines(editBoxName)
    return TextEditBoxGetTextLines(editBoxName)
end

---
--- Inserts text into an edit box.
---@param editBoxName string The name of the edit box.
---@param text string The text to insert.
function Api.EditTextBox.InsertText(editBoxName, text)
    TextEditBoxInsertText(editBoxName, text)
end

---
--- Sets the text color of an edit box.
---@param editBoxName string The name of the edit box.
---@param color table The color to set.
function Api.EditTextBox.SetTextColor(editBoxName, color)
    TextEditBoxSetTextColor(editBoxName, color.r, color.g, color.b)
end

---
--- Gets the text color of an edit box.
---@param editBoxName string The name of the edit box.
---@return number, number, number The red, green, and blue components of the color.
function Api.EditTextBox.GetTextColor(editBoxName)
    return TextEditBoxGetTextColor(editBoxName)
end

---
--- Selects all text in an edit box.
---@param editBoxName string The name of the edit box.
function Api.EditTextBox.SelectAll(editBoxName)
    TextEditBoxSelectAll(editBoxName)
end

---
--- Sets the font of an edit box.
---@param editBoxName string The name of the edit box.
---@param fontName string The name of the font.
---@param lineSpacing number The line spacing.
function Api.EditTextBox.SetFont(editBoxName, fontName, lineSpacing)
    TextEditBoxSetFont(editBoxName, fontName, lineSpacing)
end

---
--- Gets the font of an edit box.
---@param editBoxName string The name of the edit box.
---@return string, number The name of the font and the line spacing.
function Api.EditTextBox.GetFont(editBoxName)
    return TextEditBoxGetFont(editBoxName)
end

---
--- Gets the history of an edit box.
---@param editBoxName string The name of the edit box.
---@return table The history of the edit box.
function Api.EditTextBox.GetHistory(editBoxName)
    return TextEditBoxGetHistory(editBoxName)
end

---
--- Sets the history of an edit box.
---@param editBoxName string The name of the edit box.
---@param history table The history to set.
function Api.EditTextBox.SetHistory(editBoxName, history)
    TextEditBoxSetHistory(editBoxName, history)
end

---
--- Sets whether an edit box handles key down events.
---@param editBoxName string The name of the edit box.
---@param handle boolean Whether to handle key down events.
function Api.EditTextBox.HandleKeyDown(editBoxName, handle)
    TextEditBoxSetHandleKeyDown(editBoxName, handle)
end

-- ========================================================================== --
-- Api - Event
-- ========================================================================== --

Api.Event = {}

---
--- Broadcasts an event.
---@param event string The event to broadcast.
function Api.Event.Broadcast(event)
    BroadcastEvent(event)
end

-- ========================================================================== --
-- Api - Gump
-- ========================================================================== --


Api.Gump = {}

---
--- Handles a left click on a gump.
---@param gumpId number The ID of the gump.
---@param windowName string The name of the window.
function Api.Gump.OnLeftClick(gumpId, windowName)
    GenericGumpOnClicked(gumpId, windowName)
end

---
--- Handles a double click on a gump.
---@param gumpId number The ID of the gump.
---@param windowName string The name of the window.
function Api.Gump.OnDoubleClick(gumpId, windowName)
    GenericGumpOnDoubleClicked(gumpId, windowName)
end

---
--- Handles a right click on a gump.
---@param gumpId number The ID of the gump.
function Api.Gump.OnRightClick(gumpId)
    GenericGumpOnRClicked(gumpId)
end

---
--- Gets the tooltip text for a gump.
---@param gumpId number The ID of the gump.
---@param windowName string The name of the window.
---@return string The tooltip text.
function Api.Gump.GetTooltipText(gumpId, windowName)
    return GenericGumpGetToolTipText(gumpId, windowName)
end

---
--- Opens a web browser.
---@param link string The link to open.
function Api.Gump.OpenWebBrowser(link)
    OpenWebBrowser(tostring(link))
end

---
--- Handles closing a container.
---@param id number The ID of the container.
function Api.Gump.OnCloseContainer(id)
    GumpManagerOnCloseContainer(id)
end

---
--- Gets the item properties object ID for a gump.
---@param gumpId number The ID of the gump.
---@param windowName string The name of the window.
---@return number The item properties object ID.
function Api.Gump.GetItemPropertiesObjectId(gumpId, windowName)
    return GenericGumpGetItemPropertiesId(gumpId, windowName)
end

-- ========================================================================== --
-- Api - Icon
-- ========================================================================== --

Api.Icon = {}

---
--- Gets the icon data for a texture ID.
---@param textureId number The texture ID.
---@return any The icon data.
function Api.Icon.GetIconData(textureId)
    return GetIconData(textureId)
end

---
--- Gets the texture size for a texture ID.
---@param textureId number The texture ID.
---@return number, number The width and height of the texture.
function Api.Icon.GetTextureSize(textureId)
    return UOGetTextureSize(textureId)
end

---
--- Requests tile art.
---@param type number The type of tile art.
---@param width number The width of the tile art.
---@param height number The height of the tile art.
---@return any The tile art.
function Api.Icon.RequestTileArt(type, width, height)
    return RequestTileArt(type, width, height)
end

-- ========================================================================== --
-- Api - Label
-- ========================================================================== --


Api.Label = {}

---
--- Sets the text of a label.
---@param name string The name of the label.
---@param text string|number The text to set.
function Api.Label.SetText(name, text)
    if text == nil then
        return
    elseif type(text) == "number" then
        text = StringFormatter.fromTid(text)
    elseif type(text) == "string" then
        text = StringFormatter.toWString(text)
    end
    LabelSetText(name, text)
end

---
--- Gets the text of a label.
---@param name string The name of the label.
---@return string The text of the label.
function Api.Label.GetText(name)
    return LabelGetText(name)
end

---
--- Sets the text color of a label.
---@param name string The name of the label.
---@param color table The color to set.
function Api.Label.SetTextColor(name, color)
    LabelSetTextColor(name, color.r, color.g, color.b)
end

---
--- Sets the text alignment of a label.
---@param name string The name of the label.
---@param alignment string The alignment to set.
function Api.Label.SetTextAlignment(name, alignment)
    LabelSetTextAlign(name, alignment)
end

---
--- Sets the word wrap of a label.
---@param name string The name of the label.
---@param wordWrap boolean Whether to wrap words.
function Api.Label.SetWordWrap(name, wordWrap)
    LabelSetWordWrap(name, wordWrap)
end

-- ========================================================================== --
-- Api - List Box
-- ========================================================================== --


Api.ListBox = {}

---
--- Sets the data table for a list box.
---@param name string The name of the list box.
---@param data table The data table to set.
function Api.ListBox.SetDataTable(name, data)
    ListBoxSetDataTable(name, data)
end

---
--- Gets the data index for a row in a list box.
---@param name string The name of the list box.
---@param rowIndex number The row index.
---@return number The data index.
function Api.ListBox.GetDataIndex(name, rowIndex)
    return ListBoxGetDataIndex(name, rowIndex)
end

---
--- Sets the display order for a list box.
---@param name string The name of the list box.
---@param orderArray table The display order to set.
function Api.ListBox.SetDisplayOrder(name, orderArray)
    ListBoxSetDisplayOrder(name, orderArray)
end

---
--- Sets the visible row count for a list box.
---@param name string The name of the list box.
---@param count number The visible row count to set.
function Api.ListBox.SetVisibleRowCount(name, count)
    ListBoxSetVisibleRowCount(name, count)
end

-- ========================================================================== --
-- Api - Log Display
-- ========================================================================== --

Api.LogDisplay = {}

---
--- Sets whether to show timestamps in a log display.
---@param name string The name of the log display.
---@param doShow boolean Whether to show timestamps.
function Api.LogDisplay.ShowTimestamp(name, doShow)
    LogDisplaySetShowTimestamp(name, doShow == nil or doShow)
end

---
--- Gets whether timestamps are showing in a log display.
---@param name string The name of the log display.
---@return boolean Whether timestamps are showing.
function Api.LogDisplay.IsTimestampShowing(name)
    return LogDisplayGetShowTimestamp(name)
end

---
--- Sets whether to show the log name in a log display.
---@param name string The name of the log display.
---@param doShow boolean Whether to show the log name.
function Api.LogDisplay.ShowLogName(name, doShow)
    LogDisplaySetShowLogName(name, doShow == nil or doShow)
end

---
--- Sets whether to show the filter name in a log display.
---@param name string The name of the log display.
---@param doShow boolean Whether to show the filter name.
function Api.LogDisplay.ShowFilterName(name, doShow)
    LogDisplaySetShowFilterName(name, doShow == nil or doShow)
end

---
--- Adds a log to a log display.
---@param name string The name of the log display.
---@param log string The log to add.
---@param bool boolean A boolean value.
function Api.LogDisplay.AddLog(name, log, bool)
    LogDisplayAddLog(name, log, bool == nil or bool)
end

---
--- Removes a log from a log display.
---@param name string The name of the log display.
---@param log string The log to remove.
function Api.LogDisplay.RemoveLog(name, log)
    LogDisplayRemoveLog(name, log)
end

---
--- Sets the filter color for a log display.
---@param name string The name of the log display.
---@param log string The log to set the color for.
---@param level number The level of the filter.
---@param color table The color to set.
function Api.LogDisplay.SetFilterColor(name, log, level, color)
    LogDisplaySetFilterColor(name, log, level, color.r, color.g, color.b)
end

---
--- Sets the filter state for a log display.
---@param name string The name of the log display.
---@param log string The log to set the state for.
---@param filterId number The ID of the filter.
---@param filter any The filter to set.
function Api.LogDisplay.SetFilterState(name, log, filterId, filter)
    LogDisplaySetFilterState(name, log, filterId, filter)
end

---
--- Sets the text fade time for a log display.
---@param name string The name of the log display.
---@param time number The fade time to set.
function Api.LogDisplay.SetTextFadeTime(name, time)
    LogDisplaySetTextFadeTime(name, time)
end

---
--- Gets the text fade time for a log display.
---@param name string The name of the log display.
---@return number The text fade time.
function Api.LogDisplay.GetTextFadeTime(name)
    return LogDisplayGetTextFadeTime(name)
end

---
--- Gets whether the scrollbar is active in a log display.
---@param name string The name of the log display.
---@return boolean Whether the scrollbar is active.
function Api.LogDisplay.IsScrollbarActive(name)
    return LogDisplayIsScrollbarActive(name)
end

---
--- Sets the font for a log display.
---@param name string The name of the log display.
---@param font string The font to set.
function Api.LogDisplay.SetFont(name, font)
    LogDisplaySetFont(name, font)
end

---
--- Gets the font for a log display.
---@param name string The name of the log display.
---@return string The font.
function Api.LogDisplay.GetFont(name)
    return LogDisplayGetFont(name)
end

---
--- Scrolls a log display to the bottom.
---@param name string The name of the log display.
function Api.LogDisplay.ScrollToBottom(name)
    LogDisplayScrollToBottom(name)
end

---
--- Gets whether a log display is scrolled to the bottom.
---@param name string The name of the log display.
---@return boolean Whether the log display is scrolled to the bottom.
function Api.LogDisplay.IsScrolledToBottom(name)
    return LogDisplayIsScrolledToBottom(name)
end

---
--- Resets the line fade time for a log display.
---@param name string The name of the log display.
function Api.LogDisplay.ResetLineFadeTime(name)
    LogDisplayResetLineFadeTime(name)
end

---
--- Sets whether to show the scrollbar in a log display.
---@param name string The name of the log display.
---@param showScrollbar boolean Whether to show the scrollbar.
function Api.LogDisplay.ShowScrollbar(name, showScrollbar)
    LogDisplayShowScrollbar(name, showScrollbar)
end

---
--- Scrolls a log display to the top.
---@param name string The name of the log display.
function Api.LogDisplay.ScrollToTop(name)
    LogDisplayScrollToTop(name)
end

---
--- Gets whether a log display is scrolled to the top.
---@param name string The name of the log display.
---@return boolean Whether the log display is scrolled to the top.
function Api.LogDisplay.IsScrolledToTop(name)
    return LogDisplayIsScrolledToTop(name)
end

-- ========================================================================== --
-- Api - Mod
-- ========================================================================== --


Api.Mod = {}

---
--- Loads resources for a mod.
---@param path string The path to the resources.
---@param file string The file to load.
---@param resource string The resource to load.
function Api.Mod.LoadResources(path, file, resource)
    LoadResources(path, file, resource)
end

---
--- Sets whether a module is enabled.
---@param moduleName string The name of the module.
---@param isEnabled boolean Whether the module is enabled.
function Api.Mod.SetEnabled(moduleName, isEnabled)
    ModuleSetEnabled(moduleName, isEnabled)
end

---
--- Initializes a module.
---@param moduleName string The name of the module.
function Api.Mod.Initialize(moduleName)
    ModuleInitialize(moduleName)
end

---
--- Gets the data for all modules.
---@return any The data for all modules.
function Api.Mod.GetData()
    return ModulesGetData()
end

---
--- Initializes restricted modules.
function Api.Mod.InitializeRestricted()
    ModulesInitializeRestricted()
end

---
--- Initializes all enabled modules.
function Api.Mod.InitializeAllEnabled()
    ModulesInitializeAllEnabled()
end

---
--- Loads a module as restricted.
---@param modFilePath string The path to the module file.
---@param allowRaw boolean Whether to allow raw loading.
function Api.Mod.LoadModuleAsRestricted(modFilePath, allowRaw)
    ModuleRestrictedLoad(modFilePath, allowRaw)
end

---
--- Loads a module.
---@param modFilePath string The path to the module file.
---@param setName string The name of the set.
---@param allowRaw boolean Whether to allow raw loading.
function Api.Mod.LoadModule(modFilePath, setName, allowRaw)
    ModuleLoad(modFilePath, setName, allowRaw)
end

---
--- Loads modules from a list file.
---@param listFilePath string The path to the list file.
---@param setName string The name of the set.
---@param allowRaw boolean Whether to allow raw loading.
function Api.Mod.LoadModulesFromList(listFilePath, setName, allowRaw)
    ModulesLoadFromListFile(listFilePath, setName, allowRaw)
end

---
--- Loads modules from a directory.
---@param directory string The directory to load modules from.
---@param setName string The name of the set.
function Api.Mod.LoadModulesFromDirectory(directory, setName)
    ModulesLoadFromDirectory(directory, setName)
end

-- ========================================================================== --
-- Api - Object
-- ========================================================================== --

Api.Object = {}

---
--- Gets the distance of an object from the player.
---@param id number The ID of the object.
---@return number The distance of the object from the player.
function Api.Object.GetDistanceFromPlayer(id)
    return GetDistanceFromPlayer(id)
end

---
--- Checks if an object is valid.
---@param id number The ID of the object.
---@return boolean Whether the object is valid.
function Api.Object.IsValid(id)
    return IsValidObject(id)
end

---
--- Checks if an object is a mobile.
---@param id number The ID of the object.
---@return boolean Whether the object is a mobile.
function Api.Object.IsMobile(id)
    return IsMobile(id)
end

---
--- Gets the paperdoll object for a paperdoll ID.
---@param paperdollId number The paperdoll ID.
---@param scale number The scale of the object.
---@return any The paperdoll object.
function Api.Object.GetPaperdollObject(paperdollId, scale)
    return GetPaperdollObject(paperdollId, scale or 1.0)
end

-- ========================================================================== --
-- Api - Radar
-- ========================================================================== --


Api.Radar = {}

---
--- Sets the window size for the radar.
---@param sizeX number The width of the window.
---@param sizeY number The height of the window.
---@param boolOne boolean A boolean value.
---@param centerOnPlayer boolean Whether to center the radar on the player.
function Api.Radar.SetWindowSize(sizeX, sizeY, boolOne, centerOnPlayer)
    UORadarSetWindowSize(sizeX, sizeY, boolOne, centerOnPlayer)
end

---
--- Gets the facet for the radar.
---@return any The facet for the radar.
function Api.Radar.GetFacet()
    return UOGetRadarFacet()
end

---
--- Gets the area for the radar.
---@return any The area for the radar.
function Api.Radar.GetArea()
    return UOGetRadarArea()
end

---
--- Sets the offset for the radar.
---@param offsetX number The x-offset.
---@param offsetY number The y-offset.
function Api.Radar.SetOffset(offsetX, offsetY)
    UORadarSetWindowOffset(offsetX, offsetY)
end

---
--- Gets the maximum zoom for a map.
---@param facet any The facet of the map.
---@param area any The area of the map.
---@return number The maximum zoom.
function Api.Radar.GetMaxZoom(facet, area)
    return UORadarGetMaxZoomForMap(facet, area)
end

---
--- Sets the zoom for the radar.
---@param zoom number The zoom to set.
function Api.Radar.SetZoom(zoom)
    UOSetRadarZoom(zoom)
end

---
--- Sets whether to center the radar on the player.
---@param isCenter boolean Whether to center the radar on the player.
function Api.Radar.SetCenterOnPlayer(isCenter)
    UORadarSetCenterOnPlayer(isCenter)
end

---
--- Gets the physical facet for the radar.
---@return any The physical facet for the radar.
function Api.Radar.GetPhysicalFacet()
    return UOGetPhysicalRadarFacet()
end

---
--- Gets the physical area for the radar.
---@param facet any The facet of the map.
---@param area any The area of the map.
---@return any The physical area for the radar.
function Api.Radar.GetPhysicalArea(facet, area)
    return UORadarGetAreaDimensions(facet, area)
end

---
--- Gets the facet label for the radar.
---@param facet any The facet of the map.
---@return string The facet label.
function Api.Radar.GetFacetLabel(facet)
    return UORadarGetFacetLabel(facet)
end

---
--- Gets the area label for the radar.
---@param facet any The facet of the map.
---@param area any The area of the map.
---@return string The area label.
function Api.Radar.GetAreaLabel(facet, area)
    return UORadarGetAreaLabel(facet, area)
end

---
--- Gets the facet dimensions for the radar.
---@param num number A number.
---@return any The facet dimensions.
function Api.Radar.GetFacetDimensions(num)
    return UORadarGetFacetDimensions(num)
end

---
--- Gets the center of the radar.
---@return any The center of the radar.
function Api.Radar.GetCenter()
    return UOGetRadarCenter()
end

---
--- Sets the rotation for the radar.
---@param rotation number The rotation to set.
function Api.Radar.SetRotation(rotation)
    UOSetRadarRotation(rotation)
end

---
--- Centers the radar on a location.
---@param x number The x-coordinate of the location.
---@param y number The y-coordinate of the location.
---@param facet any The facet of the map.
---@param area any The area of the map.
---@param bool boolean A boolean value.
function Api.Radar.CenterOnLocation(x, y, facet, area, bool)
    UOCenterRadarOnLocation(x, y, facet, area, bool)
end

---
--- Checks if a location is in an area.
---@param x number The x-coordinate of the location.
---@param y number The y-coordinate of the location.
---@param facet any The facet of the map.
---@param area any The area of the map.
---@return boolean Whether the location is in the area.
function Api.Radar.IsLocationInArea(x, y, facet, area)
    return UORadarIsLocationInArea(x, y, facet, area)
end

---
--- Translates a radar position to a world position.
---@param offsetX number The x-offset of the radar position.
---@param offsetY number The y-offset of the radar position.
---@param useScale boolean Whether to use the scale.
---@return any The world position.
function Api.Radar.TranslateRadarPositionToWorldPosition(offsetX, offsetY, useScale)
    return UOGetRadarPosToWorld(offsetX, offsetY, useScale)
end

---
--- Translates a world position to a radar position.
---@param x number The x-coordinate of the world position.
---@param y number The y-coordinate of the world position.
---@return any The radar position.
function Api.Radar.TranslateWorldPositionToRadarPosition(x, y)
    return UOGetWorldPosToRadar(x, y)
end

---
--- Gets the area count for a facet.
---@param facet any The facet.
---@return number The area count.
function Api.Radar.GetAreaCount(facet)
    return UORadarGetAreaCount(facet)
end

-- ========================================================================== --
-- Api - Scroll Window
-- ========================================================================== --

Api.ScrollWindow = {}

---
--- Sets the offset for a scroll window.
---@param id string The ID of the scroll window.
---@param offset number The offset to set.
function Api.ScrollWindow.SetOffset(id, offset)
    ScrollWindowSetOffset(id, offset)
end

---
--- Updates the scroll rect for a scroll window.
---@param id string The ID of the scroll window.
function Api.ScrollWindow.UpdateScrollRect(id)
    ScrollWindowUpdateScrollRect(id)
end

-- ========================================================================== --
-- Api - Settings
-- ========================================================================== --

Api.Settings = {}

---
--- Notifies that the user settings have changed.
---@return boolean Whether the settings need to be reloaded.
function Api.Settings.NotifyChange()
    --This is some variable that the client understands
    needsReload = UserSettingsChanged()
    return needsReload
end

-- ========================================================================== --
-- Api - Slider
-- ========================================================================== --

Api.Slider = {}

---
--- Sets the current position of a slider.
---@param id string The ID of the slider.
---@param position number The position to set.
function Api.Slider.SetCurrentPosition(id, position)
    SliderBarSetCurrentPosition(id, position)
end

---
--- Gets the current position of a slider.
---@param id string The ID of the slider.
---@return number The current position of the slider.
function Api.Slider.GetCurrentPosition(id)
    return SliderBarGetCurrentPosition(id)
end

-- ========================================================================== --
-- Api - Status Bar
-- ========================================================================== --

Api.StatusBar = {}

---
--- Sets the maximum value of a status bar.
---@param id string The ID of the status bar.
---@param value number The maximum value to set.
function Api.StatusBar.SetMaxValue(id, value)
    StatusBarSetMaximumValue(id, value or 0)
end

---
--- Sets the current value of a status bar.
---@param id string The ID of the status bar.
---@param value number The current value to set.
function Api.StatusBar.SetCurrentValue(id, value)
    StatusBarSetCurrentValue(id, value or 0)
end

---
--- Sets the foreground tint of a status bar.
---@param id string The ID of the status bar.
---@param color table The color to set.
function Api.StatusBar.SetForegroundTint(id, color)
    StatusBarSetForegroundTint(id, color.r, color.g, color.b)
end

---
--- Sets the background tint of a status bar.
---@param id string The ID of the status bar.
---@param color table The color to set.
function Api.StatusBar.SetBackgroundTint(id, color)
    StatusBarSetBackgroundTint(id, color.r, color.g, color.b)
end

-- ========================================================================== --
-- Api - String
-- ========================================================================== --

Api.String = {}

---
--- Gets a string from a TID.
---@param tid number The TID.
---@return string The string.
function Api.String.GetStringFromTid(tid)
    return GetStringFromTid(tid)
end

---
--- Converts a string to a wstring.
---@param string string The string to convert.
---@return wstring The wstring.
function Api.String.StringToWString(string)
    return StringToWString(string)
end

---
--- Converts a wstring to a string.
---@param wString wstring The wstring to convert.
---@return string The string.
function Api.String.WStringToString(wString)
    return WStringToString(wString)
end

-- ========================================================================== --
-- Api - Target
-- ========================================================================== --

Api.Target = {}

---
--- Handles a single left click on a target.
---@param id number The ID of the target.
function Api.Target.LeftClick(id)
    HandleSingleLeftClkTarget(id)
end

---
--- Gets all mobile targets.
---@return table All mobile targets.
function Api.Target.GetAllMobileTargets()
    return GetAllMobileTargets()
end

-- ========================================================================== --
-- Api - Text Log
-- ========================================================================== --

Api.TextLog = {}

---
--- Creates a text log.
---@param name string The name of the text log.
---@param num number A number.
function Api.TextLog.Create(name, num)
    TextLogCreate(name, num)
end

---
--- Destroys a text log.
---@param name string The name of the text log.
function Api.TextLog.Destroy(name)
    TextLogDestroy(name)
end

---
--- Sets whether a text log is enabled.
---@param name string The name of the text log.
---@param isEnable boolean Whether the text log is enabled.
function Api.TextLog.SetEnabled(name, isEnable)
    TextLogSetEnabled(name, isEnable == nil or isEnable)
end

---
--- Clears a text log.
---@param name string The name of the text log.
function Api.TextLog.Clear(name)
    TextLogClear(name)
end

---
--- Sets incremental saving for a text log.
---@param name string The name of the text log.
---@param doSave boolean Whether to do incremental saving.
---@param path string The path to save to.
function Api.TextLog.SetIncrementalSaving(name, doSave, path)
    TextLogSetIncrementalSaving(name, doSave, path)
end

---
--- Gets whether a text log is enabled.
---@param name string The name of the text log.
---@return boolean Whether the text log is enabled.
function Api.TextLog.IsEnabled(name)
    return TextLogGetEnabled(name)
end

---
--- Gets the number of entries in a text log.
---@param name string The name of the text log.
---@return number The number of entries.
function Api.TextLog.GetNumEntries(name)
    return TextLogGetNumEntries(name)
end

---
--- Gets an entry from a text log.
---@param name string The name of the text log.
---@param index number The index of the entry.
---@return any The entry.
function Api.TextLog.GetEntry(name, index)
    return TextLogGetEntry(name, index)
end

---
--- Adds an entry to a text log.
---@param name string The name of the text log.
---@param filterId number The ID of the filter.
---@param text string The text of the entry.
function Api.TextLog.AddEntry(name, filterId, text)
    TextLogAddEntry(name, filterId, text)
end

-- ========================================================================== --
-- Api - Time
-- ========================================================================== --

Api.Time = {}

---
--- Gets the current date and time.
---@return any The current date and time.
function Api.Time.GetCurrentDateTime()
    return GetCurrentDateTime()
end

-- ========================================================================== --
-- Api - User Action
-- ========================================================================== --

Api.UserAction = {}

---
--- Uses an item.
---@param id number The ID of the item.
---@param flag boolean A flag.
function Api.UserAction.UseItem(id, flag)
    UserActionUseItem(id, flag)
end

---
--- Toggles war mode.
function Api.UserAction.ToggleWarMode()
    UserActionToggleWarMode()
end

-- ========================================================================== --
-- Api - Viewport
-- ========================================================================== --

Api.Viewport = {}

---
--- Updates the viewport.
---@param x1 number The x1 coordinate.
---@param y1 number The y1 coordinate.
---@param x2 number The x2 coordinate.
---@param y2 number The y2 coordinate.
function Api.Viewport.Update(x1, y1, x2, y2)
    UpdateViewport(x1, y1, x2, y2)
end

-- ========================================================================== --
-- Api - Waypoint
-- ========================================================================== --

Api.Waypoint = {}

---
--- Sets the facet for the waypoint map.
---@param facet any The facet to set.
function Api.Waypoint.SetFacet(facet)
    UOSetWaypointMapFacet(facet)
end

---
--- Creates a user waypoint.
---@param type any The type of the waypoint.
---@param facet any The facet of the map.
---@param x number The x-coordinate of the waypoint.
---@param y number The y-coordinate of the waypoint.
---@param id number The ID of the waypoint.
function Api.Waypoint.Create(type, facet, x, y, id)
    UOCreateUserWaypoint(type, facet, x, y, id)
end

---
--- Deletes a user waypoint.
---@param id number The ID of the waypoint to delete.
function Api.Waypoint.Delete(id)
    UODeleteUserWaypoint(id)
end

---
--- Edits a user waypoint.
---@param id number The ID of the waypoint to edit.
function Api.Waypoint.Edit(id)
    UOEditUserWaypoint(id)
end

---
--- Resets the facet for the waypoint map.
function Api.Waypoint.ResetFacet()
    UOResetWaypointMapFacet()
end

---
--- Sets the display info for a waypoint type.
function Api.Waypoint.SetTypeDisplayInfo()
    UOSetWaypointTypeDisplayInfo()
end

---
--- Sets the display mode for waypoints.
---@param mode any The display mode to set.
function Api.Waypoint.SetDisplayMode(mode)
    UOSetWaypointDisplayMode(mode)
end

---
--- Gets the info for a waypoint.
---@param id number The ID of the waypoint.
---@return any The waypoint info.
function Api.Waypoint.GetInfo(id)
    return UOGetWaypointInfo(id)
end

-- ========================================================================== --
-- Api - Window
-- ========================================================================== --

Api.Window = {}

---
--- Destroys a window.
---@param windowName string The name of the window to destroy.
---@return boolean Whether the window was destroyed.
function Api.Window.Destroy(windowName)
    if Api.Window.DoesExist(windowName) then
        DestroyWindow(windowName)
        return true
    end

    return false
end

---
--- Checks if a window exists.
---@param windowName string The name of the window.
---@return boolean Whether the window exists.
function Api.Window.DoesExist(windowName)
    return DoesWindowNameExist(windowName)
end

---
--- Sets the showing state of a window.
---@param windowName string The name of the window.
---@param show boolean Whether to show the window.
function Api.Window.SetShowing(windowName, show)
    WindowSetShowing(windowName, show)
end

---
--- Gets the showing state of a window.
---@param windowName string The name of the window.
---@return boolean Whether the window is showing.
function Api.Window.IsShowing(windowName)
    return WindowGetShowing(windowName)
end

---
--- Sets the layer of a window.
---@param windowName string The name of the window.
---@param layer number The layer to set.
function Api.Window.SetLayer(windowName, layer)
    WindowSetLayer(windowName, layer)
end

---
--- Gets the layer of a window.
---@param windowName string The name of the window.
---@return number The layer of the window.
function Api.Window.GetLayer(windowName)
    return WindowGetLayer(windowName)
end

---
--- Sets whether a window handles input.
---@param windowName string The name of the window.
---@param handleInput boolean Whether to handle input.
function Api.Window.SetHandleInput(windowName, handleInput)
    WindowHandleInput(windowName, handleInput)
end

---
--- Gets whether a window handles input.
---@param windowName string The name of the window.
---@return boolean Whether the window handles input.
function Api.Window.GetHandleInput(windowName)
    return WindowGetHandleInput(windowName)
end

---
--- Sets whether a window is popable.
---@param windowName string The name of the window.
---@param popable boolean Whether the window is popable.
function Api.Window.SetPopable(windowName, popable)
    WindowSetPopable(windowName, popable)
end

---
--- Gets whether a window is popable.
---@param windowName string The name of the window.
---@return boolean Whether the window is popable.
function Api.Window.IsPopable(windowName)
    return windowGetPopable(windowName)
end

---
--- Sets whether a window is movable.
---@param windowName string The name of the window.
---@param movable boolean Whether the window is movable.
function Api.Window.SetMovable(windowName, movable)
    WindowSetMovable(windowName, movable)
end

---
--- Gets whether a window is movable.
---@param windowName string The name of the window.
---@return boolean Whether the window is movable.
function Api.Window.IsMovable(windowName)
    return WindowGetMovable(windowName)
end

---
--- Sets the offset from the parent of a window.
---@param windowName string The name of the window.
---@param xOffset number The x-offset.
---@param yOffset number The y-offset.
function Api.Window.SetOffsetFromParent(windowName, xOffset, yOffset)
    WindowSetOffsetFromParent(windowName, xOffset, yOffset)
end

---
--- Gets the offset from the parent of a window.
---@param windowName string The name of the window.
---@return number, number The x-offset and y-offset.
function Api.Window.GetOffsetFromParent(windowName)
    return WindowGetOffsetFromParent(windowName)
end

---
--- Sets the dimensions of a window.
---@param windowName string The name of the window.
---@param xOffset number The width.
---@param yOffset number The height.
function Api.Window.SetDimensions(windowName, xOffset, yOffset)
    WindowSetDimensions(windowName, xOffset, yOffset)
end

---
--- Gets the dimensions of a window.
---@param windowName string The name of the window.
---@return number, number The width and height.
function Api.Window.GetDimensions(windowName)
    return WindowGetDimensions(windowName)
end

---
--- Checks if a window is sticky.
---@param windowName string The name of the window.
---@return boolean Whether the window is sticky.
function Api.Window.IsSticky(windowName)
    return WindowIsSticky(windowName)
end

---
--- Clears the anchors of a window.
---@param windowName string The name of the window.
function Api.Window.ClearAnchors(windowName)
    WindowClearAnchors(windowName)
end

---
--- Adds an anchor to a window.
---@param windowName string The name of the window.
---@param anchorPoint string The anchor point.
---@param relativeTo string The window to be relative to.
---@param relativePoint string The relative point.
---@param pointX number The x-point.
---@param pointY number The y-point.
function Api.Window.AddAnchor(windowName, anchorPoint, relativeTo, relativePoint, pointX, pointY)
    WindowAddAnchor(windowName, anchorPoint, relativeTo, relativePoint, pointX or 0, pointY or 0)
end

---
--- Gets an anchor of a window.
---@param windowName string The name of the window.
---@param anchorId number The ID of the anchor.
---@return any The anchor.
function Api.Window.GetAnchor(windowName, anchorId)
    return WindowGetAnchor(windowName, anchorId)
end

---
--- Gets the anchor count of a window.
---@param windowName string The name of the window.
---@return number The anchor count.
function Api.Window.GetAnchorCount(windowName)
    return WindowGetAnchorCount(windowName)
end

---
--- Forces a window to process its anchors.
---@param windowName string The name of the window.
function Api.Window.ForceProcessAnchors(windowName)
    WindowForceProcessAnchors(windowName)
end

---
--- Assigns focus to a window.
---@param windowName string The name of the window.
---@param doFocus boolean Whether to focus the window.
---@return boolean Whether focus was assigned.
function Api.Window.AssignFocus(windowName, doFocus)
    return WindowAssignFocus(windowName, doFocus)
end

---
--- Checks if a window has focus.
---@param windowName string The name of the window.
---@return boolean Whether the window has focus.
function Api.Window.HasFocus(windowName)
    return WindowHasFocus(windowName)
end

---
--- Sets the resizing state of a window.
---@param windowName string The name of the window.
---@param isResizing boolean Whether the window is resizing.
function Api.Window.SetResizing(windowName, isResizing)
    WindowSetResizing(windowName, isResizing)
end

---
--- Gets the resizing state of a window.
---@param windowName string The name of the window.
---@return boolean Whether the window is resizing.
function Api.Window.IsResizing(windowName)
    return WindowGetResizing(windowName)
end

---
--- Starts an alpha animation on a window.
---@param windowName string The name of the window.
---@param animType any The type of the animation.
---@param startAlpha number The starting alpha.
---@param endAlpha number The ending alpha.
---@param duration number The duration of the animation.
---@param setStartBeforeDelay boolean Whether to set the start before the delay.
---@param delay number The delay before the animation starts.
---@param numLoop number The number of times to loop the animation.
function Api.Window.StartAlphaAnimation(windowName, animType, startAlpha, endAlpha, duration, setStartBeforeDelay, delay, numLoop)
    WindowStartAlphaAnimation(windowName, animType, startAlpha, endAlpha, duration, setStartBeforeDelay,
        delay, numLoop)
end

---
--- Stops the alpha animation on a window.
---@param windowName string The name of the window.
function Api.Window.StopAlphaAnimation(windowName)
    WindowStopAlphaAnimation(windowName)
end

---
--- Stops the scale animation on a window.
---@param windowName string The name of the window.
function Api.Window.StopScaleAnimation(windowName)
    WindowStopScaleAnimation(windowName)
end

---
--- Starts a scale animation on a window.
---@param windowName string The name of the window.
---@param animType any The type of the animation.
---@param startX number The starting x-scale.
---@param startY number The starting y-scale.
---@param endX number The ending x-scale.
---@param endY number The ending y-scale.
---@param duration number The duration of the animation.
---@param setStartBeforeDelay boolean Whether to set the start before the delay.
---@param delay number The delay before the animation starts.
---@param numLoop number The number of times to loop the animation.
function Api.Window.StartScaleAnimation(windowName, animType, startX, startY, endX, endY, duration, setStartBeforeDelay, delay, numLoop)
    WindowStartScaleAnimation(
        windowName,
        animType,
        startX,
        startY,
        endX,
        endY,
        duration,
        setStartBeforeDelay,
        delay,
        numLoop
    )
end

---
--- Stops the position animation on a window.
---@param windowName string The name of the window.
function Api.Window.StopPositionAnimation(windowName)
    WindowStopPositionAnimation(windowName)
end

---
--- Sets the alpha of a window.
---@param windowName string The name of the window.
---@param alpha number The alpha to set.
function Api.Window.SetAlpha(windowName, alpha)
    WindowSetAlpha(windowName, alpha)
end

---
--- Gets the alpha of a window.
---@param windowName string The name of the window.
---@return number The alpha of the window.
function Api.Window.GetAlpha(windowName)
    return WindowGetAlpha(windowName)
end

---
--- Sets the color of a window.
---@param windowName string The name of the window.
---@param color table The color to set.
function Api.Window.SetColor(windowName, color)
    WindowSetTintColor(windowName, color.r, color.g, color.b)
end

---
--- Gets the color of a window.
---@param windowName string The name of the window.
---@return number, number, number The red, green, and blue components of the color.
function Api.Window.GetColor(windowName)
    return WindowGetTintColor(windowName)
end

---
--- Creates a window from a template.
---@param windowName string The name of the window.
---@param template string The name of the template.
---@param parent string The name of the parent window.
---@param doShow boolean Whether to show the window.
---@return boolean Whether the window was created.
function Api.Window.CreateFromTemplate(windowName, template, parent, doShow)
    if not Api.Window.DoesExist(windowName) then
        CreateWindowFromTemplateShow(windowName, template or windowName, parent or "Root",
            doShow == nil or doShow)
        return true
    end
    return false
end

---
--- Creates a window.
---@param windowName string The name of the window.
---@param doShow boolean Whether to show the window.
---@return boolean Whether the window was created.
function Api.Window.Create(windowName, doShow)
    if not Api.Window.DoesExist(windowName) then
        CreateWindow(windowName, doShow == nil or doShow)
        return true
    end
    return false
end

---
--- Toggles a window.
---@param windowName string The name of the window.
---@return boolean Whether the window was created or shown.
function Api.Window.ToggleWindow(windowName)
    if not Api.Window.DoesExist(windowName) then
        return Api.Window.Create(windowName, true)
    end
    return true
end

---
--- Sets the ID of a window.
---@param windowName string The name of the window.
---@param id number The ID to set.
function Api.Window.SetId(windowName, id)
    WindowSetId(windowName, id)
end

---
--- Gets the ID of a window.
---@param windowName string The name of the window.
---@return number The ID of the window.
function Api.Window.GetId(windowName)
    return WindowGetId(windowName)
end

---
--- Sets the tab order of a window.
---@param windowName string The name of the window.
---@param tabOrder number The tab order to set.
function Api.Window.SetTabOrder(windowName, tabOrder)
    WindowSetTabOrder(windowName, tabOrder)
end

---
--- Gets the tab order of a window.
---@param windowName string The name of the window.
---@return number The tab order of the window.
function Api.Window.GetTabOrder(windowName)
    return WindowGetTabOrder(windowName)
end

---
--- Sets the moving state of a window.
---@param windowName string The name of the window.
---@param isMoving boolean Whether the window is moving.
function Api.Window.SetMoving(windowName, isMoving)
    WindowSetMoving(windowName, isMoving)
end

---
--- Gets the moving state of a window.
---@param windowName string The name of the window.
---@return boolean Whether the window is moving.
function Api.Window.IsMoving(windowName)
    return WindowGetMoving(windowName)
end

---
--- Registers an event handler for a window.
---@param windowName string The name of the window.
---@param event string The event to register.
---@param callback function The callback function.
function Api.Window.RegisterEventHandler(windowName, event, callback)
    WindowRegisterEventHandler(windowName, event, callback)
end

---
--- Unregisters an event handler for a window.
---@param windowName string The name of the window.
---@param event string The event to unregister.
function Api.Window.UnregisterEventHandler(windowName, event)
    WindowUnregisterEventHandler(windowName, event)
end

---
--- Registers a core event handler for a window.
---@param windowName string The name of the window.
---@param event string The event to register.
---@param callback function The callback function.
function Api.Window.RegisterCoreEventHandler(windowName, event, callback)
    WindowRegisterCoreEventHandler(windowName, event, callback)
end

---
--- Unregisters a core event handler for a window.
---@param windowName string The name of the window.
---@param event string The event to unregister.
function Api.Window.UnregisterCoreEventHandler(windowName, event)
    WindowUnregisterCoreEventHandler(windowName, event)
end

---
--- Sets the parent of a window.
---@param windowName string The name of the window.
---@param parentId string The ID of the parent window.
function Api.Window.SetParent(windowName, parentId)
    WindowSetParent(windowName, parentId)
end

---
--- Gets the parent of a window.
---@param windowName string The name of the window.
---@return string The parent of the window.
function Api.Window.GetParent(windowName)
    return WindowGetParent(windowName)
end

---
--- Sets the scale of a window.
---@param windowName string The name of the window.
---@param scale number The scale to set.
function Api.Window.SetScale(windowName, scale)
    WindowSetScale(windowName, scale)
end

---
--- Gets the scale of a window.
---@param windowName string The name of the window.
---@return number The scale of the window.
function Api.Window.GetScale(windowName)
    return WindowGetScale(windowName)
end

---
--- Sets the relative scale of a window.
---@param windowName string The name of the window.
---@param scale number The relative scale to set.
function Api.Window.SetRelativeScale(windowName, scale)
    WindowSetRelativeScale(windowName, scale)
end

---
--- Resizes a window based on its children.
---@param windowName string The name of the window.
---@param isRecursive boolean Whether to resize recursively.
---@param borderSpacing number The border spacing.
function Api.Window.SetResizeOnChildren(windowName, isRecursive, borderSpacing)
    WindowResizeOnChildren(windowName, isRecursive, borderSpacing)
end

---
--- Sets the game action trigger for a window.
---@param windowName string The name of the window.
---@param action any The action to set.
function Api.Window.SetGameActionTrigger(windowName, action)
    WindowSetGameActionTrigger(windowName, action)
end

---
--- Sets the game action data for a window.
---@param windowName string The name of the window.
---@param actionType any The type of the action.
---@param actionId number The ID of the action.
---@param actionText string The text of the action.
function Api.Window.SetGameActionData(windowName, actionType, actionId, actionText)
    WindowSetGameActionData(windowName, actionType, actionId, actionText)
end

---
--- Sets the game action button for a window.
---@param windowName string The name of the window.
---@param button any The button to set.
function Api.Window.SetGameActionButton(windowName, button)
    WindowSetGameActionButton(windowName, button)
end

---
--- Gets the game action button for a window.
---@param windowName string The name of the window.
---@return any The game action button.
function Api.Window.GetGameActionButton(windowName)
    return WindowGetGameActionButton(windowName)
end

---
--- Checks if the game action is locked for a window.
---@param windowName string The name of the window.
---@return boolean Whether the game action is locked.
function Api.Window.IsGameActionLocked(windowName)
    return WindowIsGameActionLocked(windowName)
end

---
--- Sets whether to draw a window when the interface is hidden.
---@param windowName string The name of the window.
---@param doDraw boolean Whether to draw the window.
function Api.Window.SetDrawWhenInterfaceHidden(windowName, doDraw)
    WindowSetDrawWhenInterfaceHidden(windowName, doDraw)
end

---
--- Restores the default settings for a window.
---@param windowName string The name of the window.
function Api.Window.RestoreDefaults(windowName)
    WindowRestoreDefaultSettings(windowName)
end

---
--- Sets the update frequency for a window.
---@param windowName string The name of the window.
---@param frequency number The update frequency to set.
function Api.Window.SetUpdateFrequency(windowName, frequency)
    WindowSetUpdateFrequency(windowName, frequency)
end

---
--- Gets the screen position of a window.
---@param id string The ID of the window.
---@return number, number The x and y coordinates of the window.
function Api.Window.GetPosition(id)
    return WindowGetScreenPosition(id)
end

---
--- Attaches a window to a world object.
---@param objectId number The ID of the world object.
---@param window string The name of the window.
function Api.Window.AttachToWorldObject(objectId, window)
    AttachWindowToWorldObject(objectId, window)
end

---
--- Detaches a window from a world object.
---@param objectId number The ID of the world object.
---@param window string The name of the window.
function Api.Window.DetachFromWorldObject(objectId, window)
    DetachWindowFromWorldObject(objectId, window)
end

---
--- Registers window data.
---@param data any The data to register.
---@param id number The ID of the data.
function Api.Window.RegisterData(data, id)
    RegisterWindowData(data, id or 0)
end

---
--- Unregisters window data.
---@param data any The data to unregister.
---@param id number The ID of the data.
function Api.Window.UnregisterData(data, id)
    UnregisterWindowData(data, id or 0)
end

---
--- Saves the position of a window.
---@param window string The name of the window.
---@param closing boolean Whether the window is closing.
---@param alias string An alias for the window.
function Api.Window.SavePosition(window, closing, alias)
    WindowUtils.SaveWindowPosition(window, closing, alias)
end

---
--- Restores the position of a window.
---@param window string The name of the window.
---@param trackSize boolean Whether to track the size of the window.
---@param alias string An alias for the window.
---@param ignoreBounds boolean Whether to ignore the bounds of the window.
function Api.Window.RestorePosition(window, trackSize, alias, ignoreBounds)
    WindowUtils.RestoreWindowPosition(window, trackSize, alias, ignoreBounds)
end

-- ========================================================================== --
-- Api - Interface Core
-- ========================================================================== --


Api.InterfaCore = {}

---
--- Gets the scale factor of the interface.
---@return number The scale factor.
function Api.InterfaCore.GetScaleFactor()
    return 1 / InterfaceCore.scale
end


-- ========================================================================== --
-- Utils
-- ========================================================================== --

-- ========================================================================== --
-- Utils - Array
-- ========================================================================== --

Utils.Array = {}

---@generic K
---@generic V
---@generic T
---@param array T[]
---@param getKey fun(item: T, index: integer): K
---@param getValue fun(item: T, index: integer): V
---@return table<K,V>
function Utils.Array.MapToTable(array, getKey, getValue)
    local newTable = {}

    Utils.Array.ForEach(
        array,
        function (item, index)
            newTable[getKey(item, index)] = getValue(item, index)
        end
    )

    return newTable
end

---@generic T
---@param array T[]
---@param find fun(item: T): boolean
---@return integer
function Utils.Array.IndexOf(array, find)
    for i = 1, #array do
        local item = array[i]
        if find(item) then
            return i
        end
    end

    return -1
end

---@generic T
---@param array T[]
---@param find fun(item: T): boolean
---@return T?
function Utils.Array.Find(array, find)
    for i = 1, #array do
        local item = array[i]
        if find(item) then
            return item
        end
    end

    return nil
end

---@generic T
---@param array T[]
---@param forEach fun(item: T, index: integer)
function Utils.Array.ForEach(array, forEach)
    for i = 1, #array do
        local item = array[i]
        forEach(item, i)
    end
end

-- ========================================================================== --
-- Utils - Table
-- ========================================================================== --

Utils.Table = {}

---@generic K
---@generic V
---@param table table<K, V>
---@param forEach fun(k: K, v: V)
function Utils.Table.ForEach(table, forEach)
    for k, v in pairs(table) do
        forEach(k, v)
    end
end

---@generic K
---@generic V
---@param table table<K, V>
---@return table<K, V>
function Utils.Table.Copy(table)
    local newTable = {}
    for k, v in pairs(table) do
        newTable[k] = v
    end
    return newTable
end

---@generic K
---@generic V
---@param table table<K, V>
---@return table<K, V>
function Utils.Table.OverrideFunctions(table)
    for k, v in pairs(table) do
        if type(v) == "function" then
            table[k] = function () end
        end
    end
    return table
end

-- ========================================================================== --
-- Utils - String
-- ========================================================================== --

Utils.String = {}

function Utils.String.ExtractNumber(text)
    return tonumber(string.match(text, "%d+") or 0)
end

function Utils.String.Random()
    local charset = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
    local result = ""
    for i = 1, 24 do
        local rand = math.random(1, #charset)
        result = result .. charset:sub(rand, rand)
    end
    return result
end

function Utils.String.FromWString(text)
    if type(text) == "string" then
        return text
    else
        return Api.String.WStringToString(text)
    end
end

function Utils.String.ToWString(text)
    if type(text) == "number" then
        return Api.String.GetStringFromTid(text)
    elseif type(text) == "wstring" then
        return text
    elseif type(text) == "string" then
        return Api.String.StringToWString(text)
    else
        return Api.String.StringToWString(tostring(text))
    end
end

function Utils.String.Lower(text)
    if type(text) == "string" then
        return string.lower(text)
    elseif type(text) == "wstring" then
        return string.lower(Utils.String.FromWString(text))
    end
end

function Utils.String.Upper(text)
    if type(text) == "string" then
        return string.upper(text)
    elseif type(text) == "wstring" then
        return string.upper(Utils.String.FromWString(text))
    end
end


-- ========================================================================== --
-- Constants
-- ========================================================================== --

Constants.TargetType = {
    Mobile = 2,
    Object = 3,
    Corpse = 4
}

Constants.ButtonFlags = {
    Control = 8,
    Alt = 32,
    Shift = 4
}

Constants.DragSource = {}

function Constants.DragSource.Object()
    return SystemData.DragSource["SOURCETYPE_OBJECT"]
end

Constants.Broadcasts = {}

function Constants.Broadcasts.Help()
    return SystemData.Events["REQUEST_OPEN_HELP_MENU"]
end

function Constants.Broadcasts.BeginHealthBarDrag()
    return SystemData.Events["BEGIN_DRAG_HEALTHBAR_WINDOW"]
end


function Constants.Broadcasts.EscapeKeyProcessed()
    return SystemData.Events["ESCAPE_KEY_PROCESSED"]
end

function Constants.Broadcasts.ExitGame()
    return SystemData.Events["EXIT_GAME"]
end

function Constants.Broadcasts.BugReport()
    return SystemData.Events["BUG_REPORT_SCREEN"]
end

---@class DataEvent
---@field getType fun(): integer
---@field getEvent fun(): integer
---@field name string

---@type table<string, DataEvent>
Constants.DataEvents = {}

Constants.DataEvents.OnUpdateMobileName = {
    getType = function ()
        return WindowData.MobileName.Type
    end,
    getEvent = function ()
        return WindowData.MobileName.Event
    end,
    name = "OnUpdateMobileName"
}

Constants.DataEvents.OnUpdatePlayerStatus = {
    getType = function ()
        return WindowData.PlayerStatus.Type
    end,
    getEvent = function ()
        return WindowData.PlayerStatus.Event
    end,
    name = "OnUpdatePlayerStatus"
}

Constants.DataEvents.OnUpdateHealthBarColor = {
    getType = function ()
        return WindowData.HealthBarColor.Type
    end,
    getEvent = function ()
            return WindowData.HealthBarColor.Event
        end,
    name = "OnUpdateHealthBarColor"
}

Constants.DataEvents.OnUpdateMobileStatus = {
    getType = function ()
        return WindowData.MobileStatus.Type
    end,
    getEvent = function ()
        return WindowData.MobileStatus.Event
    end,
    name = "OnUpdateMobileStatus"
}

---@class SystemEvent
---@field getEvent fun(): integer
---@field name string

---@type table<string, SystemEvent>
Constants.SystemEvents = {}

Constants.SystemEvents.OnEndHealthBarDrag = {
    getEvent = function ()
        return SystemData.Events["END_DRAG_HEALTHBAR_WINDOW"]
    end,
    name = "OnEndHealthBarDrag"
}

Constants.CoreEvents = {}
Constants.CoreEvents.OnInitialize = "OnInitialize"
Constants.CoreEvents.OnShown = "OnShown"
Constants.CoreEvents.OnHidden = "OnHidden"
Constants.CoreEvents.OnShutdown = "OnShutdown"
Constants.CoreEvents.OnLButtonUp = "OnLButtonUp"
Constants.CoreEvents.OnLButtonDown = "OnLButtonDown"
Constants.CoreEvents.OnRButtonUp = "OnRButtonUp"
Constants.CoreEvents.OnRButtonDown = "OnRButtonDown"
Constants.CoreEvents.OnUpdate = "OnUpdate"
Constants.CoreEvents.OnLButtonDblClk = "OnLButtonDblClk"
Constants.CoreEvents.OnMouseOver = "OnMouseOver"
Constants.CoreEvents.OnMouseOverEnd = "OnMouseOverEnd"
Constants.CoreEvents.OnMouseDrag = "OnMouseDrag"

Constants.AnchorPoints = {}
Constants.AnchorPoints.BottomLeft = "bottomleft"
Constants.AnchorPoints.TopLeft = "topleft"
Constants.AnchorPoints.Top = "top"
Constants.AnchorPoints.Bottom = "bottom"
Constants.AnchorPoints.Center = "center"

Constants.WindowLayers = {}
Constants.WindowLayers.Background = 0
Constants.WindowLayers.Default = 1
Constants.WindowLayers.Secondary = 2
Constants.WindowLayers.Popup = 3
Constants.WindowLayers.Overlay = 4

Constants.ButtonStates = {}
Constants.ButtonStates.Normal = 0
Constants.ButtonStates.Pressed = 1
Constants.ButtonStates.Disabled = 2
Constants.ButtonStates.Highlighted = 3
Constants.ButtonStates.PressedHighlighted = 4
Constants.ButtonStates.DisabledPressed = 5

Constants.Textures = {}
Constants.Textures.MenuSelection = "MenuSelection"

Constants.Colors = {}
Constants.Colors.White = { r = 255, g = 255, b = 255 }
Constants.Colors.OffWhite = { r = 206, g = 217, b = 242 }
Constants.Colors.Red = { r = 164, g = 32,   b = 32 }
Constants.Colors.YellowDark = { r = 164, g = 164, b = 32 }
Constants.Colors.Blue = { r = 32, g = 32, b = 164 }
Constants.Colors.HealhBar = {
    { r = 164, g = 32, b = 32 }, -- Healthy
    { r = 32, g = 164, b = 32 }, -- Poisoned
    { r = 128, g = 128, b = 128 } -- Cursed
}
Constants.Colors.Notoriety = {
    { r = 128, g = 200, b = 255 }, -- Innocent
    { r = 0,   g = 180, b = 0   }, -- Friendly
    { r = 225, g = 225, b = 225 }, -- Attackable
    { r = 225, g = 225, b = 225 }, -- Criminal
    { r = 242, g = 159, b = 77  }, -- Enemy
    { r = 255, g = 64,  b = 64  }, -- Murderer
    { r = 255, g = 255, b = 0   } -- Invulnerable
}

Constants.TextAlignment = {}
Constants.TextAlignment.Center = "center"


-- ========================================================================== --
-- Data
-- ========================================================================== --

-- ========================================================================== --
-- Data - Active Mobile
-- ========================================================================== --

---@class SystemData.ActiveMobile
---@field Id number

---@class ActiveMobileWrapper
local ActiveMobile = {}
ActiveMobile.__index = ActiveMobile

function ActiveMobile:new()
    return setmetatable({}, self)
end

---@return SystemData.ActiveMobile
function ActiveMobile:getData()
    return SystemData.ActiveMobile
end

function ActiveMobile:getId()
    return self:getData().Id
end

function ActiveMobile:setId(id)
    self:getData().Id = id
end

function Data.ActiveMobile()
    return ActiveMobile:new()
end


-- ========================================================================== --
-- Data - Current Target
-- ========================================================================== --

---@class WindowData.CurrentTarget
---@field TargetId number
---@field HasPaperdoll boolean
---@field TargetType number
---@field HasTarget boolean
---@field isMobile fun(): boolean
---@field isObject fun(): boolean
---@field isCorpse fun(): boolean

---@class CurrentTargetWrapper
local CurrentTarget = {}
CurrentTarget.__index = CurrentTarget

function CurrentTarget:new()
    return setmetatable({}, self)
end

---@return WindowData.CurrentTarget
function CurrentTarget:getData()
    return WindowData.CurrentTarget
end

function CurrentTarget:hasTarget()
    return self:getData().HasTarget
end

function CurrentTarget:isMobile()
    return self:getData().TargetType == 2
end

function CurrentTarget:isCorpse()
    return self:getData().TargetType == 4
end

function CurrentTarget:isObject()
    return self:getData().TargetType == 3
end

function CurrentTarget:getId()
    return self:getData().TargetId
end

function Data.CurrentTarget()
    return CurrentTarget:new()
end

-- ========================================================================== --
-- Data - Cursor
-- ========================================================================== --

---@class WindowData.Cursor
---@field target boolean

---@class CursorDataWrapper
local Cursor = {}
Cursor.__index = Cursor

function Cursor:new()
    return setmetatable({}, self)
end

---@return WindowData.Cursor
function Cursor:getData()
    return WindowData.Cursor
end

function Cursor:isTarget()
    return self:getData().target
end

function Data.Cursor()
    return Cursor:new()
end

-- ========================================================================== --
-- Data - Drag
-- ========================================================================== --

---@class DragDataWrapper
local Drag = {}
Drag.__index = Drag

function Drag:new()
    return setmetatable({}, self)
end

---@return table<string, number>
function Drag:getDragItemData()
    return SystemData.DragItem
end

---@return table<string, number>
function Drag:getDragSourceData()
    return SystemData.DragSource
end

function Drag:isDraggingItem()
    return self:getDragItemData().DragType == SystemData.DragItem.TYPE_ITEM
end

function Drag:getDraggingObject()
    return self:getDragSourceData()["SOURCETYPE_OBJECT"]
end

function Data.Drag()
    return Drag:new()
end

-- ========================================================================== --
-- Data - Health Bar Color
-- ========================================================================== --

---@class WindowData.HealthBarColor
---@field VisualStateId number

---@class HealthBarColorWrapper
---@field _id number
local HealthBarColor = {}
HealthBarColor.__index = HealthBarColor

function HealthBarColor:new(id)
    local instance = setmetatable({}, self)
    instance._id = id
    return instance
end

---@return WindowData.HealthBarColor
function HealthBarColor:getData()
    return WindowData.HealthBarColor[self._id]
end

function HealthBarColor:getVisualStateId()
    return self:getData().VisualStateId
end

function HealthBarColor:getVisualStateColor()
    return Constants.Colors.HealhBar[self:getVisualStateId() + 1]
end

function Data.HealthBarColor(id)
    return HealthBarColor:new(id)
end

-- ========================================================================== --
-- Data - Mobile Name
-- ========================================================================== --

---@class MobileNameWrapper
---@field _id number
local MobileName = {}
MobileName.__index = MobileName

function MobileName:new(id)
    local instance = setmetatable({}, self)
    instance._id = id
    return instance
end

---@return MobileName
function MobileName:getData()
    return WindowData.MobileName[self._id]
end

function MobileName:getName()
    return self:getData().MobName
end

function Data.MobileName(id)
    return MobileName:new(id)
end

-- ========================================================================== --
-- Data - Mobile Status
-- ========================================================================== --

---@class WindowData.MobileStatus
---@field MaxMana number
---@field Gender number
---@field MobName string
---@field MaxStamina number
---@field CurrentHealth number
---@field Race number
---@field MyPet boolean
---@field CurrentStamina number
---@field IsDead boolean
---@field CurrentMana number
---@field MaxHealth number
---@field Notoriety number

---@class MobileStatusWrapper
---@field _id number
local MobileStatus = {}
MobileStatus.__index = MobileStatus

function MobileStatus:new(id)
    local instance = setmetatable({}, self)
    instance._id = id
    return instance
end

---@return WindowData.MobileStatus
function MobileStatus:getData()
    return WindowData.MobileStatus[self._id]
end

function MobileStatus:getName()
    return self:getData().MobName
end

function MobileStatus:getNotoriety()
    return self:getData().Notoriety
end

function MobileStatus:getNotorietyColor()
    return Constants.Colors.Notoriety[self:getNotoriety() + 1]
end

function Data.MobileStatus(id)
    return MobileStatus:new(id)
end

-- ========================================================================== --
-- Data - Mouse
-- ========================================================================== --

---@class SystemData.Position
---@field x number
---@field y number

---@class MouseDataWrapper
local Mouse = {}
Mouse.__index = Mouse

function Mouse:new()
    return setmetatable({}, self)
end

---@return SystemData.Position
function Mouse:getPosition()
    return SystemData.MousePosition
end

function Data.Mouse()
    return Mouse:new()
end

-- ========================================================================== --
-- Data - Mouse Over
-- ========================================================================== --

---@class SystemData.Window
---@field name string

---@class MouseOverDataWrapper
local MouseOver = {}
MouseOver.__index = MouseOver

function MouseOver:new()
    return setmetatable({}, self)
end

---@return string
function MouseOver:getWindow()
    return SystemData.MouseOverWindow.name
end

function Data.MouseOver()
    return MouseOver:new()
end

-- ========================================================================== --
-- Data - Object
-- ========================================================================== --

---@class ObjectWrapper
---@field _id number
local Object = {}
Object.__index = Object

function Object:new(id)
    local instance = setmetatable({}, self)
    instance._id = id
    return instance
end

function Object:isValid()
    return Api.Object.IsValid(self._id)
end

function Object:isMobile()
    return Api.Object.IsMobile(self._id)
end

function Data.Object(id)
    return Object:new(id)
end

-- ========================================================================== --
-- Data - Object Handles
-- ========================================================================== --

---@class WindowData.ObjectHandle
---@field ObjectId integer[]
---@field Names string[]
---@field Notoriety integer[]
---@field IsMobile boolean[]

---@class ObjectHandle
---@field id integer
---@field name string
---@field isMobile boolean
---@field isValid fun(): boolean

---@class ObjectHandleDataWrapper
local ObjectHandles = {}
ObjectHandles.__index = ObjectHandles

function ObjectHandles:new()
    return setmetatable({}, self)
end

---@return WindowData.ObjectHandle
function ObjectHandles:getData()
    return WindowData.ObjectHandle
end

---@return table<number, ObjectHandle>
function ObjectHandles:getHandles()
    local windowData = self:getData()

    return Utils.Array.MapToTable(
        windowData.ObjectId,
        function (item)
            return item
        end,
        function (item, index)
            return {
                id = item,
                name = Utils.String.FromWString(windowData.Names[index]),
                notoriety = windowData.Notoriety[index],
                isMobile = windowData.IsMobile[index],
                isValid = function ()
                    return Data.Object(item):isValid()
                        and Utils.Array.Find(windowData.ObjectId, function (id)
                            return id == item
                        end)
                end
            }
        end
    )
end

function ObjectHandles:getHandle(id)
    return self:getHandles()[id]
end

function Data.ObjectHandles()
    return ObjectHandles:new()
end

-- ========================================================================== --
-- Data - Player Status
-- ========================================================================== --

---@class WindowData.PlayerStatus
---@field StatCap number
---@field StamRegen number
---@field StatLock number[]
---@field Intelligence number
---@field IncreaseManaMax number
---@field InWarMode boolean
---@field Race number
---@field TithingPoints number
---@field Gold number
---@field EnhancePotions number
---@field IncreaseStamMax number
---@field ReflectPhysicalDamage number
---@field CurrentMana number
---@field IncreaseStr number
---@field IncreaseHitPointsMax number
---@field SwingSpeedIncrease number
---@field HitPointRegen number
---@field MaxPhysicalResist number
---@field Strength number
---@field MaxStamina number
---@field CurrentHealth number
---@field IncreaseMana number
---@field MaxEnergyResist number
---@field CurrentStamina number
---@field MaxWeight number
---@field DamageChangeIncrease number
---@field MaxHealth number
---@field PlayerId number
---@field MaxFollowers number
---@field LowerManaCost number
---@field MaxColdResist number
---@field FasterCastRecovery number
---@field SpellDamageIncrease number
---@field MaxDefenseChanceIncrease number
---@field IncreaseStam number
---@field IncreaseHitPoints number
---@field LowerReagentCost number
---@field ManaRegen number
---@field Luck number
---@field Weight number
---@field ColdResist number
---@field Followers number
---@field HitChanceIncrease number
---@field EnergyResist number
---@field MaxMana number
---@field PhysicalResist number
---@field MaxPoisonResist number
---@field MaxDamage number
---@field IncreaseInt number
---@field FasterCasting number
---@field MaxFireResist number
---@field IncreaseDex number
---@field DefenseChanceIncrease number
---@field VisualStateId number
---@field Dead number
---@field PoisonResist number
---@field Damage number
---@field FireResist number
---@field Dexterity number
---@field Type integer
---@field Event integer

---@class PlayerStatusWrapper
local PlayerStatus = {}
PlayerStatus.__index = PlayerStatus

function PlayerStatus:new()
    return setmetatable({}, self)
end

---@return WindowData.PlayerStatus
function PlayerStatus:getData()
    return WindowData.PlayerStatus
end

function PlayerStatus:getStatCap()
    return self:getData().StatCap
end

function PlayerStatus:getCurrentMana()
    return self:getData().CurrentMana
end

function PlayerStatus:getMaxMana()
    return self:getData().MaxMana
end

function PlayerStatus:getCurrentHealth()
    return self:getData().CurrentHealth
end

function PlayerStatus:getMaxHealth()
    return self:getData().MaxHealth
end

function PlayerStatus:getCurrentStamina()
    return self:getData().CurrentStamina
end

function PlayerStatus:getMaxStamina()
    return self:getData().MaxStamina
end

function PlayerStatus:isInWarMode()
    return self:getData().InWarMode
end

function PlayerStatus:getId()
    return self:getData().PlayerId
end

---@return integer
function PlayerStatus:getEvent()
    return self:getData().Event
end

---@return integer
function PlayerStatus:getType()
    return self:getData().Type
end

function Data.PlayerStatus()
    return PlayerStatus:new()
end


-- ========================================================================== --
-- Event Handler
-- ========================================================================== --

local EventHandler = {}

---@type table<string, Window>
local Windows = {}

function EventHandler.OnInitialize()
    local window = Windows[Active.window()]
    window._events:onInitialize()
end

function EventHandler.OnShutdown()
    local window = Windows[Active.window()]
    window._events:onShutdown()
    Windows[Active.window()] = nil
end

function EventHandler.OnLButtonUp(flags, x, y)
    local window = Windows[Active.window()]
    window._events:onLButtonUp(flags, x, y)
end

function EventHandler.OnLButtonDown(flags, x, y)
    local window = Windows[Active.window()]
    window._events:onLButtonDown(flags, x, y)
end

function EventHandler.OnRButtonDown(flags, x, y)
    local window = Windows[Active.window()]
    window._events:onRButtonDown(flags, x, y)
end

function EventHandler.OnRButtonUp(flags, x, y)
    local window = Windows[Active.window()]
    window._events:onRButtonUp(flags, x, y)
end

function EventHandler.OnHidden()
    local window = Windows[Active.window()]
    window._events:onHidden()
end

function EventHandler.OnShown()
    local window = Windows[Active.window()]
    window._events:onShown()
end

function EventHandler.OnUpdate(timePassed)
    local window = Windows[Active.window()]
    window._events:onUpdate(timePassed)
end

function EventHandler.OnUpdateMobileName()
    local window = Windows[Active.window()]
    window._events:onUpdateMobileName()
end

function EventHandler.OnLButtonDblClk(flags, x, y)
    local window = Windows[Active.window()]
    window._events:onLButtonDblClk(flags, x, y)
end

function EventHandler.OnMouseOver()
    local window = Windows[Active.window()]
    window._events:onMouseOver()
end

function EventHandler.OnMouseOverEnd()
    local window = Windows[Active.window()]
    window._events:onMouseOverEnd()
end

function EventHandler.OnMouseDrag()
    local window = Windows[Active.window()]
    window._events:onMouseDrag()
end

function EventHandler.OnUpdatePlayerStatus()
    local window = Windows[Active.window()]
    window._events:onUpdatePlayerStatus()
end

function EventHandler.OnUpdateMobileStatus()
    local window = Windows[Active.window()]
    window._events:onUpdateMobileStatus()
end

function EventHandler.OnUpdateHealthBarColor()
    local window = Windows[Active.window()]
    window._events:onUpdateHealthBarColor()
end

function EventHandler.OnEndHealthBarDrag()
    local window = Windows[Active.window()]
    window._events:onEndHealthBarDrag()
end

-- ========================================================================== --
-- Events
-- ========================================================================== --


---@class Events
---@field _model WindowEventsModel? The model containing event data.
---@field _window Window The window to which events are attached.
local Events = {}
Events.__index = Events

---@generic T:Window
---@param window T The window to attach events to.
---@param model WindowEventsModel? Optional model containing event data.
---@return Events
function Events:new(window, model)
    local instance = setmetatable({}, self)
    instance._window = window
    instance._model = model
    return instance
end

function Events:onInitialize()
    local window = self._window
    local id = Utils.String.ExtractNumber(window:getName())

    if id ~= 0 then
        window:setId(id)
    end

    local prefix = "UusCorp.EventHandler."

    for k, _ in pairs(self._model) do
        local dataEvent = Constants.DataEvents[k]
        local systemEvent = Constants.SystemEvents[k]
        local isCore = Constants.CoreEvents[k] ~= nil
        local skip = k == Constants.CoreEvents.OnInitialize or
            k == Constants.CoreEvents.OnShutdown

        local functionName = prefix .. k

        if isCore and not skip then
            window:registerCoreEventHandler(k, functionName)
        elseif systemEvent ~= nil then
            window:registerEventHandler(systemEvent.getEvent(), functionName)
        elseif dataEvent ~= nil then
            if k == Constants.DataEvents.OnUpdatePlayerStatus then
                window:registerData(dataEvent.getType(), 0)
            else
                window:registerData(dataEvent.getType(), window:getId())
            end
            window:registerEventHandler(dataEvent.getEvent(), functionName)
        end
    end

    window:registerCoreEventHandler(
        Constants.CoreEvents.OnShutdown,
        prefix .. Constants.CoreEvents.OnShutdown
    )

    if window:isParentRoot() and self._model.OnRButtonUp == nil then
        window:registerCoreEventHandler(
            Constants.CoreEvents.OnRButtonUp,
            prefix .. Constants.CoreEvents.OnRButtonUp
        )
    end

    if self._model.OnInitialize ~= nil then
        self._model.OnInitialize(window)
    end

    window:restorePosition()

    Utils.Array.ForEach(
        window._children,
        function (item, index)
            item:create(true)
            item:setParent(window:getName())
            item._events:onInitialize()
            if index > 1 then
                item:addAnchor(
                    "bottomleft",
                    window._children[index - 1]:getName(),
                    "topleft",
                    0,
                    8
                )
            end
        end
    )

    window:toggleBackground(window:isParentRoot())
    window:toggleFrame(window:isParentRoot())

    for k, v in pairs(self) do
        if Constants.DataEvents[k] then
            v()
        end
    end
end

function Events:onShutdown()
    local window = self._window
    window:savePosition()

    Utils.Array.ForEach(window._children, function (item)
        item:destroy()
    end)

    if self._model.OnShutdown ~= nil then
        self._model.OnShutdown(window)
    end

    for k, _ in pairs(self._model) do
        local dataEvent = Constants.DataEvents[k]
        local systemEvent = Constants.SystemEvents[k]
        local isCore = Constants.CoreEvents[k] ~= nil

        if isCore then
            window:unregisterCoreEventHandler(k)
        elseif systemEvent ~= nil then
            window:unregisterEventHandler(systemEvent.getEvent())
        elseif dataEvent ~= nil then
            if k == Constants.DataEvents.OnUpdatePlayerStatus then
                window:unregisterData(dataEvent.getType(), 0)
            else
                window:unregisterData(dataEvent.getType(), window:getId())
            end
            window:unregisterEventHandler(dataEvent.getEvent())
        end
    end
end

function Events:onLButtonUp(flags, x, y)
    local window = self._window
    if self._model.OnLButtonUp ~= nil then
        self._model.OnLButtonUp(window, flags, x, y)
    end

    local child = Utils.Array.Find(
        window._children,
        function (item)
            return item:getName() == Active.window()
        end
    )

    if child ~= nil then
        child._events:onLButtonUp(flags, x, y)
    end
end

function Events:onLButtonDown(flags, x, y)
    local window = self._window

    if self._model.OnLButtonDown ~= nil then
        self._model.OnLButtonDown(window, flags, x, y)
    end

    local child = Utils.Array.Find(
        window._children,
        function (item)
            return item:getName() == Active.window()
        end
    )

    if child ~= nil then
        child._events:onLButtonDown(flags, x, y)
    end
end

function Events:onRButtonUp(flags, x, y)
    local window = self._window
    if window:isParentRoot() and self._model.OnRButtonUp == nil then
        window:destroy()
        return
    end

    if self._model.OnRButtonUp ~= nil then
        self._model.OnRButtonUp(window, flags, x, y)
    end

    local child = Utils.Array.Find(
        window._children,
        function (item)
            return item:getName() == Active.window()
        end
    )

    if child ~= nil then
        child._events:onRButtonUp(flags, x, y)
    end
end

function Events:onRButtonDown(flags, x, y)
    local window = self._window
    if self._model.OnRButtonDown ~= nil then
        self._model.OnRButtonDown(window, flags, x, y)
        return
    end

    local child = Utils.Array.Find(
        window._children,
        function (item)
            return item:getName() == Active.window()
        end
    )

    if child ~= nil then
        child._events:onRButtonDown(flags, x, y)
    end
end

function Events:onHidden()
    local window = self._window
    if self._model.OnHidden ~= nil then
        self._model.OnHidden(window)
    end

    Utils.Array.ForEach(
        window._children,
        function (item)
            item._events:onHidden()
        end
    )
end

function Events:onShown()
    local window = self._window
    if self._model.OnShown ~= nil then
        self._model.OnShown(window)
    end

    Utils.Array.ForEach(
        window._children,
        function (item)
            item._events:onShown()
        end
    )
end

function Events:onUpdate(timePassed, systemData, windowData)
    local window = self._window
    if self._model.OnUpdate ~= nil then
        self._model.OnUpdate(window, timePassed, systemData, windowData)
    end

    Utils.Array.ForEach(
        window._children,
        function (item)
            item._events:onUpdate(timePassed, systemData, windowData)
        end
    )
end

function Events:onUpdateMobileName()
    local window = self._window
    if self._model.OnUpdateMobileName ~= nil then
        self._model.OnUpdateMobileName(window, Data.MobileName(window:getId()))
    end

    Utils.Array.ForEach(
        window._children,
        function (item, _)
            item._events:onUpdateMobileName()
        end
    )
end

function Events:onLButtonDblClk(flags, x, y)
    local window = self._window
    if self._model.OnLButtonDblClk ~= nil then
        self._model.OnLButtonDblClk(window, flags, x, y)
    end

    Utils.Array.ForEach(
        window._children,
        function (item,  _)
            item._events:onLButtonDblClk(flags, x, y)
        end
    )
end

function Events:onMouseOver()
    local window = self._window
    if self._model.OnMouseOver ~= nil then
        self._model.OnMouseOver(window)
    end
end

function Events:onMouseOverEnd()
    local window = self._window
    if self._model.OnMouseOverEnd ~= nil then
        self._model.OnMouseOverEnd(window)
    end
end

function Events:onMouseDrag()
    local window = self._window
    if self._model.OnMouseDrag ~= nil then
        self._model.OnMouseDrag(window)
    end
end

function Events:onUpdatePlayerStatus()
    local window = self._window
    if self._model.OnUpdatePlayerStatus ~= nil then
        self._model.OnUpdatePlayerStatus(window, Data.PlayerStatus())
    end

    Utils.Array.ForEach(
        window._children,
        function (item,  _)
            item._events:onUpdatePlayerStatus()
        end
    )
end

function Events:onUpdateMobileStatus()
    local window = self._window

    if self._model.OnUpdateMobileStatus ~= nil then
        self._model.OnUpdateMobileStatus(window, Data.MobileStatus(window:getId()))
    end

    Utils.Array.ForEach(
        window._children,
        function (item,  _)
            item._events:onUpdateMobileStatus()
        end
    )
end

function Events:onUpdateHealthBarColor()
    local window = self._window

    if self._model.OnUpdateHealthBarColor ~= nil then
        self._model.OnUpdateHealthBarColor(window, Data.HealthBarColor(window:getId()))
    end

    Utils.Array.ForEach(
        window._children,
        function (item,  _)
            item._events:onUpdateHealthBarColor()
        end
    )
end

function Events:onEndHealthBarDrag()
    local window = self._window

    if self._model.OnEndHealthBarDrag ~= nil then
        self._model.OnEndHealthBarDrag(window)
    end

    Utils.Array.ForEach(
        window._children,
        function (item,  _)
            item._events:onEndHealthBarDrag()
        end
    )
end



-- ========================================================================== --
-- Window
-- ========================================================================== --

---@class WindowEventsModel
---@field OnInitialize fun(self: Window)?
---@field OnLButtonUp fun(self: Window, flags: integer, x: integer, y: integer)?
---@field OnRButtonUp fun(self: Window, flags: integer, x: integer, y: integer)?
---@field OnShutdown fun(self: Window)?
---@field OnHidden fun(self: Window)?
---@field OnShown fun(self: Window)?
---@field OnLButtonDown fun(self: Window, flags: integer, x: integer, y: integer)?
---@field OnRButtonDown fun(self: Window, flags: integer, x: integer, y: integer)?
---@field OnUpdate fun(self: Window, timePassed: integer)?
---@field OnUpdateMobileName fun(self: Window, windowData: MobileNameWrapper)?
---@field OnLButtonDblClk fun(self: Window, flags: integer, x: integer, y: integer)?
---@field OnMouseOver fun(self: Window)?
---@field OnMouseOverEnd fun(self: Window)?
---@field OnMouseDrag fun(self: Window)?
---@field OnUpdatePlayerStatus fun(self: Window, playerStatus: PlayerStatusWrapper)?
---@field OnUpdateMobileStatus fun(self: Window, mobileStatus: MobileStatusWrapper)?
---@field OnUpdateHealthBarColor fun(self: Window, healthBarColor: HealthBarColorWrapper)?
---@field OnEndHealthBarDrag fun(self: Window)?

---@class WindowModel
---@field name string?
---@field template string?
---@field events WindowEventsModel?
---@field persistPosition boolean? If true, the window will save its position when closed and restore it when opened again

---@class Window
---@field _children Window[] A list of child windows.
---@field _name string The unique name of the window.
---@field _template string The template used to create the window.
---@field _events Events A table of event callbacks.
---@field _frame string The name of the window's frame component.
---@field _background string The name of the window's background component.
---@field _persistPosition boolean If true, the window will save its position when closed and restore it when opened again.
local Window = {}
Window.__index = Window

---@param model WindowModel?
function Window:new(model)
    model = model or {}
    local instance = setmetatable({}, self)

    instance._children = {}
    instance._name = model.name or Utils.String.Random()
    instance._template = model.template or "UusCorpWindow"
    instance._frame = instance._name .. "Frame"
    instance._background = instance._name .. "Background"
    instance._events = Events:new(instance, model.events or {})
    instance._persistPosition = model.persistPosition or false

    return instance
end

---@return Window
function Window:getFrame()
    if self._frameWindow == nil then
        self._frameWindow = Window:new { name = self._frame }
    end
    return self._frameWindow
end

---@return Window
function Window:getBackground()
    if self._backgroundWindow == nil then
        self._backgroundWindow = Window:new { name = self._background }
    end
    return self._backgroundWindow
end

function Window:toggleFrame(doShow)
    if Api.Window.DoesExist(self._frame) then
        Api.Window.SetShowing(self._frame, doShow)
    end
end

function Window:toggleBackground(doShow)
    if Api.Window.DoesExist(self._background) then
        Api.Window.SetShowing(self._background, doShow)
    end
end

function Window:attachToObject()
    Api.Window.AttachToWorldObject(self:getId(), self:getName())
end

function Window:setChildren(children)
    self._children = children
end

function Window:getName()
    return self._name
end

function Window:getId()
    return Api.Window.GetId(self._name)
end

function Window:setId(id)
    Api.Window.SetId(self._name, id)
end

---@return Window
function Window:getParent()
    return Windows[Api.Window.GetParent(self._name)] or
        Window:new { name = Api.Window.GetParent(self._name) }
end

function Window:setParent(parent)
    Api.Window.SetParent(self._name, parent)
end

function Window:matchParentWidth(percent)
    local parent = self:getParent()
    local x, _ = parent:getDimensions()
    local _, y = self:getDimensions()
    self:setDimensions(x * percent, y)
end

function Window:isParentRoot()
    return Api.Window.GetParent(self._name) == Views.Defaults.RootWindow:getName()
end

function Window:registerCoreEventHandler(event, callback)
    Api.Window.RegisterCoreEventHandler(self._name, event, callback)
end

function Window:unregisterCoreEventHandler(event)
    Api.Window.UnregisterCoreEventHandler(self._name, event)
end

function Window:registerEventHandler(event, callback)
    Api.Window.RegisterEventHandler(self._name, event, callback)
end

function Window:unregisterEventHandler(event)
    Api.Window.UnregisterEventHandler(self._name, event)
end

function Window:isMoving()
    return Api.Window.IsMoving(self._name)
end

function Window:setMoving(isMoving)
    Api.Window.SetMoving(self._name, isMoving)
end

function Window:getDimensions()
    return Api.Window.GetDimensions(self._name)
end

function Window:setDimensions(x, y)
    Api.Window.SetDimensions(self._name, x, y)
end

function Window:getAlpha()
    return Api.Window.GetAlpha(self._name)
end

function Window:setAlpha(alpha)
    Api.Window.SetAlpha(self._name, alpha)
end

function Window:setLayer(layer)
    Api.Window.SetLayer(self._name, layer)
end

function Window:getScale()
    return Api.Window.GetScale(self._name)
end

function Window:setScale(scale)
    Api.Window.SetScale(self._name, scale)
end

function Window:getOffsetFromParent()
    return Api.Window.GetOffsetFromParent(self._name)
end

function Window:setOffsetFromParent(x, y)
    Api.Window.SetOffsetFromParent(self._name, x, y)
end

function Window:getColor()
    return Api.Window.GetColor(self._name)
end

function Window:setColor(color)
    Api.Window.SetColor(self._name, color)
end

function Window:getPosition()
    return Api.Window.GetPosition(self._name)
end

function Window:restorePosition()
    if self._persistPosition and self:isParentRoot() then
        Api.Window.RestorePosition(self._name)
    end
end

function Window:savePosition()
    if self._persistPosition and self:isParentRoot() then
        Api.Window.SavePosition(self._name)
    end
end

function Window:isShowing()
    return Api.Window.IsShowing(self._name)
end

function Window:setShowing(isShowing)
    Api.Window.SetShowing(self._name, isShowing)
end

function Window:isPopable()
    return Api.Window.IsPopable(self._name)
end

function Window:setPopable(isPopable)
    Api.Window.SetPopable(self._name, isPopable)
end

function Window:isMovable()
    return Api.Window.IsMovable(self._name)
end

function Window:setMovable(isMovable)
    Api.Window.SetMovable(self._name, isMovable)
end

function Window:isSticky()
    return Api.Window.IsSticky(self._name)
end

function Window:clearAnchors()
    Api.Window.ClearAnchors(self._name)
end

function Window:forceProcessAnchors()
    Api.Window.ForceProcessAnchors(self._name)
end

function Window:addAnchor(anchorPoint, relativeTo, relativePoint, x, y)
    Api.Window.AddAnchor(self._name, anchorPoint, relativeTo, relativePoint, x or 0, y or 0)
end

function Window:anchorToParentTop(x, y)
    self:addAnchor(
        Constants.AnchorPoints.Top,
        self:getParent():getName(),
        Constants.AnchorPoints.Top,
        x or 0,
        y or 0
    )
end

function Window:centerInWindow(toCenter, x, y)
    self:addAnchor(
        Constants.AnchorPoints.Center,
        toCenter:getName(),
        Constants.AnchorPoints.Center,
        x or 0,
        y or 0
    )
end

function Window:anchorToParentCenter(x, y)
    self:centerInWindow(self:getParent(), x, y)
end

function Window:isFocused()
    return Api.Window.HasFocus(self._name)
end

function Window:setFocus(doFocus)
    Api.Window.AssignFocus(self._name, doFocus)
end

function Window:isResizing()
    return Api.Window.IsResizing(self._name)
end

function Window:setResizing(isResizing)
    Api.Window.SetResizing(self._name, isResizing)
end

function Window:setRelativeScale(scale)
    Api.Window.SetRelativeScale(self._name, scale)
end

function Window:doesExist()
    return Api.Window.DoesExist(self._name)
end

function Window:destroy()
    return Api.Window.Destroy(self._name)
end

function Window:create(doShow)
    doShow = doShow == nil or doShow
    if self._template == nil then
        return Api.Window.Create(self._name, doShow)
    else
        return Api.Window.CreateFromTemplate(self._name, self._template, "Root", doShow)
    end
end

function Window:registerData(type, id)
    Api.Window.RegisterData(type, id)
end

function Window:unregisterData(type, id)
    Api.Window.UnregisterData(type, id)
end

-- ========================================================================== --
-- Default Window
-- ========================================================================== --


---@class DefaultWindow: Window
local DefaultWindow = {}
DefaultWindow.__index = DefaultWindow
setmetatable(DefaultWindow, { __index = Window })

---Returns a wrapped window, for use with windows
---provided by the default interface
---@generic T
---@param name string
---@param getDefault fun(): T The function to get the default data for the window.
---@return DefaultWindow
function DefaultWindow:new(name, getDefault)
    -- Call the base Window constructor and set the metatable to DefaultWindow
    local instance = Window.new(self, { name = name })
    setmetatable(instance, self)
    instance._getDefault = getDefault
    return instance --[[@as DefaultWindow]]
end

---@return table
function DefaultWindow:getDefault()
    return self._getDefault()
end
-- ========================================================================== --
-- Button
-- ========================================================================== --

---@class ButtonEventsModel : WindowEventsModel
---@field OnInitialize fun(self: Button)?
---@field OnLButtonUp fun(self: Button, flags: integer, x: integer, y: integer)?
---@field OnRButtonUp fun(self: Button, flags: integer, x: integer, y: integer)?
---@field OnShutdown fun(self: Button)?
---@field OnHidden fun(self: Button)?
---@field OnShown fun(self: Button)?
---@field OnLButtonDown fun(self: Button, flags: integer, x: integer, y: integer)?
---@field OnRButtonDown fun(self: Button, flags: integer, x: integer, y: integer)?
---@field OnUpdate fun(self: Button, timePassed: integer)?
---@field OnUpdateMobileName fun(self: Button, windowData: MobileNameWrapper)?
---@field OnLButtonDblClk fun(self: Button, flags: integer, x: integer, y: integer)?
---@field OnMouseOver fun(self: Button)?
---@field OnMouseOverEnd fun(self: Button)?
---@field OnMouseDrag fun(self: Button)?
---@field OnUpdatePlayerStatus fun(self: Button, playerStatus: PlayerStatusWrapper)?
---@field OnUpdateMobileStatus fun(self: Button, mobileStatus: MobileStatusWrapper)?
---@field OnUpdateHealthBarColor fun(self: Button, healthBarColor: HealthBarColorWrapper)?
---@field OnEndHealthBarDrag fun(self: Button)?

---@class ButtonModel : WindowModel
---@field name string?
---@field template string?
---@field events ButtonEventsModel?

---@class Button: Window
local Button = {}
Button.__index = Button
setmetatable(Button, { __index = Window })

---@param model ButtonModel?
---@return Button
function Button:new(model)
    model = model or {}
    model.template = model.template or "UusCorpButton"
    local instance = Window.new(self, model)
    setmetatable(instance, self)
    return instance --[[@as Button]]
end

function Button:getTextDimensions()
    Api.Button.GetTextDimensions(self:getName())
end

function Button:setText(text)
    Api.Button.SetText(self:getName(), Utils.String.ToWString(text))
end

function Button:getText()
    return Api.Button.GetText(self:getName())
end

function Button:setTexture(state, texture, x, y)
    Api.Button.SetTexture(self:getName(), state, texture, x, y)
end

function Button:setTextColor(state, color)
    Api.Button.SetTextColor(self:getName(), state, color.r, color.g, color.b)
end

-- ========================================================================== --
-- Label
-- ========================================================================== --

---@class LabelEventsModel : WindowEventsModel
---@field OnInitialize fun(self: Label)?
---@field OnLButtonUp fun(self: Label, flags: integer, x: integer, y: integer)?
---@field OnRButtonUp fun(self: Label, flags: integer, x: integer, y: integer)?
---@field OnShutdown fun(self: Label)?
---@field OnHidden fun(self: Label)?
---@field OnShown fun(self: Label)?
---@field OnLButtonDown fun(self: Label, flags: integer, x: integer, y: integer)?
---@field OnRButtonDown fun(self: Label, flags: integer, x: integer, y: integer)?
---@field OnUpdate fun(self: Label, timePassed: integer)?
---@field OnUpdateMobileName fun(self: Label, windowData: MobileNameWrapper)?
---@field OnLButtonDblClk fun(self: Label, flags: integer, x: integer, y: integer)?
---@field OnMouseOver fun(self: Label)?
---@field OnMouseOverEnd fun(self: Label)?
---@field OnMouseDrag fun(self: Label)?
---@field OnUpdatePlayerStatus fun(self: Label, playerStatus: PlayerStatusWrapper)?
---@field OnUpdateMobileStatus fun(self: Label, mobileStatus: MobileStatusWrapper)?
---@field OnUpdateHealthBarColor fun(self: Label, healthBarColor: HealthBarColorWrapper)?
---@field OnEndHealthBarDrag fun(self: Label)?

---@class LabelModel : WindowModel
---@field name string?
---@field template string?
---@field events LabelEventsModel?

---@class Label: Window
local Label = {}
Label.__index = Label
setmetatable(Label, { __index = Window })

---@param model LabelModel?
---@return Label
function Label:new(model)
    model = model or {}
    model.template = model.template or "UusCorpLabel"
    local instance = Window.new(self, model)
    setmetatable(instance, self)
    return instance --[[@as Label]]
end

function Label:setText(text)
    Api.Label.SetText(self:getName(), Utils.String.ToWString(text))
end

function Label:setTextColor(color)
    Api.Label.SetTextColor(self:getName(), color)
end

function Label:setTextAlignment(alignment)
    Api.Label.SetTextAlignment(self:getName(), alignment)
end

function Label:centerText()
    self:setTextAlignment(Constants.TextAlignment.Center)
end

-- ========================================================================== --
-- StatusBar
-- ========================================================================== --

---@class StatusBarEventsModel : WindowEventsModel
---@field OnInitialize fun(self: StatusBar)?
---@field OnLButtonUp fun(self: StatusBar, flags: integer, x: integer, y: integer)?
---@field OnRButtonUp fun(self: StatusBar, flags: integer, x: integer, y: integer)?
---@field OnShutdown fun(self: StatusBar)?
---@field OnHidden fun(self: StatusBar)?
---@field OnShown fun(self: StatusBar)?
---@field OnLButtonDown fun(self: StatusBar, flags: integer, x: integer, y: integer)?
---@field OnRButtonDown fun(self: StatusBar, flags: integer, x: integer, y: integer)?
---@field OnUpdate fun(self: StatusBar, timePassed: integer)?
---@field OnUpdateMobileName fun(self: StatusBar, windowData: MobileNameWrapper)?
---@field OnLButtonDblClk fun(self: StatusBar, flags: integer, x: integer, y: integer)?
---@field OnMouseOver fun(self: StatusBar)?
---@field OnMouseOverEnd fun(self: StatusBar)?
---@field OnMouseDrag fun(self: StatusBar)?
---@field OnUpdatePlayerStatus fun(self: StatusBar, playerStatus: PlayerStatusWrapper)?
---@field OnUpdateMobileStatus fun(self: StatusBar, mobileStatus: MobileStatusWrapper)?
---@field OnUpdateHealthBarColor fun(self: StatusBar, healthBarColor: HealthBarColorWrapper)?
---@field OnEndHealthBarDrag fun(self: StatusBar)?

---@class StatusBarModel : WindowModel
---@field name string?
---@field template string?
---@field events StatusBarEventsModel?

---@class StatusBar: Window
local StatusBar = {}
StatusBar.__index = StatusBar
setmetatable(StatusBar, { __index = Window })

---@param model StatusBarModel?
---@return StatusBar
function StatusBar:new(model)
    model = model or {}
    model.template = model.template or "UusCorpStatusBar"
    local instance = Window.new(self, model)
    setmetatable(instance, self)
    return instance --[[@as StatusBar]]
end

function StatusBar:setMaxValue(maxValue)
    Api.StatusBar.SetMaxValue(self:getName(), maxValue)
end

function StatusBar:setCurrentValue(currentValue)
    Api.StatusBar.SetCurrentValue(self:getName(), currentValue)
end

function StatusBar:setBackgroundTint(tint)
    Api.StatusBar.SetBackgroundTint(self:getName(), tint)
end

function StatusBar:setForegroundTint(tint)
    Api.StatusBar.SetForegroundTint(self:getName(), tint)
end

-- ========================================================================== --
-- Interface
-- ========================================================================== --

-- ========================================================================== --
-- Interface - Defaults
-- ========================================================================== --


Views.Defaults = {}

---@class ResizeWindow
---@field HANDLE_SIZE integer Size of the resize handles
---@field IsMoving boolean Whether the window is currently being moved
---@field Locked boolean Whether the resize window is locked
---@field Initialize fun() Initializes the resize window and sets up UI and event handlers
---@field LockTooltip fun() Shows a tooltip for the lock/unlock button
---@field Lock fun() Toggles the locked state of the resize window
---@field Shutdown fun() Saves the window position and performs cleanup
---@field Update fun(timePassed: number) Updates the resize window state and viewport
---@field UpdateViewport fun() Updates the viewport based on window dimensions
---@field StartMoving fun() Starts moving the resize window if not locked
---@field StopMoving fun() Stops moving and updates the viewport
---@field OnResizeBegin fun() Begins the resize operation
---@field OnResizeEnd fun() Ends the resize operation and updates handles and viewport
---@field UpdateHandles fun(windowWidth: number, windowHeight: number) Updates the dimensions of the resize handles
---@field SendViewportData fun(windowWidth: number, windowHeight: number) Sends updated viewport data
---@field UpdateWindow fun() Updates the window position, size, and handles
---@field OnViewportChanged fun() Handles viewport change events and updates window

---@class ResizeWindowWrapper : DefaultWindow
---@field getDefault fun(self: ResizeWindowWrapper): ResizeWindow
Views.Defaults.ResizeWindow = DefaultWindow:new("ResizeWindow", function ()
    return ResizeWindow
end)

---@class RootWindow

---@class RootWindowWrapper : DefaultWindow
---@field getDefault fun(self: RootWindowWrapper): RootWindow
Views.Defaults.RootWindow = DefaultWindow:new("Root", function ()
    return {}
end)

---@class MainMenuWindow
---@field TID table Table of TIDs for menu items
---@field Initialize fun() Initializes the main menu window
---@field Shutdown fun() Shuts down the main menu window
---@field OnLogOut fun() Handles the log out action
---@field OnOpenUserSettings fun() Opens the user settings window
---@field OnOpenMacros fun() Opens the macros window
---@field OnOpenActions fun() Opens the actions window
---@field OnOpenBugReportItem fun() Opens the bug report window
---@field OnOpenHelp fun() Opens the help menu
---@field OnOpenUOStore fun() Opens the Ultima Store
---@field ToggleSettingsWindow fun() Toggles the settings window
---@field ToggleBugReportWindow fun() Toggles the bug report window
---@field OnToggleAgentsSettings fun() Toggles the agents settings window

---@class MainMenuWindowWrapper : DefaultWindow
---@field getDefault fun(self: MainMenuWindowWrapper): MainMenuWindow
Views.Defaults.MainMenuWindow = DefaultWindow:new("MainMenuWindow", function ()
    return MainMenuWindow
end)

---@class BugReportWindow
---@field NUM_MACROS integer Number of macros
---@field NUM_MACRO_ICONS integer Number of macro icons
---@field MACRO_ICONS_ID_BASE integer Macro icons ID base
---@field activeId integer Active ID
---@field iconNum integer Icon number
---@field bugTypes table Table of bug types
---@field Size integer Size of bug types
---@field selectedType integer Selected bug type
---@field TID table Table of TID values
---@field Initialize fun() Initializes the bug report window
---@field Update fun(timePassed: number) Updates the bug report window
---@field Shutdown fun() Shuts down the bug report window
---@field Hide fun() Hides the bug report window
---@field OnOpen fun() Handles window open
---@field OnClose fun() Handles window close
---@field OnSelectBugType fun() Handles select bug type
---@field SelectBugType fun(type: integer) Selects bug type
---@field OnSubmit fun() Handles submit
---@field OnClear fun() Handles clear

---@class BugReportWindowWrapper : DefaultWindow
---@field getDefault fun(self: BugReportWindowWrapper): BugReportWindow
Views.Defaults.BugReportWindow = DefaultWindow:new("BugReportWindow", function ()
    return BugReportWindow
end)

---@class StatusWindow
---@field CurPlayerId integer Current player ID
---@field Skills table Table of skill definitions (sop, TCName)
---@field Notoriety table Table of notoriety types
---@field TextColors table Table mapping notoriety to text color (r, g, b)
---@field Locked boolean Whether the status window is locked
---@field HPLocked boolean Whether the HP window is locked
---@field MANALocked boolean Whether the Mana window is locked
---@field STAMLocked boolean Whether the Stamina window is locked
---@field DisableDelta number Time delta for disabling input
---@field TempDisabled boolean Whether input is temporarily disabled
---@field MPHeight integer Height of the mana bar
---@field MPWidth integer Width of the mana bar
---@field LastMPHeight integer Last height of the mana bar
---@field HPHeight integer Height of the health bar
---@field HPWidth integer Width of the health bar
---@field LastHPHeight integer Last height of the health bar
---@field TCToolsHandle boolean Whether the TC tools handle is active
---@field Initialize fun(reinit?: boolean) Initializes the status window and sets up UI/data
---@field Shutdown fun() Shuts down the status window and saves positions
---@field Latency_OnMouseOver fun() Shows tooltip for latency
---@field LockTooltip fun() Shows tooltip for lock button
---@field Lock fun() Toggles the locked state of the status window
---@field LockTooltipHP fun() Shows tooltip for HP lock button
---@field LockHP fun() Toggles the locked state of the HP window
---@field LockTooltipMANA fun() Shows tooltip for Mana lock button
---@field LockMANA fun() Toggles the locked state of the Mana window
---@field LockTooltipSTAM fun() Shows tooltip for Stamina lock button
---@field LockSTAM fun() Toggles the locked state of the Stamina window
---@field MenuTooltip fun() Shows tooltip for the menu button
---@field Menu fun() Opens the context menu for the player
---@field UpdateLatency fun() Updates the latency bar display
---@field ClickOutside fun() Disables input for the advanced status window
---@field EnableInput fun(timePassed: number) Enables input after a delay
---@field UpdateStatus fun() Updates the status window with current player data
---@field OnLButtonUp fun() Handles left button up (drag/drop or target)
---@field OnLButtonDown fun() Handles left button down (start moving window)
---@field OnHPLButtonUp fun() Handles left button up on HP window
---@field OnHPLButtonDown fun() Handles left button down on HP window
---@field OnMLANAButtonUp fun() Handles left button up on Mana window
---@field OnMANALButtonDown fun() Handles left button down on Mana window
---@field OnSTAMLButtonUp fun() Handles left button up on Stamina window
---@field OnSTAMLButtonDown fun() Handles left button down on Stamina window
---@field GuardsButton_OnLButtonUp fun() Sends a guards help chat command
---@field GuardsButton_OnMouseOver fun() Shows tooltip for guards button
---@field OnRButtonUp fun() Opens the context menu for the player
---@field UpdateLabelContent fun() Updates the health, mana, and stamina label content
---@field OnMouseOver fun() Handles mouse over for the status window
---@field OnMouseOverEnd fun() Handles mouse over end for the status window
---@field ToggleStrLabel fun() Toggles the display of stat labels
---@field OnMouseDlbClk fun() Uses the player item on double click
---@field TCTools fun() Opens the TC tools context menu
---@field TCToolsTooltip fun() Shows tooltip for TC tools
---@field TCToolsOver fun() Handles mouse over for TC tools
---@field TCToolsOnLButtonDown fun() Starts moving the TC tools window
---@field TCToolsOverend fun() Handles mouse out for TC tools
---@field SetMana fun(current: integer, maximum: integer) Sets the mana bar height
---@field SetHealth fun(current: integer, maximum: integer) Sets the health bar height
---@field ChangeStyle fun(style: integer) Changes the status window style
---@field ToggleButtons fun() Toggles the display of status window buttons
---@field TCContextMenuCallback fun(returnCode: any, param: any) Handles TC context menu actions
---@field EditSkill fun(id: integer, value: any, max: any, min: any) Edits a skill value
---@field EditStr fun(id: any, value: any, max: any, min: any) Edits a stat value

---@class StatusWindowWrapper : DefaultWindow
---@field getDefault fun(self: StatusWindowWrapper): StatusWindow
Views.Defaults.StatusWindow = DefaultWindow:new("StatusWindow", function ()
    return StatusWindow
end)

---@class TargetWindow
---@field TargetId integer Current target ID
---@field HasTarget boolean Whether there is a current target
---@field TargetType integer Type of the current target
---@field MobileType integer Constant for mobile target type
---@field ObjectType integer Constant for object target type
---@field CorpseType integer Constant for corpse target type
---@field Buttons table Array of button window names
---@field Delta number Time delta for periodic updates
---@field DeltaC number Time delta for button refresh
---@field CurrentCreature table|nil Data for the current creature
---@field RegisterTime table Table tracking registration times for targets
---@field PreviousTargets table Array of previous target IDs
---@field Locked boolean Whether the target window is locked
---@field KnownPlayers table Table of known player IDs
---@field KnownTamable table Table of known tamable creature IDs
---@field Initialize fun() Initializes the target window and sets up UI/data
---@field Shutdown fun() Shuts down the target window and unregisters data
---@field ClearPreviousTarget fun() Clears the previous target and resets state
---@field UnregisterPreviousTargetData fun() Unregisters data for the previous target
---@field UpdateMobile fun() Updates the target window for a mobile target
---@field ForceUpdate fun(timePassed: number) Periodically updates and refreshes the target window
---@field RefreshButtons fun() Refreshes the state of action buttons
---@field GetActionsList fun(mobileId: integer): table Gets the list of actions for a mobile
---@field UpdateButtons fun() Updates the action buttons for the current target
---@field UpdateObject fun() Updates the target window for an object target
---@field UpdateCorpse fun() Updates the target window for a corpse target
---@field UpdateTarget fun() Updates the target window based on the current target type
---@field MobileStatusUpdate fun() Updates the status for a mobile target
---@field UpdateStatus fun(targetId: integer) Updates the health/status for a target
---@field HandleUpdateNameEvent fun() Handles name update events
---@field UpdateName fun(targetId: integer) Updates the name label for a target
---@field HandleTintHealthBarEvent fun() Handles health bar tint events
---@field TintHealthBar fun(mobileId: integer) Tints the health bar for a target
---@field UpdateObjectInfo fun() Updates object info for the current target
---@field OnItemDblClicked fun() Handles double-click on the target window
---@field OnRClick fun() Handles right-click on the target window
---@field OnLClick fun() Handles left-click on the target window
---@field OnMouseOver fun() Handles mouse over for the target window
---@field OnMouseOverEnd fun() Handles mouse over end for the target window
---@field ButtonsUse fun() Handles use of an action button
---@field OnMoveStart fun() Handles start of window move
---@field Lock fun() Toggles the locked state of the target window
---@field LockTooltip fun() Shows tooltip for the lock button

---@class TargetWindowWrapper : DefaultWindow
---@field getDefault fun(self: TargetWindowWrapper): TargetWindow
Views.Defaults.TargetWindow = DefaultWindow:new("TargetWindow", function ()
    return TargetWindow
end)

---@class ObjectHandleWindow
---@field Active boolean Whether object handles are currently active
---@field hasWindow table Table tracking which object IDs have handle windows
---@field ObjectsData table Data for all objects currently handled
---@field ReverseObjectLookUp table Reverse lookup from object ID to index
---@field grayColor table Default gray color for object handles
---@field whiteColor table Default white color for object handles
---@field WindowShiftOffset integer Offset for window shifting
---@field mouseOverId integer ID of the object currently under the mouse
---@field Notoriety table Table of notoriety types (NONE, INNOCENT, FRIEND, CANATTACK, CRIMINAL, ENEMY, MURDERER, INVULNERABLE)
---@field TextColors table Table mapping notoriety to text color (r, g, b)
---@field REFRESH_DELAY number Delay between refreshes
---@field RefreshTimer number Timer for refresh logic
---@field CurrentFilter string Current filter string for object names
---@field ObjectHandleScale number Scale for object handle windows
---@field ObjectHandleAlpha number Alpha for object handle windows
---@field lastItem integer Last item processed for scavenging
---@field cooldown number Cooldown timer for scavenging
---@field ForceIgnore integer|nil Object ID to force ignore
---@field Initialize fun() Initializes the object handle system
---@field retrieveObjectsData fun(objectsData: table): boolean Retrieves object data from WindowData
---@field CreateObjectHandles fun() Creates object handle windows for all objects on screen
---@field DestroyObjectHandles fun() Destroys all object handle windows
---@field OnClickClose fun() Handles close button click on an object handle window
---@field OnRClick fun() Handles right-click on an object handle window (context menu)
---@field OnDblClick fun() Handles double-click on an object handle window (use object)
---@field OnItemClicked fun() Handles item click on an object handle window (target or drag)
---@field OnLButtonUp fun() Handles left button up on an object handle window
---@field OnMouseOver fun() Handles mouse over on an object handle window (shows tooltip)
---@field CreateSingle fun(objectId: integer, name: string, noto: integer, isMobile: boolean) Creates a single object handle window
---@field OnUpdate fun(timePassed: number) Periodic update for object handle logic
---@field OnMouseOverEnd fun() Handles mouse leaving an object handle window

---@class ObjectHandleWindowWrapper : DefaultWindow
---@field getDefault fun(self: ObjectHandleWindowWrapper): ObjectHandleWindow
Views.Defaults.ObjectHandleWindow = DefaultWindow:new("ObjectHandleWindow", function ()
    return ObjectHandleWindow
end)

---@type ItemProperties
Views.Defaults.ItemProperties = ItemProperties

Views.Defaults.ItemPropertiesData = ItemPropertiesData

Views.Defaults.InterfaceCore = InterfaceCore

---@type Actions
Views.Defaults.Actions = Actions

-- ========================================================================== --
-- Interface - Window
-- ========================================================================== --

---@param model WindowModel?
---@return Window
function Views.Window(model)
   local window = Window:new(model)
    Windows[window:getName()] = window
    return window
end

-- ========================================================================== --
-- Interface - Button
-- ========================================================================== --

---@param model ButtonModel?
---@return Button
function Views.Button(model)
    local button = Button:new(model)
    Windows[button:getName()] = button
    return button
end

-- ========================================================================== --
-- Interface - Label
-- ========================================================================== --


---@param model LabelModel?
---@return Label
function Views.Label(model)
    local label = Label:new(model)
    Windows[label:getName()] = label
    return label
end

-- ========================================================================== --
-- Interface - Status Bar
-- ========================================================================== --


---@param model StatusBarModel?
---@return StatusBar
function Views.StatusBar(model)
    local statusBar = StatusBar:new(model)
    Windows[statusBar:getName()] = statusBar
    return statusBar
end

-- ========================================================================== --
-- Mod
-- ========================================================================== --

---@class ModInitializer
---@field OnInitialize fun(): Mod Initializes the mod 

---@class Mod
---@field Name string Name of the mod
---@field Path string Path to the mod resources
---@field Files string[]? list of files to load
---@field _onInitialize fun(self: Context) Initializes the mod
local Mod = {}
Mod.__index = Mod

---@class ModModel
---@field Name string Name of the mod
---@field Path string Path to the mod resources
---@field Files string[]? list of files to load
---@field OnInitialize fun(self: Context) Initializes the mod

function Mod:new(model)
    local mod = setmetatable({}, self)
    mod.Name = model.Name
    mod.Path = model.Path
    mod.Files = model.Files or {}
    mod._onInitialize = model.OnInitialize or function() end
    return mod
end

function Mod:initialize()
    Api.Mod.Initialize(self.Name)
end

function Mod:loadResources()
    Utils.Array.ForEach(
        self.Files,
        function(file)
            Api.Mod.LoadResources(
                "Data/Interface/Default/uus-corp-ui" .. self.Path,
                SystemData.Directories.Interface .. "/" .. SystemData.Settings.Interface.customUiName .. self.Path,
                file
            )
        end
    )
end

function Mod:onInitialize()
    self:loadResources()
    self._onInitialize(Context)
end

local ModManager = {}

---@type table<string, Mod>
ModManager.Mods = {}

---@type table<string, function>
ModManager.Initializers = {}

-- ========================================================================== --
-- Uus Corp
-- ========================================================================== --

UusCorp = {}

UusCorp.EventHandler = EventHandler

UusCorp.ModInitializer = ModManager.Initializers

---@param model ModModel
---@return Mod
function UusCorp.Mod(model)
    local mod = Mod:new(model)
    ModManager.Mods[model.Name] = mod
    ModManager.Initializers[model.Name] = function ()
        mod:onInitialize()
    end
    return Mod:new(model)
end
