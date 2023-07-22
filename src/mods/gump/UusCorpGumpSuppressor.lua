UusCorpGumpSuppressor = {}

function UusCorpGumpSuppressor.initialize()
    GumpsParsing.GumpMaps[999112].name = "UUS_CORP_OVERRIDE_VendorSearch"
    local gumpParsing = UusCorpCore.copyTable(GumpsParsing)

    function GumpsParsing.MainParsingCheck(timePassed)
        gumpParsing.MainParsingCheck(timePassed)
        GumpsParsing.ToShow[999139] = nil
    end
end