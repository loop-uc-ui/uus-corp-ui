RadarApi = {}

function RadarApi.setWindowSize(sizeX, sizeY, boolOne, centerOnPlayer)
    UORadarSetWindowSize(sizeX, sizeY, boolOne, centerOnPlayer)
end

function RadarApi.getFacet()
    return UOGetRadarFacet()
end

function RadarApi.getArea()
    return UOGetRadarArea()
end

function RadarApi.setOffset(offsetX, offsetY)
    UORadarSetWindowOffset(offsetX, offsetY)
end

function RadarApi.getMaxZoom(facet, area)
    return UORadarGetMaxZoomForMap(facet, area)
end

function RadarApi.setZoom(zoom)
    UOSetRadarZoom(zoom)
end

function RadarApi.setCenterOnPlayer(isCenter)
    UORadarSetCenterOnPlayer(isCenter)
end

function RadarApi.getPhysicalRadarFacet()
    --TODO determine proper args
    return UOGetPhysicalRadarFacet()
end

function RadarApi.getAreaDimensions(facet, area)
    return UORadarGetAreaDimensions(facet, area)
end

function RadarApi.getFacetLabel(facet)
    return UORadarGetFacetLabel(facet)
end

function RadarApi.getAreaLabel(facet, area)
    return UORadarGetAreaLabel(facet, area)
end

function RadarApi.getFacetDimensions(num)
    --TODO determine proper args
    return UORadarGetFacetDimensions(num)
end

function RadarApi.getCenter()
    return UOGetRadarCenter()
end

function RadarApi.setRotation(rotation)
    UOSetRadarRotation(rotation)
end

function RadarApi.centerOnLocation(x, y, facet, area, bool)
    UOCenterRadarOnLocation(x, y, facet, area, bool)
end

function RadarApi.isLocationInArea(x, y, facet, area)
    return UORadarIsLocationInArea(x, y, facet, area)
end

function RadarApi.worldPosToRadar(x, y)
    return UOGetWorldPosToRadar(x, y)
end

function RadarApi.radarPosToWorld(offsetX, offsetY, useScale)
    return UOGetRadarPosToWorld(offsetX, offsetY, useScale)
end

function RadarApi.getAreaCount(facet)
    return UORadarGetAreaCount(facet)
end
