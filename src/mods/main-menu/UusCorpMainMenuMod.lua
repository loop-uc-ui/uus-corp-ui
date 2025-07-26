UusCorpMainMenuMod = {
    Initialize = function ()
        UusCorp.Interface.Defaults.BugReportWindow:destroy()

        UusCorp.Interface.Defaults.RootWindow:unregisterEventHandler(
            UusCorp.Constants.Broadcasts.BugReport()
        )

        UusCorp.Interface.Defaults.InterfaceCore.OnExitGame = function ()
            UusCorp.Api.Event.Broadcast(
                UusCorp.Constants.Broadcasts.ExitGame()
            )
        end

        UusCorp.Interface.Defaults.Actions.ToggleMainMenu = function ()
            local cursor = UusCorp.Cursor().isTarget()
            local currentTarget = UusCorp.CurrentTarget().hasTarget()

            if cursor or currentTarget then
                return
            end

            UusCorpMainMenuWindow:setShowing(
                not UusCorpMainMenuWindow:isShowing()
            )
        end

        UusCorp.Interface.Defaults.RootWindow:registerEventHandler(
            UusCorp.Constants.Broadcasts.EscapeKeyProcessed(),
            "Actions.ToggleMainMenu"
        )

        -- -- Destroy the old main menu menu, so our custom one
        -- -- takes precendence
        UusCorp.Interface.Defaults.MainMenuWindow:destroy()
        UusCorpMainMenuWindow:create(false)
    end
}