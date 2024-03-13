---@class UusCorpDistanceCounterWindow:UusCorpWindow
---@field counter UusCorpLabel
UusCorpDistanceCounterWindow = UusCorpWindow:new {
    name = "UusCorpDistanceCounterWindow",

    ---@param view UusCorpDistanceCounterWindow
    onInitialize = function (view)
        view.counter:setText("")
    end,

    ---@param view UusCorpDistanceCounterWindow
    onUpdate = function (view, _)
        if not Cursor.hasTarget() then
            view.counter:setText("")
            return
        end

        local scaleFactor = InterfaceCoreWrapper.scaleFactor()

        local posX, posY = UusCorpResizeWindow:getPosition()
        local resizeX, resizeY = UusCorpResizeWindow:getDimensions()
        resizeX = resizeX / scaleFactor
        resizeY = resizeY / scaleFactor

        local borderX = posX + resizeX
        local borderY = posY + resizeY

        local mousePosition = UusCorpMousePosition()

        -- If we're outside the ResizeWndow then clear the text
        local outsideX = mousePosition.x > borderX or mousePosition.x < posX
        local outsideY = mousePosition.y > borderY or mousePosition.y < posY

        if outsideX or outsideY then
            view.counter:setText("")
            return
        end

        -- Find the player's location by identifying
        -- the midpoint of the ResizeWindow's opposite vertices

        local playerX = (posX + borderX) / 2
        local playerY = (posY + borderY) / 2
        local xDelta = mousePosition.x - playerX
        local yDelta = mousePosition.y - playerY
        local x = xDelta * xDelta
        local y = yDelta * yDelta

        view.counter:setText(tostring(math.floor(math.sqrt(x + y) / 32)))

        local width, height = view:getDimensions()

        -- Set the window position
        local windowOffset = 16

        local mouseX = mousePosition.x
        local propWindowX = mouseX + windowOffset - width / scaleFactor / 4

        local mouseY = mousePosition.y
        local propWindowY = mouseY - windowOffset - (height / scaleFactor)

        view:setOffsetFromParent(
            propWindowX * scaleFactor,
            propWindowY * scaleFactor
        )
    end,

    counter = UusCorpLabel:new {
        name = "UusCorpDistanceCounterWindowCounter"
    }
}

UusCorpDistanceCounterEventHandler = UusCorpEventHandler:new {
    name = "UusCorpDistanceCounterEventHandler",
    getView = function ()
        return UusCorpDistanceCounterWindow
    end,
    coreEvents = {
        UusCorpCoreEvents.OnUpdate
    }
}

function UusCorpDistanceCounterWindow.initialize()
    UusCorpCore.loadResources(
        "/src/mods/distance-counter",
        "UusCorpDistanceCounterWindow.xml"
    )

    UusCorpDistanceCounterWindow:create()
end

-- function UusCorpDistanceCounterWindow.onInitialize()
--     UusCorpDistanceCounterWindow.Label:setText("")
-- end
