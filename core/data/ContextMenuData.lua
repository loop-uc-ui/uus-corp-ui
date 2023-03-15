ContextMenuData = {}

function ContextMenuData.menu()
    return WindowData.ContextMenu
end

function ContextMenuData.hideMenu()
    return ContextMenuData.menu().hideMenu
end

function ContextMenuData.returnCode()
    return ContextMenuData.menu().returnCode
end

function ContextMenuData.objectId()
    return ContextMenuData.menu().objectId
end

function ContextMenuData.items()
    return ContextMenuData.menu().menuItems
end

function ContextMenuData.itemFlags(index)
    return ContextMenuData.items()[index].flags
end

function ContextMenuData.itemTextId(index)
    return ContextMenuData.items()[index].tid
end

function ContextMenuData.itemReturnCode(index)
    return ContextMenuData.items()[index].returnCode
end

function ContextMenuData.setReturnCode(returnCode)
    WindowData.ContextMenu.returnCode = returnCode
end