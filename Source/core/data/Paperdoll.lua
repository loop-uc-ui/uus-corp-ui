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

function Paperdoll.durability(id, slotIndex)
    return Paperdoll.slotData(id, slotIndex).Durability
end

function Paperdoll.maxDurability(id, slotIndex)
    return Paperdoll.durability(id, slotIndex).Max
end

function Paperdoll.currentDurability(id, slotIndex)
    return Paperdoll.durability(id, slotIndex).Current
end

function Paperdoll.textureData(id)
    return SystemData.PaperdollTexture[toNum(id)]
end