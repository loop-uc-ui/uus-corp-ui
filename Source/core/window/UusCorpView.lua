UusCorpView = {}
UusCorpView.__index = UusCorpView

function UusCorpView:asStatusBar()
    return setmetatable({
        name = self.name
    }, UusCorpStatusBar)
end

function UusCorpView:asLabel()
    return setmetatable({
        name = self.name
    }, UusCorpLabel)
end

function UusCorpView:asButton()
    return setmetatable({
        name = self.name
    }, UusCorpButton)
end

function UusCorpView:asWindow(parent, template)
    local window = setmetatable({
        name = self.name,
        parent = parent or "Root",
        template = template or self.name,
        children = {},
        actions = {},
        event = {}
    }, UusCorpWindow)

    return window:addAction(
        UusCorpViewAction.onRButtonUp(function ()
            window:destroy()
            return window
        end)
    )
end