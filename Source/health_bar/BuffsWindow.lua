BuffsWindow = {}
BuffsWindow.Name = "BuffsWindow"

local buffs = {}

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
                8,
                0
            )
        elseif i % 5 == 0 then
            WindowApi.addAnchor(
                "Buff" .. list[i].id,
                "bottom",
                "Buff" .. list[i - 4].id,
                "top",
                0,
                8
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
end

function BuffsWindow.onEffectReceived()
    local id = Buffs.id()

    if id < 999 or id == nil or Buffs.isBeingRemoved() then
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

    local parent = WindowApi.getParent(Active.window())
    local x, y = WindowApi.getDimensions(parent)

    WindowApi.forceProcessAnchors(
        WindowApi.getParent(Active.window())
    )

    WindowApi.forceProcessAnchors(
        WindowApi.getParent(
            WindowApi.getParent(
                Active.window()
            )
        )
    )

    anchorBuffs()
end

function BuffsWindow.onBuffUpdate(timePassed)
    local id = WindowApi.getId(Active.window())
    local buff = buffs[id]
    buff.timer = buff.timer - timePassed

    if buff.hasTimer and buff.timer <= 0 or buff.isBeingRemoved then
        WindowApi.destroyWindow(Active.window())
    end
end

function BuffsWindow.onBuffEnd()
    buffs[WindowApi.getId(Active.window())] = nil
    anchorBuffs()
end

function BuffsWindow.onShutdown()
    WindowDataApi.unregisterData(
        Buffs.dataType()
    )
    WindowApi.unregisterEventHandler(
        Active.window(),
        Buffs.event()
    )
end