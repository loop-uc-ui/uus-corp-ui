---@class Event:number
---@class Type:number

---@class Object
---@field objectId number
---@field objectType number

---@class SkillAllSkillsOther

---@class WindowData.HealthBarColor
---@field VisualStateId number

---@class WindowData.ObjectHandle
---@field ObjectId integer[]
---@field Names string[]
---@field Notoriety integer[]

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

---@class GChat
---@field GC_SHOW_CHAT boolean
---@field GC_SHOW_UNAVAILABLE boolean

---@class WindowData.CurrentTarget
---@field TargetId number
---@field HasPaperdoll boolean
---@field TargetType number
---@field HasTarget boolean
---@field isMobile fun(): boolean
---@field isObject fun(): boolean
---@field isCorpse fun(): boolean

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

---@class Events
---@field OnInitialize fun(self: Window)?
---@field OnLButtonUp fun(self: Window, flags: integer, x: integer, y: integer)?
---@field OnRButtonUp fun(self: Window, flags: integer, x: integer, y: integer)?
---@field OnShutdown fun(self: Window)?
---@field OnHidden fun(self: Window)?
---@field OnShown fun(self: Window)?
---@field OnLButtonDown fun(self: Window, flags: integer, x: integer, y: integer)?
---@field OnRButtonDown fun(self: Window, flags: integer, x: integer, y: integer)?
---@field OnUpdate fun(self: Window, timePassed: integer)?
---@field OnUpdateMobileName fun(self: Window, windowData: MobileName)?
---@field OnLButtonDblClk fun(self: Window, flags: integer, x: integer, y: integer)?
---@field OnMouseOver fun(self: Window)?
---@field OnMouseOverEnd fun(self: Window)?
---@field OnMouseDrag fun(self: Window)?
---@field OnUpdatePlayerStatus fun(self: Window, playerStatus: WindowData.PlayerStatus)?
---@field OnUpdateMobileStatus fun(self: Window, mobileStatus: WindowData.MobileStatus)?
---@field OnUpdateHealthBarColor fun(self: Window, healthBarColor: WindowData.HealthBarColor)?

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

---@class WindowData.Cursor
---@field target boolean

---@class WindowModel
---@field name string?
---@field template string?
---@field events Events?


---@param model WindowModel?
---@return Window
local Window = function (model)
    model = model or {}

    ---@type Window[]
    local _children = {}
    local _name = model.name or UusCorp.Utils.String.Random()
    local _template = model.template or "UusCorpWindow"
    local _events = model.events or {}
    local _frame = _name .. "Frame"
    local _background = _name .. "Background"
    local _data = {}

    ---@class Window
    local window = {}

    window.toggleFrame = function (doShow)
        if UusCorp.Api.Window.DoesExist(_frame) then
            UusCorp.Api.Window.SetShowing(_frame, doShow)
        end
    end

    window.toggleBackground = function (doShow)
        if UusCorp.Api.Window.DoesExist(_background) then
            UusCorp.Api.Window.SetShowing(_background, doShow)
        end
    end

    window.attachToObject = function ()
        UusCorp.Api.Window.AttachToWorldObject(window.getId(), window.getName())
    end

    window.setChildren = function (children)
        _children = children
    end

    window.getName = function ()
        return _name
    end

    window.getId = function ()
        return UusCorp.Api.Window.GetId(_name)
    end

    window.setId = function (id)
        UusCorp.Api.Window.SetId(_name, id)
    end

    ---@return Window
    window.getParent = function ()
        return UusCorp.EventHandler.Windows[UusCorp.Api.Window.GetParent(_name)] or
            UusCorp.Interface.Window { name = UusCorp.Api.Window.GetParent(_name) }
    end

    window.setParent = function (parent)
        UusCorp.Api.Window.SetParent(_name, parent)
    end

    window.matchParentWidth = function (percent)
        local parent = window.getParent()
        local x, _ = parent.getDimensions()
        local _, y = window.getDimensions()
        window.setDimensions(x * percent, y)
    end

    window.isParentRoot = function ()
        return window.getParent().getName() == UusCorp.Constants.WindowNames.Root
    end

    window.registerCoreEventHandler = function (event, callback)
        UusCorp.Api.Window.RegisterCoreEventHandler(_name, event, callback)
    end

    window.unregisterCoreEventHandler = function (event, callback)
        UusCorp.Api.Window.RegisterCoreEventHandler(_name, event, callback)
    end

    window.registerEventHandler = function (event, callback)
        UusCorp.Api.Window.RegisterEventHandler(_name, event, callback)
    end

    window.unregisterEventHandler = function (event)
        UusCorp.Api.Window.UnregisterEventHandler(_name, event)
    end

    window.isMoving = function ()
        return UusCorp.Api.Window.IsMoving(_name)
    end

    window.setMoving = function (isMoving)
        UusCorp.Api.Window.SetMoving(_name, isMoving)
    end

    window.getDimensions = function ()
        return UusCorp.Api.Window.GetDimensions(_name)
    end

    window.setDimensions = function (x, y)
        UusCorp.Api.Window.SetDimensions(_name, x, y)
    end

    window.getAlpha = function ()
        return UusCorp.Api.Window.GetAlpha(_name)
    end

    window.setAlpha = function (alpha)
        UusCorp.Api.Window.SetAlpha(_name, alpha)
    end

    window.setLayer = function (layer)
        UusCorp.Api.Window.SetLayer(_name, layer)
    end

    window.getScale = function ()
        return UusCorp.Api.Window.GetScale(_name)
    end

    window.setScale = function (scale)
        UusCorp.Api.Window.SetScale(_name, scale)
    end

    window.getOffsetFromParent = function ()
        return UusCorp.Api.Window.GetOffsetFromParent(_name)
    end

    window.setOffsetFromParent = function (x, y)
        UusCorp.Api.Window.SetOffsetFromParent(_name, x, y)
    end

    window.getColor = function ()
        return UusCorp.Api.Window.GetColor(_name)
    end

    window.setColor = function (color)
        UusCorp.Api.Window.SetColor(_name, color)
    end

    window.getPosition = function ()
        return UusCorp.Api.Window.GetPosition(_name)
    end

    window.restorePosition = function ()
        if window.isParentRoot() then
            UusCorp.Api.Window.RestorePostion(_name)
        end
    end

    window.savePosition = function ()
        if window.isParentRoot() then
            UusCorp.Api.Window.SavePostion(_name)
        end
    end

    window.isShowing = function ()
        return UusCorp.Api.Window.IsShowing(_name)
    end

    window.setShowing = function (isShowing)
        UusCorp.Api.Window.SetShowing(_name, isShowing)
    end

    window.isPopable = function ()
        return UusCorp.Api.Window.IsPopable(_name)
    end

    window.setPopable = function (isPopable)
        UusCorp.Api.Window.SetPopable(_name, isPopable)
    end

    window.isMovable = function ()
        return UusCorp.Api.Window.IsMovable(_name)
    end

    window.setMovable = function (isMovable)
        UusCorp.Api.Window.SetMovable(_name, isMovable)
    end

    window.isSticky = function ()
        return UusCorp.Api.Window.IsSticky(_name)
    end

    window.clearAnchors = function ()
        UusCorp.Api.Window.ClearAnchors(_name)
    end

    window.forceProcessAnchors = function ()
        UusCorp.Api.Window.ForceProcessAnchors(_name)
    end

    window.addAnchor = function (anchorPoint, relativeTo, relativePoint, x, y)
        UusCorp.Api.Window.AddAnchor(_name, anchorPoint, relativeTo, relativePoint, x, y)
    end

    window.anchorToParenTop = function (x, y)
        window.addAnchor(
            UusCorp.Constants.AnchorPoints.Top,
            window.getParent().getName(),
            UusCorp.Constants.AnchorPoints.Top,
            x or 0,
            y or 0
        )
    end

    window.anchorToParentCenter = function (x, y)
        window.addAnchor(
            UusCorp.Constants.AnchorPoints.Center,
            window.getParent().getName(),
            UusCorp.Constants.AnchorPoints.Center,
            x or 0,
            y or 0
        )
    end

    window.isFocused = function ()
        return UusCorp.Api.Window.HasFocus(_name)
    end

    window.setFocus = function (doFocus)
        UusCorp.Api.Window.AssignFocus(_name, doFocus)
    end

    window.isResizing = function ()
        return UusCorp.Api.Window.IsResizing(_name)
    end

    window.setResizing = function (isResizing)
        UusCorp.Api.Window.SetResizing(_name, isResizing)
    end

    window.setRelativeScale = function (scale)
        UusCorp.Api.Window.SetRelativeScale(_name, scale)
    end

    window.doesExist = function ()
        return UusCorp.Api.Window.DoesExist(_name)
    end

    window.destroy = function ()
        return UusCorp.Api.Window.Destroy(_name)
    end

    window.create = function (doShow)
        doShow = doShow == nil or doShow
        if _template == nil then
            return UusCorp.Api.Window.Create(_name, doShow)
        else
            return UusCorp.Api.Window.CreateFromTemplate(_name, _template, "Root", doShow)
        end
    end

    window.registerData = function (type, id)
        UusCorp.Api.Window.RegisterData(type, id)
    end

    window.unregisterData = function (type, id)
        UusCorp.Api.Window.UnregisterData(type, id)
    end

    window.events = {
        onInitialize = function ()
            local id = UusCorp.Utils.String.ExtractNumber(_name)

            if id ~= 0 then
                window.setId(id)
            end

            for k, v in pairs(_events) do
                local dataEvent = UusCorp.Constants.DataEvents[k]
                local isCore = UusCorp.Constants.CoreEvents[k] ~= nil
                local skip = k == UusCorp.Constants.CoreEvents.OnInitialize or
                    k == UusCorp.Constants.CoreEvents.OnShutdown

                if isCore and not skip then
                    window.registerCoreEventHandler(k, "UusCorp.EventHandler." .. k)
                elseif dataEvent ~= nil then
                    if k == UusCorp.Constants.DataEvents.OnUpdatePlayerStatus then
                        window.registerData(dataEvent.getType(), 0)
                    else
                        window.registerData(dataEvent.getType(), window.getId())
                    end
                    window.registerEventHandler(dataEvent.getEvent(), "UusCorp.EventHandler." .. k)
                end
            end

            window.registerCoreEventHandler(
                UusCorp.Constants.CoreEvents.OnShutdown,
                "UusCorp.EventHandler." .. UusCorp.Constants.CoreEvents.OnShutdown
            )

            if window.isParentRoot() and _events.OnRButtonUp == nil then
                window.registerCoreEventHandler(
                    UusCorp.Constants.CoreEvents.OnRButtonUp,
                    "UusCorp.EventHandler." .. UusCorp.Constants.CoreEvents.OnRButtonUp
                )
            end

            if _events.OnInitialize ~= nil then
                _events.OnInitialize(window)
            end

            window.restorePosition()

            UusCorp.Utils.Array.ForEach(
                _children,
                function (item, index)
                    item.create(true)
                    item.setParent(_name)
                    item.events.onInitialize()
                    if index > 1 then
                        item.addAnchor(
                            "bottomleft",
                            _children[index - 1].getName(),
                            "topleft",
                            0,
                            8
                        )
                    end
                end
            )

            window.toggleBackground(window.isParentRoot())
            window.toggleFrame(window.isParentRoot())

            for k, v in pairs(window.events) do
                if UusCorp.Constants.DataEvents[k] then
                    v()
                end
            end
        end,

        onShutdown = function ()
            window.savePosition()

            UusCorp.Utils.Array.ForEach(_children, function (item)
                item:destroy()
            end)

            if _events.OnShutdown ~= nil then
                _events.OnShutdown(window)
            end
        end,

        onLButtonUp = function (flags, x, y)
            if _events.OnLButtonUp ~= nil then
                _events.OnLButtonUp(window, flags, x, y)
            end

            local child = UusCorp.Utils.Array.Find(
                _children,
                function (item)
                    return item.getName() == Active.window()
                end
            )

            if child ~= nil then
                child.events.onLButtonUp(flags, x, y)
            end
        end,

        onLButtonDown = function (flags, x, y)
            if _events.OnLButtonDown ~= nil then
                _events.OnLButtonDown(window, flags, x, y)
            end

            local child = UusCorp.Utils.Array.Find(
                _children,
                function (item)
                    return item.getName() == Active.window()
                end
            )

            if child ~= nil then
                child.events.onLButtonDown(flags, x, y)
            end
        end,

        onRButtonUp = function (flags, x, y)
            if window.isParentRoot() and _events.OnRButtonUp == nil then
                window.destroy()
                return
            end

            if _events.OnRButtonUp ~= nil then
                _events.OnRButtonUp(window, flags, x, y)
            end

            local child = UusCorp.Utils.Array.Find(
                _children,
                function (item)
                    return item.getName() == Active.window()
                end
            )

            if child ~= nil then
                child.events.onRButtonUp(flags, x, y)
            end
        end,

        onRButtonDown = function (flags, x, y)
            if _events.OnRButtonDown ~= nil then
                _events.OnRButtonDown(window, flags, x, y)
                return
            end

            local child = UusCorp.Utils.Array.Find(
                _children,
                function (item)
                    return item.getName() == Active.window()
                end
            )

            if child ~= nil then
                child.events.onRButtonDown(flags, x, y)
            end
        end,

        onHidden = function ()
            if _events.OnHidden ~= nil then
                _events.OnHidden(window)
            end

            UusCorp.Utils.Array.ForEach(
                _children,
                function (item)
                    item.events.onHidden()
                end
            )
        end,

        onShown = function ()
            if _events.OnShown ~= nil then
                _events.OnShown(window)
            end

            UusCorp.Utils.Array.ForEach(
                _children,
                function (item)
                    item.events.onShown()
                end
            )
        end,

        onUpdate = function (timePassed, systemData, windowData)
            if _events.OnUpdate ~= nil then
                _events.OnUpdate(window, timePassed, systemData, windowData)
            end

            UusCorp.Utils.Array.ForEach(
                _children,
                function (item)
                    item.events.onUpdate(timePassed, systemData, windowData)
                end
            )
        end,

        onUpdateMobileName = function ()
            if _events.OnUpdateMobileName ~= nil then
                _events.OnUpdateMobileName(window, UusCorp.Data.Window().MobileName[window.getId()])
            end

            UusCorp.Utils.Array.ForEach(
                _children,
                function (item, _)
                    item.events.onUpdateMobileName()
                end
            )
        end,

        onLButtonDblClk = function (flags, x, y)
            if _events.OnLButtonDblClk ~= nil then
                _events.OnLButtonDblClk(window, flags, x, y)
            end

            UusCorp.Utils.Array.ForEach(
                _children,
                function (item,  _)
                    item.events.onLButtonDblClk(flags, x, y)
                end
            )
        end,

        onMouseOver = function ()
            if _events.OnMouseOver ~= nil then
                _events.OnMouseOver(window)
            end
        end,

        onMouseOverEnd = function ()
            if _events.OnMouseOverEnd ~= nil then
                _events.OnMouseOverEnd(window)
            end
        end,

        onMouseDrag = function ()
            if _events.OnMouseDrag ~= nil then
                _events.OnMouseDrag(window)
            end
        end,

        onUpdatePlayerStatus = function ()
            if _events.OnUpdatePlayerStatus ~= nil then
                _events.OnUpdatePlayerStatus(window, UusCorp.Data.Window().PlayerStatus)
            end

            UusCorp.Utils.Array.ForEach(
                _children,
                function (item,  _)
                    item.events.onUpdatePlayerStatus()
                end
            )
        end,

        onUpdateMobileStatus = function ()
            if _events.OnUpdateMobileStatus ~= nil then
                _events.OnUpdateMobileStatus(window, UusCorp.Data.Window().MobileStatus[window.getId()])
            end

            UusCorp.Utils.Array.ForEach(
                _children,
                function (item,  _)
                    item.events.onUpdateMobileStatus()
                end
            )
        end,

        onUpdateHealthBarColor = function ()
            if _events.OnUpdateHealthBarColor ~= nil then
                _events.OnUpdateHealthBarColor(window, UusCorp.Data.Window().HealthBarColor[window.getId()])
            end

            UusCorp.Utils.Array.ForEach(
                _children,
                function (item,  _)
                    item.events.onUpdateHealthBarColor()
                end
            )
        end
    }

    return window
end

---@param model WindowModel?
---@return Button
local Button = function (model)
    model = model or {}
    model.template = model.template or "UusCorpButton"

    ---@class Button:Window
    local button = Window(model)

    button.getTextDimensions = function ()
        UusCorp.Api.Button.GetTextDimensions(button.getName())
    end

    button.setText = function (text)
        UusCorp.Api.Button.SetText(button.getName(), UusCorp.Utils.String.ToWString(text))
    end

    button.getText = function ()
        return UusCorp.Api.Button.GetText(button.getName())
    end

    button.setTexture = function (state, texture, x, y)
        UusCorp.Api.Button.SetTexture(button.getName(), state, texture, x, y)
    end

    button.setTextColor = function (state, color)
        UusCorp.Api.Button.SetTextColor(button.getName(), state, color.r, color.g, color.b)
    end

    return button
end

---@param model WindowModel?
---@return Label
local Label = function (model)
    model = model or {}
    model.template = model.template or "UusCorpLabel"

    ---@class Label:Window
    local label = Window(model)

    label.setText = function (text)
        UusCorp.Api.Label.SetText(label.getName(), UusCorp.Utils.String.ToWString(text))
    end

    label.setTextColor = function (color)
        UusCorp.Api.Label.SetTextColor(label.getName(), color)
    end

    label.setTextAlignment = function (alignment)
        UusCorp.Api.Label.SetTextAlignment(label.getName(), alignment)
    end

    return label
end

local StatusBar = function (model)
    model = model or {}
    model.template = model.template or "UusCorpStatusBar"

    ---@class StatusBar:Window
    local statusBar = Window(model)

    statusBar.setMaxValue = function (maxValue)
        UusCorp.Api.StatusBar.SetMaxValue(statusBar.getName(), maxValue)
    end

    statusBar.setCurrentValue = function (currentValue)
        UusCorp.Api.StatusBar.SetCurrentValue(statusBar.getName(), currentValue)
    end

    statusBar.setBackgroundTint = function (tint)
        UusCorp.Api.StatusBar.SetBackgroundTint(statusBar.getName(), tint)
    end

    statusBar.setForegroundTint = function (tint)
        UusCorp.Api.StatusBar.SetForegroundTint(statusBar.getName(), tint)
    end

    return statusBar
end

---@class ModModel
---@field OnInitialize fun(self: Mod)
---@field Name string
---@field Path string

---@param model ModModel
---@return Mod
local Mod = function (model)
    ---@class Mod
    local mod = {}

    mod.OnInitialize = function ()
        model.OnInitialize(mod)
    end

    mod.Initialize = function ()
        UusCorp.Api.Mod.Initialize(model.Name)
    end

    mod.LoadResource = function (file)
        UusCorp.Api.Mod.LoadResources(
            "Data/Interface/Default/uus-corp-ui" .. model.Path,
            SystemData.Directories.Interface .. "/" .. SystemData.Settings.Interface.customUiName .. model.Path,
            file
        )
    end

    return mod
end

UusCorp = {
    Api = {
        Ability = {
            GetMaxRacialAbilities = function()
                return GetMaxRacialAbilities()
            end,
            GetRacialAbilityId = function(index)
                return GetRacialAbilityId(index) + 3000
            end,
            GetAbilityData = function(id)
                return GetAbilityData(id)
            end,
            GetWeapnAbilityId = function(index)
                return GetWeaponAbilityId(index) + 1000
            end
        },
        AnimatedImage = {
            SetTexture = function(imageName, texture)
                AnimatedImageSetTexture(imageName, texture)
            end,
            StartAnimation = function(imageName, startFrame, loop, hideWhenDone, delay)
                AnimatedImageStartAnimation(imageName, startFrame, loop, hideWhenDone, delay)
            end,
            StopAnimaton = function(imageName)
                AnimatedImageStopAnimation(imageName)
            end,
            SetPlaySpeed = function(imageName, fps)
                AnimatedImageSetPlaySpeed(imageName, fps)
            end
        },
        Button = {
            GetTextDimensions = function (id)
                return ButtonGetTextDimensions(id)
            end,
            SetText = function(id, text)
                ButtonSetText(id, text)
            end,
            GetText = function(id)
                return ButtonGetText(id)
            end,
            SetDisabled = function(id, isDisabled)
                ButtonSetDisabledFlag(id, isDisabled)
            end,
            IsDisabled = function(id)
                return ButtonGetDisabledFlag(id)
            end,
            SetEnabled = function(id, isEnabled)
                ButtonSetCheckButtonFlag(id, isEnabled)
            end,
            SetChecked = function(id, isChecked)
                ButtonSetPressedFlag(id, isChecked)
            end,
            IsChecked = function(id)
                return ButtonGetPressedFlag(id)
            end,
            SetTexture = function(id, state, texture, x, y)
                ButtonSetTexture(id, state, texture, x, y)
            end,
            SetHighlight = function(id, doHighlight)
                ButtonSetHighlightFlag(id, doHighlight)
            end,
            SetStayDown = function(id, stayDown)
                ButtonSetStayDownFlag(id, stayDown)
            end,
            IsStayDown = function(id)
                return ButtonGetStayDownFlag(id)
            end,
            SetTextColor = function(id, r, g, b, a)
                ButtonSetTextColor(id, r, g, b, a)
            end
        },
        Chat = {
            SendChat = function(channel, text)
                SendChat(channel, text)
            end,
            PrintToChatWindow = function(wString, filter)
                PrintWStringToChatWindow(wString, filter)
            end
        },
        CircleImage = {
            SetTexture = function(id, texture, xCord, yCord)
                CircleImageSetTexture(id, texture, xCord, yCord)
            end,
            SetTextureScale = function(id, scale)
                CircleImageSetTextureScale(id, scale)
            end,
            SetRotation = function(id, rotation)
                CircleImageSetRotation(id, rotation)
            end
        },
        ComboBox = {
            AddItem = function(id, item)
                ComboBoxAddMenuItem(id, item)
            end,
            ClearItems = function(id)
                ComboBoxClearMenuItems(id)
            end,
            SetSelectedItem = function(id, item)
                ComboBoxSetSelectedMenuItem(id, item)
            end,
            GetSelectedItem = function(id)
                return ComboBoxGetSelectedMenuItem(id)
            end
        },
        ContextMenu = {
            RequestMenu = function(id)
                RequestContextMenu(id)
            end
        },
        CSV = {
            Load = function(path, name)
                UOBuildTableFromCSV(path, name)
            end,
            Unload = function(name)
                UOUnloadCSVTable(name)
            end
        },
        Drag = {
            DragToObject = function(id)
                DragSlotDropObjectToObject(id)
            end,
            SetActionMouseClickData = function(userAction, actionId, iconId)
                DragSlotSetActionMouseClickData(userAction, actionId, iconId)
            end,
            SetObjectMouseClickData = function(objectId, dragSource)
                DragSlotSetObjectMouseClickData(objectId, dragSource)
            end,
            DropOnPaperdollEquipment = function(objectId)
                DragSlotDropObjectToPaperdollEquipment(objectId)
            end,
            DropOnPaperdoll = function(paperdollId)
                DragSlotDropObjectToPaperdoll(paperdollId)
            end,
            DropOnObjectAtIndex = function(objectId, gridIndex)
                DragSlotDropObjectToObjectAtIndex(objectId, gridIndex)
            end,
            DropOnContainer = function(containerId, gridIndex)
                DragSlotDropObjectToContainer(containerId, gridIndex)
            end,
            AutoPickupObject = function(objectId)
                DragSlotAutoPickupObject(objectId)
            end
        },
        DynamicImage = {
            SetTexture = function(dynamicImageName, texture, x, y)
                DynamicImageSetTexture(dynamicImageName, texture or "", x or 0, y or 0)
            end,
            SetTextureScale = function(dynamicImageName, textureScale)
                DynamicImageSetTextureScale(dynamicImageName, textureScale)
            end,
            SetTextureDimensions = function(dynamicImageName, x, y)
                DynamicImageSetTextureDimensions(dynamicImageName, x, y)
            end,
            SetTextureOrientation = function(dynamicImageName, mirrored)
                DynamicImageSetTextureOrientation(dynamicImageName, mirrored)
            end,
            SetTextureSlice = function(dynamicImageName, sliceName)
                DynamicImageSetTextureSlice(dynamicImageName, sliceName)
            end,
            SetRotation = function(dynamicImageName, rotation)
                DynamicImageSetRotation(dynamicImageName, rotation)
            end,
            HasTexture = function(dynamicImageName)
                return DynamicImageHasTexture(dynamicImageName)
            end,
            SetCustomShader = function(dynamicImageName, shader, hue)
                DynamicImageSetCustomShader(dynamicImageName, shader, hue)
            end
        },
        EditTextBox = {
            SetText = function(editBoxName, text)
                TextEditBoxSetText(editBoxName, text or L "")
            end,
            GetText = function(editBoxName)
                return TextEditBoxGetText(editBoxName)
            end,
            GetTextLines = function(editBoxName)
                return TextEditBoxGetTextLines(editBoxName)
            end,
            InsertText = function(editBoxName, text)
                TextEditBoxInsertText(editBoxName, text)
            end,
            SetTextColor = function(editBoxName, color)
                TextEditBoxSetTextColor(editBoxName, color.r, color.g, color.b)
            end,
            GetTextColor = function(editBoxName)
                return TextEditBoxGetTextColor(editBoxName)
            end,
            SelectAll = function(editBoxName)
                TextEditBoxSelectAll(editBoxName)
            end,
            SetFont = function(editBoxName, fontName, lineSpacing)
                TextEditBoxSetFont(editBoxName, fontName, lineSpacing)
            end,
            GetFont = function(editBoxName)
                return TextEditBoxGetFont(editBoxName)
            end,
            GetHistory = function(editBoxName)
                return TextEditBoxGetHistory(editBoxName)
            end,
            SetHistory = function(editBoxName, history)
                TextEditBoxSetHistory(editBoxName, history)
            end,
            HandleKeyDown = function(editBoxName, handle)
                TextEditBoxSetHandleKeyDown(editBoxName, handle)
            end
        },
        Event = {
            Broadcast = function(event)
                BroadcastEvent(event)
            end
        },
        Gump = {
            OnLeftClick = function(gumpId, windowName)
                GenericGumpOnClicked(gumpId, windowName)
            end,
            OnDoubleClick = function(gumpId, windowName)
                GenericGumpOnDoubleClicked(gumpId, windowName)
            end,
            OnRightClick = function(gumpId)
                GenericGumpOnRClicked(gumpId)
            end,
            GetTooltipText = function(gumpId, windowName)
                return GenericGumpGetToolTipText(gumpId, windowName)
            end,
            OpenWebBrowser = function(link)
                OpenWebBrowser(tostring(link))
            end,
            OnCloseContainer = function(id)
                GumpManagerOnCloseContainer(id)
            end,
            GetItemPropertiesObjectId = function(gumpId, windowName)
                return GenericGumpGetItemPropertiesId(gumpId, windowName)
            end
        },
        Icon = {
            GetIconData = function(textureId)
                return GetIconData(textureId)
            end,
            GetTextureSize = function(textureId)
                return UOGetTextureSize(textureId)
            end,
            RequestTileArt = function(type, width, height)
                return RequestTileArt(type, width, height)
            end
        },
        Label = {
            SetText = function(name, text)
                if text == nil then
                    return
                elseif type(text) == "number" then
                    text = StringFormatter.fromTid(text)
                elseif type(text) == "string" then
                    text = StringFormatter.toWString(text)
                end
                LabelSetText(name, text)
            end,
            GetText = function(name)
                return LabelGetText(name)
            end,
            SetTextColor = function(name, color)
                LabelSetTextColor(name, color.r, color.g, color.b)
            end,
            SetTextAlignment = function(name, alignment)
                LabelSetTextAlign(name, alignment)
            end,
            SetWordWrap = function(name, wordWrap)
                LabelSetWordWrap(name, wordWrap)
            end
        },
        ListBox = {
            SetDataTable = function(name, data)
                ListBoxSetDataTable(name, data)
            end,
            GetDataIndex = function(name, rowIndex)
                return ListBoxGetDataIndex(name, rowIndex)
            end,
            SetDisplayOrder = function(name, orderArray)
                ListBoxSetDisplayOrder(name, orderArray)
            end,
            SetVisibleRowCount = function(name, count)
                ListBoxSetVisibleRowCount(name, count)
            end
        },
        LogDisplay = {
            ShowTimestamp = function(name, doShow)
                LogDisplaySetShowTimestamp(name, doShow == nil or doShow)
            end,
            IsTimestampShowing = function(name)
                return LogDisplayGetShowTimestamp(name)
            end,
            ShowLogName = function(name, doShow)
                LogDisplaySetShowLogName(name, doShow == nil or doShow)
            end,
            ShowFilterName = function(name, ndoShow)
                LogDisplaySetShowFilterName(name, doShow == nil or doShow)
            end,
            AddLog = function(name, log, bool)
                LogDisplayAddLog(name, log, bool == nil or bool)
            end,
            RemoveLog = function(name, log)
                LogDisplayRemoveLog(name, log)
            end,
            SetFilterColor = function(name, log, level, color)
                LogDisplaySetFilterColor(name, log, level, color.r, color.g, color.b)
            end,
            SetFilterState = function(name, log, filterId, filter)
                LogDisplaySetFilterState(name, log, filterId, filter)
            end,
            SetTextFadeTime = function(name, time)
                LogDisplaySetTextFadeTime(name, time)
            end,
            GetTextFadeTime = function(name)
                return LogDisplayGetTextFadeTime(name)
            end,
            IsScrollbarActive = function(name)
                return LogDisplayIsScrollbarActive(name)
            end,
            SetFont = function(name, font)
                LogDisplaySetFont(name, font)
            end,
            GetFont = function(name)
                return LogDisplayGetFont(name)
            end,
            ScrollToBottom = function()
                LogDisplayScrollToBottom(name)
            end,
            IsScrolledToBottom = function(name)
                return LogDisplayIsScrolledToBottom(name)
            end,
            ResetLineFadeTime = function(name)
                LogDisplayResetLineFadeTime(name)
            end,
            ShowScrollbar = function(name, showScrollbar)
                LogDisplayShowScrollbar(name, showScrollbar)
            end,
            ScrollToTop = function(name)
                LogDisplayScrollToTop(name)
            end,
            IsScrolledToTop = function(name)
                return LogDisplayIsScrolledToTop(name)
            end
        },
        Mod = {
            LoadResources = function(path, file, resource)
                LoadResources(path, file, resource)
            end,
            SetEnabled = function(moduleName, isEnabled)
                ModuleSetEnabled(moduleName, isEnabled)
            end,
            Initialize = function(moduleName)
                ModuleInitialize(moduleName)
            end,
            GetData = function()
                return ModulesGetData()
            end,
            InitializeRestricted = function()
                ModulesInitializeRestricted()
            end,
            InitializeAllEnabled = function()
                ModulesInitializeAllEnabled()
            end,
            LoadModuleAsRestricted = function(modFilePath, allowRaw)
                ModuleRestrictedLoad(modFilePath, allowRaw)
            end,
            LoadModule = function(modFilePath, setName, allowRaw)
                ModuleLoad(modFilePath, setName, allowRaw)
            end,
            LoadModulesFromList = function(listFilePath, setName, allowRaw)
                ModulesLoadFromListFile(listFilePath, setName, allowRaw)
            end,
            LoadModulesFromDirectory = function(directory, setName)
                ModulesLoadFromDirectory(directory, setName)
            end
        },
        Object = {
            GetDistanceFromPlayer = function(id)
                return GetDistanceFromPlayer(id)
            end,
            IsValid = function(id)
                return IsValidObject(id)
            end,
            IsMobile = function(id)
                return IsMobile(id)
            end,
            GetPaperdollObject = function(paperdollId, scale)
                return GetPaperdollObject(paperdollId, scale or 1.0)
            end
        },
        Radar = {
            SetWindowSize = function(sizeX, sizeY, boolOne, centerOnPlayer)
                UORadarSetWindowSize(sizeX, sizeY, boolOne, centerOnPlayer)
            end,
            GetFacet = function()
                return UOGetRadarFacet()
            end,
            GetArea = function()
                return UOGetRadarArea()
            end,
            SetOffset = function(offsetX, offsetY)
                UORadarSetWindowOffset(offsetX, offsetY)
            end,
            GetMaxZoom = function(facet, area)
                return UORadarGetMaxZoomForMap(facet, area)
            end,
            SetZoom = function(zoom)
                UOSetRadarZoom(zoom)
            end,
            SetCenterOnPlayer = function(isCenter)
                UORadarSetCenterOnPlayer(isCenter)
            end,
            GetPhysicalFacet = function()
                return UOGetPhysicalRadarFacet()
            end,
            GetPhysicalArea = function(facet, area)
                return UORadarGetAreaDimensions(facet, area)
            end,
            GetFacetLabel = function(facet)
                return UORadarGetFacetLabel(facet)
            end,
            GetAreaLabel = function(facet, area)
                return UORadarGetAreaLabel(facet, area)
            end,
            GetFacetDimensions = function(num)
                return UORadarGetFacetDimensions(num)
            end,
            GetCenter = function()
                return UOGetRadarCenter()
            end,
            SetRotation = function(rotation)
                UOSetRadarRotation(rotation)
            end,
            CenterOnLocation = function(x, y, facet, area, bool)
                UOCenterRadarOnLocation(x, y, facet, area, bool)
            end,
            IsLocationInArea = function(x, y, facet, area)
                return UORadarIsLocationInArea(x, y, facet, area)
            end,
            TranslateRadarPositionToWorldPosition = function(offsetX, offsetY, useScale)
                return UOGetRadarPosToWorld(offsetX, offsetY, useScale)
            end,
            TranslateWorldPositionToRadarPosition = function(x, y)
                return UOGetWorldPosToRadar(x, y)
            end,
            GetAreaCount = function(facet)
                return UORadarGetAreaCount(facet)
            end
        },
        ScrollWindow = {
            SetOffset = function(id, offset)
                ScrollWindowSetOffset(id, offset)
            end,
            UpdateScrollRect = function(id)
                ScrollWindowUpdateScrollRect(id)
            end
        },
        Settings = {
            NotifyChange = function()
                --This is some variable that the client understands
                needsReload = UserSettingsChanged()
                return needsReload
            end
        },
        Slider = {
            SetCurrentPosition = function(id, position)
                SliderBarSetCurrentPosition(id, position)
            end,
            GetCurrentPosition = function(id)
                return SliderBarGetCurrentPosition(id)
            end
        },
        StatusBar = {
            SetMaxValue = function(id, value)
                StatusBarSetMaximumValue(id, value or 0)
            end,
            SetCurrentValue = function(id, value)
                StatusBarSetCurrentValue(id, value or 0)
            end,
            SetForegroundTint = function(id, color)
                StatusBarSetForegroundTint(id, color.r, color.g, color.b)
            end,
            SetBackgroundTint = function(id, color)
                StatusBarSetBackgroundTint(id, color.r, color.g, color.b)
            end
        },
        String = {
            GetStringFromTid = function(tid)
                return GetStringFromTid(tid)
            end,
            StringToWString = function(string)
                return StringToWString(string)
            end,
            WStringToString = function(wString)
                return WStringToString(wString)
            end
        },
        Target = {
            LeftClick = function(id)
                HandleSingleLeftClkTarget(id)
            end,
            GetAllMobileTargets = function()
                return GetAllMobileTargets()
            end
        },
        TextLog = {
            Create = function(name, num)
                TextLogCreate(name, num)
            end,
            Destroy = function()
                TextLogDestroy(name)
            end,
            SetEnabled = function(name, isEnable)
                TextLogSetEnabled(name, isEnable == nil or isEnable)
            end,
            Clear = function(name)
                TextLogClear(name)
            end,
            SetIncrementalSaving = function(name, doSave, path)
                TextLogSetIncrementalSaving(name, doSave, path)
            end,
            IsEnabled = function(name)
                return TextLogGetEnabled(name)
            end,
            GetNumEntries = function(name)
                return TextLogGetNumEntries(name)
            end,
            GetEntry = function(name, index)
                return TextLogGetEntry(name, index)
            end,
            AddEntry = function(name, filterId, text)
                TextLogAddEntry(name, filterId, text)
            end
        },
        Time = {
            GetCurrentDateTime = function()
                return GetCurrentDateTime()
            end
        },
        UserAction = {
            UseItem = function(id, flag)
                UserActionUseItem(id, flag)
            end,
            ToggleWarMode = function()
                UserActionToggleWarMode()
            end
        },
        Viewport = {
            Update = function(x1, y1, x2, y2)
                UpdateViewport(x1, y1, x2, y2)
            end
        },
        Waypoint = {
            SetFacet = function(facet)
                UOSetWaypointMapFacet(facet)
            end,
            Create = function(type, facet, x, y, id)
                UOCreateUserWaypoint(type, facet, x, y, id)
            end,
            Delete = function(id)
                UODeleteUserWaypoint(id)
            end,
            Edit = function(id)
                UOEditUserWaypoint(id)
            end,
            ResetFacet = function()
                UOResetWaypointMapFacet()
            end,
            SetTypeDisplayInfo = function()
                UOSetWaypointTypeDisplayInfo()
            end,
            SetDisplayMode = function(mode)
                UOSetWaypointDisplayMode(mode)
            end,
            GetInfo = function(id)
                return UOGetWaypointInfo(id)
            end
        },
        Window = {
            Destroy = function(windowName)
                if UusCorp.Api.Window.DoesExist(windowName) then
                    DestroyWindow(windowName)
                    return true
                end

                return false
            end,
            DoesExist = function(windowName)
                return DoesWindowNameExist(windowName)
            end,
            SetShowing = function(windowName, show)
                WindowSetShowing(windowName, show)
            end,
            IsShowing = function(windowName)
                return WindowGetShowing(windowName)
            end,
            SetLayer = function(windowName, layer)
                WindowSetLayer(windowName, layer)
            end,
            GetLayer = function(windowName)
                return WindowGetLayer(windowName)
            end,
            SetHandleInput = function(windowName, handleInput)
                WindowHandleInput(windowName, handleInput)
            end,
            GetHandleInput = function(windowName)
                return WindowGetHandleInput(windowName)
            end,
            SetPopable = function(windowName, popable)
                WindowSetPopable(windowName, popable)
            end,
            IsPopable = function(windowName)
                return windowGetPopable(windowName)
            end,
            SetMovable = function(windowName, movable)
                WindowSetMovable(windowName, movable)
            end,
            IsMovable = function(windowName)
                return WindowGetMovable(windowName)
            end,
            SetOffsetFromParent = function(windowName, xOffset, yOffset)
                WindowSetOffsetFromParent(windowName, xOffset, yOffset)
            end,
            GetOffsetFromParent = function(windowName)
                return WindowGetOffsetFromParent(windowName)
            end,
            SetDimensions = function(windowName, xOffset, yOffset)
                WindowSetDimensions(windowName, xOffset, yOffset)
            end,
            GetDimensions = function(windowName)
                return WindowGetDimensions(windowName)
            end,
            IsSticky = function(windowName)
                return WindowIsSticky(windowName)
            end,
            ClearAnchors = function(windowName)
                WindowClearAnchors(windowName)
            end,
            AddAnchor = function(windowName, anchorPoint, relativeTo, relativePoint, pointX, pointY)
                WindowAddAnchor(windowName, anchorPoint, relativeTo, relativePoint, pointX or 0, pointY or 0)
            end,
            GetAnchor = function(windowName, anchorId)
                return WindowGetAnchor(windowName, anchorId)
            end,
            GetAnchorCount = function(windowName)
                return WindowGetAnchorCount(windowName)
            end,
            ForceProcessAnchors = function(windowName)
                WindowForceProcessAnchors(windowName)
            end,
            AssignFocus = function(windowName, doFocus)
                return WindowAssignFocus(windowName, doFocus)
            end,
            HasFocus = function(windowName)
                return WindowHasFocus(windowName)
            end,
            SetResizing = function(windowName, isResizing)
                WindowSetResizing(windowName, isResizing)
            end,
            IsResizing = function(windowName)
                return WindowGetResizing(windowName)
            end,
            StartAlphaAnimation = function(windowName, animType, startAlpha, endAlpha, duration, setStartBeforeDelay,
                                           delay, numLoop)
                WindowStartAlphaAnimation(windowName, animType, startAlpha, endAlpha, duration, setStartBeforeDelay,
                    delay, numLoop)
            end,
            StopAlphaAnimation = function(windowName)
                WindowStopAlphaAnimation(windowName)
            end,
            StopScaleAnimation = function(windowName)
                WindowStopScaleAnimation(windowName)
            end,
            StartScaleAnimation = function(windowName, animType, startX, startY, endX, endY, duration,
                                           setStartBeforeDelay, delay, numLoop)
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
            end,
            StopPositionAnimation = function(windowName)
                WindowStopPositionAnimation(windowName)
            end,
            SetAlpha = function(windowName, alpha)
                WindowSetAlpha(windowName, alpha)
            end,
            GetAlpha = function(windowName)
                return WindowGetAlpha(windowName)
            end,
            SetColor = function(windowName, color)
                WindowSetTintColor(windowName, color.r, color.g, color.b)
            end,
            GetColor = function(windowName)
                return WindowGetTintColor(windowName)
            end,
            CreateFromTemplate = function(windowName, template, parent, doShow)
                if not UusCorp.Api.Window.DoesExist(windowName) then
                    CreateWindowFromTemplateShow(windowName, template or windowName, parent or "Root",
                        doShow == nil or doShow)
                    return true
                end
                return false
            end,
            Create = function(windowName, doShow)
                if not UusCorp.Api.Window.DoesExist(windowName) then
                    CreateWindow(windowName, doShow == nil or doShow)
                    return true
                end
                return false
            end,
            ToggleWindow = function()
                if not UusCorp.Api.Window.DoesExist(windowName) then
                    return UusCorp.Api.Window.Create(windowName, true)
                end
                return true
            end,
            SetId = function(windowName, id)
                WindowSetId(windowName, id)
            end,
            GetId = function(windowName)
                return WindowGetId(windowName)
            end,
            SetTabOrder = function(windowName, tabOrder)
                WindowSetTabOrder(windowName, tabOrder)
            end,
            GetTabOrder = function(windowName)
                return WindowGetTabOrder(windowName)
            end,
            SetMoving = function(windowName, isMoving)
                WindowSetMoving(windowName, isMoving)
            end,
            IsMoving = function(windowName)
                return WindowGetMoving(windowName)
            end,
            RegisterEventHandler = function(windowName, event, callback)
                WindowRegisterEventHandler(windowName, event, callback)
            end,
            UnregisterEventHandler = function(windowName, event)
                WindowUnregisterEventHandler(windowName, event)
            end,
            RegisterCoreEventHandler = function(windowName, event, callback)
                WindowRegisterCoreEventHandler(windowName, event, callback)
            end,
            UnregisterCoreEventHandler = function(windowName, event)
                WindowUnregisterCoreEventHandler(windowName, event)
            end,
            SetParent = function(windowName, parentId)
                WindowSetParent(windowName, parentId)
            end,
            GetParent = function(windowName)
                return WindowGetParent(windowName)
            end,
            SetScale = function(windowName, scale)
                WindowSetScale(windowName, scale)
            end,
            GetScale = function(windowName)
                return WindowGetScale(windowName)
            end,
            SetRelativeScale = function(windowName, scale)
                WindowSetRelativeScale(windowName, scale)
            end,
            SetResizeOnChildren = function(windowName, isRecursive, borderSpacing)
                WindowResizeOnChildren(windowName, isRecursive, borderSpacing)
            end,
            SetGameActionTrigger = function(windowName, action)
                WindowSetGameActionTrigger(windowName, action)
            end,
            SetGameActionData = function(windowName, actionType, actionId, actionText)
                WindowSetGameActionData(windowName, actionType, actionId, actionText)
            end,
            SetGameActionButton = function(windowName, button)
                WindowSetGameActionButton(windowName, button)
            end,
            GetGameActionButton = function(windowName)
                return WindowGetGameActionButton(windowName)
            end,
            IsGameActionLocked = function(windowName)
                return WindowIsGameActionLocked(windowName)
            end,
            SetDrawWhenInterfaceHidden = function(windowName, doDraw)
                WindowSetDrawWhenInterfaceHidden(windowName, doDraw)
            end,
            RestoreDefaults = function(windowName)
                WindowRestoreDefaultSettings(windowName)
            end,
            SetUpdateFrequency = function(windowName, frequency)
                WindowSetUpdateFrequency(windowName, frequency)
            end,
            GetPosition = function(id)
                return WindowGetScreenPosition(id)
            end,
            AttachToWorldObject = function(objectId, window)
                AttachWindowToWorldObject(objectId, window)
            end,
            DetachFromWorldObject = function(objectId, window)
                DetachWindowFromWorldObject(objectId, window)
            end,
            RegisterData = function(data, id)
                RegisterWindowData(data, id or 0)
            end,
            UnregisterData = function(data, id)
                UnregisterWindowData(data, id or 0)
            end,
            SavePostion = function(window, closing, alias)
                WindowUtils.SaveWindowPosition(window, closing, alias)
            end,
            RestorePostion = function(window, trackSize, alias, ignoreBounds)
                WindowUtils.RestoreWindowPosition(window, trackSize, alias, ignoreBounds)
            end
        },
        InterfaCore = {
            GetScaleFactor = function ()
                return 1 / InterfaceCore.scale
            end
        }
    },
    Data = {
        ---@return WindowData
        Window = function()
            ---@type WindowData
            local data = WindowData

            data.CurrentTarget.isMobile = function()
                return data.CurrentTarget.TargetType == UusCorpConstants.TargetType.Mobile
            end

            data.CurrentTarget.isObject = function()
                return data.CurrentTarget.TargetType == UusCorpConstants.TargetType.Object
            end

            data.CurrentTarget.isCorpse = function()
                return data.CurrentTarget.TargetType == UusCorpConstants.TargetType.Corpse
            end

            return data
        end,
        ---@return SystemData
        System = function()
            return SystemData
        end
    },
    Constants = {
        DragSource = {
            Object = function ()
                return UusCorp.Data.System().DragSource["SOURCETYPE_OBJECT"]
            end
        },
        TargetType = {
            Mobile = 2,
            Object = 3,
            Corpse = 4
        },
        Broadcasts = {
            Help = function ()
                return UusCorp.Data.System().Events["REQUEST_OPEN_HELP_MENU"]
            end,
            BeginHealthBarDrag = function ()
                return UusCorp.Data.System().Events["BEGIN_DRAG_HEALTHBAR_WINDOW"]
            end,
            BugReport = function ()
                return UusCorp.Data.System().Events["BUG_REPORT_SCREEN"]
            end,
            ExitGame = function ()
                return UusCorp.Data.System().Events["EXIT_GAME"]
            end,
            EscapeKeyProcessed = function ()
                return UusCorp.Data.System().Events["ESCAPE_KEY_PROCESSED"]
            end
        },
        DataEvents = {
            OnUpdateMobileName = {
                getType = function ()
                    return WindowData.MobileName.Type
                end,
                getEvent = function ()
                    return WindowData.MobileName.Event
                end,
                name = "OnUpdateMobileName"
            },
            OnUpdatePlayerStatus = {
                getType = function ()
                    return UusCorp.Data.Window().PlayerStatus.Type
                end,
                getEvent = function ()
                    return UusCorp.Data.Window().PlayerStatus.Event
                end,
                name = "OnUpdatePlayerStatus"
            },
            OnUpdateHealthBarColor = {
                geType = function ()
                    return UusCorp.Data.Window().HealthBarColor.Type
                end,
                getEvent = function ()
                    return UusCorp.Data.Window().HealthBarColor.Event
                end,
                name = "OnUpdateHealthBarColor"
            },
            OnUpdateMobileStatus = {
                getType = function ()
                    return UusCorp.Data.Window().MobileStatus.Type
                end,
                getEvent = function ()
                    return UusCorp.Data.Window().MobileStatus.Event
                end,
                name = "OnUpdateMobileStatus"
            }
        },
        CoreEvents = {
            OnInitialize = "OnInitialize",
            OnShown = "OnShown",
            OnHidden = "OnHidden",
            OnShutdown = "OnShutdown",
            OnLButtonUp = "OnLButtonUp",
            OnLButtonDown = "OnLButtonDown",
            OnRButtonUp = "OnRButtonUp",
            OnRButtonDown = "OnRButtonDown",
            OnUpdate = "OnUpdate",
            OnLButtonDblClk = "OnLButtonDblClk",
            OnMouseOver = "OnMouseOver",
            OnMouseOverEnd = "OnMouseOverEnd",
            OnMouseDrag = "OnMouseDrag"
        },
        AnchorPoints = {
            BottomLeft = "bottomleft",
            TopLeft = "topleft",
            Top = "top",
            Bottom = "bottom",
            Center = "center"
        },
        WindowNames = {
            Root = "Root"
        },
        WindowLayers = {
            Background = 0,
            Default = 1,
            Secondary = 2,
            Popup = 3,
            Overlay = 4
        },
        ButtonStates = {
            Normal = 0,
            Pressed = 1,
            Disabled = 2,
            Highlighted = 3,
            PressedHighlighted = 4,
            DisabledPressed = 5
        },
        Textures = {
            MenuSelection = "MenuSelection"
        },
        Colors = {
            OffWhite = {
                r = 206,
                g = 217,
                b = 242
            }
        }
    },
    Interface = {
        Defaults = {
            ResiszeWindow = Window {
                name = "ResizeWindow"
            },

            RootWindow = Window {
                name = "Root"
            },

            MainMenuWindow = Window {
                name = "MainMenuWindow"
            },

            BugReportWindow = Window {
                name = "BugReportWindow"
            },

            ---@class ObjectHandleWindow
            ---@field CreateObjectHandles fun()
            ---@field DestroyObjectHandles fun()
            ObjectHandleWindow = ObjectHandleWindow,

            ---@class ItemProperties
            ---@field UpdateItemPropertiesData fun()
            ItemProperties = ItemProperties,

            ---@class ItemPropertiesData
            ---@field clearActiveItem fun()
            ItemPropertiesData = ItemPropertiesData,

            ---@class InterfaceCore
            ---@field OnExitGame fun()
            InterfaceCore = InterfaceCore,

            ---@class Actions
            ---@field ToggleMainMenu fun()
            Actions = Actions
        },
        ---@param model WindowModel?
        ---@return Window
        Window = function (model)
            local window = Window(model)
            UusCorp.EventHandler.Windows[window.getName()] = window
            return window
        end,

        ---@param model WindowModel?
        ---@return Button
        Button = function(model)
            local button = Button(model)
            UusCorp.EventHandler.Windows[button.getName()] = button
            return button
        end,

        ---@param model WindowModel?
        ---@return Label
        Label = function (model)
            local label = Label(model)
            UusCorp.EventHandler.Windows[label.getName()] = label
            return label
        end,

        ---@param model WindowModel?
        ---@return StatusBar
        StatusBar = function (model)
            local statusBar = StatusBar(model)
            UusCorp.EventHandler.Windows[statusBar.getName()] = statusBar
            return statusBar
        end
    },
    Utils = {
        Array = {
            ---@generic T
            ---@param array T[]
            ---@param find fun(item: T): boolean
            ---@return integer
            IndexOf = function (array, find)
                for i = 1, #array do
                    local item = array[i]
                    if find(item) then
                        return i
                    end
                end

                return -1
            end,

            ---@generic T
            ---@param array T[]
            ---@param find fun(item: T): boolean
            ---@return T?
            Find = function (array, find)
                for i = 1, #array do
                    local item = array[i]
                    if find(item) then
                        return item
                    end
                end

                return nil
            end,
            ---@generic T
            ---@param array T[]
            ---@param forEach fun(item: T, index: integer)
            ForEach = function (array, forEach)
                for i = 1, #array do
                    local item = array[i]
                    forEach(item, i)
                end
            end
        },

        Table = {
            ---@generic K
            ---@generic V
            ---@param table table<K, V>
            ---@return table<K, V>
            Copy = function (table)
                local newTable = {}
                for k, v in pairs(table) do
                    newTable[k] = v
                end
                return newTable
            end,

            ---@generic K
            ---@generic V
            ---@param table table<K, V>
            ---@return table<K, V>
            OverrideFunctions = function (table)
                for k, v in pairs(table) do
                    if type(v) == "function" then
                        table[k] = function () end
                    end
                end
                return table
            end
        },

        String = {
            ExtractNumber = function (text)
                return tonumber(string.match(text, "%d+") or 0)
            end,

            Random = function()
                local charset = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
                local result = ""
                for i = 1, 24 do
                    local rand = math.random(1, #charset)
                    result = result .. charset:sub(rand, rand)
                end
                return result
            end,

            FromWString = function(text)
                if type(text) == "string" then
                    return text
                else
                    return UusCorp.Api.String.WStringToString(text)
                end
            end,

            ToWString = function(text)
                if type(text) == "number" then
                    return UusCorp.Api.String.GetStringFromTid(text)
                elseif type(text) == "wstring" then
                    return text
                elseif type(text) == "string" then
                    return UusCorp.Api.String.StringToWString(text)
                else
                    return UusCorp.Api.String.StringToWString(tostring(text))
                end
            end,

            Lower = function(text)
                if type(text) == "string" then
                    return string.lower(text)
                elseif type(text) == "wstring" then
                    return string.lower(UusCorp.Utils.String.FromWString(text))
                end
            end,

            Upper = function(text)
                if type(text) == "string" then
                    return string.upper(text)
                elseif type(text) == "wstring" then
                    return string.upper(UusCorp.Utils.String.FromWString(text))
                end
            end
        }
    },
    EventHandler = {
        ---@type table<string, Window>
        Windows = {},
        OnInitialize = function()
            local window = UusCorp.EventHandler.Windows[Active.window()]
            window.events.onInitialize()
        end,
        OnShutdown = function()
            local window = UusCorp.EventHandler.Windows[Active.window()]
            window.events.onShutdown()
            UusCorp.EventHandler.Windows[Active.window()] = nil
        end,
        OnLButtonUp = function (flags, x, y)
            local window = UusCorp.EventHandler.Windows[Active.window()]
            window.events.onLButtonUp(flags, x, y)
        end,
        OnLButtonDown = function (flags, x, y)
            local window = UusCorp.EventHandler.Windows[Active.window()]
            window.events.onLButtonDown(flags, x, y)
        end,
        OnRButtonDown = function (flags, x, y)
            local window = UusCorp.EventHandler.Windows[Active.window()]
            window.events.onRButtonDown(flags, x, y)
        end,
        OnRButtonUp = function (flags, x, y)
            local window = UusCorp.EventHandler.Windows[Active.window()]
            window.events.onRButtonUp(flags, x, y)
        end,
        OnHidden = function ()
            local window = UusCorp.EventHandler.Windows[Active.window()]
            window.events.onHidden()
        end,
        OnShown = function ()
            local window = UusCorp.EventHandler.Windows[Active.window()]
            window.events.onShown()
        end,
        OnUpdate = function (timePassed)
            local window = UusCorp.EventHandler.Windows[Active.window()]
            window.events.onUpdate(timePassed)
        end,
        OnUpdateMobileName = function ()
            local window = UusCorp.EventHandler.Windows[Active.window()]
            window.events.onUpdateMobileName()
        end,
        OnLButtonDblClk = function (flags, x, y)
            local window = UusCorp.EventHandler.Windows[Active.window()]
            window.events.onLButtonDblClk(flags, x, y)
        end,
        OnMouseOver = function ()
            local window = UusCorp.EventHandler.Windows[Active.window()]
            window.events.onMouseOver()
        end,
        OnMouseOverEnd = function ()
            local window = UusCorp.EventHandler.Windows[Active.window()]
            window.events.onMouseOverEnd()
        end,
        OnMouseDrag = function ()
            local window = UusCorp.EventHandler.Windows[Active.window()]
            window.events.onMouseDrag()
        end,
        OnUpdatePlayerStatus = function ()
            local window = UusCorp.EventHandler.Windows[Active.window()]
            window.events.onUpdatePlayerStatus()
        end,
        OnUpdateMobileStatus = function ()
            local window = UusCorp.EventHandler.Windows[Active.window()]
            window.events.onUpdateMobileStatus()
        end,
        OnUpdateHealthBarColor = function ()
            local window = UusCorp.EventHandler.Windows[Active.window()]
            window.events.onUpdateHealthBarColor()
        end
    },
    Mod = Mod
}
