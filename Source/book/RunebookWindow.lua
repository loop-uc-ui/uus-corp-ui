RunebookWindow = {}
RunebookWindow.Name = "RunebookWindow"

function RunebookWindow.onInitialize()

end

function RunebookWindow.onPopulate(data)

end

function RunebookWindow.onShutdown()

end

function RunebookWindow.onRightClick()
    WindowApi.destroyWindow(Active.window())
end