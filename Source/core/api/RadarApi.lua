RadarApi = {}

function RadarApi.setWindowSize(sizeX, sizeY, boolOne, boolTwo)
    UORadarSetWindowSize(sizeX, sizeY, boolOne, boolTwo)
end

function RadarApi.getFacet()
    return UOGetRadarFacet()
end

function RadarApi.getArea()
    return UOGetRadarArea()
end

