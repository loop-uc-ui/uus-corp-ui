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