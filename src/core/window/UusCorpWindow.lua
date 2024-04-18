---@class UusCorpWindow:UusCorpView
UusCorpWindow = UusCorpView:new { name  = "UusCorpWindow" }

---@param model UusCorpWindow?
---@return UusCorpWindow
function UusCorpWindow:new(model)
    return UusCorpView.new(self, model) --[[@as UusCorpWindow]]
end

---@param windowData WindowData?
---@param systemData SystemData?
function UusCorpWindow:onInitialize(windowData, systemData)
    UusCorpView.onInitialize(self, windowData, systemData)
    if self:getParent() == UusCorpRootWindow then
        self:restorePosition()
    end
end

function UusCorpWindow:attachToWorldObject(id)
    UusCorp.Api.Window.AttachToWorldObject(id, self.name)
end

function UusCorpWindow:detatchFromWorlObject(id)
    UusCorp.Api.Window.DetachFromWorldObject(id, self.name)
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
    child.name = self.name .. child.name
    child.parent = self.name
    return child
end

---@return UusCorpLabel
function UusCorpWindow:addLabel(label)
    return self:addChild(UusCorpLabel:new { name = label }) --[[@as UusCorpLabel]]
end

---@return UusCorpWindow
function UusCorpWindow:addWindow(window)
    return self:addChild(UusCorpWindow:new { name = window }) --[[@as UusCorpWindow]]
end

---@return UusCorpStatusBar
function UusCorpWindow:addStatusBar(statusBar)
    return self:addChild(UusCorpStatusBar:new { name = statusBar }) --[[@as UusCorpStatusBar]]
end

---@return UusCorpEditTextBox
function UusCorpWindow:addEditTextBox(editTextBox)
    return self:addChild(UusCorpEditTextBox:new { name = editTextBox }) --[[@as UusCorpEditTextBox]]
end

---@return UusCorpButton
function UusCorpWindow:addButton(button)
    return self:addChild(UusCorpButton:new { name = button }) --[[@as UusCorpButton]]
end

---@return UusCorpScrollWindow
function UusCorpWindow:addScrollWindow(scrollWindow)
    scrollWindow = self:addChild(UusCorpScrollWindow:new { name = scrollWindow })  --[[@as UusCorpScrollWindow]]
    scrollWindow.scrollChild.name = scrollWindow.name .. "ScrollChild"
    return scrollWindow
end

---@return UusCorpDynamicImage
function UusCorpWindow:addDynamicImage(dynamicImage)
    return self:addChild(UusCorpDynamicImage:new { name = dynamicImage }) --[[@as UusCorpDynamicImage]]
end

function UusCorpWindow:onRButtonDown(flags, x, y)
    if self:getParent() == UusCorpRootWindow then
        self:destroy()
    end

    return flags, x, y
end

function UusCorpWindow:onShutdown()
    if self:getParent() == UusCorpRootWindow then
        self:savePosition()
    end
    UusCorpView.onShutdown(self)
end