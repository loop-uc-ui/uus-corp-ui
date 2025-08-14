
---@param context Context
local SearchBox = function (context)
    return context.Views.EditTextBox {
        events = {
            OnInitialize = function (self)
                self:setDimensions(100, 24)
                self:anchorToParentTop(0, 0)
            end
        }
    }
end

---@param context Context
---@param gump GumpWindow
local SearchBoxWindow = function (context, gump)
    return context.Views.Window {
        events = {
            OnInitialize = function (self)
                self:addAnchor("bottom", gump:getName(), "bottom", 0, 0)
                self:setDimensions(100, 100)
                self:setLayer(context.Constants.WindowLayers.Overlay)
                self:setChildren {
                    SearchBox(context)
                }
            end,
            OnUpdate = function (self)
                if not gump:doesExist() then
                    self:destroy()
                end
            end
        }
    }
end

UusCorpJewelryBoxSearch = UusCorp.Mod {
    Name = "UusCorpJewelryBoxSearch",
    Path = "/src/mods/gump",
    OnInitialize = function (context)
        context.Views.Defaults.GenericGump:appendToFunction(
            "OnShown",
            function (_)
                local gump = context.Views.Gump()

                if not gump then
                    return
                end

                Debug.Print("testing hello")

                if gump:isJewelryBox() then
                    Debug.Print("testing")
                    SearchBoxWindow(context, gump):create(true)
                end
            end
        )
    end
}