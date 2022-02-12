RadarApi = {}

function RadarApi.setWindowSize(sizeX, sizeY, boolOne, boolTwo)
    UORadarSetWindowSize(sizeX, sizeY, boolOne, boolTwo)
end

function RadarApi.setRotation(rotation)
    UOSetRadarRotation(rotation)
end