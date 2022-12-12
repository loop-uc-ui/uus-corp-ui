Shopkeeper = {}
Shopkeeper.Name = "Shopkeeper"

function Shopkeeper.onInitialize()
    local window = Active.window()
    local merchantId = Active.dynamicWindowId()

    WindowApi.setId(
        window,
        merchantId
    )

    WindowDataApi.registerData(
        Container.type(),
        merchantId
    )

    WindowApi.registerEventHandler(
        window,
        Container.event(),
        "Shopkeeper.onUpdateContainer"
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