UusCorpCore = {}

function UusCorpCore.initialize()
    UusCorpCore.loadResources("/core/template", "ItemGridSocketTemplate.xml")
end

function UusCorpCore.loadResources(path, file)
    ResourceApi.loadResources(
        "Data/Interface/Default/uus-corp-ui" .. path,
        SystemData.Directories.Interface .. "/" .. SystemData.Settings.Interface.customUiName .. path,
        file
    )
end

function UusCorpCore.overrideFunctions(table)
    for _, v in pairs(table) do
        if type(v) == "function" then
            v = function () end
        end
    end
end