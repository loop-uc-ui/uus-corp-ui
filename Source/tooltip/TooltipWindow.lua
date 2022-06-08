TooltipWindow = {}
TooltipWindow.Name = "TooltipWindow"
TooltipWindow.Text = TooltipWindow.Name .. "Text"

function TooltipWindow.create(data)
    WindowApi.createWindow(TooltipWindow.Name, false)

    local width = 0
    local height = 0

    for i = 1, #data do
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

        LabelApi.setText(label, data[i])

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

    WindowApi.setId(TooltipWindow.Name, #data)
    WindowApi.setShowing(TooltipWindow.Name, true)
end

function TooltipWindow.destroy()
    WindowApi.destroyWindow(TooltipWindow.Name)
end

function TooltipWindow.onInitialize()
    TooltipWindow.onUpdate()
end

function TooltipWindow.onUpdate()
    local id = WindowApi.getId(Active.window())

    WindowApi.setOffsetFromParent(
        TooltipWindow.Name,
        MousePosition.x() + 8,
        MousePosition.y() - (id * 16) - 24
    )
end