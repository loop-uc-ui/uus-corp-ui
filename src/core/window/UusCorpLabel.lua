UusCorpLabel = {}

function UusCorpLabel.new(name)
    local label = UusCorpWindow.new(name)

    function label.setText(text)
        LabelApi.setText(name, text)
    end

    function label.setTextColor(color)
        LabelApi.setTextColor(name, color)
    end

    return label
end