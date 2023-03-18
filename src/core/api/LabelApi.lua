LabelApi = {}

function LabelApi.setText(id, text)
    if text == nil then
        return
    elseif type(text) == "number" then
        text = StringFormatter.fromTid(text)
    elseif type(text) == "string" then
        text = StringFormatter.toWString(text)
    end

    LabelSetText(id, text)
end

function LabelApi.setTextColor(id, color)
    LabelSetTextColor(id, color.r, color.g, color.b)
end

function LabelApi.setTextAlignment(id, alignment)
    LabelSetTextAlign(id, alignment)
end

function LabelApi.getText(id)
    return LabelGetText(id)
end

function LabelApi.setWordWrap(id, wordWrap)
    LabelSetWordWrap(id, wordWrap)
end