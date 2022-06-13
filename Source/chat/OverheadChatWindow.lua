OverheadChatWindow = {}
OverheadChatWindow.Name = "OverheadChatWindow"
OverheadChatWindow.ChatOne = "Chat1"
OverheadChatWindow.ChatTwo = "Chat2"
OverheadChatWindow.ChatThree = "Chat3"

local function restartAnimation(window)
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

function OverheadChatWindow.create()
    WindowApi.createFromTemplate(
        OverheadChatWindow.Name .. Chat.sourceId(),
        OverheadChatWindow.Name,
        RootWindow.Name
    )
end

function OverheadChatWindow.onInitialize()
    WindowApi.setUpdateFrequency(Active.window(), 1)
    WindowApi.clearAnchors(Active.window())
    WindowApi.attachWIndowToWorldObject(
        Chat.sourceId(),
        Active.window()
    )
    WindowApi.setId(Active.window(), Chat.sourceId())
    WindowApi.registerEventHandler(
        Active.window(),
        Events.textArrived(),
        "OverheadChatWindow.onTextArrived"
    )
end

function OverheadChatWindow.onShutdown()
    WindowApi.unregisterEventHandler(
        Active.window(),
        Events.textArrived()
    )
end

function OverheadChatWindow.onTextArrived()
    if not Chat.isOverhead(Chat.chatChannel()) then
        return
    end

    local rows = {
        Active.window() .. OverheadChatWindow.ChatOne,
        Active.window() .. OverheadChatWindow.ChatTwo,
        Active.window() .. OverheadChatWindow.ChatThree
    }

    if WindowApi.doesExist(rows[3]) and WindowApi.doesExist(rows[1]) then
        LabelApi.setText(rows[1], LabelApi.getText(rows[2]))
        LabelApi.setText(rows[2], LabelApi.getText(rows[3]))
        LabelApi.setText(rows[3], Chat.chatText())
        restartAnimation(rows[3])
    end

    for _, v in ipairs(rows) do
        if not WindowApi.doesExist(v) then
            WindowApi.createFromTemplate(
                v,
                "OverheadChatTemplate",
                OverheadChatWindow.Name .. Chat.sourceId()
            )
            break
        end
    end
end

function OverheadChatWindow.onTextInitialize()
    WindowApi.clearAnchors(Active.window())
    restartAnimation(Active.window())
    LabelApi.setText(Active.window(), Chat.chatText())

    if string.match(Active.window(), OverheadChatWindow.ChatTwo) then
        WindowApi.addAnchor(
            OverheadChatWindow.Name .. Chat.sourceId() .. OverheadChatWindow.ChatOne,
            "top",
            Active.window(),
            "bottom"
        )
    elseif string.match(Active.window(), OverheadChatWindow.ChatThree) then
        WindowApi.addAnchor(
            OverheadChatWindow.Name .. Chat.sourceId() .. OverheadChatWindow.ChatTwo,
            "top",
            Active.window(),
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
    local rows = {
        Active.window() .. OverheadChatWindow.ChatOne,
        Active.window() .. OverheadChatWindow.ChatTwo,
        Active.window() .. OverheadChatWindow.ChatThree
    }

    local destroy = true

    for _, v in ipairs(rows) do
        if WindowApi.doesExist(v) then
            destroy = false
            break
        end
    end

    if destroy then
        WindowApi.destroyWindow(Active.window())
    end
end