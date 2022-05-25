ContainerWindow = {}
ContainerWindow.Name = "ContainerWindow_"

function ContainerWindow.Initalize()
    local id = Active.dynamicWindowId()
    local window = ContainerWindow.Name .. id
    WindowApi.setId(window, id)
    WindowApi.registerEventHandler(window, Container.event(), "ContainerWindow.updateContainer")
    WindowApi.registerEventHandler(window, ObjectInfo.event(), "ContainerWindow.updateObject")
    WindowDataApi.registerData(Container.type(), id)
    Debug.Print("test")
end

function ContainerWindow.updateContainer()
    
end

function ContainerWindow.updateObject()

end