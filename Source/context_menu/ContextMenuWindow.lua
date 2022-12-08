--[[
    The client is doing some behind-the-scenes magic.
    On clicking any object, it sets a window with name "ContextMenu"
    visibility to true. There is no need to do any extra
    event registration.
]]--
ContextMenuWindow = {}

ContextMenuWindow.Name = "ContextMenu"

ContextMenuWindow.List = ContextMenuWindow.Name .. "List"

ContextMenuWindow.Data = {}

ContextMenuWindow.IsHardcoded = false

function ContextMenuWindow.create(data)
    ContextMenuWindow.Data = data
    ContextMenuWindow.IsHardcoded = true
    WindowApi.setShowing(ContextMenuWindow.Name, true)
end

function ContextMenuWindow.onInitialize()
end

function ContextMenuWindow.onShown()
    local order = {}

    if not ContextMenuWindow.IsHardcoded then
        for i = 1, #ContextMenu.items() do
            table.insert(
                order,
                i
            )

            table.insert(
                ContextMenuWindow.Data,
                {
                    text = StringFormatter.fromTid(
                        ContextMenu.itemTextId(i)
                    )
                }
            )
        end
    else
        for i = 1, #ContextMenuWindow.Data do
            table.insert(
                order,
                i
            )
        end
    end

    ListBoxApi.setVisibleRowCount(
        ContextMenuWindow.List,
        #order
    )

    ListBoxApi.setDisplayOrder(
        ContextMenuWindow.List,
        order
    )

    local x, _ = WindowApi.getDimensions(
        Active.window()
    )

    WindowApi.setDimensions(
        ContextMenuWindow.Name,
        x,
        #order * 25
    )

    WindowApi.setDimensions(
        ContextMenuWindow.List,
        x,
        #order * 25
    )

    WindowApi.setOffsetFromParent(
        Active.window(),
        MousePosition.x(),
        MousePosition.y()
    )
end

function ContextMenuWindow.onShutdown()
    ContextMenuWindow.Data = {}
    ContextMenuWindow.IsHardcoded = false
end

function ContextMenuWindow.onHidden()
    ContextMenuWindow.Data = {}
    ContextMenuWindow.IsHardcoded = false
end

function ContextMenuWindow.populate(data)
    for i = 1, #data do
        local item = ContextMenuWindow.List .. "Row" .. i
        WindowApi.setId(item, i)
    end
end

function ContextMenuWindow.onItemClick()
    if ContextMenuWindow.IsHardcoded then
        ContextMenuWindow.Data[WindowApi.getId(Active.window())].onClick()
    else
        ContextMenu.setReturnCode(
            ContextMenu.itemReturnCode(
                WindowApi.getId(Active.window())
            )
        )
        EventApi.broadcast(Events.contextMenuSelected())
    end
    WindowApi.setShowing(ContextMenuWindow.Name, false)
end