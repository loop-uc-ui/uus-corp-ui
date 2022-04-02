UusCorpWindowDataAdapter = {}

function UusCorpWindowDataAdapter:init()
    setmetatable({}, UusCorpWindowDataAdapter)
    self.data = {}
    return self
end

function UusCorpWindowDataAdapter:addData(type, id)
    self.data[type] = id
end

function UusCorpWindowDataAdapter:register()
    for key, value in pairs(self.data) do
        WindowDataApi.registerData(key, value)
    end
end

function UusCorpWindowDataAdapter:unregister()
    for key, value in pairs(self.data) do
        WindowDataApi.unregisterData(key, value)
    end
    self.data = {}
end