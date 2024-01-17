UusCorpMapMod = {}

function UusCorpMapMod.onInitialize()
    local name = "MapWindow"

    ---The default UI needlessly processes map events
    ---even when it is not visible. Unregistering the data is
    ---easier than destroying the window completely.
    local unregister = function ()
        WindowApi.unregisterCoreEventHandler(name, "OnUpdate")
        WindowDataApi.unregisterData(Radar.type(), 0)
        WindowDataApi.unregisterData(WaypointList.type(), 0)
        WindowDataApi.unregisterData(WaypointDisplay.type(), 0)
        WindowApi.unregisterEventHandler(name, Radar.event())
        WindowApi.unregisterEventHandler(name, WaypointList.event())
    end

    unregister()
    local _window = UusCorpCore.copyTable(MapWindow)

    function MapWindow.OnShown()
        WindowDataApi.registerData(Radar.type(), 0)
        WindowDataApi.registerData(WaypointList.type(), 0)
        WindowDataApi.registerData(WaypointDisplay.type(), 0)
        WindowApi.registerEventHandler(name, Radar.event(), name .. ".UpdateMap")
        WindowApi.registerEventHandler(name, WaypointList.event(), name .. ".UpdateWaypoints")
        WindowApi.registerCoreEventHandler(name, "OnUpdate", name .. ".OnUpdate")
        _window.OnShown()
    end

    function MapWindow.OnHidden()
        _window.OnHidden()
        unregister()
    end
end