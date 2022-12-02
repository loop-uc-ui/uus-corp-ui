TooltipWindow = {}
TooltipWindow.Name = "TooltipWindow"
TooltipWindow.Text = TooltipWindow.Name .. "Text"
TooltipWindow.Data = {}
TooltipWindow.Context = 0

-- Copied from default UI
local function stripHTML(inString)
	local outString = L""
	local o1, _, _, c2
	c2 = 0
    inString = StringFormatter.toWString(inString)
	o1, _ = wstring.find(inString, L"<", 1, true)
	while o1 do
		if (c2+1 <= o1-1) then
			outString = outString..wstring.sub(inString, c2+1, o1-1)
		end
		_, c2 = wstring.find(inString, L">", o1, true)
		o1, _ = wstring.find(inString, L"<", c2, true)
	end
	if (c2+1 <= wstring.len(inString)) then
		outString = outString..wstring.sub(inString, c2+1, -1)
	end
	return outString
end

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

        LabelApi.setText(label, stripHTML(TooltipWindow.Data[i]))
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