UusCorpObjectHandleWindow = {}
UusCorpObjectHandleWindow.Name = "ObjectHandleWindow"
UusCorpObjectHandleWindow.Label = "Name"

function UusCorpObjectHandleWindow.initialize()
    UusCorpCore.loadResources(
        "/mods/object-handle",
        "UusCorpObjectHandleWindow.xml"
    )

    ObjectHandleWindow.CreateObjectHandles = function ()
        for i = 1, #ObjectHandles.objectId() do
            local id = ObjectHandles.objectId()[i]

            if ObjectApi.isValid(id) then
                WindowApi.createFromTemplate(
                    UusCorpObjectHandleWindow.Name .. id,
                    UusCorpObjectHandleWindow.Name,
                    "Root"
                )
            end
        end
    end

    ObjectHandleWindow.DestroyObjectHandles = function ()
        for i = 1, #ObjectHandles.objectId() do
            local id =  ObjectHandles.objectId()[i]
            if  ObjectApi.isValid(id) then
                WindowApi.destroyWindow(
                    UusCorpObjectHandleWindow.Name .. id
                )
            end
        end
    end
end

function UusCorpObjectHandleWindow.onInitialize()
    local window = Active.window()
    local id = tonumber(string.gsub(window, UusCorpObjectHandleWindow.Name, ""), 10)
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
        window .. UusCorpObjectHandleWindow.Label,
        ObjectHandles.names()[index]
    )

    local notoriety = Colors.Notoriety[ObjectHandles.notoriety()[index]]

    LabelApi.setTextColor(
        window .. UusCorpObjectHandleWindow.Label,
        notoriety or Colors.OffWhite
    )

    WindowApi.attachWIndowToWorldObject(
        id,
        window
    )

    local x, y = WindowApi.getDimensions(
        window .. UusCorpObjectHandleWindow.Label
    )

    WindowApi.setDimensions(
        window,
        x,
        y
    )
end

function UusCorpObjectHandleWindow.onRightClick()
    WindowApi.destroyWindow(Active.window())
end

function UusCorpObjectHandleWindow.onDoubleClick()
    UserActionApi.useItem(
        WindowApi.getId(Active.window()),
        false
    )
end

function UusCorpObjectHandleWindow.onShutdown()
    WindowApi.detachWindowFromWorldObject(
        WindowApi.getId(Active.window()),
        Active.window()
    )
end

function UusCorpObjectHandleWindow.onMouseDrag()
    local id = WindowApi.getId(Active.window())
    if ObjectApi.isMobile(id) then
        Active.setMobile(id)
        EventApi.broadcast(Events.beginHealthBarDrag())
    elseif ObjectApi.isValid(id) then
        DragApi.setObjectMouseClickData(id, Drag.sourceObject())
    end
end