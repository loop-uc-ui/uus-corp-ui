WindowDataApi = {}

function WindowDataApi.registerData(data, id)
    RegisterWindowData(data, id)
end

function WindowDataApi.registerData(data)
    WindowDataApi.registerData(data, 0)
end

function WindowDataApi.unregisterData(data, id)
    UnregisterWindowData(data, id)
end

function WindowDataApi.unregisterData(data)
    WindowDataApi.unregisterData(data, 0)
end
