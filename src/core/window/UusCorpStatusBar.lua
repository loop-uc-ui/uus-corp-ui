UusCorpStatusBar = {}

function UusCorpStatusBar.new(name)
    local window = UusCorpWindow.new(name)

    function window.setCurrentValue(value)
        StatusBarApi.setCurrentValue(name, value)
    end

    function window.setMaxValue(value)
        StatusBarApi.setMaximumValue(name, value)
    end

    function window.setForegroundTint(tint)
        StatusBarApi.setForegroundTint(name, tint)
    end

    function window.setBackgroundTint(tint)
        StatusBarApi.setBackgroundTint(name, tint)
    end

    return window
end