
local Label = function ()
    return UusCorp.Interface.Label {
        events = {
            ---@param self Label
            OnInitialize = function (self)
                self:setText("")
            end,

            ---@param self Label
            OnUpdate = function (self)
                if not UusCorp.Cursor().isTarget() then
                    self:setText("")
                    return
                end

                local scaleFactor = UusCorp.Api.InterfaCore.GetScaleFactor()

                local resizeWindow = UusCorp.Interface.Defaults.ResizeWindow
                local posX, posY = resizeWindow:getPosition()
                local resizeX, resizeY = resizeWindow:getDimensions()
                resizeX = resizeX / scaleFactor
                resizeY = resizeY / scaleFactor

                local borderX = posX + resizeX
                local borderY = posY + resizeY

                -- If we're outside the ResizeWndow then clear the text
                local mousePosition = UusCorp.Mouse().getPosition()
                local outsideX = mousePosition.x > borderX or mousePosition.x < posX
                local outsideY = mousePosition.y > borderY or mousePosition.y < posY

                if outsideX or outsideY then
                    self:setText("")
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

                --TODO 64 is a magic number, find a better way to calculate distance
                self:setText(tostring(math.floor(math.sqrt(x + y) / 64)))

                local width, height = UusCorpDistanceCounterWindow:getDimensions()

                -- Set the window position
                local windowOffset = 16

                local mouseX = mousePosition.x
                local propWindowX = mouseX + windowOffset - width / scaleFactor / 4

                local mouseY = mousePosition.y
                local propWindowY = mouseY - windowOffset - (height / scaleFactor)

                UusCorpDistanceCounterWindow:setOffsetFromParent(
                    propWindowX * scaleFactor,
                    propWindowY * scaleFactor
                )
            end
        }
    }
end

UusCorpDistanceCounterWindow = UusCorp.Interface.Window {
    name = "UusCorpDistanceCounterWindow",
    events = {
        OnInitialize = function (self)
            self:setChildren { Label() }
            self:toggleBackground(false)
            self:toggleFrame(false)
        end
    }
}