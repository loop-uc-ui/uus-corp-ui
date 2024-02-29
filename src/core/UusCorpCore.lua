UusCorpCore = {}

---@type table<string, fun(activeWindow: string, id: number): UusCorpView>
UusCorpCore.Windows = {}

function UusCorpCore.initialize()
    UusCorpCore.loadResources("/src/core/template", "ItemGridSocketTemplate.xml")
    UusCorpCore.loadResources("/src/core/textures", "UusCorpTextures.xml")
    UusCorpCore.loadResources("/src/core/template", "SimpleWindowFrame.xml")
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

---@param name string
---@param view fun(activeWindow: string, id: number): UusCorpView
function UusCorpCore.registerWindow(name, view)
    UusCorpCore.Windows[name] = view
end

UusCorpCore.registerWindow(
    "name",
    function (activeWindow, id)
        return UusCorpWindow:new {
            name = activeWindow,
            data = {
                UusCorpViewDataFactory.container(0)
            },
            event = {
                UusCorpEventFactory.container()
            },
            children = {}
        }
    end
)