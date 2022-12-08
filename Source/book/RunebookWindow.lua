RunebookWindow = {}
RunebookWindow.Name = "RunebookWindow"

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
            Active.window()
        )

        WindowApi.setId(
            window,
            k
        )

        LabelApi.setText(
            window .. "Name",
            v.name
        )

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
    local data = {}

    local id = WindowApi.getId(Active.window())

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