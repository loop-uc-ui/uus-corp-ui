Drag = {}

function Drag.type()
    return SystemData.DragItem.DragType
end

function Drag.source()
    return SystemData.DragSource
end

function Drag.isItem()
    return Drag.type() == SystemData.DragItem.TYPE_ITEM
end

function Drag.isNone()
    return Drag.type() == SystemData.DragItem.TYPE_NONE
end

function Drag.sourcePaperdoll()
    return Drag.source().SOURCETYPE_PAPERDOLL
end

function Drag.item()
    return SystemData.DragItem
end

function Drag.itemWidth()
    return Drag.item().itemWidth
end

function Drag.itemHeight()
    return Drag.item().itemHeight
end

function Drag.itemName()
    return Drag.item().itemName
end

function Drag.itemScale()
    return Drag.item().itemScale
end

function Drag.itemHueId()
    return Drag.item().itemHueId
end

function Drag.itemHue()
    return Drag.item().itemHue
end

function Drag.itemType()
    return Drag.item().itemType
end

function Drag.itemAmount()
    return Drag.item().DragAmount
end