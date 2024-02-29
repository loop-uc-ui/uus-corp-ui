---@class UusCorpDynamicImageModel:UusCorpViewModel
local UusCorpDynamicImageModel = {
    name = "",
    data = {},
    events = {}
}

---@class UusCorpDynamicImage:UusCorpView
UusCorpDynamicImage = UusCorpView:new(UusCorpDynamicImageModel)

---@param model UusCorpDynamicImageModel
---@return UusCorpDynamicImage
function UusCorpDynamicImage:new(model)
    return UusCorpView.new(self, model) --[[@as UusCorpDynamicImage]]
end

function UusCorpDynamicImage:setTexture(texture, x, y)
    DynamicImageApi.setTexture(self:getName(), texture, x, y)
end

function UusCorpDynamicImage:setTextureDimensions(x, y)
    DynamicImageApi.setTextureDimensions(self:getName(), x, y)
end

function UusCorpDynamicImage:setTextureScale(scale)
    DynamicImageApi.setTextureScale(self:getName(), scale)
end

function UusCorpDynamicImage:setCustomShader(shader, hue)
    DynamicImageApi.setCustomShader(self:getName(), shader, hue)
end