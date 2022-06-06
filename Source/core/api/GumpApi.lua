GumpApi = {}

function GumpApi.onClick(gumpId, windowName)
    GenericGumpOnClicked(gumpId, windowName)
end

function GumpApi.onDoubleClick(gumpId, windowName)
    GenericGumpOnDoubleClicked(gumpId, windowName)
end

function GumpApi.onRClick(gumpId)
    GenericGumpOnRClicked(gumpId)
end

function GumpApi.getToolTipText(gumpId, windowName)
    GenericGumpGetToolTipText(gumpId, windowName)
end

function GumpApi.openWebBrowser(link)
    OpenWebBrowser(tostring(link))
end