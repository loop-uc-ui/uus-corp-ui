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

function ContextMenuWindow.onInitialize()
end

function ContextMenuWindow.onShown()
    local order = {}

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
end

function ContextMenuWindow.onHidden()
    ContextMenuWindow.Data = {}
end

function ContextMenuWindow.populate(data)
    for i = 1, #data do
        local item = ContextMenuWindow.List .. "Row" .. i
        WindowApi.setId(item, i)
    end
end

function ContextMenuWindow.onItemClick()
    ContextMenu.setReturnCode(
        ContextMenu.itemReturnCode(
            WindowApi.getId(Active.window())
        )
    )
    EventApi.broadcast(Events.contextMenuSelected())
    WindowApi.setShowing(ContextMenuWindow.Name, false)
end