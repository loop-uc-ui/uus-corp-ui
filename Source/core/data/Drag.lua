Drag = {}

function Drag.type()
    return SystemData.DragItem.DragType
end

function Drag.isItem()
    return Drag.type() == SystemData.DragItem.TYPE_ITEM
end

function Drag.isNone()
    return Drag.type() == SystemData.DragItem.TYPE_NONE
end