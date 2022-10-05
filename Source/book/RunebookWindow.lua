RunebookWindow = {}
RunebookWindow.Name = "RunebookWindow"

local labels = {}

local actions = {}

local runes = {}

function RunebookWindow.onInitialize()
    WindowApi.setId(
        Active.window(),
        Gump.getObjectId()
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
            Active.window()
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
end

function RunebookWindow.onRightClick()
    WindowApi.destroyWindow(Active.window())
end