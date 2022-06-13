OverheadText = {}
OverheadText.Name = "OverheadTextWindow_"
OverheadText.MobileName = "Name"

function OverheadText.Initialize()
    local window = Active.window()
    local mobile = Active.dynamicWindowId()
    WindowApi.setId(window, mobile)
    WindowDataApi.registerData(MobileData.nameType(), mobile)
    OverheadText.update(window)
    WindowApi.startAlphaAnimation(
        Active.window(),
        Animation.singleNoReset(),
        1.0,
        0,
        1,
        true,
        10,
        0
    )
end

function OverheadText.Shutdown()
end

function OverheadText.OnOverheadChatShutdown()

end

function OverheadText.NameOnDblClick()
    local id = WindowApi.getId(
        WindowApi.getParent(
            Active.window()
        )
    )
    UserAction.useItem(
        id,
        false
    )
end

function OverheadText.update(window)
    local id = WindowApi.getId(window)
    local name = MobileData.name(id)
    LabelApi.setText(window .. OverheadText.MobileName, name)
end