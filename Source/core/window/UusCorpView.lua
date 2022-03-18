UusCorpView = middleclass.class("UusCorpView")

function UusCorpView:init(name) 
    self.name = name
end

function UusCorpView:doesExist()
    return WindowApi.doesExist(self.name)
end

function UusCorpView:setShowing(isShowing) 
    WindowApi.setShowing(self.name, isShowing == nil or isShowing)
end

---------- LIFE CYCLE CALLBACKS -------------

function UusCorpView:create(doShow)
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