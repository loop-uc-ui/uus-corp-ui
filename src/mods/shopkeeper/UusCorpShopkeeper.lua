UusCorpShopkeeper = {}
UusCorpShopkeeper.Name = "Shopkeeper"

UusCorpShopkeeper.Lists = {
    Top = UusCorpShopkeeper.Name .. "TopList",
    Bottom = UusCorpShopkeeper.Name .. "BottomList"
}

UusCorpShopkeeper.Total = UusCorpShopkeeper.Name .. "Total"

-- The item we're buying/selling is tied to onUpdate
-- in order to allow for long pressing of the + / - buttons.
local updateItem = {
    id = nil,
    increment = nil,
    doStop = false
}

local shoppingCart = {}

local merchantList = {}

local acceptOffer = false

local function incrementQuantity(id, increment)
    local max

    if ShopData.isSelling() then
        local index = 1

        for i = 1, #ShopData.sellIds() do
            if id == ShopData.sellId(i) then
                break
            end
            index = i + 1
        end

        max = ShopData.sellQuantities(index)
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

    local item = merchantList[id]

    item.quantity = function()
        return max - current
    end

    item.price = function()
        return item.quantity() * tonumber(
            LabelApi.getText(
                "ShopItem" .. id .. "Cost"
            )
        )
    end

    return item
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
        UusCorpShopkeeper.Lists.Top .. "ScrollChild"
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
                ShopData.sellId(i),
                function ()
                    if i > 1 then
                        return ShopData.sellId(i - 1)
                    else
                        return nil
                    end
                end
            )

            merchantList[ShopData.sellId(i)] = {
                id = function()
                    return ShopData.sellId(i)
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

            UusCorpShopkeeper.onUpdateObjectInfo(
                "ShopItem" .. ShopData.sellId(i),
                merchantList[ShopData.sellId(i)]
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
            "UusCorpShopkeeper.onUpdateObjectInfo"
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

function UusCorpShopkeeper.initialize()
    UusCorpCore.loadResources(
        "/src/mods/shopkeeper",
        "UusCorpShopkeeper.xml"
    )
end

function UusCorpShopkeeper.onInitialize()
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
            Container.type(),
            ObjectInfo.sellContainerId(merchantId)
        )

        updateBuyItems(merchantId)
    end

    ScrollWindowApi.updateScrollRect(
        UusCorpShopkeeper.Lists.Top
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

    WindowApi.setShowing(
        UusCorpShopkeeper.Total,
        false
    )
end

function UusCorpShopkeeper.onRightClick()
    WindowApi.destroyWindow(Active.window())
end

function UusCorpShopkeeper.onShutdown()
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

    if acceptOffer then
        EventApi.broadcast(Events.acceptShopOffer())
    else
        EventApi.broadcast(Events.cancelShopOffer())
    end

    acceptOffer = false
    updateItem = nil
    shoppingCart = {}
    merchantList = {}
end

function UusCorpShopkeeper.onUpdateObjectInfo(itemWindow, data)
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

    if string.match(itemWindow, "ShopCartItem") then
        ButtonApi.setText(
            itemWindow .. "BuyAll",
            "Clear"
        )
    else
        ButtonApi.setText(
            itemWindow .. "BuyAll",
            "All"
        )
    end
end

function UusCorpShopkeeper.onStopIncrement()
    updateItem = nil
end

function UusCorpShopkeeper.onQuantityUp()
    updateItem = {}
    updateItem.id = WindowApi.getId(
        WindowApi.getParent(
            Active.window()
        )
    )
    updateItem.increment = -1
end

function UusCorpShopkeeper.onQuantityDown()
    updateItem = {}
    updateItem.id = WindowApi.getId(
        WindowApi.getParent(
            Active.window()
        )
    )
    updateItem.increment = 1
end

function UusCorpShopkeeper.onItemDoubleClick(flags)
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

    updateItem = {}
    updateItem.id = WindowApi.getId(
        Active.window()
    )
    updateItem.increment = increment
    updateItem.doStop = true
end

function UusCorpShopkeeper.onBuyAll()
    local increment = -math.huge

    if string.match(Active.window(), "ShopCartItem") then
        increment = math.abs(increment)
    end

    updateItem = {}
    updateItem.id = WindowApi.getId(
        WindowApi.getParent(
            Active.window()
        )
    )
    updateItem.increment = increment
    updateItem.doStop = true
end

function UusCorpShopkeeper.onUpdateShoppingCart()
    if updateItem == nil or updateItem.id == nil or updateItem.increment == nil then
        return
    end

    local update = incrementQuantity(updateItem.id, updateItem.increment)

    local itemWindow = "ShopCartItem" .. update.id()

    if WindowApi.createFromTemplate(
        itemWindow,
        "ShopItemTemplate",
        UusCorpShopkeeper.Lists.Bottom .. "ScrollChild"
    ) then
        WindowApi.setId(
            itemWindow,
            update.id()
        )

        table.insert(
            shoppingCart,
            update
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
            UusCorpShopkeeper.Lists.Bottom
        )
    end

    UusCorpShopkeeper.onUpdateObjectInfo(
        itemWindow,
        update
    )

    if update.quantity() <= 0 then
        WindowApi.destroyWindow(
            itemWindow
        )

        for i = 1, #shoppingCart do
            local item = shoppingCart[i]
            if item.id() == update.id() then
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
        UusCorpShopkeeper.Total,
        #shoppingCart > 0
    )

    local total = 0

    for i = 1, #shoppingCart do
        local item = "ShopCartItem" .. shoppingCart[i].id() .. "Cost"
        local cost = tonumber(
            string.match(
                StringFormatter.fromWString(
                    LabelApi.getText(
                        item
                    )
                ),
                "%d+"
            )
        )
        total = total + cost
    end

    if total > 0 then
        LabelApi.setText(
            UusCorpShopkeeper.Total,
            "Total: " .. total .. " gp"
        )
    end

    if updateItem.doStop then
        updateItem = nil
    end
end

function UusCorpShopkeeper.onSendTransaction()
    for i = 1, #shoppingCart do
        ShopData.offerIds()[i] = shoppingCart[i].id()
        ShopData.offerQuantities()[i] = shoppingCart[i].quantity()
    end
    acceptOffer = true
    WindowApi.destroyWindow(WindowApi.getParent(Active.window()))
end

function UusCorpShopkeeper.onClearShoppingCart()
    for i = 1, #shoppingCart do
        WindowApi.destroyWindow("ShopCartItem" .. shoppingCart[i].id())
    end
    ScrollWindowApi.updateScrollRect(UusCorpShopkeeper.Lists.Bottom)
    shoppingCart = {}
end