UusCorpGump = {}
UusCorpGump.Data = {}
UusCorpGump.Ids = {
    JewelryBox = 61,
    JewelryBoxPartial = 24,
    VendorSearch = 218,
    VendorSearchStoredSearch = 219
}

function UusCorpGump.initialize()
    UusCorpCore.loadResources(
        "/src/mods/gump",
        "UusCorpJewelryBoxSearch.xml"
    )

    GumpsParsing.GumpMaps[999112].name = "UUS_CORP_OVERRIDE_VendorSearch"

    local gumpParsing = UusCorpCore.copyTable(GumpsParsing)
    local genericGump = UusCorpCore.copyTable(GenericGump)

    function GumpsParsing.MainParsingCheck(timePassed)
        gumpParsing.MainParsingCheck(timePassed)
        GumpsParsing.ToShow[999139] = nil -- Supress pet training progress gump
    end

    function GenericGump.OnShown()
        local id = WindowApi.getId(Active.window())

        for k, v in pairs(Gump.gumps()) do
            if v.windowName == Active.window() then
                UusCorpGump.Data[id] = Gump.gumpData(k)
                break
            end
        end

        local gump = UusCorpGump.Data[id]
        local gumpId = gump.id

        if gumpId == UusCorpGump.Ids.JewelryBox or gumpId == UusCorpGump.Ids.JewelryBoxPartial then
            WindowApi.createFromTemplate(
                "UusCorpJewelryBoxSearch",
                "UusCorpJewelryBoxSearch",
                Active.window()
            )
        elseif gumpId == UusCorpGump.Ids.VendorSearch or gumpId == UusCorpGump.Ids.VendorSearchStoredSearch then
            for _, v in pairs(gump.TextEntry) do
                EditTextBoxApi.setTextColor(v, Colors.OffBlack)
            end
        end
    end

    function GenericGump.Shutdown()
        UusCorpGump.Data[WindowApi.getId(Active.window())] = nil
        genericGump.Shutdown()
    end
end