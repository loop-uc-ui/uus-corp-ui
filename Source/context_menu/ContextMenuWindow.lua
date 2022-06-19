ContextMenuWindow = {}
ContextMenuWindow.Name = "ContextMenuWindow"
ContextMenuWindow.Data = {}

function ContextMenuWindow.onInitialize()
    if ContextMenu.menu() == nil then
        WindowApi.destroyWindow(Active.window())
    end

    WindowApi.setId(Active.window(), ContextMenu.objectId())

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

    Debug.Print(ContextMenuWindow.Data)
    ListBoxApi.setDisplayOrder(
        Active.window() .. "List",
        order
    )
end

function ContextMenuWindow.onShutdown()
    ContextMenuWindow.Data = {}
end

function ContextMenuWindow.populate(data)
end