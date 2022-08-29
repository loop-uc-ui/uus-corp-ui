BuffsWindow = {}
BuffsWindow.Name = "BuffsWindow"

local buffs = {}

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

    if id == 0 or id == nil then
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

    WindowApi.setUpdateFrequency(Active.window(), 1)
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
end

function BuffsWindow.onShutdown()
    WindowDataApi.unregisterData(
        Buffs.dataType()
    )
    WindowApi.unregisterEventHandler(
        BuffsWindow.Name,
        Buffs.event()
    )
end