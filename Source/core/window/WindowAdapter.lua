WindowAdapter = {}

function WindowAdapter:new(id)
    local this = {
        views = {},
        id = id
    }
    self.__index = self
    return setmetatable(this, self)
end

function WindowAdapter:addWindow(id)
    local window = BaseWindow:new(id)
    window:setShowing(true)
    self.views[id] = window
    return self
end

function WindowAdapter:addLabel(
        id,
        text,
        color
)
    local label = LabelWindow:new(id)

    if text ~= nil then
        label:setText(text)
    end

    if color ~= nil then
        label:setTextColor(color)
    end

    self.views[label.id] = label
    return self
end

function WindowAdapter:addComboBox(
        id,
        items,
        selectedItem
)
    local comboBox = ComboBoxWindow:new(id)
    comboBox:setItems(items)
    if selectedItem == nil then
        comboBox:setSelectedItem(1)
    end
    self.views[comboBox.id] = comboBox
    return self
end

function WindowAdapter:addCheckBox(id, isEnabled)
    local button = CheckBoxWindow:new(id)
    button:setEnabled(isEnabled == nil or isEnabled)
    self.views[button.id] = button
    return self
end

function WindowAdapter:addSlider(id, position)
    local slider = SliderWindow:new(id)
    if position == nil then
        slider:setPosition(0)
    end
    self.views[slider.id] = slider
    return self
end

function WindowAdapter:addButton(id, text)
    local button = ButtonWindow:new(id)
    if text ~= nil then
        button:setText(text)
    end
    self.views[button.id] = button
    return self
end

function WindowAdapter:addStatusBar(id, maxValue, currentValue, color)
    local statusBar = StatusBarWindow:new(id)
    statusBar:setMaximumValue(maxValue)
    statusBar:setCurrentValue(currentValue)
    if color ~= nil then
        statusBar:setColor(color)
    end
    self.views[statusBar.id] = statusBar
    return self
end

function WindowAdapter:addTemplate(
        newId,
        template,
        type,
        text
)
    WindowApi.createFromTemplate(newId, template, self.id)
    if type == "Label" then
        return self:addLabel(newId, text)
    elseif type == "Button" then
        return self:addButton(newId, text)
    elseif type == "CheckBox" then
        return self:addCheckBox(newId)
    elseif type == "Slider" then
        return self:addSlider(newId)
    else
        return nil
    end
end

function WindowAdapter:addLock(onLock, onUnlock)
    local lock = LockWindow:new(self.id, onLock, onUnlock)
    self.views[lock.id] = lock
    return self
end

function WindowAdapter:addDynamicImage(id, texture, xOffset, yOffset)
    local image = DynamicImageWindow:new(id)
    if texture ~= nil and xOffset ~= nil and yOffset ~= nil then
        image:setTexture(texture, xOffset, yOffset)
    end
    self.views[image.id] = image
    return self
end
