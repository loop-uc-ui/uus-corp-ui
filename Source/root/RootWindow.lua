local mousePosX, mousePosY

RootWindow = UusCorpWindow.new("Root"):event(
    UusCorpViewEvent.new(
        Events.beginHealthBarDrag(),
        function ()
            mousePosX = MousePosition.x()
            mousePosY = MousePosition.y()
        end
    )
):event(
    UusCorpViewEvent.new(
        Events.endHealthBarDrag(),
        function ()
            local id = SystemData.ActiveMobile.Id
            Debug.Print(id)
            if not id then
                return
            end
            Debug.Print(mousePosX)
            if mousePosX ~= MousePosition.x() and mousePosY ~= MousePosition.y() then
                MobileHealthBar:new(id):create()
            end
        end
    )
)

function RootWindow:create()
    ViewportApi.update(
        ScreenResolution.x(),
        ScreenResolution.y(),
        ScreenResolution.x(),
        ScreenResolution.y()
    )

    self:registerData()
    self:registerEvents()
    self:registerCoreEvents()
end

function RootWindow:destroy()
    self:unregisterData()
    self:unregisterEvents()
    self:unregisterCoreEvents()
end