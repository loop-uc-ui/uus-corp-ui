UusCorpPlayerStatusMod = {
    onInitialize = function ()
        UusCorpCore.loadResources(
            "/src/mods/player-status",
            "UusCorpPlayerStatusWindow.xml"
        )

        WindowApi.setShowing("StatusWindow", false)

        WindowApi.unregisterEventHandler(
            "StatusWindow",
            PlayerStatus.event()
        )

        UusCorpCore.overrideFunctions(StatusWindow)
        InterfaceCore.Update = function ()
            
        end
        UusCorpPlayerStatusWindow:create()
        -- WindowUtilsWrapper.restoreWindowPosition("PlayerHealthBar", true)
    end
}