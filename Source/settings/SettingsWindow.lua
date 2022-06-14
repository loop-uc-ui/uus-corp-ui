SettingsWindow = {}
SettingsWindow.Name = "SettingsWindow"
SettingsWindow.Tabs = {
    Graphics = {
        text = "Graphics",
        name = SettingsWindow.Name .. "GraphicsTab"
    },
    Sound = {
        text = "Sound",
        name = SettingsWindow.Name .. "SoundTab"
    },
    Chat = {
        text = "Chat",
        name = SettingsWindow.Name .. "ChatTab"
    }
}

function SettingsWindow.onInitialize()
    for _, v in pairs(SettingsWindow.Tabs) do
        ButtonApi.setText(
            v.name,
            v.text
        )
    end
end

function SettingsWindow.onShutdown()

end
