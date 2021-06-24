DynamicImageApi = {}

function DynamicImageApi.setTexture(dynamicImageName, texture, x, y)
    DynamicImageSetTexture(dynamicImageName, texture, x, y)
end

function DynamicImageApi.setTextureScale(dynamicImageName, textureScale)
    DynamicImageSetTextureScale(dynamicImageName, textureScale)
end

function DynamicImageApi.setTextureDimensions(dynamicImageName, x, y)
    DynamicImageSetTextureDimensions(dynamicImageName, x, y)
end

function DynamicImageApi.setTextureOrientation(dynamicImageName, mirrored)
    DynamicImageSetTextureOrientation(dynamicImageName, mirrored)
end

function DynamicImageApi.setTextureSlice(dynamicImageName, sliceName)
    DynamicImageSetTextureSlice(dynamicImageName, sliceName)
end

function DynamicImageApi.setRotation(dynamicImageName, rotation)
    DynamicImageSetRotation(dynamicImageName, rotation)
end

function DynamicImageApi.hasTexture(dynamicImageName)
    return DynamicImageHasTexture(dynamicImageName)
end