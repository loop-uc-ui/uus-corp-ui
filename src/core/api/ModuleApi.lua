ModuleApi = {}

function ModuleApi.setEnabled(moduleName, isEnabled)
    ModuleSetEnabled(moduleName, isEnabled)
end

function ModuleApi.initialize(moduleName)
    ModuleInitialize(moduleName)
end

function ModuleApi.getData()
    return ModulesGetData()
end

function ModuleApi.initializeRestricted()
    ModulesInitializeRestricted()
end

function ModuleApi.initializeAllEnabled()
    ModulesInitializeAllEnabled()
end

function ModuleApi.restrictedLoad(modFilePath, allowRaw)
    ModuleRestrictedLoad(modFilePath, allowRaw)
end

function ModuleApi.load(modFilePath, setName, allowRaw)
    ModuleLoad(modFilePath, setName, allowRaw)
end

function ModuleApi.loadFromList(listFilePath, setName, allowRaw)
    ModulesLoadFromListFile(listFilePath, setName, allowRaw)
end

function ModuleApi.loadFromDirectory(directory, setName)
    ModulesLoadFromDirectory(directory, setName)
end