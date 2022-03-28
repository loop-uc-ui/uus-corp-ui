UusCorpLabel = { 
    init = function(name, textValue, textColor, textAlignment)
        local self = UusCorpView.init(name)

        self.setText = function(text)
            if type(text) == "number" then
                text = StringFormatter.fromTid(text)
            elseif type(text) == "string" then
                text = StringFormatter.toWString(text)
            end
            LabelApi.setText(name, text)
        end

        self.setTextColor = function(color) LabelApi.setTextColor(name, color) end

        self.setTextAlignment = function(alignment)
            LabelApi.setTextAlignment(name, alignment)
        end

        self.getText = function() return LabelApi.getText(name) end

        self.getLifeCycle().onInitialize = function()
            if textValue then self.setText(textValue) end

            if textColor then self.setTextColor(textColor) end

            if textAlignment then self.setTextAlignment(textAlignment) end
        end

        return self
    end 
}