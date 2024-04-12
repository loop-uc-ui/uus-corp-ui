UusCorpPlayerStatusMod = {
    isPlayerStatusOpen = false,

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

        local windowUtils = UusCorpCore.copyTable(WindowUtils)

        function WindowUtils.OnLButtonUp()
            windowUtils.OnLButtonUp()
            if WindowApi.doesExist("PlayerHealthBar") then
                WindowApi.setMoving("PlayerHealthBar", false)
            end
        end

        UusCorpCore.overrideFunctions(StatusWindow)

        if UusCorpPlayerStatusMod.isPlayerStatusOpen then
            UusCorpPlayerStatusWindow:create()
        end
    end
}