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

    local icon, x, y = IconApi.getIconData(textureId)

    local buffWindow = "Buff" .. textureId

    if WindowApi.createFromTemplate(
        buffWindow,
        "BuffIconTemplate",
        Active.window()
    ) then
        DynamicImageApi.setTexture(
            buffWindow .. "Icon",
            icon,
            x,
            y
        )
    end

    WindowApi.setId(buffWindow, id)
    WindowApi.setUpdateFrequency(buffWindow, 1)
end

function BuffsWindow.onUpdate(timePassed)
    local id = WindowApi.getId(Active.window())
    local buff = buffs[id]
    buff.timer = buff.timer - timePassed

    if buff.hasTImer and buff.timer <= 0 or buff.isBeingRemoved then
        WindowApi.destroyWindow(Active.window())
    end
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