UusCorpCore = {}

function UusCorpCore.initialize()
    UusCorpCore.loadResources("/src/core/template", "ItemGridSocketTemplate.xml")
    UusCorpCore.loadResources("/src/core/textures", "UusCorpTextures.xml")
end

function UusCorpCore.loadResources(path, file)
    ResourceApi.loadResources(
        "Data/Interface/Default/uus-corp-ui" .. path,
        SystemData.Directories.Interface .. "/" .. SystemData.Settings.Interface.customUiName .. path,
        file
    )
end

function UusCorpCore.overrideFunctions(table)
    for k, v in pairs(table) do
        if type(v) == "function" then
            table[k] = function () end
        end
    end
end

function UusCorpCore.copyTable(table)
    local newTable = {}
    for k, v in pairs(table) do
        newTable[k] = v
    end
    return newTable
end