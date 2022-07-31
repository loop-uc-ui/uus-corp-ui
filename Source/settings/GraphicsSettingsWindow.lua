GraphicsSettingsWindow = {}

GraphicsSettingsWindow.Name = SettingsWindow.Name .. "GraphicsPage"

GraphicsSettingsWindow.Container = GraphicsSettingsWindow.Name .. "Container"

function GraphicsSettingsWindow.onInitialize()
end

function GraphicsSettingsWindow.onGraphicSettingChanged(index)
    for _, v in pairs(GraphicsSettingsWindow.ComboBoxes) do
        if v.name == Active.window() then
            v.setting(index)
            EventApi.broadcast(Events.userSettingsUpdated())
            break
        end
    end
end