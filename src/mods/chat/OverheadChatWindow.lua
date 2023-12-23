OverheadChatWindow = {}
OverheadChatWindow.Name = "OverheadChatWindow"
OverheadChatWindow.ChatOne = "Chat1"
OverheadChatWindow.ChatTwo = "Chat2"
OverheadChatWindow.ChatThree = "Chat3"

function OverheadChatWindow.create()
    if Chat.sourceId() == 0 then
        return
    end

    WindowApi.createFromTemplate(
        OverheadChatWindow.Name .. Chat.sourceId(),
        OverheadChatWindow.Name,
        RootWindow.Name
    )
end

function OverheadChatWindow.onInitialize()
    local window = Active.window()
    WindowApi.setUpdateFrequency(window, 1)
    WindowApi.clearAnchors(window)
    WindowApi.setId(window, Chat.sourceId())
    WindowApi.attachWindowToWorldObject(
        Chat.sourceId(),
        window
    )
end

function OverheadChatWindow.onShutdown()
end

function OverheadChatWindow.restartAnimation(window)
    WindowApi.setAlpha(window, 1.0)
    WindowApi.stopAlphaAnimation(window)
    WindowApi.startAlphaAnimation(
        window,
        Animation.singleNoReset(),
        1.0,
        0,
        2,
        false,
        10,
        0
    )
end

function OverheadChatWindow.onTextInitialize()
    local window = Active.window()
    local parent = WindowApi.getParent(window)
    local id = WindowApi.getId(parent)

    WindowApi.setId(window, id)
    WindowApi.clearAnchors(window)
    OverheadChatWindow.restartAnimation(window)
    LabelApi.setText(Active.window(), Chat.chatText())

    if string.match(window, OverheadChatWindow.ChatTwo) then
        WindowApi.addAnchor(
            parent .. OverheadChatWindow.ChatOne,
            "top",
            window,
            "bottom"
        )
    elseif string.match(window, OverheadChatWindow.ChatThree) then
        WindowApi.addAnchor(
            parent .. OverheadChatWindow.ChatTwo,
            "top",
            window,
            "bottom"
        )
    elseif string.match(window, OverheadChatWindow.ChatOne)
        and WindowApi.doesExist(parent .. OverheadChatWindow.ChatThree) then
        WindowApi.addAnchor(
            parent .. OverheadChatWindow.ChatThree,
            "top",
            window,
            "bottom"
        )
    end
end

function OverheadChatWindow.onTextUpdate()
    if WindowApi.getAlpha(Active.window()) <= 0 then
        WindowApi.destroyWindow(Active.window())
    end
end

function OverheadChatWindow.onWindowUpdate()
    local window = Active.window()
    local rows = {
        window .. OverheadChatWindow.ChatOne,
        window .. OverheadChatWindow.ChatTwo,
        window .. OverheadChatWindow.ChatThree
    }

    local destroy = true

    for _, v in ipairs(rows) do
        if WindowApi.doesExist(v) then
            destroy = false
            break
        end
    end

    if destroy then
        WindowApi.destroyWindow(window)
    end
end

function OverheadChatWindow.onTextDoubleClick()
    UserAction.useItem(
        WindowApi.getId(Active.window()),
        false
    )
end