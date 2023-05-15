UusCorpBuffsWindow = {}
UusCorpBuffsWindow.Name = "BuffsWindow"
UusCorpBuffsWindow.Buffs = {}

local function findBuff(id)
    for i = 1, #UusCorpBuffsWindow.Buffs do
        if UusCorpBuffsWindow.Buffs[i].id == tonumber(id) then
            return UusCorpBuffsWindow.Buffs[i]
        end
    end

    return nil
end

local function updateTimer(time)
    local min = math.floor(time / 60)
    local prefix = ""

    if min > 60 then
        if ((min / 60) - math.floor(min / 60) > 0) then
            prefix = ">"
        end
        local h = math.floor(min / 60)
        return prefix .. h .. "h"
    elseif min > 0 then
        if (time - (min * 60) > 0) then
            prefix = ">"
        end
        return prefix .. min	.. "m"
    else
        return time	.. "s"
    end
end

local function anchorBuffs()
    local list = {}

    for _, v in pairs(UusCorpBuffsWindow.Buffs) do
        table.insert(
            list,
            v
        )
    end

    for i = 1, #list do
        WindowApi.clearAnchors(
            "Buff" .. list[i].id
        )

        if i > 1 and i <= 4 or i % 4 ~= 1 then
            WindowApi.addAnchor(
                "Buff" .. list[i].id,
                "right",
                "Buff" .. list[i - 1].id,
                "left",
                4,
                0
            )
        elseif i > 1 and i % 4 == 1 then
            WindowApi.addAnchor(
                "Buff" .. list[i].id,
                "bottom",
                "Buff" .. list[i - 4].id,
                "top",
                0,
                4
            )
        end
    end
end

function UusCorpBuffsWindow.initialize()
    UusCorpCore.isBuffsModEnabled = true

    UusCorpCore.loadResources(
        "/src/mods/buffs",
        "UusCorpBuffsWindow.xml"
    )

    WindowApi.setShowing(
        "AdvancedBuffGood",
        false
    )

    WindowApi.setShowing(
        "AdvancedBuffEvil",
        false
    )

    UusCorpCore.overrideFunctions(AdvancedBuff)
    UusCorpCore.overrideFunctions(BuffDebuff)
    WindowApi.unregisterEventHandler(
        "BuffDebuff",
        Buffs.event()
    )
    WindowApi.createWindow(UusCorpBuffsWindow.Name, false)
end

function UusCorpBuffsWindow.shutdown()
    UusCorpCore.isBuffsModEnabled = false
end

function UusCorpBuffsWindow.onInitialize()
    WindowDataApi.registerData(
        Buffs.dataType()
    )
    WindowApi.registerEventHandler(
        Active.window(),
        Buffs.event(),
        "UusCorpBuffsWindow.onEffectReceived"
    )
end

function UusCorpBuffsWindow.onShown()
    WindowApi.clearAnchors(Active.window())
    WindowApi.addAnchor(
        Active.window(),
        "bottomleft",
        UusCorpPlayerStatusWindow.Name,
        "topleft",
        8,
        12
    )
end

function UusCorpBuffsWindow.onEffectReceived()
    WindowApi.setShowing(
        Active.window(),
        WindowApi.doesExist(UusCorpPlayerStatusWindow.Name)
    )

    local id = Buffs.id()

    if id < 1000 or id == nil then
        return
    end

    if not Buffs.hasTimer() and Buffs.isBeingRemoved() then
        WindowApi.destroyWindow("Buff" .. id)
        return
    end

    if Buffs.isBeingRemoved() then
        return
    end

    table.insert(
        UusCorpBuffsWindow.Buffs,
        {
            id = id,
            timer = Buffs.timer(),
            hasTimer = Buffs.hasTimer(),
            nameVector = Buffs.nameVector(),
            nameVectorSize = Buffs.nameVectorSize(),
            toolTipVector = Buffs.toolTipVector(),
            toolTipVectorSize = Buffs.toolTipVectorSize(),
            isBeingRemoved = Buffs.isBeingRemoved()
        }
    )

    local rowNumber = CSVUtilities.getRowIdWithColumnValue(
        Buffs.csv(),
        "ServerId",
        id
    )

    if rowNumber == nil or Buffs.csv() == nil or Buffs.csv()[rowNumber] == nil then
        return
    end

    local textureId = tonumber(Buffs.csv()[rowNumber].IconId)

    local buff = UusCorpBuffsWindow.Buffs[#UusCorpBuffsWindow.Buffs]

    buff.textureId = textureId

    local icon, x, y = IconApi.getIconData(textureId)

    buff.icon = {
        id = icon,
        x = x,
        y = y
    }

    local buffWindow = "Buff" .. id

    WindowApi.createFromTemplate(
        buffWindow,
        "BuffIconTemplate",
        Active.window()
    )
end

function UusCorpBuffsWindow.onBuffStart()
    local id = string.gsub(
        Active.window(),
        "Buff",
        ""
    )

    WindowApi.setId(Active.window(), tonumber(id))

    local buff = findBuff(tonumber(id))

    if buff == nil then
        return
    end

    DynamicImageApi.setTexture(
        Active.window() .. "Icon",
        buff.icon.id,
        buff.icon.x,
        buff.icon.y
    )

    anchorBuffs()
end

function UusCorpBuffsWindow.onBuffUpdate(timePassed)
    WindowApi.setShowing(
        WindowApi.getParent(Active.window()),
        WindowApi.doesExist(UusCorpPlayerStatusWindow.Name)
    )

    local id = WindowApi.getId(Active.window())

    local buff = findBuff(id)

    if buff == nil then
        return
    end

    if buff.hasTimer then
        buff.timer = buff.timer - timePassed

        if buff.timer >= 0 then
            LabelApi.setText(
                Active.window() .. "Time",
                updateTimer(math.floor(buff.timer))
            )
        end
    else
        WindowApi.setShowing(
            Active.window() .. "TimeBackground",
            false
        )
    end

    if buff.hasTimer and buff.timer <= 0 or buff.isBeingRemoved then
        WindowApi.destroyWindow(Active.window())
    end
end

function UusCorpBuffsWindow.onBuffEnd()
    local id = WindowApi.getId(Active.window())

    for i = 1, #UusCorpBuffsWindow.Buffs do
        if UusCorpBuffsWindow.Buffs[i].id == id then
            table.remove(
                UusCorpBuffsWindow.Buffs,
                i
            )
            break
        end
    end

    if UusCorpTooltipWindow.Context == id then
        UusCorpBuffsWindow.onBuffMouseOverEnd()
    end

    anchorBuffs()
end

function UusCorpBuffsWindow.onBuffMouseOver()
    local buff = findBuff(WindowApi.getId(Active.window()))

    if buff == nil then
        return
    end

    local data = {}

    for i = 1, #buff.nameVector do
        table.insert(
            data,
            buff.nameVector[i]
        )
    end

    for i = 1, #buff.toolTipVector do
        local text = string.gsub(
            StringFormatter.fromWString(buff.toolTipVector[i]),
            "\n",
            " "
        )
        table.insert(
            data,
            text
        )
    end

    UusCorpTooltipWindow.create(data, buff.id)
end

function UusCorpBuffsWindow.onBuffMouseOverEnd()
    UusCorpTooltipWindow.destroy()
end

function UusCorpBuffsWindow.onShutdown()
    WindowDataApi.unregisterData(
        Buffs.dataType()
    )
    WindowApi.unregisterEventHandler(
        Active.window(),
        Buffs.event()
    )
    UusCorpBuffsWindow.onBuffMouseOverEnd()
end