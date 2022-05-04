UusCorpView = {}
UusCorpView.__index = UusCorpView

function UusCorpView:asStatusBar()
    return setmetatable(
        UusCorpViewable.new(self.name),
        UusCorpStatusBar
    )
end

function UusCorpView:asLabel()
    return setmetatable(
        UusCorpViewable.new(self.name),
        UusCorpLabel
    )
end

function UusCorpView:asButton()
    return setmetatable(
        UusCorpViewable.new(self.name),
        UusCorpButton
    )
end

function UusCorpView:asWindow(parent, template)
    local window = setmetatable(
        UusCorpViewable.new(self.name),
        UusCorpWindow
    )

    window.parent = parent or "Root"
    window.template = template or self.name
    window.children = {}
    window.data = {}

    return window:coreEvent(
        UusCorpViewEvent.onRButtonUp(function ()
            window:destroy()
            return window
        end)
    )
end