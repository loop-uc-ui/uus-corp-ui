ContainerWindow = {}
ContainerWindow.Name = "ContainerWindow_"

function ContainerWindow.Initialize()
    local id = Active.dynamicWindowId()
    local window = ContainerWindow.Name .. id
    WindowApi.setId(window, id)
    WindowApi.registerEventHandler(window, Container.event(), "ContainerWindow.updateContainer")
    WindowApi.registerEventHandler(window, ObjectInfo.event(), "ContainerWindow.updateObject")
    WindowDataApi.registerData(Container.type(), id)
end

function ContainerWindow.updateContainer()
    
end

function ContainerWindow.updateObject()

end

function ContainerWindow.onRightClick()
    WindowApi.destroyWindow(Active.window())
end