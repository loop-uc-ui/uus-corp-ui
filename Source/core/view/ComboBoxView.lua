ComboBoxView = {}
ComboBoxView.__index = ComboBoxView

function ComboBoxView:new(id)
    local this = {
        id = id,
        items = {}
    }
    setmetatable(this, self)
    return this
end

function ComboBoxView:setItems(items)
    for i = 1, #items do
        local option = items[i]
        if type(option) ~= "string" and type(option) ~= "wstring" then
            option = StringFormatter.fromTid(option)
        end
        self.items[i] = option
        ComboBoxAddMenuItem(self.id, option)
    end
end

function ComboBoxView:clearItems()
    ComboBoxClearMenuItems(self.id)
end

function ComboBoxView:setSelectedItem(item)
    ComboBoxSetSelectedMenuItem(self.id, item)
end

function ComboBoxView:getSelectedItem()
    return ComboBoxGetSelectedMenuItem(self.id)
end