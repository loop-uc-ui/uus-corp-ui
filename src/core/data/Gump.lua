Gump = {}

Gump.Map = {
    Runebook = {
        Id = 89,
        Buttons = {
            DropRune = 199,
            GateTravel = 99,
            RecallCharge = 9,
            RecallSpell = 49,
            RenameBook = 1000,
            SacredJourney = 74
        }
    },
    SingleLineTextEntry = {
        Id = 686,
        Buttons = {
            Submit = 44
        }
    }
}

function Gump.getStringPageIndex()
    return WindowData.GG_Core.stringPageIndex
end

function Gump.getToolTipPageIndex()
    return WindowData.GG_Core.toolTipPageIndex
end

function Gump.getLocalizedDataCount()
    return WindowData.GG_Core.localizedDataCount
end

function Gump.getButtonIdData()
    return WindowData.GG_Core.buttonIdData
end

function Gump.getStringDataCount()
    return WindowData.GG_Core.stringDataCount
end

function Gump.getButtonIdDataCount()
    return WindowData.GG_Core.buttonIdDataCount
end

function Gump.getGumpId()
    return WindowData.GG_Core.GumpId
end

function Gump.getStringData()
    return WindowData.GG_Core.stringData
end

function Gump.getDescCount()
    return WindowData.GG_Core.descCount
end

function Gump.getTokenPageIndex()
    return WindowData.GG_Core.tokenPageIndex
end

function Gump.getDescPageIndex()
    return WindowData.GG_Core.descPageIndex
end

function Gump.getObjectId()
    return WindowData.GG_Core.ObjectId
end

function Gump.getDesc()
    return WindowData.GG_Core.desc
end

function Gump.getTextHueDataCount()
    return WindowData.GG_Core.textHueDataCount
end

function Gump.getTextHueData()
    return WindowData.GG_Core.textHueData
end

function Gump.getHuePageIndex()
    return WindowData.GG_Core.huePageIndex
end

function Gump.getPortImgData()
    return WindowData.GG_Core.portImgData
end

function Gump.getPortPageIndex()
    return WindowData.GG_Core.portPageIndex
end

function Gump.getTilePageIndex()
    return WindowData.GG_Core.tilePageIndex
end

function Gump.getGumpPicNumDataCount()
    return WindowData.GG_Core.gumppicNumDataCount
end

function Gump.getButtonPageIndex()
    return WindowData.GG_Core.buttonPageIndex
end

function Gump.returnGumpId(gumpId)
    ReturnWindowData.GG_Core.GumpId = gumpId
end

function Gump.returnButtonId(buttonId)
    ReturnWindowData.GG_Core.ButtonId = buttonId
end

function Gump.returnObjectId(objectId)
    ReturnWindowData.GG_Core.ObjectId = objectId
end

function Gump.returnText(text)
    ReturnWindowData.GG_Core.TheTexts[1] = text
end

function Gump.returnTextEntryId(textEntryId)
    ReturnWindowData.GG_Core.TextEntryID = textEntryId
end

function Gump.returnTextLength(length)
    ReturnWindowData.GG_Core.TheTextLengths[1] = length
end

function Gump.returnCode(code)
    ReturnWindowData.GG_Core.TheCode = code
end

function Gump.gumpData(gumpID)
    return GumpData.Gumps[gumpID]
end

function Gump.gumps()
    return GumpData.Gumps
end

