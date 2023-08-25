UusCorpDistanceCounterWindow = UusCorpWindow.new("UusCorpDistanceCounterWindow")
UusCorpDistanceCounterWindow.Label = UusCorpDistanceCounterWindow.addLabel("Counter")

function UusCorpDistanceCounterWindow.initialize()
    UusCorpCore.loadResources(
        "/src/mods/distance-counter",
        "UusCorpDistanceCounterWindow.xml"
    )

    UusCorpDistanceCounterWindow.create()
end

function UusCorpDistanceCounterWindow.onInitialize()
    UusCorpDistanceCounterWindow.Label.setText("")
end

function UusCorpDistanceCounterWindow.onUpdate()
    if not Cursor.hasTarget() then
        UusCorpDistanceCounterWindow.Label.setText("")
        return
    end

    local scaleFactor = InterfaceCoreWrapper.scaleFactor()

    local posX, posY = WindowApi.getPosition("ResizeWindow")
    local resizeX, resizeY = WindowApi.getDimensions("ResizeWindow")
    resizeX = resizeX / scaleFactor
    resizeY = resizeY / scaleFactor

    local borderX = posX + resizeX
    local borderY = posY + resizeY

    -- If we're outside the ResizeWndow then clear the text
    local outsideX = MousePosition.x() > borderX or MousePosition.x() < posX
    local outsideY = MousePosition.y() > borderY or MousePosition.y() < posY

    if outsideX or outsideY then
        UusCorpDistanceCounterWindow.Label.setText("")
        return
    end

    -- Find the player's location by identifying
    -- the midpoint of the ResizeWindow's opposite vertices

    local playerX = (posX + borderX) / 2
    local playerY = (posY + borderY) / 2
    local xDelta = MousePosition.x() - playerX
    local yDelta = MousePosition.y() - playerY
    local x = xDelta * xDelta
    local y = yDelta * yDelta

    UusCorpDistanceCounterWindow.Label.setText(tostring(math.floor(math.sqrt(x + y) / 32)))

    local width, height = UusCorpDistanceCounterWindow.getDimensions()

    -- Set the window position
    local windowOffset = 16

    local mouseX = MousePosition.x()
    local propWindowX = mouseX + windowOffset - width / scaleFactor / 4

    local mouseY = MousePosition.y()
    local propWindowY = mouseY - windowOffset - (height / scaleFactor)

    UusCorpDistanceCounterWindow.setOffsetFromParent(
        propWindowX * scaleFactor,
        propWindowY * scaleFactor
    )
end