WaypointApi = {}

function WaypointApi.setWaypointFacet(facet)
    UOSetWaypointMapFacet(facet)
end

function WaypointApi.createWaypoint(type, facet, x, y, id)
    UOCreateUserWaypoint(type, facet, x, y, id)
end

function WaypointApi.deleteWaypoint(id)
    UODeleteUserWaypoint(id)
end

function WaypointApi.editWaypoint(id)
    --TODO determine proper args
    UOEditUserWaypoint(id)
end

function WaypointApi.resetMapFacet()
    --TODO determine proper args
    UOResetWaypointMapFacet()
end

function WaypointApi.setWaypointTypeDisplayInfo()
    --TODO determine proper args
    UOSetWaypointTypeDisplayInfo()
end

function WaypointApi.setWaypointDisplayMode(mode)
    UOSetWaypointDisplayMode(mode)
end

function WaypointApi.getWaypointInfo(id)
    return UOGetWaypointInfo(id)
end
