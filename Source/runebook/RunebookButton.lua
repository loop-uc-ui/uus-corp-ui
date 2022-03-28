RunebookButton = {
    Name = "RunebookButtonWindow",
    Templates = {
        TRAMMEL = {
            NAME = "LegacyPurpleRuneTemplate",
            HUE_ID = 10,
            COLOR = {r = 73, g = 0, b = 146, a = 255}
        },
        MALAS = {
            NAME = "LegacyGrayRuneTemplate",
            HUE_ID = 1102,
            COLOR = {r = 146, g = 73, b = 0, a = 255}
        },
        FELUCCA = {
            NAME = "LegacyTorquoiseRuneTemplate",
            HUE_ID = 81,
            COLOR = {r = 10, g = 90, b = 90, a = 255}
        },
        TOKUNO = {
            NAME = "LegacyGreenRuneTemplate",
            HUE_ID = 1154,
            COLOR = {r = 0, g = 50, b = 0, a = 255}
        },
        TER_MUR = {
            NAME = "LegacyBrownRuneTemplate",
            HUE_ID = 1645,
            COLOR = {r = 0, g = 109, b = 219, a = 255}
        },
        DEFAULT = {
            NAME = "LegacyDefaultButtonTemplate",
            HUE_ID = 0,
            COLOR = {r = 34, g = 34, b = 34, a = 255}
        }
    },
    init = function(index, name, hueId, labelText, coords)
        local template = RunebookButton.Templates.DEFAULT

        if hueId then
            for _, value in pairs(RunebookButton.Templates) do
                if value.HUE_ID == hueId then
                    template = value
                    break
                end
            end
        end

        local self = UusCorpWindow.init(
            name or LegacyRunebook.Name .. "RuneButton" .. index,
            template.NAME,
            LegacyRunebook.Name
        )

        local text = UusCorpLabel.init(
            self.getName() .. "Name",
            labelText,
            template.COLOR
        )

        local button = UusCorpButton.init(self.getName() .. "Icon")

        self.onClick = function(isPressed)
            if isPressed then
                text.setTextColor({
                    r = 200,
                    g = 0,
                    b = 0,
                    a = 255
                })
            else
                text.setTextColor(template.COLOR)
            end
        end

        self.getChildAdapter().addChild(text)

        self.getChildAdapter().addChild(button)

        self.getRecallSpellIndex = function()
            return index + 49
        end
        
        self.getRecallChargeIndex = function ()
            return index + 9
        end
        
        self.getGateTravelIndex = function()
            return index + 99
        end
        
        self.getSacredJourneyIndex = function() 
            return index + 74
        end

        self.getIndex = function ()
            return index
        end

        local function anchorButton()
            if not index then
                return
            elseif index == 1 then
                self.addAnchor(
                    "topleft",
                    LegacyRunebook.Name .. "First",
                    "topleft",
                    15,
                    20
                )
            elseif index == 9 then
                self.addAnchor(
                    "topleft",
                    LegacyRunebook.Name .. "Second",
                    "topleft",
                    15,
                    20
                )
            else
                self.addAnchor(
                    "bottomleft",
                    LegacyRunebook.Name .. "RuneButton" .. index - 1,
                    "topleft",
                    0,
                    0
                )
            end
        end

        self.getLifeCycle().onInitialize = function ()
            self.create()
            UusCorpWindow.onInitialize(self)
            anchorButton()
            button.setDisabled(coords == L"Nowhere")
        end

        return self
    end
}
