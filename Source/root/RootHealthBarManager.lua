RootHealthBarManager = setmetatable({ name = "RootHealthBarManager", events = {}, data = {}}, { __index = RootEventManager })
RootHealthBarManager.__index = RootHealthBarManager

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
    local id = SystemData.ActiveMobile.Id

    if id then
        MobileHealthBar:new(id):create()
    end
end

function RootHealthBarManager.onEndHealthBarDrag()

end