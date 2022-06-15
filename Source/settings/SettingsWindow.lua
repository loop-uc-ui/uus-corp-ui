SettingsWindow = {}

SettingsWindow.Name = "SettingsWindow"

SettingsWindow.TabContainer = SettingsWindow.Name .. "TabContainer"

SettingsWindow.Tabs = {
    Graphics = {
        text = "Graphics",
        name = SettingsWindow.TabContainer .. "GraphicsTab",
        page = SettingsWindow.Name .. "GraphicsPage"
    },
    Sound = {
        text = "Sound",
        name = SettingsWindow.TabContainer .. "SoundTab",
        page = SettingsWindow.Name .. "SoundPage"
    },
    Chat = {
        text = "Chat",
        name = SettingsWindow.TabContainer .. "ChatTab",
        page = SettingsWindow.Name .. "ChatPage"
    },
    Controls = {
        text = "Controls",
        name = SettingsWindow.TabContainer .. "ControlsTab",
        page = SettingsWindow.Name .. "ControlsPage"
    }
}

SettingsWindow.SelectedTab = SettingsWindow.Tabs.Graphics

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

function SettingsWindow.onRightClick()
    WindowApi.destroyWindow(SettingsWindow.Name)
end
