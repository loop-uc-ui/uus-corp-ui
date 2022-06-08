OverheadText = {}
OverheadText.Name = "Name"
OverheadText.ChatOne = "Chat1"
OverheadText.ChatTwo = "Chat2"
OverheadText.ChatThree = "Chat3"

function OverheadText.Initialize()
    local window = Active.window()
    local mobile = Active.dynamicWindowId()
    WindowApi.setId(window, mobile)
    WindowDataApi.registerData(MobileData.nameType(), mobile)
    WindowApi.setShowing(window .. OverheadText.ChatOne, false)
    WindowApi.setShowing(window .. OverheadText.ChatTwo, false)
    WindowApi.setShowing(window .. OverheadText.ChatThree, false)
    OverheadText.update(window)
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
    LabelApi.setText(window .. OverheadText.Name, name)
end