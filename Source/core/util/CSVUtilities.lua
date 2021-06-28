CSVUtilities = {}

local BUFFS = {
    PATH = "Data/GameData/buffdata.csv",
    NAME = "BuffDataCSV"
}

function CSVUtilities.initialize()
    CSVApi.buildTable(BUFFS.PATH, BUFFS.NAME)
end

function CSVUtilities.shutdown()
    CSVApi.unloadCSV(BUFFS.NAME)
end

function CSVUtilities.getNumRows(CSVTable)
    if not CSVTable then
        return 0
    else
        local numRows = 0
        for _, _ in pairs(CSVTable) do
            numRows = numRows + 1
        end
        return numRows
    end
end

function CSVUtilities.getRowIdWithColumnValue(CSVTable, columnName, columnValue)
    local rows = CSVUtilities.getNumRows(CSVTable)
    for rowNum = 1, rows do
        if (CSVTable[rowNum][columnName] == columnValue) then
            return rowNum
        end
    end

    return nil
end
