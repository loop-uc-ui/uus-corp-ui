Paperdoll = {}

local function toNum(id)
    if type(id) ~= "number" then
        id = tonumber(id, 10)
    end
    return id
end

function Paperdoll.type()
    return WindowData.Paperdoll.Type
end

function Paperdoll.name()
    return SystemData.Paperdoll.Name
end

function Paperdoll.id()
    return SystemData.Paperdoll.Id
end

function Paperdoll.event()
    return WindowData.Paperdoll.Event
end

function Paperdoll.backpack(id)
    return WindowData.Paperdoll[toNum(id)].backpackId
end

function Paperdoll.numSlots(id)
    return WindowData.Paperdoll[toNum(id)].numSlots
end

function Paperdoll.slotData(id, slotIndex)
    return WindowData.Paperdoll[toNum(id)][toNum(slotIndex)]
end

function Paperdoll.slotId(id, slotIndex)
    return Paperdoll.slotData(id, slotIndex).slotId
end

function Paperdoll.slotTextureName(id, slotIndex)
    return Paperdoll.slotData(id, slotIndex).slotTextureName
end

function Paperdoll.textureData(id)
    return SystemData.PaperdollTexture[toNum(id)]
end

function Paperdoll.isLegacyEnabled()
    return SystemData.Settings.Interface.LegacyPaperdolls
end

function Paperdoll.useLegacy(useLegacy)
    SystemData.Settings.Interface.LegacyPaperdolls = useLegacy
end