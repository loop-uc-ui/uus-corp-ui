WindowDataApi = {}

function WindowDataApi.registerData(data, id)
    id = id or 0
    RegisterWindowData(data, id)
end

function WindowDataApi.unregisterData(data, id)
    id = id or 0
    UnregisterWindowData(data, id)
end
