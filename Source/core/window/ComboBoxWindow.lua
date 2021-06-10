ComboBoxWindow = BaseWindow:new()

function ComboBoxWindow:new(id)
    local this = {
        id = id,
        items = {}
    }
    self.__index = self
    return setmetatable(this, self)
end

function ComboBoxWindow:setItems(items)
    for _, value in pairs(items) do
        local option = value
        if type(option) == "number" then
            option = StringFormatter.fromTid(option)
        elseif type(option) == "string" then
            option = StringFormatter.toWString(option)
        end
        table.insert(self.items, option)
        ComboBoxApi.addItem(self.id, option)
    end
end

function ComboBoxWindow:clearItems()
    self.items = {}
    ComboBoxApi.clearItems(self.id)
end

function ComboBoxWindow:setSelectedItem(item)
    ComboBoxApi.setSelectedItem(self.id, item)
end

function ComboBoxWindow:findItem(find)
    for i = 1, #self.items do
        if find(self, self.items[i]) then
            self:setSelectedItem(i)
            break;
        end
    end
end

function ComboBoxWindow:getSelectedItem()
    return ComboBoxApi.getSelectedItem(self.id)
end