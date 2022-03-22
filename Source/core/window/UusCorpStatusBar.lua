UusCorpStatusBar = {
    init = function(name, curVal, maxVal)
        local self = UusCorpView.init(name)

        self.setMaximumValue = function(value)
            StatusBarApi.setMaximumValue(name, value)
        end

        self.setCurrentValue = function(value)
            StatusBarApi.setCurrentValue(name, value)
        end

        self.create = function()
            if curVal then self.setCurrentValue(curVal) end

            if maxVal then self.setMaximumValue(maxVal) end
        end

        return self
    end
}
