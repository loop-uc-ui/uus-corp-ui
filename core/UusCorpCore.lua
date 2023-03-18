UusCorpCore = {}

function UusCorpCore.initialize()
    UusCorpCore.loadResources("/core/template", "ItemGridSocketTemplate.xml")
    UusCorpCore.loadResources("/core/textures", "UusCorpTextures.xml")
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