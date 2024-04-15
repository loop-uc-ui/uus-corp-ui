---@class UusCorpDynamicImage:UusCorpView
UusCorpDynamicImage = UusCorpView:new {
    name = "UusCorpDynamicImage"
}

---@param model UusCorpDynamicImage
---@return UusCorpDynamicImage
function UusCorpDynamicImage:new(model)
    return UusCorpView.new(self, model) --[[@as UusCorpDynamicImage]]
end

function UusCorpDynamicImage:setTexture(texture, x, y)
    UusCorp.Api.DynamicImage.SetTexture(self.name, texture, x, y)
end

function UusCorpDynamicImage:setTextureDimensions(x, y)
    UusCorp.Api.DynamicImage.SetTextureDimensions(self.name, x, y)
end

function UusCorpDynamicImage:setTextureScale(scale)
    UusCorp.Api.DynamicImage.SetTextureScale(self.name, scale)
end

function UusCorpDynamicImage:setCustomShader(shader, hue)
    UusCorp.Api.DynamicImage.SetCustomShader(self.name, shader, hue)
end