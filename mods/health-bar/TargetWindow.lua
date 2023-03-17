TargetWindow = {}
TargetWindow.Name = "TargetWindow"

local previousTarget = nil

function TargetWindow.onInitialize()
    WindowDataApi.registerData(
        CurrentTarget.dataType()
    )
    WindowApi.registerEventHandler(
        Active.window(),
        CurrentTarget.event(),
        "TargetWindow.onCurrentTarget"
    )
end

function TargetWindow.onCurrentTarget()
    local id = CurrentTarget.id()

    if id == PlayerStatus.id() then
        return
    end

    if id == nil or id == 0 and previousTarget ~= nil then
        WindowApi.destroyWindow(previousTarget)
        return
    end

    local window = UusCorpMobileHealthBar.Name .. CurrentTarget.id()

    if not ObjectApi.isValid(id) or not CurrentTarget.isMobile() then
        WindowApi.destroyWindow(window)
        return
    end

    if WindowApi.doesExist(window) then
        return
    end

    if previousTarget ~= window then
        if previousTarget ~= nil and WindowApi.doesExist(previousTarget)
         and WindowApi.isShowing(previousTarget .. UusCorpMobileHealthBar.ObjectAnchor) then
            WindowApi.destroyWindow(previousTarget)
        end
        previousTarget = window
    end

    Active.setMobile(id)

    WindowApi.createFromTemplate(
        UusCorpMobileHealthBar.Name .. CurrentTarget.id(),
        UusCorpMobileHealthBar.Name,
        HealthBarRootOverlayWindow.Name
    )

    WindowApi.attachWIndowToWorldObject(id, window)
    WindowApi.setShowing(window .. UusCorpMobileHealthBar.ObjectAnchor, true)
    WindowApi.destroyWindow(OverheadText.Name .. id)
end

function TargetWindow.onShutdown()
    WindowDataApi.unregisterData(
        CurrentTarget.dataType()
    )
    WindowApi.unregisterEventHandler(
        Active.window(),
        CurrentTarget.event()
    )
    previousTarget = nil
end