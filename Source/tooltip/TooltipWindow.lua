TooltipWindow = {}
TooltipWindow.Name = "TooltipWindow"
TooltipWindow.Text = TooltipWindow.Name .. "Text"
TooltipWindow.Data = {}

function TooltipWindow.create(data)
    TooltipWindow.Data = data
    WindowApi.createWindow(TooltipWindow.Name, false)
end

function TooltipWindow.destroy()
    WindowApi.destroyWindow(TooltipWindow.Name)
end

function TooltipWindow.onShutdown()
    TooltipWindow.Data = {}
end

function TooltipWindow.onInitialize()
    local width = 0
    local height = 0

    for i = 1, #TooltipWindow.Data do
        local label = TooltipWindow.Text .. tostring(i)
        WindowApi.createFromTemplate(
            label,
            "TooltipLabelTemplate",
            TooltipWindow.Name
        )

        if i == 1 then
            WindowApi.addAnchor(
                label,
                "topleft",
                TooltipWindow.Name,
                "topleft",
                8,
                8
            )
        else
            WindowApi.addAnchor(
                label,
                "bottomleft",
                TooltipWindow.Text .. tostring(i - 1),
                "topleft",
                0,
                0
            )
        end

        LabelApi.setText(label, TooltipWindow.Data[i])

        local x, y = WindowApi.getDimensions(label)

        if width < x then
            width = x
        end

        height = height + y
    end

    WindowApi.setDimensions(
        TooltipWindow.Name,
        width + 16,
        height + 16
    )

    TooltipWindow.onUpdate()
    WindowApi.setShowing(TooltipWindow.Name, true)
end

function TooltipWindow.onUpdate()
    local x, y = WindowApi.getDimensions(Active.window())

    local scale = 1 / InterfaceCore.scale

    WindowApi.setOffsetFromParent(
        TooltipWindow.Name,
        scale * (MousePosition.x()),
        scale * (MousePosition.y() - y)
    )
end