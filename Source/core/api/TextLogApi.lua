TextLogApi = {}

function TextLogApi.createTextLog(name, num)
    TextLogCreate(name, num)
end

function TextLogApi.destroyTextLog(name)
    TextLogDestroy(name)
end

function TextLogApi.enableLog(name, isEnable)
    TextLogSetEnabled(name, isEnable == nil or isEnable)
end

function TextLogApi.clearLog(name)
    TextLogClear(name)
end

function TextLogApi.setIncrementalSaving(name, doSave, path)
    TextLogSetIncrementalSaving(name, doSave, path)
end

function TextLogApi.getEnabled(name)
    return TextLogGetEnabled(name)
end