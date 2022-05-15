Active = {}

function Active.window()
    return SystemData.ActiveWindow.name
end

function Active.mobile()
    return SystemData.ActiveMobile.Id
end