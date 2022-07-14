ContextMenu = {}

function ContextMenu.menu()
    return WindowData.ContextMenu
end

function ContextMenu.hideMenu()
    return ContextMenu.menu().hideMenu
end

function ContextMenu.returnCode()
    return ContextMenu.menu().returnCode
end

function ContextMenu.objectId()
    return ContextMenu.menu().objectId
end

function ContextMenu.items()
    return ContextMenu.menu().menuItems
end

function ContextMenu.itemFlags(index)
    return ContextMenu.items()[index].flags
end

function ContextMenu.itemTextId(index)
    return ContextMenu.items()[index].tid
end

function ContextMenu.itemReturnCode(index)
    return ContextMenu.items()[index].returnCode
end

function ContextMenu.setReturnCode(returnCode)
    WindowData.ContextMenu.returnCode = returnCode
end