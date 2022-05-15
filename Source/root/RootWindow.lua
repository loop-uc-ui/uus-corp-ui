local mousePosX, mousePosY

RootWindow = UusCorpWindow.new("Root"):event(
    UusCorpViewEvent.new(
        Events.beginHealthBarDrag(),
        function ()
            local id = SystemData.ActiveMobile.Id
            local bar = MobileHealthBar.name .. id

            if not id then
                return
            end

            mousePosX = MousePosition.x()
            mousePosY = MousePosition.y()

            if WindowApi.doesExist(bar) then
                MobileHealthBar.offset(id)
                WindowApi.setMoving(bar, true)
            else
                MobileHealthBar:new(id):create(false)
            end
        end
    )
):event(
    UusCorpViewEvent.new(
        Events.endHealthBarDrag(),
        function ()
            local healthBar = MobileHealthBar.name .. Active.mobile()
            local isDragged = mousePosX ~= MousePosition.x() and mousePosY ~= MousePosition.y()

            if WindowApi.doesExist(healthBar) and not WindowApi.isShowing(healthBar) and isDragged then
                WindowApi.setShowing(healthBar, true)
                MobileHealthBar.offset(Active.mobile())
            end
        end
    )
):coreEvent(
    UusCorpViewEvent.onRButtonUp(nil)
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