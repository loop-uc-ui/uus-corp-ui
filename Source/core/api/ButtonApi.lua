ButtonApi = {}

function ButtonApi.setText(id, text)
    ButtonSetText(id, text)
end

function ButtonApi.setDisabled(id, isDisabled)
    ButtonSetDisabledFlag(id, isDisabled)
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

