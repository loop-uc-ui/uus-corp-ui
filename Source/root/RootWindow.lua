RootWindow = {}
RootWindow.Name = "Root"

local mousePosX, mousePosY

local function registerEvent(eventName, func)
    WindowApi.registerEventHandler(RootWindow.Name, eventName, RootWindow.Name .. "Window." .. func)
end

function RootWindow.create()
    ViewportApi.update(
        ScreenResolution.x(),
        ScreenResolution.y(),
        ScreenResolution.x(),
        ScreenResolution.y()
    )

    CSVUtilities.initialize()
    WindowDataApi.registerData(PlayerStatus.type())
    WindowDataApi.registerData(PlayerEquipment.type(), PlayerEquipment.Slots.Backpack)
    registerEvent(Events.beginHealthBarDrag(), "onHealthBarDrag")
    registerEvent(Events.endHealthBarDrag(), "onEndHealthBarDrag")
    registerEvent(Events.showNamesUpdated(), "onShowNamesUpdated")
    registerEvent(Events.showNamesFlashTemp(),"onShowNamesFlashTemp")
    registerEvent(Events.togglePaperdoll(), "togglePaperdoll")
    registerEvent(Events.toggleBackpack(), "toggleBackpack")
    registerEvent(Events.toggleSkills(), "toggleSkills")
    registerEvent(Events.textArrived(), "onTextArrived")
end

function RootWindow.onHealthBarDrag()
    local mobile = Active.mobile()

    if not mobile then
        return
    end

    local isPlayer = mobile == PlayerStatus.id()
    local window

    if mobile == PlayerStatus.id() then
        window = PlayerHealthBar.Name
    else
        window = MobileHealthBar.Name .. mobile
    end

    if WindowApi.doesExist(window) then
        return
    elseif isPlayer then
        WindowApi.createWindow(PlayerHealthBar.Name, false)
    else
        WindowApi.createFromTemplate(window, MobileHealthBar.Name, RootWindow.Name)
        WindowApi.setShowing(window, false)
    end

    mousePosX = MousePosition.x()
    mousePosY = MousePosition.y()
end

function RootWindow.onEndHealthBarDrag()
    if mousePosX == MousePosition.x() and mousePosY == MousePosition.y() then
        return
    end

    local mobile = Active.mobile()
    local isPlayer = mobile == PlayerStatus.id()
    local window

    if isPlayer then
        window = PlayerHealthBar.Name
    else
        window = MobileHealthBar.Name .. mobile
    end

    if WindowApi.doesExist(window) and not WindowApi.isShowing(window) then
        WindowApi.setShowing(window, true)

        if isPlayer then
            PlayerHealthBar.offset()
        else
            MobileHealthBar.offset(mobile)
        end
    end
end

function RootWindow.shutdown()
    CSVUtilities.shutdown()
    WindowDataApi.unregisterData(PlayerStatus.type())
    WindowDataApi.unregisterData(Paperdoll.type(), PlayerStatus.id())
    WindowDataApi.unregisterData(PlayerEquipment.type(), PlayerEquipment.Slots.Backpack)
    WindowApi.unregisterEventHandler(RootWindow.Name, Events.beginHealthBarDrag())
    WindowApi.unregisterEventHandler(RootWindow.Name, Events.endHealthBarDrag())
    WindowApi.unregisterEventHandler(RootWindow.Name, Events.showNamesUpdated())
    WindowApi.unregisterEventHandler(RootWindow.Name, Events.showNamesFlashTemp())
    WindowApi.unregisterEventHandler(RootWindow.Name, Events.togglePaperdoll())
    WindowApi.unregisterEventHandler(RootWindow.Name, Events.toggleSkills())
    WindowApi.unregisterEventHandler(RootWindow.Name, Events.textArrived())
end

function RootWindow.onShowNamesUpdated()

end

function RootWindow.onShowNamesFlashTemp()

end

function RootWindow.togglePaperdoll()
    local paperdoll = PaperdollWindow.Name .. PlayerStatus.id()

    if WindowApi.doesExist(paperdoll) then
        WindowApi.destroyWindow(paperdoll)
    else
        WindowApi.createFromTemplate(
            paperdoll,
            PaperdollWindow.Name,
            RootWindow.Name
        )
    end
end

function RootWindow.toggleBackpack()
    local window = ContainerWindow.Name .. PlayerEquipment.slotId(PlayerEquipment.Slots.Backpack)

    if WindowApi.doesExist(window) then
        WindowApi.destroyWindow(window)
    else
        WindowApi.createFromTemplate(
            ContainerWindow.Name .. PlayerEquipment.slotId(PlayerEquipment.Slots.Backpack),
            ContainerWindow.Template,
            RootWindow.Name
        )
    end
end

function RootWindow.toggleSkills()
    if WindowApi.doesExist(SkillsWindow.Name) then
        WindowApi.destroyWindow(SkillsWindow.Name)
    else
        WindowApi.createWindow(SkillsWindow.Name, true)
    end
end

function RootWindow.onTextArrived()
    if not Chat.isOverhead(Chat.chatChannel()) or Chat.sourceId() == 0 then
        return
    end

    OverheadChatWindow.create()

    local window = OverheadChatWindow.Name .. Chat.sourceId()

    local rows = {
        window .. OverheadChatWindow.ChatOne,
        window .. OverheadChatWindow.ChatTwo,
        window .. OverheadChatWindow.ChatThree
    }

    if WindowApi.doesExist(rows[3]) and WindowApi.doesExist(rows[1]) then
        LabelApi.setText(rows[1], LabelApi.getText(rows[2]))
        LabelApi.setText(rows[2], LabelApi.getText(rows[3]))
        LabelApi.setText(rows[3], Chat.chatText())
        OverheadChatWindow.restartAnimation(rows[3])
    end

    for _, v in ipairs(rows) do
        if not WindowApi.doesExist(v) then
            WindowApi.createFromTemplate(
                v,
                "OverheadChatTemplate",
                window
            )
            break
        end
    end
end