EditTextBoxApi = {}

function EditTextBoxApi.setText(editBoxName, text)
    if type(text) == "string" then
        text = StringFormatter.toWString(text)
    end
    TextEditBoxSetText(editBoxName, text or L"")
end

function EditTextBoxApi.getText(editBoxName)
    return TextEditBoxGetText(editBoxName)
end

function EditTextBoxApi.getLines(editBoxName)
    return TextEditBoxGetTextLines(editBoxName)
end

function EditTextBoxApi.insertText(editBoxName, text)
    TextEditBoxInsertText(editBoxName, text)
end

function EditTextBoxApi.setTextColor(editBoxName, color)
    TextEditBoxSetTextColor(editBoxName, color.r, color.g, color.b)
end

function EditTextBoxApi.getTextColor(editBoxName)
    return TextEditBoxGetTextColor(editBoxName)
end

function EditTextBoxApi.selectAll(editBoxName)
    TextEditBoxSelectAll(editBoxName)
end

function EditTextBoxApi.setFont(editBoxName, fontName, lineSpacing)
    TextEditBoxSetFont(editBoxName, fontName, lineSpacing)
end

function EditTextBoxApi.getFont(editBoxName)
    return TextEditBoxGetFont(editBoxName)
end

function EditTextBoxApi.getHistory(editBoxName)
    return TextEditBoxGetHistory(editBoxName)
end

function EditTextBoxApi.setHistory(editBoxName, history)
    TextEditBoxSetHistory(editBoxName, history)
end

function EditTextBoxApi.handleKeyDown(editBoxName, handle)
    TextEditBoxSetHandleKeyDown(editBoxName, handle)
end