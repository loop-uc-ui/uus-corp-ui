UusCorpRunebookWindow = {}
UusCorpRunebookWindow.Name = "LEGACY_Runebook_GUMP"
UusCorpRunebookWindow.NameLabel = UusCorpRunebookWindow.Name .. "Name"
UusCorpRunebookWindow.NameEditBox = UusCorpRunebookWindow.Name .. "NameEditBox"

local FacetColorMap = {
    Malas = {
        id = 1102,
        name = "Malas"
    },
    Trammel = {
        id = 10,
        name = "Trammel"
    },
    Tokuno = {
        id = 1154,
        name = "Tokuno"
    },
    Felucca = {
        id = 81,
        name = "Felucca"
    },
    TerMur = {
        id = 1645,
        name = "Ter Mur"
    }
}

local labels = {}

local actions = {}

local runes = {}

local function processRuneClick(spellId, buttonId, buttonOffset)
    UserAction.requestSpell(spellId)
    GumpWindow.broadcastButtonPress(
        buttonId + buttonOffset,
        Gump.Map.Runebook.Id,
        WindowApi.getId(UusCorpRunebookWindow.Name)
    )
    WindowApi.destroyWindow(UusCorpRunebookWindow.Name)
end

local function toggleRename()
    WindowApi.setShowing(
        UusCorpRunebookWindow.NameLabel,
        not WindowApi.isShowing(UusCorpRunebookWindow.NameLabel)
    )

    WindowApi.setShowing(
        UusCorpRunebookWindow.NameEditBox,
        not WindowApi.isShowing(UusCorpRunebookWindow.NameEditBox)
    )

    WindowApi.assignFocus(
        UusCorpRunebookWindow.NameEditBox,
        WindowApi.isShowing(UusCorpRunebookWindow.NameEditBox)
    )

    UusCorpRunebookWindow.onUpdateItemProperties()
end

function UusCorpRunebookWindow.initialize()
    UusCorpCore.loadResources(
        "/mods/runebook",
        "UusCorpRunebookWindow.xml"
    )
end

function UusCorpRunebookWindow.onInitialize()
    WindowApi.setId(
        Active.window(),
        Gump.getObjectId()
    )

    WindowDataApi.registerData(
        ItemPropertiesData.type(),
        Gump.getObjectId()
    )

    WindowApi.registerEventHandler(
        Active.window(),
        ItemPropertiesData.event(),
        "UusCorpRunebookWindow.onUpdateItemProperties"
    )

    for k, v in ipairs(Gump.getStringData()) do
        if k <= 2 then
            table.insert(
                labels,
                {
                    name = v
                }
            )
            labels[k] = {
                name = v
            }
        elseif k <= 18 then
            table.insert(
                runes,
                {
                    name = v
                }
            )
        elseif k <= 20 then
            labels[k - 18].value = v
        elseif k <= 23 then
            table.insert(
                actions,
                {
                    name = v
                }
            )
        elseif k <= 39 then
            runes[k - 23].location = v
        end
    end

    for k, v in ipairs(runes) do
        local window = "RunebookRow" .. k

        WindowApi.createFromTemplate(
            window,
            "RunebookRowTemplate",
            Active.window() .. "ListScrollChild"
        )

        WindowApi.setId(
            window,
            k
        )

        LabelApi.setText(
            window .. "Name",
            v.name
        )

        local hue = Gump.getTextHueData()[k]

        LabelApi.setText(window .. "Facet", "--")

        for _, j in pairs(FacetColorMap) do
            if hue == j.id then
                LabelApi.setText(
                    window .. "Facet",
                    j.name
                )
                break
            end
        end

        LabelApi.setText(
            window .. "Location",
            v.location
        )

        if k > 1 then
            WindowApi.addAnchor(
                window,
                "bottomleft",
                "RunebookRow" .. k - 1,
                "topleft",
                0,
                4
            )
        end
    end

    WindowApi.setShowing(
        Active.window() .. "ListScrollbar",
        #runes > 16
    )

    LabelApi.setText(
        Active.window() .. "Charges",
        StringFormatter.fromWString(labels[1].name) .. " "
            .. StringFormatter.fromWString(labels[1].value)
            .. "/" .. StringFormatter.fromWString(labels[2].value)
    )


    WindowApi.setShowing(
        UusCorpRunebookWindow.NameEditBox,
        false
    )

    UusCorpRunebookWindow.onUpdateItemProperties()

    ScrollWindowApi.updateScrollRect(Active.window() .. "List")
end

function UusCorpRunebookWindow.onUpdateItemProperties()
    local objectId = WindowApi.getId(UusCorpRunebookWindow.Name)
    local name = ItemPropertiesData.propertiesList(objectId)[
        #ItemPropertiesData.propertiesList(objectId)
    ]

    LabelApi.setText(
        UusCorpRunebookWindow.NameLabel,
        name
    )

    EditTextBoxApi.setText(
        UusCorpRunebookWindow.NameEditBox,
        name
    )
end

function UusCorpRunebookWindow.onRenameClick()
    GumpWindow.broadcastButtonPress(
        Gump.Map.Runebook.Buttons.RenameBook,
        Gump.Map.Runebook.Id,
        WindowApi.getId(UusCorpRunebookWindow.Name)
    )
    toggleRename()
end

function UusCorpRunebookWindow.onRenameEscape()
    GumpWindow.broadcastTextEntry(
        EditTextBoxApi.getText(UusCorpRunebookWindow.NameEditBox),
        false,
        WindowApi.getId(UusCorpRunebookWindow.Name)
    )
    toggleRename()
end

function UusCorpRunebookWindow.onRenameEnter()
    GumpWindow.broadcastTextEntry(
        EditTextBoxApi.getText(UusCorpRunebookWindow.NameEditBox),
        true,
        WindowApi.getId(UusCorpRunebookWindow.Name)
    )
    toggleRename()
    WindowApi.destroyWindow(UusCorpRunebookWindow.Name)
end

function UusCorpRunebookWindow.onShutdown()
    if WindowApi.isShowing(UusCorpRunebookWindow.NameEditBox) then
        UusCorpRunebookWindow.onRenameEscape()
    end

    WindowDataApi.unregisterData(
        ItemPropertiesData.type(),
        WindowApi.getId(UusCorpRunebookWindow.Name)
    )

    WindowApi.unregisterEventHandler(
        Active.window(),
        ItemPropertiesData.event()
    )

    labels = {}
    runes = {}
    actions = {}
end

function UusCorpRunebookWindow.onRightClick()
    WindowApi.destroyWindow(Active.window())
end

function UusCorpRunebookWindow.onRuneClick()
    local id = WindowApi.getId(Active.window())

    if StringFormatter.fromWString(runes[id].location) == "Nowhere" then
        return
    end

    local data = {}

    table.insert(
        data,
        {
            text = actions[1].name,
            onClick = function ()
                GumpWindow.broadcastButtonPress(
                    id + Gump.Map.Runebook.Buttons.DropRune,
                    Gump.Map.Runebook.Id,
                    WindowApi.getId(UusCorpRunebookWindow.Name)
                )
                WindowApi.destroyWindow(UusCorpRunebookWindow.Name)
            end
        }
    )

    table.insert(
        data,
        {
            text = StringFormatter.fromTid(1062723),
            onClick = function ()
                --Gate
                processRuneClick(
                    Spells.Ids.GateTravel,
                    id,
                    Gump.Map.Runebook.Buttons.GateTravel
                )
            end
        }
    )

    table.insert(
        data,
        {
            text = StringFormatter.fromTid(1077594),
            onClick = function ()
                --Recall charge
                processRuneClick(
                    Spells.Ids.Recall,
                    id,
                    Gump.Map.Runebook.Buttons.RecallCharge
                )
            end
        }
    )

    table.insert(
        data,
        {
            text = StringFormatter.fromTid(1077595),
            onClick = function ()
                --Recall
                processRuneClick(
                    Spells.Ids.Recall,
                    id,
                    Gump.Map.Runebook.Buttons.RecallSpell
                )
            end
        }
    )

    table.insert(
        data,
        {
            text = StringFormatter.fromTid(1062724),
            onClick = function ()
                --Sacred journey
                processRuneClick(
                    Spells.Ids.SacredJourney,
                    id,
                    Gump.Map.Runebook.Buttons.SacredJourney
                )
            end
        }
    )

    ContextMenuWindow.create(data)
end