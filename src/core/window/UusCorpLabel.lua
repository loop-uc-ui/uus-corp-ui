UusCorpLabel = {}

function UusCorpLabel.new(name)
    local label = { }

    function label.setText(text)
        LabelApi.setText(name, text)
    end

    function label.getName()
        return name
    end

    return label
end