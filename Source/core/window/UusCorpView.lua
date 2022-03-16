UusCorpView = {}
UusCorpView.__index = UusCorpView

function UusCorpView.new(name)
    local self = {
        name = name
    }
    return setmetatable(self, UusCorpView)
end

function UusCorpView:doesExist()
    return WindowApi.doesExist(self.name)
end

function UusCorpView:setShowing(isShowing) 
    WindowApi.setShowing(self.name, isShowing == nil or isShowing)
end

---------- LIFE CYCLE CALLBACKS -------------

function UusCorpView:create(doShow)
    UusCorpViewLifeCycle.Views[self.name] = self
end

function UusCorpView:onInitialize()
end

function UusCorpView:onShutdown()
end

function UusCorpView:onLButtonUp(flags, x, y)
end

function UusCorpView:onRButtonUp(flags, x, y)
end

function UusCorpView:onRButtonDown(flags, x, y)
end