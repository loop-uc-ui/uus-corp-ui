---@class UusCorpGameObject
---@field id number
UusCorpGameObject = {}

---@param id number
---@return UusCorpGameObject
function UusCorpGameObject:new(id)
    local object = { id = id }
    setmetatable(object, self)
    self.__index = self
    return object
end

---@return UusCorpObjectInfo
function UusCorpGameObject:info()
    return UusCorpObjectInfo(self.id)
end

---@return UusCorpContainer
function UusCorpGameObject:container()
    return UusCorpContainer(self.id)
end