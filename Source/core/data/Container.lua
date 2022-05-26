Container = {}

function Container.event()
    return WindowData.ContainerWindow.Event
end

function Container.type()
    return WindowData.ContainerWindow.Type
end

function Container.data(id)
    return WindowData.ContainerWindow[id]
end

function Container.items(id)
    return Container.data(id).ContainedItems
end

function Container.itemCount(id)
    return Container.data(id).numItems
end

function Container.slots(id)
    return Container.data(id).numCreatedSlots or 1
end