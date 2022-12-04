ObjectHandleWindow = {}
ObjectHandleWindow.Name = "ObjectHandleWindow"
ObjectHandleWindow.Label = "Name"

function ObjectHandleWindow.onInitialize()
    local window = Active.window()
    local id = tonumber(string.gsub(window, ObjectHandleWindow.Name, ""), 10)
    WindowApi.setId(window, id)

    local index = 0

    for i = 1, #ObjectHandles.objectId() do
        local objectId = ObjectHandles.objectId()[i]
        if objectId == id then
            index = i
            break
        end
    end

    LabelApi.setText(
        window .. ObjectHandleWindow.Label,
        ObjectHandles.names()[index]
    )

    local notoriety = Colors.Notoriety[ObjectHandles.notoriety()[index]]

    LabelApi.setTextColor(
        window .. ObjectHandleWindow.Label,
        notoriety or Colors.OffWhite
    )

    WindowApi.attachWIndowToWorldObject(
        id,
        window
    )

    local x, y = WindowApi.getDimensions(
        window .. ObjectHandleWindow.Label
    )

    WindowApi.setDimensions(
        window,
        x,
        y
    )
end

function ObjectHandleWindow.onRightClick()
    WindowApi.destroyWindow(Active.window())
end

function ObjectHandleWindow.onDoubleClick()
    UserActionApi.useItem(
        WindowApi.getId(Active.window()),
        false
    )
end

function ObjectHandleWindow.onShutdown()
    WindowApi.detachWindowFromWorldObject(
        WindowApi.getId(Active.window()),
        Active.window()
    )
end

function ObjectHandleWindow.onMouseDrag()
    local id = WindowApi.getId(Active.window())
    if ObjectApi.isMobile(id) then
        Active.setMobile(id)
        EventApi.broadcast(Events.beginHealthBarDrag())
    elseif ObjectApi.isValid(id) then
        DragApi.setObjectMouseClickData(id, Drag.sourceObject())
    end
end