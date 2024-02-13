---@class UusCorpDynamicImage:UusCorpView
UusCorpDynamicImage = UusCorpView:new("UusCorpDynamicImage")

---@param name string
---@return UusCorpDynamicImage
function UusCorpDynamicImage:new(name)
    return UusCorpView.new(self, name) --[[@as UusCorpDynamicImage]]
end

function UusCorpDynamicImage:setTexture(texture, x, y)
    DynamicImageApi.setTexture(self.name, texture, x, y)
end

function UusCorpDynamicImage:setTextureDimensions(x, y)
    DynamicImageApi.setTextureDimensions(self.name, x, y)
end

function UusCorpDynamicImage:setTextureScale(scale)
    DynamicImageApi.setTextureScale(self.name, scale)
end

function UusCorpDynamicImage:setCustomShader(shader, hue)
    DynamicImageApi.setCustomShader(self.name, shader, hue)
end