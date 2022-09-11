BuffsWindow = {}
BuffsWindow.Name = "BuffsWindow"

local buffs = {}

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

    for _, v in pairs(buffs) do
        table.insert(
            list,
            v
        )
    end

    for i = 1, #list do
        WindowApi.clearAnchors(
            "Buff" .. list[i].id
        )

        if i > 1 and i % 5 ~= 0 then
            WindowApi.addAnchor(
                "Buff" .. list[i].id,
                "right",
                "Buff" .. list[i - 1].id,
                "left",
                4,
                0
            )
        elseif i % 5 == 0 then
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

function BuffsWindow.onInitialize()
    WindowDataApi.registerData(
        Buffs.dataType()
    )
    WindowApi.registerEventHandler(
        Active.window(),
        Buffs.event(),
        "BuffsWindow.onEffectReceived"
    )
    WindowApi.addAnchor(
        Active.window(),
        "bottomleft",
        PlayerHealthBar.Name,
        "topleft",
        8,
        12
    )
end

function BuffsWindow.onEffectReceived()
    local id = Buffs.id()

    if id < 1000 or id == nil or Buffs.isBeingRemoved() then
        return
    end

    buffs[id] = {
        id = id,
        timer = Buffs.timer(),
        hasTimer = Buffs.hasTimer(),
        nameVector = Buffs.nameVector(),
        nameVectorSize = Buffs.nameVectorSize(),
        toolTipVector = Buffs.toolTipVector(),
        toolTipVectorSize = Buffs.toolTipVectorSize(),
        isBeingRemoved = Buffs.isBeingRemoved()
    }

    local rowNumber = CSVUtilities.getRowIdWithColumnValue(
        Buffs.csv(),
        "ServerId",
        id
    )

    if rowNumber == nil or Buffs.csv() == nil or Buffs.csv()[rowNumber] == nil then
        return
    end

    local textureId = tonumber(Buffs.csv()[rowNumber].IconId)

    buffs[id].textureId = textureId

    local icon, x, y = IconApi.getIconData(textureId)

    buffs[id].icon = {
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

function BuffsWindow.onBuffStart()
    local id = string.gsub(
        Active.window(),
        "Buff",
        ""
    )

    WindowApi.setId(Active.window(), tonumber(id))

    local buff = buffs[tonumber(id)]

    DynamicImageApi.setTexture(
        Active.window() .. "Icon",
        buff.icon.id,
        buff.icon.x,
        buff.icon.y
    )

    anchorBuffs()
end

function BuffsWindow.onBuffUpdate(timePassed)
    local id = WindowApi.getId(Active.window())
    local buff = buffs[id]
    buff.timer = buff.timer - timePassed

    if buff.hasTimer and buff.timer >= 0 then
        LabelApi.setText(
            Active.window() .. "Time",
            updateTimer(math.floor(buff.timer))
        )
    end

    if buff.hasTimer and buff.timer <= 0 or buff.isBeingRemoved then
        WindowApi.destroyWindow(Active.window())
    end
end

function BuffsWindow.onBuffEnd()
    local id = WindowApi.getId(Active.window())
    buffs[id] = nil

    if TooltipWindow.Context == id then
        BuffsWindow.onBuffMouseOverEnd()
    end

    anchorBuffs()
end

function BuffsWindow.onBuffMouseOver()
    local buff = buffs[WindowApi.getId(Active.window())]
    local data = {}

    for i = 1, #buff.nameVector do
        table.insert(
            data,
            buff.nameVector[i]
        )
    end

    for i = 1, #buff.toolTipVector do
        table.insert(
            data,
            buff.toolTipVector[i]
        )
    end

    TooltipWindow.create(data, buff.id)
end

function BuffsWindow.onBuffMouseOverEnd()
    TooltipWindow.destroy()
end

function BuffsWindow.onShutdown()
    WindowDataApi.unregisterData(
        Buffs.dataType()
    )
    WindowApi.unregisterEventHandler(
        Active.window(),
        Buffs.event()
    )
    BuffsWindow.onBuffMouseOverEnd()
end