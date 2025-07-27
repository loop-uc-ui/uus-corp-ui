---@return Button
local Button = function (text, onLButtonUp, onShown)
    return UusCorp.Interface.Button {
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

UusCorpMainMenuWindow = UusCorp.Interface.Window {
    name = "UusCorpMainMenuWindow",
    events = {
        OnInitialize = function (self)
            self:setDimensions(214, 440)
            self:anchorToParentCenter()
            self:setChildren {
                Button(
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
                    1077859,
                    function ()
                        InterfaceCore.OnExitGame()
                    end
                ),
                Button(
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
                    L"Store",
                    function ()
                        EventApi.broadcast(Events.store())
                        self:setShowing(false)
                    end
                ),
                Button(
                    L"Agents",
                    function ()
                        ToggleWindowByName("OrganizerWindow", "")
                        self:setShowing(false)
                    end
                ),
                Button(
                    3000172,
                    function ()
                        ToggleWindowByName("MacroWindow", "")
                        self:setShowing(false)
                    end
                ),
                Button(
                    1079812,
                    function ()
                        ToggleWindowByName("ActionsWindow", "")
                        self:setShowing(false)
                    end
                ),
                Button(
                    1061037,
                    function ()
                        UusCorp.Api.Event.Broadcast(Events.help())
                        EventApi.broadcast(Events.help())
                        self:setShowing(false)
                    end
                ),
                Button(
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