UusCorpWindow = setmetatable({}, {__index = UusCorpView})
UusCorpWindow.__index = UusCorpWindow

local ROOT_WINDOW = "Root"

function UusCorpWindow.new(name)
    local self = setmetatable(
        UusCorpView.new(name),
        UusCorpWindow
    )
    self.children = {}
    return self
end

function UusCorpWindow:create(root, parent, template)
    if self:doesExist() then
        return
    end

    self.template = template or self.name

    local isRootWindow = not parent or parent == ROOT_WINDOW

    if isRootWindow then
        UusCorpWindowManager.Windows[self.name] = self
    else
        UusCorpWindowManager.Windows[root].children[self.name] = self
    end

    WindowApi.createFromTemplate(
        self.name,
        self.template,
        parent or ROOT_WINDOW
    )

    return self
end

function UusCorpWindow:addChild(window)
    self.children[window.name] = window
    return self
end

function UusCorpWindow:destroy()
    if self:doesExist() then
        WindowApi.destroyWindow(self.name)
        self = nil
    end
end