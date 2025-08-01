UusCorpClassicVendorSearch = UusCorp.Mod {
    Name = "UusCorpClassicVendorSearch",
    Path = "/src/mods/classic-vendor-search",
    OnInitialize = function (context)
        context.Views.Defaults.GumpsParsing:getDefault().GumpMaps[999112].name = "UUS_CORP_OVERRIDE_VendorSearch"

        context.Views.Defaults.GenericGump:appendToFunction(
            "OnShown",
            function(_)
                local gump = context.Data.Gumps():getGump()

                if not gump then
                    return
                elseif gump:isVendorSearch() or gump:isVendorStoredSearch() then
                    context.Utils.Array.ForEach(
                        gump:getTextEntries(),
                        function (item, _)
                            item:setTextColor(context.Constants.Colors.OffBlack)
                        end
                    )
                end
            end
        )
    end
}