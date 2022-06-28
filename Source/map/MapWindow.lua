MapWindow = {}

MapWindow.Name = "MapWindow"

function MapWindow.onInitialize()

end

function MapWindow.onShutdown()

end

function MapWindow.onRightClick()
    WindowApi.destroyWindow(MapWindow.Name)
end