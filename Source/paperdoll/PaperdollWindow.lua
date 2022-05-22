PaperdollWindow = {}
PaperdollWindow.Name = "PaperdollWindow"

local SLOTS = 18

local function toggleSlotTexture(icon, hasGear)
    local slot = WindowApi.getParent(icon)
    local id = WindowApi.getId(slot)
    local texture = ""

    if not hasGear then
        texture = "slot_" .. id
    end

    ButtonApi.setTexture(slot, InterfaceCore.ButtonStates.STATE_NORMAL, texture, 0, 0)
    ButtonApi.setTexture(slot, InterfaceCore.ButtonStates.STATE_NORMAL_HIGHLITE, texture, 0, 0)
    ButtonApi.setTexture(slot, InterfaceCore.ButtonStates.STATE_PRESSED, texture, 0, 0)
    ButtonApi.setTexture(slot, InterfaceCore.ButtonStates.STATE_DISABLED, texture, 0, 0)
end

function PaperdollWindow.onInitialize()
    local pId = Paperdoll.id()
    local window = PaperdollWindow.Name .. pId

    WindowApi.setId(window, pId)
    WindowDataApi.registerData(Paperdoll.type(), pId)
    WindowApi.registerEventHandler(window, Paperdoll.event(), "PaperdollWindow.update")
    PaperdollWindow.update()
end

function PaperdollWindow.update()
    local window = Active.window()
    local id = WindowApi.getId(window)

    for i = 1, Paperdoll.numSlots(id) do
        local icon = window .. "ItemSlotButton" .. i .. "SquareIcon"
        local data = Paperdoll.slotData(id, i)

        if data ~= nil and data.newWidth ~= nil and data.newHeight ~= nil and data.iconName ~= nil then
            DynamicImageApi.setTextureDimensions(icon, data.newWidth, data.newHeight)
            DynamicImageApi.setTexture(icon, data.iconName, 0, 0)
            DynamicImageApi.setCustomShader(icon, "UOSpriteUIShader", {
                data.hueId,
                data.objectType
            })
            toggleSlotTexture(icon, true)
        else
            toggleSlotTexture(icon, false)
        end
    end
end

function PaperdollWindow.ItemMouseOver()
end

function PaperdollWindow.onShutdown()
    WindowDataApi.unregisterData(Paperdoll.type(), WindowApi.getId(Active.window()))
    WindowApi.unregisterEventHandler(Active.window(), Paperdoll.event())
end

function PaperdollWindow.onRightClick()
    WindowApi.destroyWindow(Active.window())
end