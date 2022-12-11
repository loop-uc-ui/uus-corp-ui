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
    WindowApi.destroyWindow(Active.window())
end

function GumpWindow.OnHyperLinkClicked(link)
    GumpApi.openWebBrowser(link)
end

function GumpWindow.broadcastButtonPress(buttonId, gumpId, objectId)
    Gump.returnButtonId(buttonId)
    Gump.returnGumpId(gumpId)
    Gump.returnObjectId(objectId)
    EventApi.broadcast(Events.gumpAction())
end

function GumpWindow.broadcastTextEntry(text, isSubmit, objectId)
    if isSubmit then
        isSubmit = 1
    else
        isSubmit = 0
    end

    Gump.returnGumpId(Gump.Map.SingleLineTextEntry.Id)
    Gump.returnObjectId(objectId)
    Gump.returnTextEntryId(Gump.Map.SingleLineTextEntry.Buttons.Submit)
    Gump.returnText(text)
    Gump.returnTextLength(string.len(StringFormatter.fromWString(text)))
    Gump.returnCode(isSubmit)
    EventApi.broadcast(Events.gumpActionTextEntry())
end