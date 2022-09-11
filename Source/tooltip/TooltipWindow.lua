TooltipWindow = {}
TooltipWindow.Name = "TooltipWindow"
TooltipWindow.Text = TooltipWindow.Name .. "Text"
TooltipWindow.Data = {}
TooltipWindow.Context = 0

function TooltipWindow.create(data, context)
    TooltipWindow.Data = data
    TooltipWindow.Context = context or 0
    WindowApi.createWindow(TooltipWindow.Name, false)
end

function TooltipWindow.destroy()
    WindowApi.destroyWindow(TooltipWindow.Name)
end

function TooltipWindow.onShutdown()
    TooltipWindow.Data = {}
end

function TooltipWindow.onInitialize()
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
                4
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
    end

    TooltipWindow.onUpdate()
    WindowApi.resizeOnChildren(
        Active.window(),
        true,
        8
    )
    WindowApi.setShowing(TooltipWindow.Name, true)
end

function TooltipWindow.onUpdate()
    local _, y = WindowApi.getDimensions(Active.window())

    local scale = 1 / InterfaceCore.scale

    WindowApi.setOffsetFromParent(
        TooltipWindow.Name,
        scale * (MousePosition.x()),
        scale * (MousePosition.y() - y)
    )
end