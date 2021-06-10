LabelApi = {}

function LabelApi.setText(id, text)
    LabelSetText(id, text)
end

function LabelApi.setTextColor(id, color)
    LabelSetTextColor(id, color.r, color.g, color.b)
end