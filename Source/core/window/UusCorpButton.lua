UusCorpButton = {
    init = function(name, text)
        local self = UusCorpView.init(name)

        self.setText = function(buttonText)
            if type(buttonText) == "number" then
                buttonText = StringFormatter.fromTid(text)
            elseif type(buttonText) == "string" then
                buttonText = StringFormatter.toWString(text)
            end
            ButtonApi.setText(name, text)
        end

        self.setDisabled = function(isDisabled)
            ButtonApi.setDisabled(name, isDisabled)
        end

        self.getLifeCycle().onInitialize = function ()
            if text then
                self.setText(text)
            end
        end

        return self
    end
}
