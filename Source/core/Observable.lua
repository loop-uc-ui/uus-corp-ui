-- function UusCorp.observable(onChange, object)
--     local protectedTable = {}
--     local table = {}

--     table.__index = function (_, k)
--         return protectedTable[k]
--     end

--     table.__newindex = function (_, k, v)
--         protectedTable[k] = v
--         onChange(k, v)
--     end

--     table.__pairs = function (_)
--         return next, protectedTable, nil
--     end

--     return setmetatable({}, table)
-- end