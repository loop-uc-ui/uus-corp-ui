RunebookButtonWindow = ListWindow:new("RunebookButtonWindow")

RunebookButtonWindow.TEMPLATES = {
    TRAMMEL = "LegacyPurpleRuneTemplate",
    MALAS = "LegacyGrayRuneTemplate",
    FELUCCA = "LegacyTorquoiseRuneTemplate",
    TOKUNO = "LegacyGreenRuneTemplate",
    TER_MUR = "LegacyBrownRuneTemplate",
    DEFAULT = "LegacyDefaultButtonTemplate"
}

function RunebookButtonWindow:new(index, template, labelText)
    local this = {
        index = index,
        id = LegacyRunebook.id.."RuneButton"..index
    }
    this.adapter = WindowAdapter:new(this.id)
    WindowApi.createFromTemplate(this.id, template, LegacyRunebook.id)

    this.adapter:addButton(
            this.id.."Icon"
    ):addLabel(
            this.id.."Name",
            labelText
    )

    self.__index = self
    return setmetatable(this, self)
end

function RunebookButtonWindow:anchor(anchor)
    if anchor ~= nil then
        self:addAnchor(anchor.point, anchor.relativeTo, anchor.relativePoint, anchor.x, anchor.y)
    elseif self.index == 1 then
        self:addAnchor("topleft", LegacyRunebook.id.."First", "topleft", 15, 20)
    elseif self.index == 9 then
        self:addAnchor("topleft", LegacyRunebook.id.."Second", "topleft", 15, 20)
    else
        self:addAnchor("bottomleft", LegacyRunebook.id.."RuneButton"..self.index-1, "topleft", 0, 0)
    end
end

function RunebookButtonWindow:recallSpellIndex()
    return self.index + 49
end


function RunebookButtonWindow:recallChargeIndex()
    return self.index + 9
end

function RunebookButtonWindow:gateTravelIndex()
    return self.index + 99
end

function RunebookButtonWindow:sacredJourneyIndex()
    return self.index + 74
end

function RunebookButtonWindow:coords()
    return StringFormatter:replaceChar(GenericGumpCore.stringData()[self.index + 23], "o ",".")
end

function RunebookButtonWindow:name()
    return self.adapter.views[self.id.."Name"]:getText()
end