UusCorpPlayerStatusMod = UusCorp.Mod {
    Name = "UusCorpPlayerStatus",

    Path = "/src/mods/player-status",

    OnInitialize = function ()
        local statusWindow = UusCorp.Interface.Defaults.StatusWindow
        statusWindow:setShowing(false)
        statusWindow:unregisterEventHandler(UusCorp.Data.PlayerStatus():getEvent())
        UusCorp.Utils.Table.OverrideFunctions(statusWindow:getDefault())
        local window = UusCorpPlayerStatusWindow()
        window:create(true)
        window:setShowing(true)
        window:setOffsetFromParent(0, 0)
    end
}