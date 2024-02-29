---@class UusCorpWindowModel:UusCorpViewModel
---@field children UusCorpView[]
local UusCorpWindowModel = {
    name = "",
    data = {},
    events = {},
    children = {}
}

---@class UusCorpWindow:UusCorpView
UusCorpWindow = UusCorpView:new(UusCorpWindowModel)

---@param model UusCorpWindowModel
---@return UusCorpWindow
function UusCorpWindow:new(model)
    if type(model) == "string" then
        model = {
            name = model,
            data = {},
            events = {},
            children = {}
        }
    end
    return UusCorpView.new(self, model) --[[@as UusCorpWindow]]
end

function UusCorpWindow:attachToWorldObject(id)
    WindowApi.attachWindowToWorldObject(id, self:getName())
end

function UusCorpWindow:detatchFromWorlObject(id)
    WindowApi.detachWindowFromWorldObject(id, self:getName())
end

function UusCorpWindow:savePosition()
    WindowUtilsWrapper.saveWindowPosition(self:getName())
end

function UusCorpWindow:restorePosition()
    WindowUtilsWrapper.restoreWindowPosition(self:getName())
end

---@return UusCorpLabel
function UusCorpWindow:addLabel(label)
    return UusCorpLabel:new(self:getName() .. label)
end

---@return UusCorpWindow
function UusCorpWindow:addWindow(window)
    return UusCorpWindow:new(self:getName() .. window)
end

---@return UusCorpStatusBar
function UusCorpWindow:addStatusBar(statusBar)
    return UusCorpStatusBar:new(self:getName() .. statusBar)
end

---@return UusCorpEditTextBox
function UusCorpWindow:addEditTextBox(editTextBox)
    return UusCorpEditTextBox:new(self:getName() .. editTextBox)
end

---@return UusCorpButton
function UusCorpWindow:addButton(button)
    return UusCorpButton:new(self:getName() .. button)
end

---@return UusCorpScrollWindow
function UusCorpWindow:addScrollWindow(scrollWindow)
    return UusCorpScrollWindow:new(self:getName() .. scrollWindow)
end

---@return UusCorpDynamicImage
function UusCorpWindow:addDynamicImage(dynamicImage)
    return UusCorpDynamicImage:new(self:getName() .. dynamicImage)
end

function UusCorpWindow:onInitialize()
    UusCorpView.onInitialize(self)
    local children = self.model.children --[[@as UusCorpView[]>]]
    if children ~= nil then
        for i = 1, #children do
            children[i]:onInitialize()
        end
    end
end

function UusCorpWindow:onShutdown()
    local children = self.model.children --[[@as UusCorpView[]>]]
    if children ~= nil then
        for i = 1, #children do
            children[i]:onShutdown()
        end
    end
    UusCorpView.onShutdown(self)
end