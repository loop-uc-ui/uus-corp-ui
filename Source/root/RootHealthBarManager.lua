RootHealthBarManager = setmetatable({ name = "RootHealthBarManager", events = {}, data = {}}, { __index = RootEventManager })
RootHealthBarManager.__index = RootHealthBarManager

local mousePosX, mousePosY

function RootHealthBarManager:initialize()
    self:registerEvent(
        Events.beginHealthBarDrag(),
        "onBeginHealthBarDrag"
    )

    self:registerEvent(
        Events.endHealthBarDrag(),
        "onEndHealthBarDrag"
    )
end

function RootHealthBarManager.onBeginHealthBarDrag()
    mousePosX = MousePosition.x()
    mousePosY = MousePosition.y()
end

function RootHealthBarManager.onEndHealthBarDrag()
    local id = SystemData.ActiveMobile.Id

    if not id then
        return
    end

    if mousePosX ~= MousePosition.x() and mousePosY ~= MousePosition.y() then
        MobileHealthBar:new(id):create()
    end
end