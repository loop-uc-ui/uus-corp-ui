Shopkeeper = {}
Shopkeeper.Name = "Shopkeeper"

Shopkeeper.Lists = {
    Top = Shopkeeper.Name .. "TopList",
    Bottom = Shopkeeper.Name .. "BottomList"
}

Shopkeeper.EmptyText = Shopkeeper.Lists.Bottom .. "EmptyCart"

local updateItem

local shoppingCart = {}

local merchantList = {}

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

    updateItem = merchantList[id]

    updateItem.quantity = function()
        return max - current
    end

    updateItem.price = function()
        return updateItem.quantity() * tonumber(
            LabelApi.getText(
                "ShopItem" .. id .. "Cost"
            )
        )
    end
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

    WindowApi.setId(
        itemWindow,
        objectId
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

            merchantList[i] = {
                id = function()
                    return i
                end,
                name = function()
                    return ShopData.sellName(i)
                end,
                type = function()
                    return ShopData.sellType(i)
                end,
                quantity = function()
                    return ShopData.sellQuantities(i)
                end,
                price = function()
                    return ShopData.sellPrice(i)
                end
            }

            Shopkeeper.onUpdateObjectInfo(
                "ShopItem" .. i,
                merchantList[i]
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

        WindowDataApi.registerData(
            ObjectInfo.type(),
            item.objectId
        )

        WindowApi.registerEventHandler(
            "ShopItem" .. item.objectId,
            ObjectInfo.event(),
            "Shopkeeper.onUpdateObjectInfo"
        )

        --These need to be functions because there
        --is a delay in the time that the server sends this info.
        merchantList[item.objectId] = {
            id = function()
                return item.objectId
            end,
            name = function()
                return ObjectInfo.name(item.objectId)
            end,
            type = function()
                return ObjectInfo.objectType(item.objectId)
            end,
            quantity = function()
                return ObjectInfo.shopQuantity(item.objectId)
            end,
            price = function()
                return ObjectInfo.shopValue(item.objectId)
            end
        }
    end
end

function Shopkeeper.onInitialize()
    local window = Active.window()
    local merchantId = Active.dynamicWindowId()

    WindowApi.setUpdateFrequency(
        window,
        0.25
    )

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

    ButtonApi.setText(
        Active.window() .. "ClearShoppingCart",
        "Clear"
    )

    local buttonText = "Buy"

    if ShopData.isSelling() then
        buttonText = "Sell"
    end

    ButtonApi.setText(
        Active.window() .. "SendTransaction",
        buttonText
    )

    LabelApi.setText(
        Shopkeeper.EmptyText,
        "Your shopping cart is empty."
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

    for _, v in pairs(merchantList) do
        WindowDataApi.unregisterData(
            ObjectInfo.type(),
            v.id()
        )

        WindowApi.unregisterEventHandler(
            "ShopItem" .. v.id(),
            ObjectInfo.event()
        )
    end

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

    updateItem = nil
    shoppingCart = {}
    merchantList = {}
end

function Shopkeeper.onUpdateObjectInfo(itemWindow, data)
    itemWindow = itemWindow or Active.window()
    local objectId = WindowApi.getId(itemWindow)
    local objectName = data and data.name() or ObjectInfo.name(objectId)
    local objectType = data and data.type() or ObjectInfo.objectType(objectId)
    local objectQuantity = data and data.quantity() or ObjectInfo.shopQuantity(objectId)
    local objectPrice = data and data.price() or ObjectInfo.shopValue(objectId)

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

function Shopkeeper.onUpdateShoppingCart()
    if updateItem == nil then
        return
    end

    local itemWindow = "ShopCartItem" .. updateItem.id()

    if WindowApi.createFromTemplate(
        itemWindow,
        "ShopItemTemplate",
        Shopkeeper.Lists.Bottom .. "ScrollChild"
    ) then
        WindowApi.setId(
            itemWindow,
            updateItem.id()
        )

        table.insert(
            shoppingCart,
            updateItem
        )

        if #shoppingCart > 1 then
            WindowApi.addAnchor(
                itemWindow,
                "bottom",
                "ShopCartItem" .. shoppingCart[#shoppingCart - 1].id(),
                "top",
                0,
                0
            )
        end

        ScrollWindowApi.updateScrollRect(
            Shopkeeper.Lists.Bottom
        )
    end

    Shopkeeper.onUpdateObjectInfo(
        itemWindow,
        updateItem
    )

    if updateItem.quantity() <= 0 then
        WindowApi.destroyWindow(
            itemWindow
        )

        for i = 1, #shoppingCart do
            local item = shoppingCart[i]
            if item.id() == updateItem.id() then
                table.remove(
                    shoppingCart,
                    i
                )
                break
            end
        end

        for i = 1, #shoppingCart do
            local item = shoppingCart[i]
            local window = "ShopCartItem" .. item.id()
            WindowApi.clearAnchors(window)

            if i > 1 then
                WindowApi.addAnchor(
                    window,
                    "bottom",
                    "ShopCartItem" .. shoppingCart[i - 1].id(),
                    "top",
                    0,
                    0
                )
            end
        end
    end

    WindowApi.setShowing(
        Shopkeeper.EmptyText,
        #shoppingCart <= 0
    )

    updateItem = nil
end

function Shopkeeper.onUpdateMobileName()
end