UusCorpView = {}
UusCorpView.__index = UusCorpView

function UusCorpView.new(name)
    return setmetatable({
        name = name
    }, UusCorpView)
end

function UusCorpView:doesExist()
    return WindowApi.doesExist(self.name)
end

function UusCorpView:hide()
    WindowApi.setShowing(self.name, false)
    return self
end

---------- LIFE CYCLE CALLBACKS -------------

function UusCorpView.onInitialize()
end

function UusCorpView.onShutdown()
end

function UusCorpView.onLButtonUp(flags, x, y)
end

function UusCorpView.onRButtonUp(flags, x, y)
end

function UusCorpView.onRButtonDown(flags, x, y)
end