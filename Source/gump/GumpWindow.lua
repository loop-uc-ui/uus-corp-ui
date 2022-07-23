GumpWindow = {}

function GumpWindow.Initialize()
    local destroy = false

    for _, v in pairs(Gump.SuppressedIds) do
        if v == Gump.getGumpId() then
            destroy = true
            break
        end
    end

    if destroy then
        WindowApi.destroyWindow(Active.window())
    else
        WindowApi.setShowing(Active.window(), true)
    end
end

function GumpWindow.OnClicked()
    GumpApi.onClick(
        WindowApi.getId(Active.window()),
        Active.window()
    )
end

function GumpWindow.OnDoubleClicked()
    GumpApi.onDoubleClick(
        WindowApi.getId(Active.window()),
        Active.window()
    )
end

function GumpWindow.OnRClicked()
    GumpApi.onRClick(WindowApi.getId(Active.window()))
    WindowApi.destroyWindow(Active.window())
end

function GumpWindow.OnHyperLinkClicked(link)
    GumpApi.openWebBrowser(link)
end