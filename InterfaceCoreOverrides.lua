--[[
    InterfaceCore.lua is a script that runs prior to loading the UI (see docs).
    It contains logic for the Login screen and performs various other operations,
    like registering certain events to the Root window. This cannot be tweaked
    without editing the Interface UOP file, but we can override things via Lua
    after the custom UI is loaded.
]]--

function InterfaceCore.OnExitGame()
    --Suppress InterfaceCore pop up
    EventApi.broadcast(Events.exitGame())
end

function ModulesLoadFromListFile(listPath, setName, allowRaw)
    --Stub to prevent loading of default Chat and Context Menu mods
    return listPath, setName, allowRaw
end