ObjectApi = {}

function ObjectApi.getDistanceFromPlayer(id)
    return GetDistanceFromPlayer(id)
end

function ObjectApi.isValid(id)
    return IsValidObject(id)
end

function ObjectApi.fromPaperdoll(paperdollId, scale)
    return GetPaperdollObject(paperdollId, scale or 1.0)
end