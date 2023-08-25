UusCorpLabel = {}

function UusCorpLabel.new(name)
    local label = { name = name }

    label.setText = function (text)
        LabelApi.setText(name, text)
    end

    return label
end