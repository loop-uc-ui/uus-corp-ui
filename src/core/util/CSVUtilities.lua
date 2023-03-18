CSVUtilities = {}

local DATA = {
    BUFFS = {
        PATH = "Data/GameData/buffdata.csv",
        NAME = "BuffDataCSV"
    },
    SKILLS = {
        PATH = "data/gamedata/skilldata.csv",
        NAME = "SkillsCSV"
    },
    PLAYER_STATS = {
        PATH = "Data/GameData/playerstats.csv",
        NAME = "PlayerStatsDataCSV"
    }
}

function CSVUtilities.initialize()
    for _, v in pairs(DATA) do
        CSVApi.buildTable(
            v.PATH,
            v.NAME
        )
    end
end

function CSVUtilities.shutdown()
    for _, v in pairs(DATA) do
        CSVApi.unloadCSV(
            v.NAME
        )
    end
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
