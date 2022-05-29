ObjectInfo = {}

function ObjectInfo.event()
    return WindowData.ObjectInfo.Event
end

function ObjectInfo.type()
    return WindowData.ObjectInfo.Type
end

function ObjectInfo.info(id)
    return WindowData.ObjectInfo[id]
end

function ObjectInfo.newWidth(id)
    return ObjectInfo.info(id).newWidth
end

function ObjectInfo.newHeight(id)
    return ObjectInfo.info(id).newHeight
end

function ObjectInfo.iconId(id)
    return ObjectInfo.info(id).iconId
end

function ObjectInfo.iconName(id)
    return ObjectInfo.info(id).iconName
end

function ObjectInfo.iconScale(id)
    return ObjectInfo.info(id).iconScale
end

function ObjectInfo.hue(id)
    return ObjectInfo.info(id).hue
end

function ObjectInfo.quantity(id)
    return ObjectInfo.info(id).quantity
end

function ObjectInfo.shopQuantity(id)
    return ObjectInfo.info(id).shopQuantity
end

function ObjectInfo.containerId(id)
    return ObjectInfo.info(id).containerId
end

function ObjectInfo.hueId(id)
    return ObjectInfo.info(id).hueId
end

function ObjectInfo.name(id)
    return ObjectInfo.info(id).name
end

function ObjectInfo.shopName(id)
    return ObjectInfo.info(id).shopName
end

function ObjectInfo.objectType(id)
    return ObjectInfo.info(id).objectType
end

function ObjectInfo.shopValue(id)
    return ObjectInfo.info(id).shopValue
end