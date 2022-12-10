RunebookWindow = {}
RunebookWindow.Name = "RunebookWindow"

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

local gumpId = 0

local objectId = 0

local function processRuneClick(spellId, buttonId, buttonOffset)
    UserAction.requestSpell(spellId)
    EventApi.broadcast(Events.gumpAction(buttonId + buttonOffset, gumpId, objectId))
    WindowApi.destroyWindow(RunebookWindow.Name)
end

function RunebookWindow.onInitialize()
    WindowApi.setId(
        Active.window(),
        Gump.getObjectId()
    )

    gumpId = Gump.getGumpId()

    objectId = Gump.getObjectId()

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

    ScrollWindowApi.updateScrollRect(Active.window() .. "List")
end

function RunebookWindow.onShutdown()
    labels = {}
    runes = {}
    actions = {}
    gumpId = 0
    objectId = 0
end

function RunebookWindow.onRightClick()
    WindowApi.destroyWindow(Active.window())
end

function RunebookWindow.onRuneClick()
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
                EventApi.broadcast(Events.gumpAction(id + 199, gumpId, objectId))
                WindowApi.destroyWindow(RunebookWindow.Name)
            end
        }
    )

    table.insert(
        data,
        {
            text = StringFormatter.fromTid(1062723),
            onClick = function ()
                --Gate
                processRuneClick(52, id, 99)
            end
        }
    )

    table.insert(
        data,
        {
            text = StringFormatter.fromTid(1077594),
            onClick = function ()
                --Recall charge
                processRuneClick(32, id, 9)
            end
        }
    )

    table.insert(
        data,
        {
            text = StringFormatter.fromTid(1077595),
            onClick = function ()
                --Recall
                processRuneClick(32, id, 49)
            end
        }
    )

    table.insert(
        data,
        {
            text = StringFormatter.fromTid(1062724),
            onClick = function ()
                --Sacred journey
                processRuneClick(210, id, 74)
            end
        }
    )

    ContextMenuWindow.create(data)
end