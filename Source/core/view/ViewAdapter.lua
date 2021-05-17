ViewAdapter = {}

function ViewAdapter:new(name, title)
    local this = {}
    setmetatable(this, self)
    self.__index = self
    this.name = name
    this.title = title
    this.views = {}
    return this
end

function ViewAdapter:setAlpha(alpha)
    WindowSetAlpha(self.name, alpha)
    return self
end

function ViewAdapter:clearAnchors()
    WindowClearAnchors(self.name)
    return self
end

function ViewAdapter:addAnchor(anchorTop, anchorName, anchorBottom, topPos, bottomPos)
    WindowAddAnchor(self.name, anchorTop, anchorName, anchorBottom, topPos, bottomPos)
    return self
end

function ViewAdapter:isShowing()
    return WindowGetShowing(self.name)
end

function ViewAdapter:setShowing(doShow)
    WindowSetShowing(self.name, doShow)
    return self
end

function ViewAdapter:addLabel(
        id,
        text,
        r,
        g,
        b
)
    local label = LabelView:new(id)
    label:setText(text)
    if r ~= nil and g ~= nil and b ~= nil then
        label:setTextColor(r, g, b)
    end
    self.views[label.id] = label
    return self
end

function ViewAdapter:addComboBox(
        id,
        items,
        selectedItem
)
    local comboBox = ComboBoxView:new(id)
    comboBox:setItems(items)
    if selectedItem ~= nil then
        comboBox:setSelectedItem(selectedItem)
    end
    self.views[comboBox.id] = comboBox
    return self
end

function ViewAdapter:addCheckBox(id, isEnabled)
    local button = CheckBoxView:new(id)
    button:setEnabled(isEnabled == nil or isEnabled)
    self.views[button.id] = button
    return self
end

function ViewAdapter:addSlider(id, position)
    local slider = SliderView:new(id)
    slider:setPosition(position)
    self.views[slider.id] = slider
    return self
end

function ViewAdapter:addButton(id, text)
    local button = ButtonView:new(id)
    button:setText(text)
    self.views[button.id] = button
    return self
end

function ViewAdapter:addTemplate(
        root,
        template,
        type,
        text
)
    CreateWindowFromTemplate(self.name, template, root)
    self:setShowing(true)
    if type == "Label" then
        return self:addLabel(self.name, text)
    elseif type == "Button" then
        return self:addButton(self.name, text)
    elseif type == "CheckBox" then
        return self:addCheckBox(self.name, true)
    elseif type == "Slider" then
        return self:addSlider(self.name)
    else
        return nil
    end
end

function ViewAdapter:setOffset(offset)
    ScrollWindowSetOffset(self.name, offset)
    return self
end

function ViewAdapter:updateScrollRect()
    ScrollWindowUpdateScrollRect(self.name)
    return self
end

function ViewAdapter:destroy()
    DestroyWindow(self.name)
end