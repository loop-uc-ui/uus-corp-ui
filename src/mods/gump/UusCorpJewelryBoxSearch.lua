UusCorpJewelryBoxSearch = {}
UusCorpJewelryBoxSearch.Data = {}

function UusCorpJewelryBoxSearch.onInitialize()
    local gumpData = UusCorpGump.Data[WindowApi.getId(WindowApi.getParent(Active.window()))]
    for k, v in ipairs(gumpData.Buttons) do
        local objectId = GumpApi.getItemPropertiesObjectId(
            WindowApi.getId(v),
            v
        )

        if objectId ~= nil and objectId ~= 0 then
            WindowDataApi.registerData(
                ItemPropertiesData.type(),
                objectId
            )

            UusCorpJewelryBoxSearch.Data[v] = {
                id = objectId
            }
        end
    end

    WindowApi.registerEventHandler(
        Active.window(),
        ItemPropertiesData.event(),
        "UusCorpJewelryBoxSearch.updateItemPropertes"
    )

    UusCorpJewelryBoxSearch.updateItemPropertes()
end

function UusCorpJewelryBoxSearch.updateItemPropertes()
    for k, v in pairs(UusCorpJewelryBoxSearch.Data) do
        local properties = ItemPropertiesData.propertiesList(v.id)
        if properties ~= nil and #properties > 0 then
            local search = ""

            for i = 1 , #properties do
                search = search .. " " .. StringFormatter.fromWString(properties[i])
            end

            UusCorpJewelryBoxSearch.Data[k] = {
                id = v.id,
                properties = search
            }
        end
    end
end

function UusCorpJewelryBoxSearch.onTextChanged(text)
    for k, v in pairs(UusCorpJewelryBoxSearch.Data) do
        local isFound = string.find(
            string.lower(v.properties),
            string.lower(StringFormatter.fromWString(text))
        ) ~= nil
        WindowApi.setShowing(k, isFound)
    end
end

function UusCorpJewelryBoxSearch.onShutdown()
    for _, v in pairs(UusCorpJewelryBoxSearch.Data) do
        WindowDataApi.unregisterData(ItemPropertiesData.type(), v.id)
    end
    WindowApi.unregisterEventHandler(Active.window(), ItemPropertiesData.event())
    UusCorpJewelryBoxSearch.Data = {}
end