UusCorpCharacterSheetWindow = {}

UusCorpCharacterSheetWindow.Name = "CharacterSheetWindow"

UusCorpCharacterSheetWindow.List = UusCorpCharacterSheetWindow.Name .. "List"

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

local function populateList(title, list, data)
    if WindowApi.createFromTemplate(
        list,
        list,
        UusCorpCharacterSheetWindow.List .. "ScrollChild"
    ) then
        LabelApi.setText(
            list .. "Title",
            title
        )
    end

    for i = 1, #data do
        if WindowApi.createFromTemplate(
            list .. "Row" .. i,
            "CharacterSheetRowTemplate",
            list .. "Data"
        ) and i > 1 then
            WindowApi.addAnchor(
                list .. "Row" .. i,
                "bottom",
                list .. "Row" .. i - 1,
                "top",
                0,
                4
            )

            ScrollWindowApi.updateScrollRect(UusCorpCharacterSheetWindow.List)
        end

        LabelApi.setText(
            list .. "Row" .. i .. "ItemName",
            data[i].name
        )

        LabelApi.setText(
            list .. "Row" .. i .. "ItemValue",
            data[i].value
        )
    end
end

function UusCorpCharacterSheetWindow.initialize()
    UusCorpCore.loadResources(
        "/mods/character-sheet",
        "UusCorpCharacterSheetWindow.xml"
    )
end

function UusCorpCharacterSheetWindow.onInitialize()
    WindowDataApi.registerData(PlayerStatus.type())

    WindowApi.registerEventHandler(
        UusCorpCharacterSheetWindow.Name,
        PlayerStatus.event(),
        "UusCorpCharacterSheetWindow.onUpdate"
    )

    UusCorpCharacterSheetWindow.onUpdate()
end

function UusCorpCharacterSheetWindow.onShutdown()
    WindowDataApi.unregisterData(PlayerStatus.type())
    WindowApi.unregisterEventHandler(
        UusCorpCharacterSheetWindow.Name,
        PlayerStatus.event()
    )
end

function UusCorpCharacterSheetWindow.onRightClick()
    WindowApi.destroyWindow(UusCorpCharacterSheetWindow.Name)
end

function UusCorpCharacterSheetWindow.onUpdate()
    local data = {}

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
                data,
                #data + 1,
                {
                    name = name,
                    value = StringFormatter.toWString(value)
                }
            )
        end
    end

    local stats = {}
    local combat = {}
    local magic = {}
    local resistances = {}
    local regens = {}

    for i = 1, #data do
        if i <= 11 then
            table.insert(
                stats,
                data[i]
            )
        elseif i <= 16 then
            table.insert(
                resistances,
                data[i]
            )
        elseif i <= 20 then
            table.insert(
                combat,
                data[i]
            )
        elseif i == 21 then
            table.insert(
                magic,
                data[i]
            )
        elseif i <= 24 then
            table.insert(
                regens,
                data[i]
            )
        elseif i <= 27 then
            table.insert(
                combat,
                data[i]
            )
        else
            table.insert(
                magic,
                data[i]
            )
        end
    end

    populateList("Stats", "CharacterSheetStatsList", stats)
    populateList("Regens", "CharacterSheetRegenList", regens)
    populateList("Resists", "CharacterSheetResistList", resistances)
    populateList("Combat", "CharacterSheetCombatList", combat)
    populateList("Magic", "CharacterSheetMagicList", magic)
end