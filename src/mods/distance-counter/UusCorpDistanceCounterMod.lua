
---@param context Context
local Label = function (context)
    return context.Views.Label {
        events = {
            OnInitialize = function (self)
                self:setText("")
            end,

            OnUpdate = function (self)
                if not context.Data.Cursor():isTarget() then
                    self:setText("")
                    return
                end

                local scaleFactor = context.Api.InterfaCore.GetScaleFactor()

                local resizeWindow = context.Views.Defaults.ResizeWindow
                local posX, posY = resizeWindow:getPosition()
                local resizeX, resizeY = resizeWindow:getDimensions()
                resizeX = resizeX / scaleFactor
                resizeY = resizeY / scaleFactor

                local borderX = posX + resizeX
                local borderY = posY + resizeY

                -- If we're outside the ResizeWndow then clear the text
                local mousePosition = context.Data.Mouse():getPosition()
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

                local width, height = self:getParent():getDimensions()

                -- Set the window position
                local windowOffset = 16

                local mouseX = mousePosition.x
                local propWindowX = mouseX + windowOffset - width / scaleFactor / 4

                local mouseY = mousePosition.y
                local propWindowY = mouseY - windowOffset - (height / scaleFactor)

                self:getParent():setOffsetFromParent(
                    propWindowX * scaleFactor,
                    propWindowY * scaleFactor
                )
            end
        }
    }
end

---@param context Context
local UusCorpDistanceCounterWindow = function(context)
    return context.Views.Window {
        name = "UusCorpDistanceCounterWindow",
        events = {
            OnInitialize = function (self)
                self:setChildren { Label(context) }
                self:toggleBackground(false)
                self:toggleFrame(false)
            end
        }
    }
end

UusCorpDistanceCounterMod = UusCorp.Mod {
    Name = "UusCorpDistanceCounter",
    Path = "/src/mods/distance-counter",
    OnInitialize = function (context)
        UusCorpDistanceCounterWindow(context):create(true)
    end
}