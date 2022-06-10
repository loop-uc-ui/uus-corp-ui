PlayerEquipment = {}

PlayerEquipment.Slots = {
    Drag = 0,
    RightHand = 1,
    LeftHand = 2,
    Feet = 3,
    Legs = 4,
    Torso = 5, --shirt
    Head = 6,
    Hands = 7,
    Finger = 8,
    Talisman = 9,
    Neck = 10,
    Hair = 11,
    Waist = 12,
    Chest = 13,
    LeftWrist = 14,
    RightWrist = 15,
    FacialHair = 16,
    AboveChest = 17,
    Ears = 18,
    Arms = 19,
    Cape = 20,
    Backpack = 21,
    Dress = 22,
    Skirt = 23,
    FeetLegs = 24,
    Riding = 25,
    Max = 26,
    Sells = 26, --not sure why this is duplicated
    Invent = 27,
    Buys = 28,
    Bank = 29,
    ShopMax = 30
}

function PlayerEquipment.type()
    return WindowData.PlayerEquipmentSlot.Type
end

function PlayerEquipment.event()
    return WindowData.PlayerEquipmentSlot.Event
end

function PlayerEquipment.slotId(slot)
    return WindowData.PlayerEquipmentSlot[slot].objectId
end