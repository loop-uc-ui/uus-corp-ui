ItemProperties = {}

function ItemProperties.type()
    return WindowData.ItemProperties.Type
end

function ItemProperties.event()
    return WindowData.ItemProperties.Event
end

function ItemProperties.propertiesTidsParams(id)
    return WindowData.ItemProperties[id].PropertiesTidsParams
end

function ItemProperties.currentDurability(id)
    return ItemProperties.propertiesTidsParams(id)[16]
end

function ItemProperties.maxDurability(id)
    return ItemProperties.propertiesTidsParams(id)[17]
end