ObjectHandleWindow = {}
ObjectHandleWindow.Name = "ObjectHandleWindow"

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
        window .. "Name",
        ObjectHandles.names()[index]
    )

    WindowApi.attachWIndowToWorldObject(
        id,
        window
    )

    local x, y = WindowApi.getDimensions(
        window .. "Name"
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