---@class UusCorpWindow:UusCorpView
UusCorpWindow = UusCorpView:new { name  = "UusCorpWindow" }

---@param model UusCorpWindow
---@return UusCorpWindow
function UusCorpWindow:new(model)
    local newObject = setmetatable(model or {}, self)
    self.__index = self
    ---@type table<string, UusCorpView>
    self.children = {}
    return newObject
end

function UusCorpWindow:attachToWorldObject(id)
    WindowApi.attachWindowToWorldObject(id, self.name)
end

function UusCorpWindow:detatchFromWorlObject(id)
    WindowApi.detachWindowFromWorldObject(id, self.name)
end

function UusCorpWindow:savePosition()
    WindowUtilsWrapper.saveWindowPosition(self.name)
end

function UusCorpWindow:restorePosition()
    WindowUtilsWrapper.restoreWindowPosition(self.name)
end

---@param child UusCorpView
---@return UusCorpView
function UusCorpWindow:addChild(child)
    self.children[child.name] = child
    return child
end

---@return UusCorpLabel
function UusCorpWindow:addLabel(label)
    return self:addChild(UusCorpLabel:new { name = self.name .. label }) --[[@as UusCorpLabel]]
end

---@return UusCorpWindow
function UusCorpWindow:addWindow(window)
    return self:addChild(UusCorpWindow:new { name = self.name .. window }) --[[@as UusCorpWindow]]
end

---@return UusCorpStatusBar
function UusCorpWindow:addStatusBar(statusBar)
    return self:addChild(UusCorpStatusBar:new { name = self.name .. statusBar }) --[[@as UusCorpStatusBar]]
end

---@return UusCorpEditTextBox
function UusCorpWindow:addEditTextBox(editTextBox)
    return self:addChild(UusCorpEditTextBox:new { name = self.name .. editTextBox }) --[[@as UusCorpEditTextBox]]
end

---@return UusCorpButton
function UusCorpWindow:addButton(button)
    return self:addChild(UusCorpButton:new { name = self.name .. button }) --[[@as UusCorpButton]]
end

---@return UusCorpScrollWindow
function UusCorpWindow:addScrollWindow(scrollWindow)
    return self:addChild(UusCorpScrollWindow:new { name = self.name .. scrollWindow }) --[[@as UusCorpScrollWindow]]
end

---@return UusCorpDynamicImage
function UusCorpWindow:addDynamicImage(dynamicImage)
    return self:addChild(UusCorpDynamicImage:new { name = self.name .. dynamicImage }) --[[@as UusCorpDynamicImage]]
end