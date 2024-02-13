---@class UusCorpWindow:UusCorpView
UusCorpWindow = UusCorpView:new("UusCorpWindow")

---@param name string
---@return UusCorpWindow
function UusCorpWindow:new(name)
    return UusCorpView.new(self, name) --[[@as UusCorpWindow]]
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

---@return UusCorpLabel
function UusCorpWindow:addLabel(label)
    return UusCorpLabel:new(self.name .. label)
end

---@return UusCorpWindow
function UusCorpWindow:addWindow(window)
    return UusCorpWindow:new(self.name .. window)
end

---@return UusCorpStatusBar
function UusCorpWindow:addStatusBar(statusBar)
    return UusCorpStatusBar:new(self.name .. statusBar)
end

---@return UusCorpEditTextBox
function UusCorpWindow:addEditTextBox(editTextBox)
    return UusCorpEditTextBox:new(self.name .. editTextBox)
end

---@return UusCorpButton
function UusCorpWindow:addButton(button)
    return UusCorpButton:new(self.name .. button)
end

---@return UusCorpScrollWindow
function UusCorpWindow:addScrollWindow(scrollWindow)
    return UusCorpScrollWindow:new(self.name .. scrollWindow)
end

---@return UusCorpDynamicImage
function UusCorpWindow:addDynamicImage(dynamicImage)
    return UusCorpDynamicImage:new(self.name .. dynamicImage)
end