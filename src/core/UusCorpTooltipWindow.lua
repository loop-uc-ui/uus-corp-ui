UusCorpTooltipWindow = {}
UusCorpTooltipWindow.Name = "UusCorpTooltipWindow"
UusCorpTooltipWindow.Text = UusCorpTooltipWindow.Name .. "Text"
UusCorpTooltipWindow.Data = {}
UusCorpTooltipWindow.Context = 0

-- Copied from default UI
local function stripHTML(inString)
	local outString = L""
	local o1, c2
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

function UusCorpTooltipWindow.create(data, context)
    UusCorpTooltipWindow.Data = data
    UusCorpTooltipWindow.Context = context or 0
    WindowApi.createWindow(UusCorpTooltipWindow.Name, false)
end

function UusCorpTooltipWindow.initialize()
    UusCorpCore.loadResources(
        "/src/core",
        "UusCorpTooltipWindow.xml"
    )
end

function UusCorpTooltipWindow.destroy()
    WindowApi.destroyWindow(UusCorpTooltipWindow.Name)
end

function UusCorpTooltipWindow.onShutdown()
    UusCorpTooltipWindow.Data = {}
end

function UusCorpTooltipWindow.onInitialize()
    for i = 1, #UusCorpTooltipWindow.Data do
        local label = UusCorpTooltipWindow.Text .. tostring(i)
        WindowApi.createFromTemplate(
            label,
            "TooltipLabelTemplate",
            UusCorpTooltipWindow.Name
        )

        if i == 1 then
            WindowApi.addAnchor(
                label,
                "topleft",
                UusCorpTooltipWindow.Name,
                "topleft",
                8,
                4
            )
        else
            WindowApi.addAnchor(
                label,
                "bottomleft",
                UusCorpTooltipWindow.Text .. tostring(i - 1),
                "topleft",
                0,
                0
            )
        end

        LabelApi.setText(label, stripHTML(UusCorpTooltipWindow.Data[i]))
    end

    WindowApi.resizeOnChildren(
        Active.window(),
        false,
        8
    )

    UusCorpTooltipWindow.onUpdate()

    WindowApi.setShowing(UusCorpTooltipWindow.Name, true)
end

function UusCorpTooltipWindow.onUpdate()
    local scale = 1 / InterfaceCore.scale

    local xPos = scale * MousePosition.x()
    local yPos = scale * (MousePosition.y() - 24)

    WindowApi.clearAnchors(Active.window())

    WindowApi.addAnchor(
        Active.window(),
        "topleft",
        "Root",
        "bottomleft",
        xPos,
        yPos
    )
end