CharacterSheetWindow = {}

CharacterSheetWindow.Name = "CharacterSheetWindow"

CharacterSheetWindow.List = CharacterSheetWindow.Name .. "List"

CharacterSheetWindow.Data = {}

local TextIds = {
    IncreaseManaMax = 1079409,
    IncreaseStamMax = 1079408,
    IncreaseHitPointsMax = 1079407,
    IncreaseMana = 1079406,
    IncreaseStam = 1079405,
    IncreaseHitPoints = 1079404,
    IncreaseInt = 1079403,
    IncreaseDex = 1079402,
    IncreaseStr = 1079401
}

-- Data from the server isn't properly structured to show the
-- stats in a more user friendly way. We need to skip certain labels
-- so that they can be displayed as # / # (+increase)
local function skipLabel(tid)
    for _, v in pairs(TextIds) do
        if v == tid then
            return true
        end
    end

    return false
end

local function formatPoints(current, max, increase)
    if tonumber(increase) >= 0 then
        increase = "+" .. increase
    end

    return current .. " / " .. max .. " (" .. increase .. ")"
end

local function formatStat(current, increase)
    if tonumber(increase) >= 0 then
        increase = "+" .. increase
    end

    return current .. " (" .. increase .. ")"
end

function CharacterSheetWindow.onInitialize()
    WindowDataApi.registerData(PlayerStatus.type())

    WindowApi.registerEventHandler(
        CharacterSheetWindow.Name,
        PlayerStatus.event(),
        "CharacterSheetWindow.onUpdate"
    )

    CharacterSheetWindow.onUpdate()
end

function CharacterSheetWindow.onShutdown()
    CharacterSheetWindow.Data = {}
    WindowDataApi.unregisterData(PlayerStatus.type())
    WindowApi.unregisterEventHandler(
        CharacterSheetWindow.Name,
        PlayerStatus.event()
    )
end

function CharacterSheetWindow.onRightClick()
    WindowApi.destroyWindow(CharacterSheetWindow.Name)
end

function CharacterSheetWindow.onUpdate()
    CharacterSheetWindow.Data = {}
    local order = {}
    
    for _, v in ipairs(PlayerStatus.stats()) do
        if v.tid ~= nil and v.tid ~= 0 and not skipLabel(v.tid) then
            local name = StringFormatter.fromTid(
                v.tid
            )

            local value = ""

            if v.tid == 1061149 then
                value = formatPoints(
                    PlayerStatus.currentHealth(),
                    PlayerStatus.maxHealth(),
                    PlayerStatus.increaseMaxHitPoints()
                )
            elseif v.tid == 1061150 then
                value = formatPoints(
                    PlayerStatus.currentStamina(),
                    PlayerStatus.maxStamina(),
                    PlayerStatus.increaseMaxStamina()
                )
            elseif v.tid == 1061151 then
                value = formatPoints(
                    PlayerStatus.currentMana(),
                    PlayerStatus.maxMana(),
                    PlayerStatus.increaseMaxMana()
                )
            elseif v.tid == 1061148 then
                value = formatStat(
                    PlayerStatus.intelligence(),
                    PlayerStatus.increaseIntelligence()
                )
            elseif v.tid == 1061146 then
                value = formatStat(
                    PlayerStatus.strength(),
                    PlayerStatus.increaseStrength()
                )
            elseif v.tid == 1061147 then
                value = formatStat(
                    PlayerStatus.dexterity(),
                    PlayerStatus.increaseDexterity()
                )
            elseif v.tid == 1017319 then
                value = PlayerStatus.damage() .. " - " .. PlayerStatus.maxDamage()
            else
                for i, j in pairs(PlayerStatus.data()) do
                    if i == StringFormatter.fromWString(v.name) then
                        value = j
                        break
                    end
                end
            end

            table.insert(
                CharacterSheetWindow.Data,
                #CharacterSheetWindow.Data + 1,
                {
                    name = name,
                    value = StringFormatter.toWString(value)
                }
            )

            table.insert(
                order,
                #order + 1,
                #order + 1
            )
        end
    end

    ListBoxApi.setDisplayOrder(
        CharacterSheetWindow.List,
        order
    )
end