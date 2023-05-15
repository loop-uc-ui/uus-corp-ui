ItemPropertiesData = {}

function ItemPropertiesData.type()
    return WindowData.ItemProperties.Type
end

function ItemPropertiesData.event()
    return WindowData.ItemProperties.Event
end

function ItemPropertiesData.properties(id)
    return WindowData.ItemProperties[id]
end

function ItemPropertiesData.propertiesTidsParams(id)
    return ItemPropertiesData.properties(id).PropertiesTidsParams
end

function ItemPropertiesData.currentDurability(id)
    return ItemPropertiesData.propertiesTidsParams(id)[16]
end

function ItemPropertiesData.maxDurability(id)
    return ItemPropertiesData.propertiesTidsParams(id)[17]
end

function ItemPropertiesData.propertiesList(id)
    if id == 0 or id == nil then
        return nil
    else
        return ItemPropertiesData.properties(id).PropertiesList
    end
end

function ItemPropertiesData.tyepItem()
    return WindowData.ItemProperties.TYPE_ITEM
end

function ItemPropertiesData.typeWString()
    return WindowData.ItemProperties.TYPE_WSTRINGDATA
end

function ItemPropertiesData.detailLong()
    return ItemProperties.DETAIL_LONG
end

function ItemPropertiesData.setActiveItem(itemData)
    ItemProperties.SetActiveItem(itemData)
end

function ItemPropertiesData.clearActiveItem()
    ItemProperties.ClearMouseOverItem()
end