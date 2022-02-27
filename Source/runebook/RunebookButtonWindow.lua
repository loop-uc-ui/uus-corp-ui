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

    if ( index == 1 ) then
        WindowAddAnchor(this.id, "topleft", LegacyRunebook.id.."First", "topleft", 15, 20)
    elseif ( index == 9 )then
        WindowAddAnchor(this.id, "topleft", LegacyRunebook.id.."Second", "topleft", 15, 20)
    else
        WindowAddAnchor(this.id, "bottomleft", LegacyRunebook.id.."RuneButton"..index-1, "topleft", 0, 0)
    end

    self.__index = self
    return setmetatable(this, self)
end