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
    },
    Interface = {
        text = "Interface",
        name = SettingsWindow.TabContainer .. "InterfaceTab",
        page = SettingsWindow.Name .. "InterfacePage"
    }
}

SettingsWindow.SelectedTab = SettingsWindow.Tabs.Graphics

function SettingsWindow.onInitialize()
    for _, v in pairs(SettingsWindow.Tabs) do
        ButtonApi.setText(
            v.name,
            v.text
        )
        WindowApi.setShowing(v.page, SettingsWindow.SelectedTab == v)
        ButtonApi.setChecked(v.name, SettingsWindow.SelectedTab == v)
    end
end

function SettingsWindow.onShutdown()
end

function SettingsWindow.onRightClick()
    WindowApi.destroyWindow(SettingsWindow.Name)
end

function SettingsWindow.onTabClick()
    local window = Active.window()

    if window == SettingsWindow.SelectedTab.name then
        return
    end

    for _, v in pairs(SettingsWindow.Tabs) do
        if v.name == window then
            SettingsWindow.SelectedTab = v
            break
        end
    end

    for _, v in pairs(SettingsWindow.Tabs) do
        WindowApi.setShowing(v.page, SettingsWindow.SelectedTab == v)
        ButtonApi.setChecked(v.name, SettingsWindow.SelectedTab == v)
    end
end