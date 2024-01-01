---@class UusCorpTargetWindow:UusCorpWindow
UusCorpTargetWindow = UusCorpWindow:new("UusCorpTargetWindow")

---@private
UusCorpTargetWindow.NameLabel = UusCorpTargetWindow:addLabel("Name")

---@private
UusCorpTargetWindow.HealthBarPercent = UusCorpTargetWindow:addLabel("HealthBarPerc")

---@private
UusCorpTargetWindow.StatusBar = UusCorpTargetWindow:addStatusBar("HealthBar")

---@private
UusCorpTargetWindow.Distance = UusCorpTargetWindow:addLabel("Distance")

local function createTarget()
    if not CurrentTarget.isMobile() then
        return true
    else
        local targets = TargetApi.getAllMobileTargets()
        local target = nil

        for _, v in pairs(targets) do
            if v == CurrentTarget.id() then
                target = v
            end
        end

        return target ~= nil and ObjectApi.getDistanceFromPlayer(target) < 30
    end
end

function UusCorpTargetWindow.initialize()
    UusCorpCore.loadResources(
        "/src/mods/target",
        "UusCorpTargetWindow.xml"
    )

    UusCorpCore.overrideFunctions(TargetWindow)

    local oldWindow = UusCorpWindow:new("TargetWindow")
    oldWindow:unregisterData(CurrentTarget.dataType(), 0)
    oldWindow:unregisterEvent(CurrentTarget.event())
    oldWindow:unregisterEvent(MobileStatus.event())
    oldWindow:unregisterEvent(MobileData.nameEvent())
    oldWindow:unregisterEvent(ObjectInfo.event())
    oldWindow:unregisterEvent(HealthBarColorData.event())
    oldWindow:unregisterCoreEvent("OnUpdate")
    oldWindow:setShowing(false)

    WindowDataApi.registerData(CurrentTarget.dataType(), 0)
    WindowApi.registerEventHandler("Root", CurrentTarget.event(), "UusCorpTargetWindow.createWindow")
end

function UusCorpTargetWindow.createWindow()
    if not CurrentTarget.hasTarget() then
        UusCorpTargetWindow:destroy()
        return
    end

    if not createTarget() then
        return
    end

    if UusCorpTargetWindow:doesExist() and CurrentTarget.id() ~= UusCorpTargetWindow:getId() then
        UusCorpTargetWindow:destroy()
    end

    UusCorpTargetWindow:create(true)
end

function UusCorpTargetWindow.onInitialize()
    UusCorpTargetWindow:restorePosition()

    local id = CurrentTarget.id()
    UusCorpTargetWindow:setId(id)
    UusCorpTargetWindow:setScale(1.0)

    if CurrentTarget.isMobile() then
        UusCorpTargetWindow:registerData(MobileStatus.type(), id)
        UusCorpTargetWindow:registerEvent(MobileStatus.event(), "onUpdateMobileStatus")
        UusCorpTargetWindow:registerData(HealthBarColorData.type(), id)
        UusCorpTargetWindow:registerEvent(HealthBarColorData.event(), "onUpdateHealthBarColor")


        if MobileStatus.status(id) ~= nil then
            UusCorpTargetWindow.onUpdateMobileStatus(id)
        end

        if HealthBarColorData.data(id) ~= nil then
            UusCorpTargetWindow.onUpdateHealthBarColor(id)
        end
    elseif CurrentTarget.isObject() or CurrentTarget.isCorpse() then
        UusCorpTargetWindow:registerData(ObjectInfo.type(), id)
        UusCorpTargetWindow:registerEvent(ObjectInfo.event(), "onUpdateObjectInfo")
        UusCorpTargetWindow.StatusBar:setShowing(false)
        UusCorpTargetWindow.HealthBarPercent:setShowing(false)
        UusCorpTargetWindow.onUpdateObjectInfo()
    end
end

function UusCorpTargetWindow.onUpdateMobileStatus(id)
    id = id or UusCorpTargetWindow:getId()
    local maxHealth = MobileStatus.maxHealth(id)
    local currentHealth = MobileStatus.currentHealth(id)

    -- There's a delay in updating the mobile's status where
    -- values are initialy 0'd out
    UusCorpTargetWindow.StatusBar:setShowing(maxHealth ~= 0)
    UusCorpTargetWindow.HealthBarPercent:setShowing(maxHealth ~= 0)

    UusCorpTargetWindow.NameLabel:setText(MobileStatus.name(id))
    UusCorpTargetWindow.StatusBar:setCurrentValue(currentHealth)
    UusCorpTargetWindow.StatusBar:setMaxValue(maxHealth)

    UusCorpTargetWindow.NameLabel:setTextColor(
        Colors.Notoriety[MobileStatus.notoriety(id)]
    )

    UusCorpTargetWindow.HealthBarPercent:setText(
        tostring(math.floor(currentHealth / maxHealth * 100)) .. "%"
    )
end

function UusCorpTargetWindow.onUpdate()
    local id = UusCorpTargetWindow:getId()
    local distance = ObjectApi.getDistanceFromPlayer(id)

    if distance <= 0 then
        UusCorpTargetWindow.Distance:setText("")
    else
        UusCorpTargetWindow.Distance:setText(tostring(distance))
    end

    if not CurrentTarget.hasTarget() then
        UusCorpTargetWindow:destroy()
    end
end

function UusCorpTargetWindow.onShutdown()
    local id = UusCorpTargetWindow:getId()

    if CurrentTarget.isMobile() then
        UusCorpTargetWindow:unregisterData(MobileStatus.type(), id)
        UusCorpTargetWindow:unregisterEvent(MobileStatus.event())
        UusCorpTargetWindow:unregisterData(HealthBarColorData.type(), id)
        UusCorpTargetWindow:unregisterEvent(HealthBarColorData.event())
    elseif CurrentTarget.isObject() or CurrentTarget.isCorpse() then
        UusCorpTargetWindow:unregisterData(ObjectInfo.type(), id)
        UusCorpTargetWindow:unregisterEvent(ObjectInfo.event())
    end

    UusCorpTargetWindow:savePosition()
end

function UusCorpTargetWindow.onUpdateObjectInfo()
    UusCorpTargetWindow.NameLabel.setText(ObjectInfo.name(UusCorpTargetWindow:getId()))
end

function UusCorpTargetWindow.onRightClick(flags)
    if ButtonFlags.isControl(flags) then
        ContextMenuApi.requestMenu(UusCorpTargetWindow:getId())
    end
end

function UusCorpTargetWindow.onDoubleClick()
    UserActionApi.useItem(UusCorpTargetWindow:getId(), false)
end

function UusCorpTargetWindow.onUpdateHealthBarColor(id)
    id = id or UusCorpTargetWindow:getId()
    UusCorpTargetWindow.StatusBar:setForegroundTint(
        Colors.HealthBar[HealthBarColorData.visualState(id) + 1]
    )
end

function UusCorpTargetWindow.onLeftClickUp()
    if Drag.isItem() then
        DragApi.dragToObject(UusCorpTargetWindow:getId())
    end
    TargetApi.clickTarget(UusCorpTargetWindow:getId())
end