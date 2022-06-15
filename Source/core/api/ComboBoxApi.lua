ComboBoxApi = {}

function ComboBoxApi.addItem(id, item)
    if item == nil then
        return
    elseif type(item) == "number" then
        item = StringFormatter.fromTid(item)
    elseif type(item) == "string" then
        item = StringFormatter.toWString(item)
    end

    ComboBoxAddMenuItem(id, item)
end

function ComboBoxApi.clearItems(id)
    ComboBoxClearMenuItems(id)
end

function ComboBoxApi.setSelectedItem(id, item)
    ComboBoxSetSelectedMenuItem(id, item)
end

function ComboBoxApi.getSelectedItem(id)
    return ComboBoxGetSelectedMenuItem(id)
end