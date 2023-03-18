IconApi = {}

function IconApi.getIconData(textureId)
    return GetIconData(textureId)
end

function IconApi.getTextureSize(textureId)
    return UOGetTextureSize(textureId)
end

function IconApi.requestTileArt(type, width, height)
    return RequestTileArt(type, width, height)
end