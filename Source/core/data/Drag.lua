Drag = {}

function Drag.type()
    return SystemData.DragItem.DragType
end

function Drag.isItem()
    return Drag.type() == SystemData.DragItem.TYPE_ITEM
end