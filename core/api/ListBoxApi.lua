ListBoxApi = {}

function ListBoxApi.setDataTable(name, data)
    ListBoxSetDataTable(name, data)
end

function ListBoxApi.getDataIndex(name, rowIndex)
    return ListBoxGetDataIndex(name, rowIndex)
end

function ListBoxApi.setDisplayOrder(name, orderArray)
    ListBoxSetDisplayOrder(name, orderArray)
end

function ListBoxApi.setVisibleRowCount(name, count)
    ListBoxSetVisibleRowCount(name, count)
end