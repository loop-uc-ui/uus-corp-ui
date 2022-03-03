RunebookButtonWindow = ListWindow:new("RunebookButtonWindow")

RunebookButtonWindow.TEMPLATES = {
    TRAMMEL = {
        NAME = "LegacyPurpleRuneTemplate",
        HUE_ID = 10,
        COLOR = {
            r = 73,
            g = 0,
            b = 146,
            a = 255
        }
    },
    MALAS = {
        NAME = "LegacyGrayRuneTemplate",
        HUE_ID = 1102,
        COLOR = {
            r = 146,
            g = 73,
            b = 0,
            a = 255
        }
    },
    FELUCCA = {
        NAME = "LegacyTorquoiseRuneTemplate",
        HUE_ID = 81,
        COLOR = {
            r = 10,
            g = 90,
            b = 90,
            a = 255
        }
    },
    TOKUNO = {
        NAME = "LegacyGreenRuneTemplate",
        HUE_ID = 1154,
        COLOR = {
            r = 0,
            g = 50,
            b = 0,
            a = 255
        }
    },
    TER_MUR = {
        NAME = "LegacyBrownRuneTemplate",
        HUE_ID = 1645,
        COLOR = {
            r = 0,
            g = 109,
            b = 219,
            a = 255
        }
    },
    DEFAULT = {
        NAME = "LegacyDefaultButtonTemplate",
        HUE_ID = 0,
        COLOR = {
            r = 34,
            g = 34,
            b = 34,
            a = 255
        }
    }
}

function RunebookButtonWindow:new(index, hueId, labelText)
    local this = {
        index = index,
        id = LegacyRunebook.id.."RuneButton"..index,
        labelText = labelText
    }
    this.adapter = WindowAdapter:new(this.id)

    local template = RunebookButtonWindow.TEMPLATES.DEFAULT

    for _, value in pairs(RunebookButtonWindow.TEMPLATES) do
        if value.HUE_ID == hueId then
            template = value
            break
        end
    end

    this.template = template
    self.__index = self
    return setmetatable(this, self)
end

function RunebookButtonWindow:initialize()
    WindowApi.createFromTemplate(self.id, self.template.NAME, LegacyRunebook.id)

    self.adapter:addButton(
            self.id.."Icon"
    ):addLabel(
            self.id.."Name",
            self.labelText,
            self.template.COLOR
    )

    if self:coords() == L"Nowhere" then
        self.adapter.views[self.id.."Icon"]:setDisabledFlag(true)
    end
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

function RunebookButtonWindow:label()
    return self.adapter.views[self.id.."Name"]
end

function RunebookButtonWindow:name()
    return self.adapter.views[self.id.."Name"]:getText()
end

function RunebookButtonWindow:onClick(isPressed)
    if isPressed then
        self:label():setTextColor({
            r = 200,
            g = 0,
            b = 0,
            a = 255
        })
    else
        self:label():setTextColor(self.template.COLOR)
    end
end