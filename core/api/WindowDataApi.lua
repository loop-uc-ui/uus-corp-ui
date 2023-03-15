WindowDataApi = {}

function WindowDataApi.registerData(data, id)
    RegisterWindowData(data, id or 0)
end

function WindowDataApi.unregisterData(data, id)
    UnregisterWindowData(data, id or 0)
end
