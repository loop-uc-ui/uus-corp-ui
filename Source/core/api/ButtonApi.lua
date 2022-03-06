ButtonApi = {}

function ButtonApi.setText(id, text)
    ButtonSetText(id, text)
end

function ButtonApi.getText(id)
    return ButtonGetText(id)
end

function ButtonApi.setDisabled(id, isDisabled)
    ButtonSetDisabledFlag(id, isDisabled)
end

function ButtonApi.isDisabled(id)
    return ButtonGetDisabledFlag(id)
end

function ButtonApi.setEnabled(id, isEnabled)
    ButtonSetCheckButtonFlag(id, isEnabled)
end

function ButtonApi.setChecked(id, isChecked)
    ButtonSetPressedFlag(id, isChecked)
end

function ButtonApi.isChecked(id)
    return ButtonGetPressedFlag(id)
end

function ButtonApi.setTexture(id, state, texture, x, y)
    ButtonSetTexture(id, state, texture, x, y)
end

function ButtonApi.setHighlight(id, doHighlight)
    ButtonSetHighlightFlag(id, doHighlight)
end

function ButtonApi.setStayDown(id, stayDown)
    ButtonSetStayDownFlag(id, stayDown)
end

function ButtonApi.isStayDown(id)
    return ButtonGetStayDownFlag(id)
end

function ButtonApi.setTextColor(id, r, g, b, a)
    ButtonSetTextColor(id, r, g, b, a)
end

