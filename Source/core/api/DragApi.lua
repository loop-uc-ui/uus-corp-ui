DragApi = {}

function DragApi.dragToObject(id)
    DragSlotDropObjectToObject(id)
end

function DragApi.setActionMouseClickData(userAction, actionId, iconId)
    DragSlotSetActionMouseClickData(
            userAction,
            actionId,
            iconId
    )
end

function DragApi.setObjectMouseClickData(objectId, dragSource)
    DragSlotSetObjectMouseClickData(objectId, dragSource)
end

function DragApi.dropEquipmentOnPaperdoll(objectId)
    DragSlotDropObjectToPaperdollEquipment(objectId)
end

function DragApi.dropObjectOnPaperdoll(paperdollId)
    DragSlotDropObjectToPaperdoll(paperdollId)
end