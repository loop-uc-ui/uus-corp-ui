---@diagnostic disable: unused-local
UusCorpView = {}
UusCorpView.__index = UusCorpView

function UusCorpView:init(name)
    local this = setmetatable({}, self)
    this.name = name
    this.eventAdapter = UusCorpEventAdapter:init(name)
    return this
end

function UusCorpView:doesExist() return WindowApi.doesExist(self.name) end

function UusCorpView:setShowing(isShowing)
    WindowApi.setShowing(self.name, isShowing == nil or isShowing)
end

function UusCorpView:setColor(color) WindowApi.setColor(self.name, color) end

function UusCorpView:addAnchor(point, relativeTo, relativePoint, x, y)
    WindowApi.addAnchor(self.name, point, relativeTo, relativePoint, x, y)
end