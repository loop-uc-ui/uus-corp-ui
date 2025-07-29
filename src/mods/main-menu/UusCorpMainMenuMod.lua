---@param context Context
---@return Button
local Button = function (context, text, onLButtonUp, onShown)
    return context.Views.Button {
        events = {
            OnLButtonUp = onLButtonUp,

            OnInitialize = function (self)
                self:setDimensions(130, 41)
                self:setText(text)
                if onShown ~= nil then
                    onShown(self)
                end
            end
        }
    }
end

---@param context Context
local UusCorpMainMenuWindow = function (context)
    return context.Views.Window {
        name = "UusCorpMainMenuWindow",
        events = {
            OnInitialize = function (self)
                self:setDimensions(214, 440)
                self:anchorToParentCenter()
                self:setChildren {
                    Button(
                        context,
                        3000128,
                        function ()
                            EventApi.broadcast(Events.logOut())
                        end,
                        ---@param button Button
                        function (button)
                            button:anchorToParentTop()
                        end
                    ),
                    Button(
                        context,
                        1077859,
                        function ()
                            InterfaceCore.OnExitGame()
                        end
                    ),
                    Button(
                        context,
                        L"Settings",
                        function ()
                            if self:doesExist() then
                                ToggleWindowByName("UusCorpSettingsWindow", "")
                                self:setShowing(false)
                            else
                                ToggleWindowByName("SettingsWindow", "")
                            end
                        end
                    ),
                    Button(
                        context,
                        L"Store",
                        function ()
                            EventApi.broadcast(Events.store())
                            self:setShowing(false)
                        end
                    ),
                    Button(
                        context,
                        L"Agents",
                        function ()
                            ToggleWindowByName("OrganizerWindow", "")
                            self:setShowing(false)
                        end
                    ),
                    Button(
                        context,
                        3000172,
                        function ()
                            ToggleWindowByName("MacroWindow", "")
                            self:setShowing(false)
                        end
                    ),
                    Button(
                        context,
                        1079812,
                        function ()
                            ToggleWindowByName("ActionsWindow", "")
                            self:setShowing(false)
                        end
                    ),
                    Button(
                        context,
                        1061037,
                        function ()
                            context.Api.Event.Broadcast(Events.help())
                            EventApi.broadcast(Events.help())
                            self:setShowing(false)
                        end
                    ),
                    Button(
                        context,
                        L"Debug",
                        function ()
                            ToggleWindowByName("DebugWindow", "")
                            self:setShowing(false)
                        end
                    )
                }
            end,
            OnRButtonUp = function (self)
                self:setShowing(false)
            end
        }
    }
end


UusCorpMainMenuMod = UusCorp.Mod {
    Name = "UusCorpMainMenu",
    Path = "/src/mods/main-menu",
    OnInitialize = function (context)
        local mainMenuWindow = UusCorpMainMenuWindow(context)

        context.Views.Defaults.BugReportWindow:destroy()

        context.Views.Defaults.RootWindow:unregisterEventHandler(
            context.Constants.Broadcasts.BugReport()
        )

        context.Views.Defaults.InterfaceCore.OnExitGame = function ()
            context.Api.Event.Broadcast(
                context.Constants.Broadcasts.ExitGame()
            )
        end

        ---@diagnostic disable-next-line: inject-field
        context.Views.Defaults.Actions.ToggleMainMenu = function ()
            local cursor = context.Data.Cursor():isTarget()
            local currentTarget = context.Data.CurrentTarget():hasTarget()

            if cursor or currentTarget then
                return
            end

            mainMenuWindow:setShowing(not mainMenuWindow:isShowing())
        end

        context.Views.Defaults.RootWindow:registerEventHandler(
            context.Constants.Broadcasts.EscapeKeyProcessed(),
            "Actions.ToggleMainMenu"
        )

        -- -- Destroy the old main menu menu, so our custom one
        -- -- takes precendence
        context.Views.Defaults.MainMenuWindow:destroy()
        mainMenuWindow:create(false)
    end
}