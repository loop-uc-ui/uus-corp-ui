PaperdollWindow = {}
PaperdollWindow.Name = "PaperdollWindow"

local SLOTS = 18

function PaperdollWindow.onInitialize()

end

function PaperdollWindow.onShutdown()

end

function PaperdollWindow.onRightClick()
    WindowApi.destroyWindow(Active.window())
end