SliderApi = {}

function SliderApi.setPosition(id, position)
    SliderBarSetCurrentPosition(id, position)
end

function SliderApi.getPosition(id)
    return SliderBarGetCurrentPosition(id)
end