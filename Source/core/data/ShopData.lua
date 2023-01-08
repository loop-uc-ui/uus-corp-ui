ShopData = {}

function ShopData.sellQuantities(index)
    return WindowData.ShopData.Sell.Quantities[index]
end

function ShopData.sellId(index)
    return WindowData.ShopData.Sell.Ids[index]
end

function ShopData.sellPrice(index)
    return WindowData.ShopData.Sell.Prices[index]
end

function ShopData.sellType(index)
    return WindowData.ShopData.Sell.Types[index]
end

function ShopData.sellName(index)
    return WindowData.ShopData.Sell.Names[index]
end

function ShopData.isSelling()
    return WindowData.ShopData.IsSelling
end

function ShopData.sellNames()
    return WindowData.ShopData.Sell.Names
end
