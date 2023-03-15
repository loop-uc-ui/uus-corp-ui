CSVApi = {}

function CSVApi.buildTable(path, name)
    UOBuildTableFromCSV(path, name)
end

function CSVApi.unloadCSV(name)
    UOUnloadCSVTable(name)
end