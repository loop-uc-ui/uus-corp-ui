ComboBoxApi = {}

function ComboBoxApi.addItem(id, item)
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