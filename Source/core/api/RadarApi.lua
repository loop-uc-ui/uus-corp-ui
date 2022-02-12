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

function RadarApi.getCenterOnPlayer(isCenter)
    UORadarSetCenterOnPlayer(isCenter)
end

function RadarApi.getPhysicalRadarFacet()
    --TODO determine proper args
    return UOGetPhysicalRadarFacet()
end

function RadarApi.getAreaDimensions()
    --TODO determine proper args
    return UORadarGetAreaDimensions()
end

function RadarApi.getFacetLabel()
    --TODO determine proper args
    return UORadarGetFacetLabel(facet)
end

function RadarApi.getAreaLabel()
    --TODO determine proper args
    return UORadarGetAreaLabel()
end

function RadarApi.getFacetDimensions()
    --TODO determine proper args
    return UORadarGetFacetDimensions()
end

function RadarApi.getCenter()
    return UOGetRadarCenter()
end
