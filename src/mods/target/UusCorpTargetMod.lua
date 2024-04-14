UusCorpTargetMod = {
    name = "UusCorpTarget",

    onInitialize = function ()
        UusCorpCore.loadResources(
            "/src/mods/target",
            "UusCorpTargetWindow.xml"
        )

        UusCorpCore.overrideFunctions(TargetWindow)

        local oldWindow = UusCorpWindow:new { name = "TargetWindow" }
        oldWindow:unregisterData(CurrentTarget.dataType(), 0)
        oldWindow:unregisterEvent(CurrentTarget.event())
        oldWindow:unregisterEvent(MobileStatus.event())
        oldWindow:unregisterEvent(MobileData.nameEvent())
        oldWindow:unregisterEvent(ObjectInfo.event())
        oldWindow:unregisterEvent(HealthBarColorData.event())
        oldWindow:unregisterCoreEvent("OnUpdate")
        oldWindow:setShowing(false)

        UusCorpRootWindow.onUpdateCurrentTarget = function ()
            UusCorpTargetMod.createTargetWindow()
        end
        UusCorpRootWindow:registerEvents()
    end,

    shouldCreateTargetWindow = function ()
        if not CurrentTarget.isMobile() then
            return true
        else
            local targets = TargetApi.getAllMobileTargets()
            local target = nil

            for _, v in pairs(targets) do
                if v == CurrentTarget.id() then
                    target = v
                    break
                end
            end

            return target ~= nil and ObjectApi.getDistanceFromPlayer(target) < 30
        end
    end,

    createTargetWindow = function ()
        if not CurrentTarget.hasTarget() then
            UusCorpTargetWindow:destroy()
            return
        end

        if not UusCorpTargetMod.shouldCreateTargetWindow() then
            return
        end

        if UusCorpTargetWindow:doesExist() and CurrentTarget.id() ~= UusCorpTargetWindow:getId() then
            UusCorpTargetWindow:destroy()
        end

        UusCorpTargetWindow:create(true)
    end
}