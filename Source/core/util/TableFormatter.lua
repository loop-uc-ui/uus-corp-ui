TableFormatter = {}

function TableFormatter.sortArray(array)
    table.sort(array)
    return array
end

function TableFormatter.getKeys(thisTable)
    local array = {}
    for n in pairs(thisTable) do
        table.insert(array, n)
    end
    return array
end

function TableFormatter.getValues(thisTable)
    local array = {}
    for _, v in pairs(thisTable) do
        table.insert(array, v)
    end
    return array
end

function TableFormatter:sortTable(thisTable)
    local keys = self.sortArray(self.getKeys(thisTable))
    local newTable = {}
    for i = 1, #keys do
        newTable[i] = {
            key = keys[i],
            value = thisTable[keys[i]]
        }
    end
    return newTable
end

function TableFormatter.indexOf(table, item)
    for key, value in pairs(table) do
        if value == item then
            return key
        end
    end
    return -1
end