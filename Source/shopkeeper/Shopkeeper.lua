Shopkeeper = {}
Shopkeeper.Name = "Shopkeeper"
Shopkeeper.List = Shopkeeper.Name .. "List"
Shopkeeper.ScrollChild = Shopkeeper.List .. "ScrollChild"


local function stripFirstNumber(wStr)
	if (not wStr or wStr == "" or wStr == L"") then
		return wStr
	end
	if (type(wStr) == "string") then
		wStr = StringFormatter.toWString(wStr)
	end
	wStr = wstring.gsub(wStr, L"%,", L"" )
	local tempStr = wstring.gsub(wStr, L"^%d* ", L"" )
	return tempStr
end

local function updateBuyItems(id)
    local sellContainerId = ObjectInfo.sellContainerId(id)

    for i = 1, Container.itemCount(sellContainerId) do
        local item = Container.items(sellContainerId)[i]

        WindowDataApi.registerData(
            ObjectInfo.type(),
            item.objectId
        )

        WindowDataApi.registerData(
            ItemProperties.type(),
            item.objectId
        )

        local itemWindow = "ShopItem" .. item.objectId

        WindowApi.createFromTemplate(
            itemWindow,
            "ShopItemTemplate",
            Shopkeeper.ScrollChild
        )

        LabelApi.setText(
            itemWindow .. "Name",
            stripFirstNumber(
                ObjectInfo.name(
                    item.objectId
                )
            )
        )

        local iconWindow = itemWindow .. "IconHolderSquareIcon"

        local name, x, y, scale, newWidth, newHeight = IconApi.requestTileArt(
            ObjectInfo.objectType(item.objectId),
            300,
            300
        )

        DynamicImageApi.setTextureDimensions(
            iconWindow,
            newWidth,
            newHeight
        )

        WindowApi.setDimensions(
            iconWindow,
            newWidth,
            newHeight
        )

        DynamicImageApi.setTexture(
            iconWindow,
            name,
            x,
            y
        )

        if i > 1 then
            WindowApi.addAnchor(
                itemWindow,
                "bottomleft",
                "ShopItem" .. Container.items(sellContainerId)[i - 1].objectId,
                "toptop",
                0,
                12
            )
        end
    end

    ScrollWindowApi.updateScrollRect(Shopkeeper.List)
end

function Shopkeeper.onInitialize()
    local window = Active.window()
    local merchantId = Active.dynamicWindowId()

    WindowApi.setId(
        window,
        merchantId
    )


    WindowDataApi.registerData(
        ObjectInfo.type(),
        merchantId
    )

    WindowApi.registerEventHandler(
        window,
        ObjectInfo.event(),
        "Shopkeeper.onUpdateObjectInfo"
    )

    WindowDataApi.registerData(
        Container.type(),
        ObjectInfo.sellContainerId(merchantId)
    )

    WindowApi.registerEventHandler(
        window,
        Container.event(),
        "Shopkeeper.onUpdateContainer"
    )

    WindowDataApi.registerData(
        ItemProperties.type(),
        merchantId
    )

    WindowApi.registerEventHandler(
        window,
        ItemProperties.event(),
        "Shopkeeper.onUpdateItemProperties"
    )

    WindowDataApi.registerData(
        MobileData.nameType(),
        merchantId
    )

    WindowApi.registerEventHandler(
        window,
        MobileData.nameEvent(),
        "Shopkeeper.onUpdateMobileName"
    )

    WindowDataApi.registerData(
        PlayerStatus.type(),
        0
    )

    WindowApi.registerEventHandler(
        window,
        PlayerStatus.event(),
        "Shopkeeper.onUpdatePlayerStatus"
    )

    updateBuyItems(merchantId)
end

function Shopkeeper.onRightClick()
    WindowApi.destroyWindow(Active.window())
end

function Shopkeeper.onShutdown()
    local merchantId = WindowApi.getId(Active.window())

    WindowDataApi.unregisterData(
        Container.type(),
        merchantId
    )

    WindowApi.unregisterEventHandler(
        Active.window(),
        Container.event()
    )

    WindowDataApi.unregisterData(
        ObjectInfo.type(),
        merchantId
    )

    WindowApi.unregisterEventHandler(
        Active.window(),
        ObjectInfo.event()
    )

    WindowDataApi.unregisterData(
        ItemProperties.type(),
        merchantId
    )

    WindowApi.unregisterEventHandler(
        Active.window(),
        ItemProperties.event()
    )

    WindowDataApi.unregisterData(
        MobileData.nameType(),
        merchantId
    )

    WindowApi.unregisterEventHandler(
        Active.window(),
        MobileData.nameEvent()
    )

    WindowDataApi.unregisterData(
        PlayerStatus.type(),
        0
    )

    WindowApi.unregisterEventHandler(
        Active.window(),
        PlayerStatus.event()
    )
end

function Shopkeeper.onUpdateContainer()

end

function Shopkeeper.onUpdateObjectInfo()

end

function Shopkeeper.onUpdateItemProperties()
end

function Shopkeeper.onUpdateMobileName()
end

function Shopkeeper.onUpdatePlayerStatus()
end