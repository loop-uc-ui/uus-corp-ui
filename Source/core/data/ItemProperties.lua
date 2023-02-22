ItemProperties = {}

function ItemProperties.type()
    return WindowData.ItemProperties.Type
end

function ItemProperties.event()
    return WindowData.ItemProperties.Event
end

function ItemProperties.properties(id)
    return WindowData.ItemProperties[id]
end

function ItemProperties.propertiesTidsParams(id)
    return ItemProperties.properties(id).PropertiesTidsParams
end

function ItemProperties.currentDurability(id)
    return ItemProperties.propertiesTidsParams(id)[16]
end

function ItemProperties.maxDurability(id)
    return ItemProperties.propertiesTidsParams(id)[17]
end

function ItemProperties.propertiesList(id)
    if id == 0 or id == nil then
        return nil
    else
        return ItemProperties.properties(id).PropertiesList
    end
end