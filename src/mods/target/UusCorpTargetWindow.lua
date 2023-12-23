UusCorpTargetWindow = UusCorpWindow.new("UusCorpTargetWindow")
UusCorpTargetWindow.NameLabel = UusCorpTargetWindow.addLabel("Name")
UusCorpTargetWindow.HealthBarPercent = UusCorpTargetWindow.addLabel("HealthBarPerc")
UusCorpTargetWindow.StatusBar = UusCorpTargetWindow.addStatusBar("HealthBar")

local function createTarget()
    local targets = TargetApi.getAllMobileTargets()
    local target = nil

    for _, v in pairs(targets) do
        if v == CurrentTarget.id() then
            target = v
        end
    end

    return target ~= nil and ObjectApi.getDistanceFromPlayer(target) < 30
end

function UusCorpTargetWindow.initialize()
    UusCorpCore.loadResources(
        "/src/mods/target",
        "UusCorpTargetWindow.xml"
    )

    UusCorpCore.overrideFunctions(TargetWindow)

    local oldWindow = UusCorpWindow.new("TargetWindow")
    oldWindow.unregisterData(CurrentTarget.dataType(), 0)
    oldWindow.unregisterEvent(CurrentTarget.event())
    oldWindow.unregisterEvent(MobileStatus.event())
    oldWindow.unregisterEvent(MobileData.nameEvent())
    oldWindow.unregisterEvent(ObjectInfo.event())
    oldWindow.unregisterEvent(HealthBarColorData.event())
    oldWindow.unregisterCoreEvent("OnUpdate")
    oldWindow.setShowing(false)

    WindowDataApi.registerData(CurrentTarget.dataType(), 0)
    WindowApi.registerEventHandler("Root", CurrentTarget.event(), "UusCorpTargetWindow.createWindow")
end

function UusCorpTargetWindow.createWindow()
    if not createTarget() then
        return
    end

    if UusCorpTargetWindow.doesExist() and CurrentTarget.id() ~= UusCorpTargetWindow.getId() then
        UusCorpTargetWindow.destroy()
    end

    UusCorpTargetWindow.create(true)
end

function UusCorpTargetWindow.onInitialize()
    UusCorpTargetWindow.restorePosition()

    local id = CurrentTarget.id()
    UusCorpTargetWindow.setId(id)
    UusCorpTargetWindow.setScale(1.0)
    UusCorpTargetWindow.registerData(MobileStatus.type(), id)
    UusCorpTargetWindow.registerEvent(MobileStatus.event(), "onUpdateMobileStatus")
    UusCorpTargetWindow.registerData(HealthBarColorData.type(), id)
    UusCorpTargetWindow.registerEvent(HealthBarColorData.event(), "onUpdateHealthBarColor")

    if MobileStatus.status(id) ~= nil then
        UusCorpTargetWindow.onUpdateMobileStatus(id)
    end

    if HealthBarColorData.data(id) ~= nil then
        UusCorpTargetWindow.onUpdateHealthBarColor(id)
    end
end

function UusCorpTargetWindow.onUpdateMobileStatus(id)
    id = id or UusCorpTargetWindow.getId()
    local maxHealth = MobileStatus.maxHealth(id)
    local currentHealth = MobileStatus.currentHealth(id)

    -- There's a delay in updating the mobile's status where
    -- values are initialy 0'd out
    UusCorpTargetWindow.StatusBar.setShowing(maxHealth ~= 0)
    UusCorpTargetWindow.HealthBarPercent.setShowing(maxHealth ~= 0)

    WindowApi.setShowing(statusBar, maxHealth ~= 0)
    WindowApi.setShowing(healthLabel, maxHealth ~= 0)

    UusCorpTargetWindow.NameLabel.setText(MobileStatus.name(id))
    UusCorpTargetWindow.StatusBar.setCurrentValue(currentHealth)
    UusCorpTargetWindow.StatusBar.setMaxValue(maxHealth)

    UusCorpTargetWindow.NameLabel.setTextColor(
        Colors.Notoriety[MobileStatus.notoriety(id)]
    )

    UusCorpTargetWindow.HealthBarPercent.setText(
        tostring(math.floor(currentHealth / maxHealth * 100)) .. "%"
    )
end

function UusCorpTargetWindow.onUpdate()
end

function UusCorpTargetWindow.onShutdown()
    local id = UusCorpTargetWindow.getId()
    UusCorpTargetWindow.unregisterData(MobileStatus.type(), id)
    UusCorpTargetWindow.unregisterEvent(MobileStatus.event())
    UusCorpTargetWindow.unregisterData(HealthBarColorData.type(), id)
    UusCorpTargetWindow.unregisterEvent(HealthBarColorData.event())
    UusCorpTargetWindow.savePosition()
end

function UusCorpTargetWindow.onRightClick()
    UusCorpTargetWindow.destroy()
end

function UusCorpTargetWindow.onDoubleClick()
    UserActionApi.useItem(UusCorpTargetWindow.getId(), false)
end

function UusCorpTargetWindow.onUpdateHealthBarColor(id)
    id = id or UusCorpTargetWindow.getId()
    UusCorpTargetWindow.StatusBar.setForegroundTint(
        Colors.HealthBar[HealthBarColorData.visualState(id) + 1]
    )
end