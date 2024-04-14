---@class Event:number
---@class Type:number

---@class Object
---@field objectId number
---@field objectType number

---@class SkillAllSkillsOther

---@class WindowData.HealthBarColor
---@field VisualStateId number

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

---@return WindowData
UusCorpWindowData = function ()
    ---@class WindowData
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
    local data = WindowData

    data.CurrentTarget.isMobile = function ()
        return data.CurrentTarget.TargetType == UusCorpConstants.TargetType.Mobile
    end

    data.CurrentTarget.isObject = function ()
        return data.CurrentTarget.TargetType == UusCorpConstants.TargetType.Object
    end

    data.CurrentTarget.isCorpse = function ()
        return data.CurrentTarget.TargetType == UusCorpConstants.TargetType.Corpse
    end

    return data
end

