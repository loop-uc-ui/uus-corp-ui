GumpWindow = {}

function GumpWindow.Initialize()
    WindowApi.setShowing(Active.window(), true)
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
end

function GumpWindow.OnHyperLinkClicked(link)
    GumpApi.openWebBrowser(link)
end