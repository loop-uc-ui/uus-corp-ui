Active = {}

function Active.window()
    return SystemData.ActiveWindow.name
end

function Active.mobile()
    return SystemData.ActiveMobile.Id
end

function Active.updateId()
    return WindowData.UpdateInstanceId
end

function Active.dynamicWindowId()
    return SystemData.DynamicWindowId
end