local mousePosX, mousePosY

RootWindow = UusCorpWindow.new("Root"):event(
    UusCorpViewEvent.new(
        Events.beginHealthBarDrag(),
        function ()
            local mobile = Active.mobile()

            if not mobile then
                return
            end

            local isPlayer = mobile == PlayerStatus.id()
            local window

            if mobile == PlayerStatus.id() then
                window = PlayerHealthBar.name
            else
                window = MobileHealthBar.name .. mobile
            end

            mousePosX = MousePosition.x()
            mousePosY = MousePosition.y()

            if WindowApi.doesExist(window) then
                if isPlayer then
                    PlayerHealthBar.offset()
                else
                    MobileHealthBar.offset(mobile)
                end
                WindowApi.setMoving(window, true)
            elseif isPlayer then
                PlayerHealthBar.new():create(false)
            else
                MobileHealthBar:new(mobile):create(false)
            end
        end
    )
):event(
    UusCorpViewEvent.new(
        Events.endHealthBarDrag(),
        function ()
            local mobile = Active.mobile()
            local isPlayer = mobile == PlayerStatus.id()
            local window

            if isPlayer then
                window = PlayerHealthBar.name
            else
                window = MobileHealthBar.name .. mobile
            end

            local isDragged = mousePosX ~= MousePosition.x() and mousePosY ~= MousePosition.y()

            if WindowApi.doesExist(window) and not WindowApi.isShowing(window) and isDragged then
                WindowApi.setShowing(window, true)

                if isPlayer then
                    PlayerHealthBar.offset()
                else
                    MobileHealthBar.offset(mobile)
                end
            end
        end
    )
):coreEvent(
    UusCorpViewEvent.onRButtonUp(nil)
):data(
    PlayerStatus.type()
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