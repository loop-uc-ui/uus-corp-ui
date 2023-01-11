Shopkeeper = {}
Shopkeeper.Name = "Shopkeeper"

Shopkeeper.Lists = {
    Top = Shopkeeper.Name .. "TopList",
    Bottom = Shopkeeper.Name .. "BottomList"
}

local function incrementQuantity(id, increment)
    local max

    if ShopData.isSelling() then
        max = ShopData.sellQuantities(id)
    else
        max = ObjectInfo.shopQuantity(id)
    end

    local itemWindow = "ShopItem" .. id

    local quantityWindow = itemWindow .. "Quantity"

    local current = tonumber(
        LabelApi.getText(
            quantityWindow
        ),
        10
    )

    --If we go beyond 0 then set the value to 0.
    --If we go beyond the max then set the value to the max.
    --Otherwise, add the increment to the current value
    if current + increment <= 0 then
        current = 0
    elseif current + increment >= max then
        current = max
    else
        current = current + increment
    end

    LabelApi.setText(
        quantityWindow,
        StringFormatter.toWString(
            current
        )
    )
end

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

local function createItems(objectId, previous)
    local itemWindow = "ShopItem" .. objectId

    WindowApi.createFromTemplate(
        itemWindow,
        "ShopItemTemplate",
        Shopkeeper.Lists.Top .. "ScrollChild"
    )

    if previous() ~= nil then
        WindowApi.addAnchor(
            itemWindow,
            "bottom",
            "ShopItem" .. previous(),
            "top",
            0,
            0
        )
    end
end

local function updateSellItems()
    for i = 1, #ShopData.sellNames() do
        if ShopData.sellQuantities(i) > 0 then
            createItems(
                i,
                function ()
                    if i > 1 then
                        return ShopData.sellId(i - 1)
                    else
                        return nil
                    end
                end
            )
        end
    end
end

local function updateBuyItems(id)
    local sellContainerId = ObjectInfo.sellContainerId(id)

    for i = 1, Container.itemCount(sellContainerId) do
        local item = Container.items(sellContainerId)[i]

        createItems(
            item.objectId,
            function ()
                if i > 1 then
                    return Container.items(sellContainerId)[i - 1].objectId
                else
                    return nil
                end
            end
        )
    end
end

function Shopkeeper.onInitialize()
    local window = Active.window()
    local merchantId = Active.dynamicWindowId()

    WindowApi.setId(
        window,
        merchantId
    )

    if ShopData.isSelling() then
        updateSellItems()
    else
        WindowDataApi.registerData(
            ObjectInfo.type(),
            merchantId
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
            Container.type(),
            ObjectInfo.sellContainerId(merchantId)
        )

        updateBuyItems(merchantId)
    end

    ScrollWindowApi.updateScrollRect(
        Shopkeeper.Lists.Top
    )
end

function Shopkeeper.onItemInitialize()
    local id = tonumber(
        string.gsub(
            Active.window(),
            "ShopItem",
            ""
        ),
        10
    )

    WindowApi.setId(
        Active.window(),
        id
    )

    --If we're selling then the data is presume not to change
    --and we take the data from ShopData instead of ObjectInfo
    if ShopData.isSelling() then
        Shopkeeper.onUpdateObjectInfo(
            {
                name = ShopData.sellName(id),
                type = ShopData.sellType(id),
                quantity = ShopData.sellQuantities(id),
                price = ShopData.sellPrice(id)
            }
        )
    else
        WindowDataApi.registerData(
            ObjectInfo.type(),
            id
        )

        WindowApi.registerEventHandler(
            Active.window(),
            ObjectInfo.event(),
            "Shopkeeper.onUpdateObjectInfo"
        )
    end
end

function Shopkeeper.onItemShutdown()
    if ShopData.isSelling() then
        return
    end

    local id = WindowApi.getId(Active.window())

    WindowDataApi.unregisterData(
        ObjectInfo.type(),
        id
    )

    WindowApi.unregisterEventHandler(
        Active.window(),
        ObjectInfo.event()
    )
end

function Shopkeeper.onRightClick()
    WindowApi.destroyWindow(Active.window())
end

function Shopkeeper.onShutdown()
    if ShopData.isSelling() then
        return
    end

    local merchantId = WindowApi.getId(Active.window())

    WindowDataApi.unregisterData(
        Container.type(),
        merchantId
    )

    WindowDataApi.unregisterData(
        ObjectInfo.type(),
        merchantId
    )

    WindowDataApi.unregisterData(
        MobileData.nameType(),
        merchantId
    )

    WindowApi.unregisterEventHandler(
        Active.window(),
        MobileData.nameEvent()
    )
end

function Shopkeeper.onUpdateObjectInfo(data)
    local itemWindow = Active.window()
    local objectId = WindowApi.getId(itemWindow)
    local objectName = data and data.name or ObjectInfo.name(objectId)
    local objectType = data and data.type or ObjectInfo.objectType(objectId)
    local objectQuantity = data and data.quantity or ObjectInfo.shopQuantity(objectId)
    local objectPrice = data and data.price or ObjectInfo.shopValue(objectId)

    LabelApi.setText(
        itemWindow .. "Name",
        stripFirstNumber(objectName)
    )

    local iconWindow = itemWindow .. "IconHolderSquareIcon"

    WindowApi.setId(
        iconWindow,
        objectId
    )

    local name, x, y, _, newWidth, newHeight = IconApi.requestTileArt(
        objectType,
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

    LabelApi.setText(
        itemWindow .. "Cost",
        objectPrice .. " gp"
    )

    LabelApi.setText(
        itemWindow .. "Quantity",
        StringFormatter.toWString(objectQuantity)
    )

    ButtonApi.setText(
        itemWindow .. "BuyAll",
        "All"
    )
end

function Shopkeeper.onQuantityUp()
    incrementQuantity(
        WindowApi.getId(
            WindowApi.getParent(
                Active.window()
            )
        ),
        -1
    )
end

function Shopkeeper.onQuantityDown()
    incrementQuantity(
        WindowApi.getId(
            WindowApi.getParent(
                Active.window()
            )
        ),
        1
    )
end

function Shopkeeper.onItemDoubleClick(flags)
    local plus = Active.window() .. "BuyMore"
    local minus = Active.window() .. "BuyLess"
    local buyAll = Active.window() .. "BuyAll"

    if WindowApi.hasFocus(plus) or WindowApi.hasFocus(minus)
        or WindowApi.hasFocus(buyAll) then
        return
    end

    local increment = -1

    if ButtonFlags.isShift(flags) then
        increment = -math.huge
    end

    incrementQuantity(
        WindowApi.getId(
            Active.window()
        ),
        increment
    )
end

function Shopkeeper.onBuyAll()
    incrementQuantity(
        WindowApi.getId(
            WindowApi.getParent(
                Active.window()
            )
        ),
        -math.huge
    )
end

function Shopkeeper.onUpdateMobileName()
end