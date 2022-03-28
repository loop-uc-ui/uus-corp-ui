UusCorpView = {
    init = function(name)
        local self = {}
        local lifeCycle = UusCorpLifeCycle()

        self.doesExist = function() return WindowApi.doesExist(name) end

        self.setShowing = function(isShowing)
            WindowApi.setShowing(name, isShowing == nil or isShowing)
        end

        self.setColor = function(color) WindowApi.setColor(name, color) end

        ---@diagnostic disable-next-line: unused-local
        self.create = function(doShow, parent, template) end

        self.destroy = function()
            WindowApi.destroyWindow(name)
        end

        self.getName = function() return name end

        self.addAnchor = function(point, relativeTo, relativePoint, x, y)
            WindowApi.addAnchor(name, point, relativeTo, relativePoint, x, y)
        end

        self.getLifeCycle = function() return lifeCycle end

        return self
    end 
}
